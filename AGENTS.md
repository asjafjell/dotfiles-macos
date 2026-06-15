# AGENTS.md

## What this repo is

Personal macOS dotfiles for `asjafjell`. Expected clone location: `~/.dotfiles-macos`.

No standard dotfile manager (not stow/chezmoi/yadm/nix). A custom Python installer (`install.py`) reads `config.json` and runs shell commands + creates symlinks.

## No automated validation

There are no tests, no lint, no CI, no build steps, no Makefile. Nothing to run to verify changes. Edits are verified manually on the local machine.

## Running the installer

```sh
export DOTFILES=~/.dotfiles-macos   # required — install.py uses $DOTFILES via expandvars
python3 install.py                  # interactive; asks before overwriting existing symlink targets
```

The installer runs commands in `config.json` then creates symlinks. It will prompt to overwrite each conflicting destination.

## Known gaps in the installer

- **`ssh/config` is NOT symlinked**: `ssh/config` exists in the repo but has no entry in `config.json`. Must be linked manually: `ln -s ~/.dotfiles-macos/ssh/config ~/.ssh/config`
- **`.oh-my-zsh` step will fail**: `config.json` references `$DOTFILES/.oh-my-zsh` which does not exist. Oh My Zsh must be installed manually before or after the installer runs.
- **`$HOME/.github/` symlink is acknowledged broken**: See commit history.

## Key config files and their symlink destinations

| Repo path | Symlinked to |
|---|---|
| `zsh/.zshrc` | `~/.zshrc` |
| `git/.gitconfig` | `~/.gitconfig` |
| `ghostty/config` | `~/.config/ghostty/config` |
| `github/` | `~/.github/` (broken) |
| `ssh/config` | `~/.ssh/config` (not in installer) |

## Git commit signing

`git/.gitconfig` has `commit.gpgsign = true` using 1Password's SSH agent. All commits from this machine are signed. Requires 1Password and its SSH agent to be running and unlocked.

## Zsh / Powerlevel10k quirk

Two separate p10k configs exist — `zsh/.p10k-ghostty.zsh` and `zsh/.p10k-intellij.zsh`. `.zshrc` selects between them at shell start based on `$TERMINAL_EMULATOR`. Editing one does not affect the other.

## Hardcoded paths

`zsh/.zshrc` contains hardcoded `/Users/aas/` paths (`PNPM_HOME`, `.dotnet/tools`). These will not work for any other username without editing.

## Brewfile notes

- `opencode` is installed via a custom tap: `anomalyco/tap/opencode` — not in the standard Homebrew index.
- Java casks (`temurin@17`, `temurin@21`) must be installed before `.javaconfig` runs successfully (it references `/Library/Java/JavaVirtualMachines/temurin-17.jdk` etc.).

## Committed `.venv/`

A Python 3.9 venv at `.venv/` is committed to the repo. It is linked to the macOS CLT Python at `/Library/Developer/CommandLineTools/...`. Do not delete or replace it without understanding the dependency.
