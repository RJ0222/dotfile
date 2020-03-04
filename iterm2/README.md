# Bash & Iterm2 enviroment for Rockid

## Requirement

- Java 8
- Python 3

## Iterm2 Macos Setup

1. Open `Perfereance -> Appearanace -> General -> Theme` and set it to `Minimal`
2. Goto `Perfereance -> Appearanace -> Windows -> Hide scrollbars` and hook it up
3. Goto `Perfereance -> Appearanace -> Dimming -> Dim inactive split panes` and hook it up
4. Open `Perfereance -> Advanced  -> Terminal windows resize smoothly` and set it to `Yes`
5. Import Rockid.json to Item2 Profiles

## Bash5 MacOS Setup

Copy .bash_profile to ~/.bash_profile

```
brew install bash bash-completion
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
chsh -s /usr/local/bin/bash

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh
source ~/.bash_profile

shit show completions
shit show aliases

BASH_PREVIEW=true shit reload

brew install coreutils autojump grep lrzsz ncdu
brew install mysql-client@5.7
brew install node@10
```

## MacOS Cursor & Mouse Setup
```
# Turn off mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# Turn off scrolling acceleration
defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1

# Adjust cursor speed to unlimit
defaults write NSGlobalDomain KeyRepeat -int 0
```
