# Installing the Meridian Skill

## Step 1 — Add the skill folder to your Claude client

Unzip the downloaded file. Place the `meridian-skill/` folder wherever your
Claude client looks for skills (e.g., `~/.claude/skills/meridian/`).

## Step 2 — Set your environment variables

```bash
export MERIDIAN_BASE_URL={{MERIDIAN_BASE_URL}}
export MERIDIAN_API_KEY=<paste your key here>
```

Your API key is generated on the **Integrations** page in Meridian
(`{{MERIDIAN_BASE_URL}}/settings/integrations`). Create a key, copy it once
— Meridian will not show it again.

**Never paste your API key into the zip, a config file, or source control.**
The key is intentionally omitted from this bundle.

## Verifying the setup

```bash
./scripts/meridian_request.sh GET /api/meridian/v1/me
```

You should see your user, organization, and permissions in the JSON response.

## The `meridian_request.sh` helper (optional)

`scripts/meridian_request.sh` is a thin curl wrapper for testing and
ad-hoc requests. The skill itself calls the API directly; the script is
for humans during setup and debugging.

Usage:
```
./scripts/meridian_request.sh METHOD /path [body.json]
```

Examples:
```bash
./scripts/meridian_request.sh GET /api/meridian/v1/clients
./scripts/meridian_request.sh POST /api/meridian/v1/knowledge body.json
```
