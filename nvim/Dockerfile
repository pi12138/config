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
    && apt-get install -y git python3-pip npm luarocks ripgrep fd-find python3-neovim curl wget sudo \ 
    && apt-get clean
RUN npm install -g neovim \
    && wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.3/tree-sitter-linux-x64.gz \
    && gzip -d tree-sitter-linux-x64.gz \
    && chmod +x tree-sitter-linux-x64 \
    && mkdir -p /root/.local/share/nvim/bin \
    && mv tree-sitter-linux-x64 /root/.local/share/nvim/bin/tree-sitter \
    && ln -sf /root/.local/share/nvim/bin/tree-sitter /usr/bin/tree-sitter \
    && wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && tar -xzf nvim-linux-x86_64.tar.gz \
    && mv nvim-linux-x86_64 /opt/ \
    && ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim \
    && rm nvim-linux-x86_64.tar.gz \
    && mkdir -p .config \
    && useradd -m -s /bin/bash ${USER} \
    && usermod -aG sudo ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chown -R ${USER}:${USER} /go
COPY . /root/.config/nvim

USER ${USER}
WORKDIR /home/${USER}
RUN go env -w GOPROXY=https://goproxy.io,direct \
    && go env -w GO111MODULE='auto' \ 
    && go install golang.org/x/tools/gopls@latest \
    && go clean -cache -modcache

ENV LANG=C.utf8 LC_ALL=C.utf8 LC_CTYPE=C.utf8 TZ=Asia/Shanghai
CMD ["sleep", "infinity"]

