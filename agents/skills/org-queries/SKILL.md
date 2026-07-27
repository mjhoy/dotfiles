---
name: org-queries
description: How to query my personal org files.
---

For my personal TODO tracking, I use emacs org-mode. The files live in the ~/org
directory. For ease of use, I have a script named `org-query` that hits my
running emacs instance and produces structured json output for common
queries.

All queries run against files defined in `org-agenda-files`.

## Usage

```bash
org-query <command> [tags]
```

### Commands

| Command     | Description                                 |
|-------------|---------------------------------------------|
| `todos`     | All entries with any TODO state             |
| `active`    | Active entries (TODO, NEXT, REVIEW, DEPLOY) |
| `next`      | Only NEXT entries                           |
| `scheduled` | Only entries with a SCHEDULED date          |
| `deadlines` | Only entries with a DEADLINE date           |

### Tag filtering

Optional second argument filters by tags:

```bash
org-query active work          # active items tagged :work:
org-query scheduled work,home  # scheduled items tagged :work: or :home:
```

## Output

JSON array of entries:

```json
[
  {
    "heading": "Write documentation",
    "state": "NEXT",
    "file": "/Users/me/org/projects.org",
    "line": 42,
    "tags": ["work", "docs"],
    "scheduled": "2026-02-01",
    "deadline": "2026-02-05"
  }
]
```

You can pipe the output to a program like `jq` to slice out specific bits of
data.

If you are looking at work TODOs, _always_ use the 'work' tag.
