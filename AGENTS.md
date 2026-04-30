# AGENTS.md

## Boundaries
- This is a personal Ansible playbook repo from personal repository. It's based on a popular [macOS setup](https://github.com/geerlingguy/mac-dev-playbook) by [](https://github.com/geerlingguy).
- `overrides/` is a separate manually cloned git checkout for company-specific settings, not a submodule. Manage and commit it separately from the root repo.
- Do not run provisioning yourself unless the user explicitly asks. That includes `ansible-playbook main.yml`, tagged playbook runs, and `tests/uninstall-homebrew.sh`.

## Wiring
- Entry point: `main.yml`.
- `main.yml` loads variables from `default.config.yml`, then root `config.yml` if present, then every `overrides/*.yml`.
- Use the right config layer:
  - `default.config.yml`: shared defaults
  - `config.yml`: this machine's real local config
  - `overrides/*.yml`: company-specific overrides loaded automatically
- Dotfiles mostly live outside this repo: `tasks/render-dotfiles.yml` clones `dotfiles_repo` to `dotfiles_repo_local_destination` and renders templates from that external repo before the `geerlingguy.dotfiles` role links files.

## Commands
- Install roles/collections: `ansible-galaxy install -r requirements.yml`
- Fast verification: `ansible-playbook main.yml --syntax-check`
- CI lint order: `yamllint .` then `ansible-lint`
- Useful tags from `main.yml`: `dotfiles`, `homebrew`, `mas`, `dock`, `sudoers`, `terminal`, `osx`, `extra-packages`, `sublime-text`, `dev-env`, `post`

## CI Notes
- Root `ansible.cfg` uses `inventory`, `become=true`, and `roles_path=./roles:/etc/ansible/roles`; root `inventory` targets local `127.0.0.1`.
- CI does not use the checked-in personal `config.yml`; it copies `tests/ansible.cfg`, `tests/inventory`, and `tests/config.yml` into the repo root before running syntax-check, a full `ansible-playbook main.yml`, and an idempotence rerun.


## Rules
- Don't trigger ansible provisioning on yourself
- After changes check if TODO leftovers about change are still there (in TODOs.md and other TODOs across the whole codebase)