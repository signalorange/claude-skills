---
name: meridian
description: Use when the user mentions Meridian, their CRM, opportunities,
  proposals, clients, knowledge base, projects, or asks to look up / draft
  content tied to their Meridian organization.
version: 0.0.0
---

<!-- version: 0.0.0 is a placeholder. The mix meridian.skill.build task replaces
     it with the actual app version from mix.exs at build time. Do not edit
     the version field in this source file manually. -->

# Meridian Skill

You can interact with the user's Meridian organization through a REST API.
Treat it exactly like the user themselves working in Meridian — every call
is scoped to their organization and their personal permissions.

## Authentication

- Base URL: env var `MERIDIAN_BASE_URL`
- Header: `Authorization: Bearer $MERIDIAN_API_KEY`

## First call — always

Call `GET /api/meridian/v1/me` at the start of any Meridian-related task.
The `permissions` array tells you which operations the user can perform.
**Do not attempt a write the user lacks permission for.** Read
`api-reference.md` for the full endpoint list.

## When NOT to use this skill

- The user is asking about Meridian-as-a-product (pricing, marketing) —
  answer from training.
- The user wants to use Meridian's LLM Router (chat completions, embeddings)
  — that's a different API surface; this skill does not cover it.

## Common flows

### Draft a proposal from an opportunity
1. `GET /opportunities/:id` for context.
2. `GET /proposals?opportunity_id=:id` for prior drafts.
3. Discuss approach with the user. **Do not POST a draft without confirming**.
4. `POST /proposals` with the agreed body.

### Suggest a KB article from a chat
1. `POST /knowledge` — note this **enters an approval queue**, it does NOT
   publish. Tell the user "I queued an article for your approval", not
   "I published one."

## See also
- `api-reference.md` — full endpoint list, fields, examples.
- `INSTALL.md` — only relevant during setup; do not load during normal use.
