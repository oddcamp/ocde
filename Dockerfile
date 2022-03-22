FROM ubuntu:21.04

ARG USER=oddcamp
ARG USER_ID=1000
ARG GROUP_ID=1000

ARG DEBIAN_FRONTEND=noninteractive

ARG ASDF_VERSION="v0.9.0"

ENV TZ=Etc/UTC

COPY scripts/* first-run-notice.txt /tmp/scripts/

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    dirmngr \
    iproute2 \
    procps \
    lsof \
    net-tools \
    psmisc \
    wget \
    rsync \
    unzip \
    zip \
    nano \
    less \
    jq \
    lsb-release \
    apt-transport-https \
    locales \
    sudo \
    ncdu \
    man-db \
    strace \
    manpages \
    manpages-dev \
    libreadline-dev \
    libpq-dev \
    libssl-dev \
    openssh-client \
    perl \
    tzdata \
    zlib1g-dev \
    shared-mime-info \
    htop \
    zsh \
    python2 \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Ensure at least the en_US.UTF-8 UTF-8 locale is available.
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen

# Create a non-root user to match UID/GID.
RUN addgroup --gid $GROUP_ID $USER
RUN adduser --shell /bin/bash --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

# Add add sudo support for user
RUN echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

# Move first run notice to right spot
RUN mkdir -p /usr/local/etc/vscode-dev-containers/ \
    && mv -f /tmp/scripts/first-run-notice.txt /usr/local/etc/vscode-dev-containers/

USER $USER

SHELL ["/bin/bash", "-l", "-c"]

# install and setup asdf version manager
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.profile
RUN echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

RUN chmod +x $HOME/.asdf/asdf.sh

RUN source ~/.bashrc

# install asdf plugins
RUN asdf plugin-add ruby
RUN asdf plugin-add rust
RUN asdf plugin-add nodejs
RUN asdf plugin-add yarn
RUN asdf plugin-add elixir
RUN asdf plugin-add erlang

RUN echo -e '\n. /tmp/scripts/first-run-notice.sh' >> ~/.bashrc
RUN echo -e '\n. /tmp/scripts/default-editor.sh' >> ~/.bashrc

WORKDIR /home/$USER

CMD [ "sleep", "infinity" ]
