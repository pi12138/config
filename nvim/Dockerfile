FROM ubuntu:noble
WORKDIR /root
USER root
COPY . /tmp/nvim
ENV LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8 LC_CTYPE=zh_CN.UTF-8
RUN apt update && apt install -y git python3-pip curl wget npm luarocks ripgrep fd-find gzip python3-neovim
RUN npm install -g neovim
RUN mkdir -p Downloads && cd Downloads && wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.3/tree-sitter-linux-x64.gz \
    && gzip -d tree-sitter-linux-x64.gz && chmod +x tree-sitter-linux-x64 && mkdir -p /root/.local/share/nvim/bin \
    && mv tree-sitter-linux-x64 /root/.local/share/nvim/bin/tree-sitter \
    && ln -sf /root/.local/share/nvim/bin/tree-sitter /usr/bin/tree-sitter 
RUN cd Downloads && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && rm -rf /opt/nvim && tar -C /opt -xzf nvim-linux-x86_64.tar.gz \
    && ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim && rm nvim-linux-x86_64.tar.gz \
    && apt clean
RUN mkdir -p .config && mv /tmp/nvim .config/nvim
CMD ["sleep", "infinity"]

