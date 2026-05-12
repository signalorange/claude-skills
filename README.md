# SignalORange Claude Skills

A [Claude Code plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces) for skills built and maintained by SignalORange.

## Install

```bash
/plugin marketplace add signalorange/claude-skills
/plugin install logbook@signalorange
```

Browse everything available with `/plugin marketplace browse` once the marketplace is added.

## Plugins

| Plugin | Source | Status |
| --- | --- | --- |
| `logbook` | [`signalorange/logbook-skill`](https://github.com/signalorange/logbook-skill) | Available |
| `artemis` | `./plugins/artemis` | Placeholder |
| `meridian` | `./plugins/meridian` | Placeholder |

### logbook

A portable structure for AI-friendly codebases: feature specs (`feat-<slug>.md`), `ideas.md`, `LOGBOOK.md` index, and ship/promote workflows. Distributed from its own repo at [`signalorange/logbook-skill`](https://github.com/signalorange/logbook-skill).

Invoke with `/logbook:<skill-name>`.

### artemis, meridian

Placeholder entries reserving marketplace slots. Each ships a stub skill that explains it is not yet implemented. Replace `plugins/<name>/skills/<name>/SKILL.md` with the real skill content (and update `plugin.json`) when ready, or convert the entry to a GitHub source in `.claude-plugin/marketplace.json`.

## Repo layout

```
claude-skills/
├── .claude-plugin/
│   └── marketplace.json        ← catalog
├── plugins/
│   ├── artemis/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/artemis/SKILL.md
│   └── meridian/
│       ├── .claude-plugin/plugin.json
│       └── skills/meridian/SKILL.md
└── README.md
```

External plugins (like `logbook`) do not appear under `plugins/` — they are fetched from their own repos at install time, defined by their `source` in `marketplace.json`.

## Adding a new plugin

1. Either:
   - **Local**: create `plugins/<name>/.claude-plugin/plugin.json` and `plugins/<name>/skills/<name>/SKILL.md`, then add an entry with `"source": "./plugins/<name>"` to `marketplace.json`; or
   - **External**: add an entry with `"source": { "source": "github", "repo": "signalorange/<repo>" }` to `marketplace.json`. The referenced repo must contain its own `.claude-plugin/plugin.json` and `skills/` directory.
2. Commit and push. Users pick up the change with `/plugin marketplace update signalorange`.

## Versioning

No `version` is pinned in `marketplace.json`, so every commit on the default branch is treated as a new release. To pin, add `"version": "x.y.z"` to a plugin entry (or to its `plugin.json`) and bump on each release.

## Reserved marketplace name

The marketplace identifier is `signalorange` (see `name` in `marketplace.json`). Users install plugins via `<plugin>@signalorange`.
