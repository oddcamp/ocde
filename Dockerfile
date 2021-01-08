FROM ubuntu:20.04

ARG USER=oddcamp
ARG USER_ID=1000
ARG GROUP_ID=1000

ARG DEBIAN_FRONTEND=noninteractive

ARG ASDF_VERSION="v0.8.0"

ENV TZ=Etc/UTC

RUN apt-get update -y
RUN apt install -y --no-install-recommends \
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
    zlib1g-dev

RUN addgroup --gid $GROUP_ID $USER
RUN adduser --shell /bin/bash --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

USER $USER

SHELL ["/bin/bash", "-l", "-c"]

# install and setup asdf version manager
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.profile
RUN echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
RUN source ~/.bashrc

# install asdf plugins
RUN asdf plugin-add ruby
RUN asdf plugin-add nodejs
RUN asdf plugin-add yarn

RUN $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring

WORKDIR /home/oddcamp

CMD ["/bin/bash"]
