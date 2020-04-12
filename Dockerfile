FROM ubuntu:20.04

RUN apt update && apt install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/vim \
    && apt update \
    && apt install -y --no-install-recommends \
		sudo git tree iputils-ping \
		wget curl ca-certificates \
		make g++ gcc libc6-dev \
		locales pkg-config \
        vim ctags silversearcher-ag \
        python3 python3-pip python3-venv python3-doc python3-distutils \
    && cd /usr/bin && ln -s pydoc3 pydoc && ln -s python3 python && ln -s pip3 pip \
    && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i -e 's/# \(en_US\.UTF-8 .*\)/\1/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Add user hermit
ENV HERMIT_UID=1000 \
    HERMIT_USER=hermit
RUN groupadd wheel -g 11 \
    && echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su \
    && useradd -m -s /bin/bash -N -g wheel -u $HERMIT_UID $HERMIT_USER \
    && echo "$HERMIT_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install golang
ENV GOLANG_VERSION=1.14 \
    PATH=/usr/local/go/bin:$PATH
RUN curl -sL "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" | tar xzf - -C /usr/local/

# User dotfiles
USER $HERMIT_UID
ENV HOME=/home/hermit \
    GOPATH=/home/hermit/work/go \
    GOBIN=/home/hermit/.local/go/bin \
    PATH=/home/hermit/.local/go/bin:/home/hermit/.local/bin:$PATH
COPY --chown=hermit:wheel bashrc $HOME/.bashrc
COPY --chown=hermit:wheel vimrc $HOME/.vimrc

# Install vim plugins
RUN mkdir -p $HOME/.vim/swapfiles \
    && curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && (yes | vim +PlugInstall +qall!)

WORKDIR $HOME/work
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
