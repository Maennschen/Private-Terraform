# Private-Terraform — Agent Context

Private Azure learning lab (IaC). Owner uses **Azure Free / no spend budget**. Prefer free or near-free patterns; never push cost-heavy “compliance by default.”

## Environment constraints (non-negotiable)

- **Budget:** Azure Free / learning only — no private endpoints, no CMK, no GRS/ZRS “for Checkov,” no Log Analytics unless explicitly requested.
- **Auth:** Azure CLI (`az login`) + user identity. Subscription via `terraform.tfvars` (`subscription_id`, gitignored) or `ARM_SUBSCRIPTION_ID` / `TF_VAR_subscription_id`.
- **State:** Remote backend `azurerm` — `rg-terraform-state` / `sa00tfstateservices` / `sc00terraform` / key `terraform.tfstate`.
- **Host:** PikaOS (Debian sid, codename `nest`). HashiCorp apt needs a **supported** distro codename (e.g. `noble`), not `nest`/`sid`. Use `pkexec` for GUI sudo (no password in agent TTY).
- **Editors:** Prefer native `code` (apt). Flatpak VS Code cannot see host `/usr/bin/terraform`.

## Stack

| Tool | Notes |
|------|--------|
| Terraform | Pinned loosely to installed CLI; `azurerm` `~> 4.0` |
| Azure CLI | Source of truth for active subscription |
| pre-commit | fmt, tflint (config `.tflint.hcl`), terraform-docs |
| checkov | `scripts/checkov-scan.sh`; results under `open-checkov-results/` |
| tflint | azurerm plugin per `.tflint.hcl` |

## Layout

```
main.tf                 # module "subscription"
provider.tf             # azurerm + remote backend
variables.tf            # subscription_id
subscription/
  rg-services/          # RG, storage, key vault + feature_flags (security toggles)
  rg-network/           # RG, VNet, subnets, NSG association
  rg-compute/           # RG only; Linux VM module commented out
modules/                # resource_group, storage_account, key_vault, vnet, nsg, vm_linux
scripts/checkov-scan.sh
.pre-commit-config.yaml # tflint --config=.tflint.hcl (relative, not host-absolute)
```

Region: **West Europe**. Tenant/admin defaults live in `subscription/rg-services/variables.tf`.

## Security feature flags (`subscription/rg-services/feature_flags.tf`)

Operational defaults (learning):

- `enable_public_network_access = true` — needed without PE/VPN
- `enable_network_restrictions = false`
- `enable_private_endpoints = false` — **costs money**
- `enable_cmk_encryption = false` — overkill for free lab
- `enable_shared_access_key = false` — **Entra ID + RBAC** on `sa00services` (not the state SA). GA/`az login` still manages control plane; data plane needs the assigned storage roles.
- Provider must set `storage_use_azuread = true` when keys are disabled — otherwise plan/refresh fails on queue/share data plane with 403 KeyBasedAuthenticationNotPermitted.

`compliance_mode = true` flips all “strict” flags on — use only for scan experiments, **not** for day-to-day apply on Free.

## Working conventions

- Do not commit `*.tfvars`, state, or secrets. `terraform.tfvars` is local-only.
- After PC moves: recreate `terraform.tfvars` from `az account show`; fix absolute paths in tooling; `terraform init`.
- Prefer documenting intentional Checkov gaps with `# checkov:skip=CKV_...: free-tier learning` over expensive fixes.
- Cheap improvements OK: TLS, soft-delete, NSG (no open SSH/RDP), storage private blobs, RBAC/Entra where practical.
- **No permanent home-IP firewall:** DE residential IPs are typically **dynamic** (change often). Fixed `ip_rules` are a bad daily ops model without PE/VPN. Keep public access for lab usability; harden with auth and data-plane controls instead.
- VM module (when enabled): SSH keys from Key Vault; B1s; no public IP on NIC by default.

## Common commands

```bash
az account show
terraform init
terraform plan
./scripts/checkov-scan.sh quick   # or full / compliance
pre-commit run --all-files
tflint --init && tflint
```

## Related skill

For Checkov triage, free-tier skip policy, and failure matrix details see:

`.grok/skills/checkov-azure-learning/SKILL.md`

Load that skill when the user asks about Checkov, open-checkov-results, compliance_mode, or hardening on Free tier.
