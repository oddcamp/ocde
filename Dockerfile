FROM ubuntu:20.04

ARG GITHUB_ACCESS_TOKEN
ARG USER=oddcamp
ARG USER_ID=1000
ARG GROUP_ID=1000

ARG DEBIAN_FRONTEND=noninteractive

ARG ASDF_VERSION="v0.8.0"

ENV TZ=Etc/UTC
ENV ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=/app/.tool-versions

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
    zlib1g-dev \
    libicu-dev

RUN addgroup --gid $GROUP_ID $USER
RUN adduser --shell /bin/bash --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

USER $USER
SHELL ["/bin/bash", "-l", "-c"]

# install and setup asdf version manager
RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_VERSION
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> $HOME/.bashrc
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> $HOME/.profile
RUN echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> $HOME/.bashrc
RUN source $HOME/.bashrc

# Make ASDF usable in commmands aswell as shims.
RUN chmod +x $HOME/.asdf/asdf.sh

# install asdf plugins
RUN asdf plugin-add ruby
RUN asdf plugin-add rust
RUN asdf plugin-add nodejs
RUN asdf plugin-add yarn

RUN $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring

# configure ghp to use a token
RUN echo "//npm.pkg.github.com/:_authToken=${GITHUB_ACCESS_TOKEN}" >> $HOME/.npmrc

# Always install these per default when you install a new version, otherwise bundler
# won't work

RUN echo "bundler" >> $HOME/.default-gems

WORKDIR /home/oddcamp

CMD ["/bin/bash"]
