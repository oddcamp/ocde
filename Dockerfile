FROM ubuntu:20.04

ARG USER=oddcamp
ARG USER_ID=1000
ARG GROUP_ID=1000

ARG DEBIAN_FRONTEND=noninteractive

ARG ASDF_VERSION="v0.8.1"

ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg \
    libreadline-dev \
    libpq-dev \
    libssl-dev \
    openssh-client \
    perl \
    tzdata \
    zlib1g-dev \
    shared-mime-info \
    htop \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --gid $GROUP_ID $USER
RUN adduser --shell /bin/bash --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

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

# The plugin below allows installation of pre-compiled Erlang releases
# making it possile to not having to compile them.
# NOTE: Keep this up2date with ubuntu versions
RUN asdf plugin-add erlang https://github.com/michallepicki/asdf-erlang-prebuilt-ubuntu-20.04.git

# Autoinstall Bundler for all ruby versions
RUN echo "bundler" >> $HOME/.default-gems

RUN $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring

WORKDIR /home/$USER
