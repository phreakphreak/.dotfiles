# phreakphreak configuration files

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
- Dank Mono
- MonoLisa
