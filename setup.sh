#!/bin/bash

set -e

echo "🛠️ dotfiles セットアップ開始っ！"

DOTFILES_DIR="$HOME/dotfiles"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
EXCLUDE_LIST=(".git")

# === 0. Oh My Zsh のインストール ===
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💡 Oh My Zsh が見つからないのでインストールするよ〜！"

  if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  elif command -v wget >/dev/null 2>&1; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo "❌ curl か wget が必要だよ〜！インストールしてからもう一回やってねっ"
    exit 1
  fi

  echo "✅ Oh My Zsh インストール完了っ✨"
else
  echo "✅ Oh My Zsh はすでに入ってるみたい！"
fi

# === 1. dotfiles 内の dotfile をホームにリンク（.git など除く） ===
echo "🔗 dotfiles をリンク中..."

for file in "$DOTFILES_DIR"/.*; do
  filename="$(basename "$file")"

  [[ "$filename" == "." || "$filename" == ".." || "$filename" == ".git" ]] && continue

  src="$file"
  dest="$HOME/$filename"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "⚠️ $dest がすでにあるからバックアップするね → $dest.backup"
    mv "$dest" "$dest.backup"
  fi

  ln -sf "$src" "$dest"
  echo "✅ $dest → $src"
done

# === 2. プラグインのインストール ===
echo "🔌 Oh My Zsh プラグインをインストール中..."

declare -A plugins=(
  [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions"
  [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting"
)

for plugin in "${!plugins[@]}"; do
  path="$ZSH_CUSTOM/plugins/$plugin"
  url="${plugins[$plugin]}"

  if [ ! -d "$path" ]; then
    echo "📦 Installing plugin: $plugin ..."
    git clone "$url" "$path"
    echo "✅ $plugin installed"
  else
    echo "✅ $plugin already installed"
  fi
done

# === 3. テーマのインストール（Powerlevel10k） ===
echo "🎨 Powerlevel10k テーマをインストール中..."

declare -A themes=(
  [powerlevel10k]="https://github.com/romkatv/powerlevel10k.git"
)

for theme in "${!themes[@]}"; do
  path="$ZSH_CUSTOM/themes/$theme"
  url="${themes[$theme]}"

  if [ ! -d "$path" ]; then
    echo "🎨 Installing theme: $theme ..."
    git clone --depth=1 "$url" "$path"
    echo "✅ $theme installed"
  else
    echo "✅ $theme already installed"
  fi
done

echo "🎉 dotfiles セットアップ完了だよ〜！ばんざ〜いっ🙌💕"
