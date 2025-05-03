#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


set -e  # 有錯誤就停止，避免意外覆蓋重要檔案

# symlink function（帶防呆提示）
link_file() {
    local src=$1
    local dest=$2

    if [[ -e "$dest" ]] || [[ -L "$dest" ]]; then
        echo "⚠️  已存在：$dest，略過連結"
    else
        ln -s "$src" "$dest"
        echo "✅  已建立 symlink: $dest -> $src"
    fi
}

noBackup=("install.sh" "bak")

# 檢查是否有備份
if [[ ! -d ${DIR}/bak ]]; then
    mkdir -p ${DIR}/bak
    for i in $(ls ${DIR}); do
        if [[ ${noBackup[*]} =~ ${i} ]]; then
            continue
        fi
        cp -Lrp ${HOME}/."${i}" ${DIR}/bak/${i}
    done
else
    echo no backup
fi

echo "🔵 開始安裝 dotfiles symlink..."
# 建立基本的 symlink

for i in $(ls ${DIR}); do
    if [[ ${noBackup[*]} =~ ${i} ]]; then
        continue
    fi
    link_file "${HOME}/.${i}" "${DIR}/${i}"
done

echo "🏁 安裝完成！記得 source ~/.bashrc 或重新登入。"

