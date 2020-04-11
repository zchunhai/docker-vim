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
        python3.8 python3.8-distutils \
    && cd /usr/bin && ln -s pydoc3.8 pydoc && ln -s python3.8 python \
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

COPY ./script /tmp/script
# Install pip
RUN /tmp/script/install-pip.sh
# Install golang
RUN /tmp/script/install-go.sh
ENV PATH=/usr/local/go/bin:$PATH
# Install vim plugins
RUN /tmp/script/install-vim-plugins.sh
# Clean cache
RUN	rm -rf /tmp/script && rm -rf /root/.cache && rm /root/.wget-hsts

# User dotfiles
USER $HERMIT_UID
ENV HOME=/home/hermit
COPY --chown=hermit:wheel bashrc $HOME/.bashrc
COPY --chown=hermit:wheel vimrc $HOME/.vimrc
RUN vim +PluginDocs +qall!

WORKDIR $HOME/work
ENV GOPATH=$HOME/work/go
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
