# org-query

The idea of this project to is expose my org-todos as an "external api" a little
better. My main emacs can be running as a server, and through `emacsclient`
calls we can query for runtime org info.

Due to some annoyances of calling `emacsclient` directly, the main interface is
through a separate bash script `org-query` that lives at ./bin/org-query in this
repo.

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

## Testing

Tests live under emacs.d/test/org-query.
