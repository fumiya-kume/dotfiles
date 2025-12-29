# dotfiles

```bash
mkdir -p ~/dotfiles && curl -fsSL https://github.com/fumiya-kume/dotfiles/archive/refs/heads/master.tar.gz | tar -xz -C ~/dotfiles --strip-components=1 && ~/dotfiles/install.sh
```

## SSH keys (1Password)

This repo uses the 1Password SSH agent. Enable “Use SSH agent” in 1Password and keep your SSH keys in 1Password. The SSH config points to the 1Password agent socket, and key selection is configured in `~/.config/1Password/ssh/agent.toml`.
