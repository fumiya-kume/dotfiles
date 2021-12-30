# dotfiles [![E2E_Test](https://github.com/fumiya-kume/dotfiles/actions/workflows/e2e_test.yml/badge.svg)](https://github.com/fumiya-kume/dotfiles/actions/workflows/e2e_test.yml)

dotfiles repository for `fish`, `iTerm`, `peco`, `ghq` users!

![](https://user-images.githubusercontent.com/16269075/147844407-60c4b210-1dca-47ff-9eac-9e760ac7a113.png)

## Pros

- ✨ Setup up with one-line code
- 🧪 Test setup result with CI
- 💪 Using modern tools

# How to use 

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/fumiya-kume/dotfiles/master/bootstrap.sh)"
```

# Folder structure

|name|descriptioin|
| --- | --- |
|config|contains config files which are `.config`, `.gitconfig`, `Brewfile` and more|
|jobs|contains setup steps which is install/setup environment|
|workflow|contains workflow with some jobs|
|.github|contains Github Actions config files|

# What will do

1. Install Xcode
2. Install Homebrew
3. Copy config files
4. Set mac defaults (any preference)
5. Setup and install gn(which is build tool)
6. Test each commands
7. Setup SSH for Github
8. Setup GPG for Github

# Environment

- fish (which is great shell)
- iTerm (which is great terminal tool)
- SSH and GPG for Github (for security and useful development)

# Screenshots

![](https://user-images.githubusercontent.com/16269075/147844407-60c4b210-1dca-47ff-9eac-9e760ac7a113.png)
