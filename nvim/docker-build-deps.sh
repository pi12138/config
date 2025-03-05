#!/bin/bash

set -e

download_if_not_exists() {
  local FILENAME=$1
  local URL=$2

  # 检查文件是否存在
  if [ -f "$FILENAME" ]; then
    echo "File '$FILENAME' already exists. Skipping download."
    return 0
  fi

  # 下载文件
  echo "Downloading '$FILENAME' from '$URL'..."
  wget -O "$FILENAME" "$URL"

  # 检查下载是否成功
  if [ $? -eq 0 ]; then
    echo "Download completed successfully."
  else
    echo "Download failed. Please check the URL and try again."
    return 1
  fi
}

download_if_not_exists "tree-sitter-linux-x64.gz" "https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.3/tree-sitter-linux-x64.gz"
gzip -d tree-sitter-linux-x64.gz


download_if_not_exists "nvim-linux-x86_64.tar.gz" "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
tar -xzf nvim-linux-x86_64.tar.gz 
