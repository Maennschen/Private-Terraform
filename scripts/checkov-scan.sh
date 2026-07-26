#!/bin/bash
set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"
RESULTS_DIR="${REPO_ROOT}/open-checkov-results"
MODE="${1:-full}"

# Farben
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

usage() {
    cat << EOF
${BLUE}Checkov Security Scanner for Terraform${NC}

Usage: $0 [MODE] [OPTIONS]

Modes:
  full        Full scan with detailed output (default)
  quick       Quick scan, compact output only
  ci          CI mode - exit with code on failures

Options:
  --skip-download   Skip downloading external modules
  --json            Generate JSON output
  --sarif           Generate SARIF output (für GitHub)

Examples:
  $0 quick
  $0 full --json
  $0 ci
EOF
    exit 0
}

# Parse arguments
SKIP_DOWNLOAD=false
GEN_JSON=false
GEN_SARIF=false
CI_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --help|-h)
            usage
            ;;
        --skip-download)
            SKIP_DOWNLOAD=true
            shift
            ;;
        --json)
            GEN_JSON=true
            shift
            ;;
        --sarif)
            GEN_SARIF=true
            shift
            ;;
        full|quick|ci)
            MODE=$1
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

mkdir -p "${RESULTS_DIR}"

# Base Checkov Args
CHECKOV_ARGS=(
    "--framework" "terraform"
    "--directory" "${REPO_ROOT}"
)

# Download external modules?
if [ "$SKIP_DOWNLOAD" = false ]; then
    CHECKOV_ARGS+=("--download-external-modules" "true")
fi

# Mode-spezifische Konfiguration
case $MODE in
    quick)
        echo -e "${YELLOW}Quick Scan Mode${NC}"
        CHECKOV_ARGS+=("--quiet" "--compact")
        ;;
    ci)
        echo -e "${YELLOW}CI Mode - Will fail on security issues${NC}"
        CHECKOV_ARGS+=("--quiet" "--compact")
        CI_MODE=true
        ;;
    full)
        echo -e "${YELLOW}Full Scan Mode${NC}"
        ;;
esac

echo -e "${BLUE}Scanning: ${REPO_ROOT}${NC}"
echo ""

# Hauptscan
checkov "${CHECKOV_ARGS[@]}" \
    --output cli \
    --output-file-path "${RESULTS_DIR}" \
    2>&1 | tee "${RESULTS_DIR}/latest_scan.log"

CHECKOV_EXIT=$?

# Zusätzliche Outputs
if [ "$GEN_JSON" = true ]; then
    echo ""
    echo -e "${YELLOW}Generating JSON report...${NC}"
    checkov "${CHECKOV_ARGS[@]}" \
        --output json \
        --output-file-path "${RESULTS_DIR}" \
        > /dev/null 2>&1
    echo -e "${GREEN}✓ JSON: ${RESULTS_DIR}/results_json.json${NC}"
fi

if [ "$GEN_SARIF" = true ]; then
    echo ""
    echo -e "${YELLOW}Generating SARIF report...${NC}"
    checkov "${CHECKOV_ARGS[@]}" \
        --output sarif \
        --output-file-path "${RESULTS_DIR}" \
        > /dev/null 2>&1
    echo -e "${GREEN}✓ SARIF: ${RESULTS_DIR}/results_sarif.sarif${NC}"
fi

# Ergebnis-Summary
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if [ $CHECKOV_EXIT -eq 0 ]; then
    echo -e "${GREEN}✓ All security checks passed!${NC}"
else
    echo -e "${RED}✗ Security issues found${NC}"
    echo -e "Details: ${RESULTS_DIR}/results_cli.txt"
fi
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# CI Mode: Fail on errors
if [ "$CI_MODE" = true ] && [ $CHECKOV_EXIT -ne 0 ]; then
    exit 1
fi

exit 0
