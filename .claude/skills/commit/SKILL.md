---
name: commit
description: Stage and commit changes with a simple, concise message after analyzing the diff. Use when asked to commit, save work, or check in changes. Writes plain commit messages with NO co-author/trailer lines. Warns before committing when the diff spans multiple projects or mixes unrelated changes — cases where splitting into separate commits would give cleaner version control.
---

# Commit

Analyze the working changes, write a simple commit message, and commit. This repo organizes work into per-lesson `NN_projectname/` directories, so commits should usually stay scoped to one project.

## Rules

- **No trailers.** Do NOT add `Co-Authored-By`, `Generated with`, or any trailer/footer line. Just the message.
- **Keep it simple.** A short imperative subject (~50 chars). Add a one-line body only if the *why* isn't obvious from the subject. No bullet-point essays.
- **Commit only what's intended.** If files are already staged, respect that staging. Otherwise stage the relevant changed files. Don't blindly `git add -A` if untracked junk is present.

## Workflow

1. Run `git status` and `git diff` (and `git diff --cached` if anything is staged) to see the full picture.
2. **Check whether one commit is appropriate** — see the split check below. If a split is warranted, STOP and warn the user before committing.
3. Stage the relevant files and commit with a plain message.
4. Report the commit hash and one-line summary.

## Split check — warn when >1 commit would be better

Before committing, evaluate whether the diff should be **multiple commits**. Warn the user (and propose a split) when any of these hold:

- **Multiple project directories touched** — e.g. changes in both `06_debounce_counter/` and `08_counter_2/`. Each lesson is independent; mixing them buries history.
- **Project-wide / infra changes mixed with project work** — e.g. editing `CLAUDE.md`, `README.md`, `.claude/`, or `docs/` *in the same diff* as a `.v` change inside a lesson. Repo-wide changes belong in their own commit.
- **Unrelated concerns in one project** — e.g. a bug fix plus a new feature plus a refactor that don't share a single logical purpose.

When you detect this, do **not** commit silently. Present a short proposed split, e.g.:

> ⚠️ This diff spans 2 areas — I'd suggest 2 commits:
> 1. `docs: ...` — CLAUDE.md + skill changes
> 2. `06_debounce_counter: fix ...` — the Verilog fix
>
> Want me to split them, or commit as one?

Then proceed based on the user's choice. If the diff is cohesive (one project, one logical change), just commit — no need to ask.

## Message style

- Prefix with the project folder when scoped to one, e.g. `06_debounce_counter: fix wire/reg on debounced signals`.
- Use `docs:` / `repo:` for repo-wide changes (CLAUDE.md, README, skills, docs).
- Imperative mood: "add", "fix", "update" — not "added"/"fixes".
