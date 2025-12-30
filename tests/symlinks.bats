#!/usr/bin/env bats

@test ".zshrc is symlink" {
  [ -L "$HOME/.zshrc" ]
}

@test ".zshrc points to dotfiles" {
  run readlink "$HOME/.zshrc"
  [[ "$output" == *"dotfiles/home/.zshrc"* ]]
}

@test ".zprofile is symlink" {
  [ -L "$HOME/.zprofile" ]
}

@test ".gitconfig is symlink" {
  [ -L "$HOME/.gitconfig" ]
}

@test "starship.toml is symlink" {
  [ -L "$HOME/.config/starship.toml" ]
}

@test ".tigrc is symlink" {
  [ -L "$HOME/.tigrc" ]
}

@test "install.sh is idempotent" {
  ./install.sh
  ./install.sh
}
