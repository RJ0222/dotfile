# Bash & Iterm2 Setup

## Requirement

- JDK 1.8
- Python 3.x

## Iterm2 Macos Setup

1. Goto `Perfereance -> Appearanace -> General -> Theme` and set it to `Minimal`
2. Goto `Perfereance -> Appearanace -> Windows -> Hide scrollbars` and hook it up
3. Goto `Perfereance -> Appearanace -> Dimming -> Dim inactive split panes` and hook it up
4. Goto `Perfereance -> Advanced -> Terminal windows resize smoothly` and set it to `Yes`
5. Goto `Perfereance -> keys -> Navigation Shortcuts -> Shortcut to select a tab` and set it to `Option with number`
6. Import Rockid.json to Item2 Profiles

## Bash5 MacOS Setup

#### Copy .bash_profile to ~/.bash_profile

```
brew install bash bash-completion
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
chsh -s /usr/local/bin/bash

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh
source ~/.bash_profile

# Bash-it
# shit show completions
# shit show aliases
# BASH_PREVIEW=true shit reload

brew install wget coreutils autojump grep lrzsz ncdu
brew install mysql-client@5.7 && brew link mysql-client@5.7
```

## Font & Theme

- https://github.com/powerline/fonts
- https://github.com/Bash-it/bash-it
- https://github.com/dracula/dracula-theme
- https://github.com/Karmenzind/monaco-nerd-fonts
- https://github.com/ryanoasis/nerd-fonts

