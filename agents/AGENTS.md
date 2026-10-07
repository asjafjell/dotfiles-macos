# Global agent instructions

## Git

- Never use git worktrees. Do not run `git worktree add`, do not create directories under `.claude/worktrees/`, and do not use
  any tool or agent option that isolates work in a worktree. Worktrees confuse me and lead to mistakes.
- Do all work in the repository's main checkout. When a change belongs on another branch, switch branches there.
