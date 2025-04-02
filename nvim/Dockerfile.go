FROM golang:1.24.1
ARG USER=nvim
RUN cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.bak \
    && echo "" > /etc/apt/sources.list.d/debian.sources \ 
    && echo "Types: deb" > /etc/apt/sources.list.d/debian.sources \ 
    && echo "URIs: https://mirrors.tuna.tsinghua.edu.cn/debian" >> /etc/apt/sources.list.d/debian.sources \ 
    && echo "Suites: bookworm bookworm-updates bookworm-backports" >> /etc/apt/sources.list.d/debian.sources \ 
    && echo "Components: main contrib non-free non-free-firmware" >> /etc/apt/sources.list.d/debian.sources \ 
    && echo "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" >> /etc/apt/sources.list.d/debian.sources 
RUN apt-get update \
    && apt-get install -y git luarocks ripgrep fd-find curl wget sudo \ 
    && apt-get clean \
    && useradd -m -s /bin/bash ${USER} \
    && usermod -aG sudo ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chown -R ${USER}:${USER} /go

USER ${USER}
ENV HOME=/home/${USER}
WORKDIR $HOME
RUN mkdir -p $HOME/bin \
    && mkdir -p $HOME/apps \ 
    && mkdir -p $HOME/.config \
    && mkdir -p $HOME/.local/share/nvim/lazy \
    && git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable $HOME/.local/share/nvim/lazy/lazy.nvim \ 
    && wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.3/tree-sitter-linux-x64.gz \
    && gzip -d tree-sitter-linux-x64.gz \
    && chmod +x tree-sitter-linux-x64 \
    && mkdir -p $HOME/.local/share/nvim/bin \
    && mv tree-sitter-linux-x64 $HOME/.local/share/nvim/bin/tree-sitter \
    && ln -sf $HOME/.local/share/nvim/bin/tree-sitter $HOME/bin/tree-sitter \
    && wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && tar -xzf nvim-linux-x86_64.tar.gz \
    && mv nvim-linux-x86_64 $HOME/apps/ \
    && ln -sf $HOME/apps/nvim-linux-x86_64/bin/nvim $HOME/bin/nvim \
    && rm nvim-linux-x86_64.tar.gz \
    && go env -w GOPROXY=https://goproxy.io,direct \
    && go env -w GO111MODULE='auto'

COPY --chown=${USER}:${USER} . $HOME/.config/nvim
RUN cd $HOME/.config/nvim \ 
    && sed -i 's/require("plugins-config.lsp.lua")/-- require("plugins-config.lsp.lua")/' init.lua \ 
    && sed -i 's/require("plugins-config.lsp.python")/-- require("plugins-config.lsp.python")/' init.lua
ENV PATH="$HOME/bin:$PATH"
ENV LANG=C.utf8 LC_ALL=C.utf8 LC_CTYPE=C.utf8 TZ=Asia/Shanghai
CMD ["sleep", "infinity"]

