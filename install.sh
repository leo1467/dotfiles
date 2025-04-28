#!/usr/bin/env bash

set -e  # 有錯誤就停止，避免意外覆蓋重要檔案

echo "🔵 開始安裝 dotfiles symlink..."

# Dotfiles 根目錄
DOTFILES_DIR=$(pwd)

# 目標是 HOME
TARGET_DIR="$HOME"

# symlink function（帶防呆提示）
link_file() {
    local src=$1
    local dest=$2

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "⚠️  已存在：$dest，略過連結"
    else
        ln -s "$src" "$dest"
        echo "✅  已建立 symlink: $dest -> $src"
    fi
}

# 建立基本的 symlink
link_file "$DOTFILES_DIR/.bashrc" "$TARGET_DIR/.bashrc"
link_file "$DOTFILES_DIR/.vimrc" "$TARGET_DIR/.vimrc"
link_file "$DOTFILES_DIR/.tmux.conf" "$TARGET_DIR/.tmux.conf"
link_file "$DOTFILES_DIR/.gitconfig" "$TARGET_DIR/.gitconfig"
link_file "$DOTFILES_DIR/.gdbinit" "$TARGET_DIR/.gdbinit"

# Vim 資料夾（plugin / 配色）
if [ -d "$DOTFILES_DIR/.vim" ]; then
    link_file "$DOTFILES_DIR/.vim" "$TARGET_DIR/.vim"
fi

# .local/bin（自定小工具）
if [ -d "$DOTFILES_DIR/.local/bin" ]; then
    mkdir -p "$TARGET_DIR/.local"
    link_file "$DOTFILES_DIR/.local/bin" "$TARGET_DIR/.local/bin"
fi

# .config/coc（vim LSP client設定）
if [ -d "$DOTFILES_DIR/.config/coc" ]; then
    mkdir -p "$TARGET_DIR/.config"
    link_file "$DOTFILES_DIR/.config/coc" "$TARGET_DIR/.config/coc"
fi

echo "🏁 安裝完成！記得 source ~/.bashrc 或重新登入。"

