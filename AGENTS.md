# Private-Terraform — Agent Context

Private Azure learning lab (IaC). Owner uses **Azure Free / no spend budget**. Prefer free or near-free patterns; never push cost-heavy “compliance by default.”

## Environment constraints (non-negotiable)

- **Budget:** Azure Free / learning only — no private endpoints, no CMK, no GRS/ZRS “for Checkov,” no Log Analytics unless explicitly requested.
- **Auth:** Azure CLI (`az login`) + user identity. Local-only values in `terraform.tfvars` (gitignored; see `terraform.tfvars.example`): `subscription_id`, `global_admin_object_id`. Or `TF_VAR_*` / `ARM_SUBSCRIPTION_ID`. **Tenant ID** is not committed — taken from `data.azurerm_client_config.current` at plan/apply time.
- **State:** Remote backend `azurerm` — `rg-terraform-state` / `sa00tfstateservices` / `sc00terraform` / key `terraform.tfstate`.
- **Host:** PikaOS (Debian sid, codename `nest`). HashiCorp apt needs a **supported** distro codename (e.g. `noble`), not `nest`/`sid`. Use `pkexec` for GUI sudo (no password in agent TTY).
- **Editors:** Prefer native `code` (apt). Flatpak VS Code cannot see host `/usr/bin/terraform`.

## Stack

| Tool | Notes |
|------|--------|
| Terraform | `required_version = ">= 1.15.0"`; `azurerm` `~> 4.0` |
| Azure CLI | Source of truth for active subscription |
| pre-commit | fmt, tflint (config `.tflint.hcl`), terraform-docs |
| checkov | `scripts/checkov-scan.sh`; results under `open-checkov-results/` |
| tflint | azurerm plugin per `.tflint.hcl` |

## Layout

```
main.tf                 # module "subscription"
provider.tf             # azurerm + remote backend
variables.tf            # subscription_id
subscription/           # one module scope (flat .tf files, not nested packages)
  rg-services.tf        # RG, storage, key vault (fixed free-lab baseline)
  rg-network.tf         # RG, VNet, subnets, NSG association
  rg-compute.tf         # RG + lab VM (plan/wiring test; cost if applied)
  variables.tf          # global_admin_object_id (no secrets/defaults)
modules/                # resource_group, storage_account, key_vault, vnet, nsg, vm_linux
scripts/checkov-scan.sh
.pre-commit-config.yaml # tflint --config=.tflint.hcl (relative, not host-absolute)
```

Region: **West Europe**. No tenant/admin object IDs in git — only `terraform.tfvars` / live Entra session.

Flat files under `subscription/` share one module namespace (VM can reference VNet outputs directly). Reusable building blocks stay in `modules/`.

## Lab security baseline (fixed — no compliance_mode)

One honest Free-lab config. Expensive Checkov items are **skipped with reasons**, not toggled.

| Setting | Value | Why |
|---------|-------|-----|
| Public network (Storage + KV) | on | dynamic home IP, no PE/VPN |
| KV network ACLs / home IP rules | off | DE residential IP changes; locks out UI/CLI |
| Shared access keys (`sa00services`) | **off** | Entra ID + RBAC data plane (not the state SA) |
| Anonymous blob access | off | private containers |
| Private endpoints / CMK / GRS-ZRS | not implemented | cost / overkill for lab |
| KV soft-delete + purge protection | on | free, production-like |
| Blob diagnostic logs | off by default | optional module flag; log storage cost |
| VNet flow logs | off by default | optional in `subscription/rg-network.tf`; storage cost |

Provider must set `storage_use_azuread = true` when keys are disabled — otherwise plan/refresh fails on queue/share data plane with 403 KeyBasedAuthenticationNotPermitted.

Checkov CKV2_AZURE_21 wants Log Analytics Storage Insights (keys + LA cost); we skip and keep optional diagnostic settings in the storage module instead.

## Module / package file layout

In every Terraform module (and subscription packages under `subscription/`), split by block type:

| Block | File |
|-------|------|
| `resource` / nested `module` calls | `main.tf` |
| `data` | `data.tf` |
| `variable` | `variables.tf` |
| `output` | `outputs.tf`  |
| `locals` | `locals.tf` |

Do not mix types across files. Omit empty files (no empty `data.tf` placeholders).

## Working conventions

- Do not commit `*.tfvars`, state, or secrets. `terraform.tfvars` is local-only.
- After PC moves: recreate `terraform.tfvars` from `terraform.tfvars.example` + `az account show` / `az ad signed-in-user show`; fix absolute paths in tooling; `terraform init`.
- Prefer documenting intentional Checkov gaps with `# checkov:skip=CKV_...: free-tier learning` over expensive fixes.
- Cheap improvements OK: TLS, soft-delete, NSG (no open SSH/RDP), storage private blobs, RBAC/Entra where practical.
- **No permanent home-IP firewall:** DE residential IPs are typically **dynamic** (change often). Fixed `ip_rules` are a bad daily ops model without PE/VPN. Keep public access for lab usability; harden with auth and data-plane controls instead.
- VM module (when enabled): SSH keys from Key Vault; B1s; no public IP on NIC by default.

## Common commands

```bash
az account show
terraform init
terraform plan
./scripts/checkov-scan.sh quick   # or full / ci
pre-commit run --all-files
tflint --init && tflint
```

## Related skill

For Checkov triage, free-tier skip policy, and failure matrix details see:

`.grok/skills/checkov-azure-learning/SKILL.md`

Load that skill when the user asks about Checkov, open-checkov-results, hardening, or Free-tier cost tradeoffs.
