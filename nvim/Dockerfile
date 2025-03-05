FROM ubuntu:noble
WORKDIR /root
USER root
COPY . /tmp/nvim
RUN apt-get update && apt-get install -y git python3-pip npm luarocks ripgrep fd-find python3-neovim curl
RUN npm install -g neovim
RUN chmod +x /tmp/nvim/tree-sitter-linux-x64 \
    && mkdir -p /root/.local/share/nvim/bin \
    && mv /tmp/nvim/tree-sitter-linux-x64 /root/.local/share/nvim/bin/tree-sitter \
    && ln -sf /root/.local/share/nvim/bin/tree-sitter /usr/bin/tree-sitter \
    && mv /tmp/nvim/nvim-linux-x86_64 /opt/ \
    && ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim \
    && mkdir -p .config && mv /tmp/nvim .config/nvim \
    && rm -rf /tmp/nvim && apt-get clean
ENV LANG=C.utf8 LC_ALL=C.utf8 LC_CTYPE=C.utf8 TZ=Asia/Shanghai
CMD ["sleep", "infinity"]

