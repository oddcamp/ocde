FROM ubuntu:22.04

ARG USER=oddcamp
ARG USER_ID=1000
ARG GROUP_ID=1000

ARG DEBIAN_FRONTEND=noninteractive

ARG ASDF_VERSION="v0.9.0"
ENV ASDF_DATA_DIR="/home/$USER/.asdf/data"


ENV TZ=Etc/UTC

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
    inotify-tools \
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
    postgresql-client \
    imagemagick \
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

COPY --chown=${USER_ID}:${GROUP_ID} scripts/* /home/$USER/scripts/

# Copy first run notice to the right spot for vscode
COPY first-run-notice.txt /usr/local/etc/vscode-dev-containers/

USER $USER

SHELL ["/bin/bash", "-l", "-c"]

COPY --chown=${USER_ID}:${GROUP_ID} scripts/* /home/$USER/scripts/

# install and setup asdf version manager
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.profile
RUN echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

RUN chmod +x $HOME/.asdf/asdf.sh
RUN chmod +x $HOME/scripts/asdf-init.sh

RUN mkdir ~/.asdf/data

RUN source ~/.bashrc

RUN echo -e '\n. $HOME/scripts/first-run-notice.sh' >> ~/.bashrc
RUN echo -e '\n. $HOME/scripts/default-editor.sh' >> ~/.bashrc

WORKDIR /home/$USER

CMD [ "sleep", "infinity" ]
