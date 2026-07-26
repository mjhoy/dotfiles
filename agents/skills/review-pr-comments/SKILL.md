---
name: review-pr-comments
description: Address PR review comments one by one with commits in between.
argument-hint: [PR number] (optional - defaults to current branch's PR)
allowed-tools: [Bash, Read, TodoWrite, AskUserQuestion, Edit, Write, Grep, Glob]
---

# Review comments

Automate responding to GitHub review comments.

## Workflow

1. Fetch PR comments. Use the PR for the current branch. Parse and number all
   comments.
2. Create a todo list with one item per selected comment.
3. Go through the list, implementing a fix. Wait between each one for me to
   review and commit.
