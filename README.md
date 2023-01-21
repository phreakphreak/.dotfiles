# phreakphreak configuration files KDE Neon

## Update and  install packages

```sh
sudo pkcon refresh && sudo pkcon update -y
```

```sh
sudo apt install kubuntu-restricted-extras build-essential kio-extras git gnome-keyring seahorse curl unzip neovim wget zsh stow python3-pip synaptic -y
```

```sh
cd $HOME && git clone https://github.com/phreakphreak/.dotfiles.git
```

## Kitty terminal

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

```sh
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/
sudo cp ~/.local/kitty.app/share/applications/kitty.desktop /usr/share/applications/
sudo cp ~/.local/kitty.app/share/applications/kitty-open.desktop /usr/share/applications/
sudo sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" /usr/share/applications/kitty*.desktop
sudo sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" /usr/share/applications/kitty*.desktop
```



## Github CLI

```sh
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

## ZSH

### Oh My Zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### P10K

```sh
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

```

### Plugins

[Zsh Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

[Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Fonts

```
  cd ~/.dotfiles/fonts 
  sudo cp CascadiaCode/*.ttf /usr/share/fonts
  sudo cp FiraCode/*.ttf /usr/share/fonts
  sudo cp JetBrainsMono/*.ttf /usr/share/fonts
  sudo cp VictorMono/*.ttf /usr/share/fonts
  sudo cp DankMono/*.ttf /usr/share/fonts
  sudo cp HackNerdFont/*.ttf /usr/share/fonts
  sudo cp MonoLisa/*.ttf /usr/share/fonts
  fc-cache -v
```

### Keychain issues Arch 
```
https://code.visualstudio.com/docs/editor/settings-sync#_troubleshooting-keychain-issues
```
