# OCDE - Odd Camp Dev Environment

## Prerequisite

#### MacOS (ARM/AMD64)
1. Docker Desktop (https://docs.docker.com/desktop/mac/install/)
2. Brew (https://brew.sh/)
3. Git (https://git-scm.com/)
4. Git Credential Manager Core (https://github.com/GitCredentialManager/git-credential-manager)
5. Visual Studio Code (https://code.visualstudio.com/)
    - Remote - Containers extension (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
6. GITHUB_ACCESS_TOKEN environment variable

#### Linux
1. ...

#### Windows

1. ...


## Installation and Setup MacOS

#### Docker Desktop

Install Docker Desktop by downloading the appropriate distribution for your system from the link above. After installation verify that you assign enough system resources by opening up the dashboard -> preferences -> resources and assigning the following minimums:
  - CPUs: 4
  - Memory: 8 GB
  - Swap: 512 MB
  - Disk image size: 50 GB

#### Brew
Install Brew by running the bash script provided on the link above.

#### Git
Install the latest git version using Brew by running the following command:

```shell
brew install git
```

After installing you can stay up-to-date with new releases by running:

```shell
brew upgrade git
```

Configure Git to use your Oddcamp profile by setting your name and email:

```git config --global user.name <firstname lastname>```

```git config --global user.email <name@oddcamp.com>```

#### Git Credential Manager Core

Install the credential manager by running the following:

```shell
brew tap microsoft/git
brew install --cask git-credential-manager-core
```

After installing you can stay up-to-date with new releases by running:

```shell
brew upgrade git-credential-manager-core
```

#### Visual Studio Code

Install Docker Desktop by downloading the appropriate distribution for your system from the link above. Alternatively you can install it using Brew Casks by running the following:

```shell
  brew install --cask visual-studio-code
```

Open VS Code and install the extension `Remote - Containers`

#### GITHUB_ACCESS_TOKEN

Some application container will use your local environment variable GITHUB_ACCESS_TOKEN to access NPM packages, Gems, Docker images, etc from Github Packages and repositories. Add the following inside your shell profile so it is available when needed. 

```shell
  export GITHUB_ACCESS_TOKEN="replace_this_with_your_token"
```

Create a new token by visiting https://github.com/settings/tokens. Name it e.g. "Access Repo & Packages" and give it the following scopes:
  - repo (Full control of private repositories)
  - read:packages (Download packages from GitHub Package Registry)

**Important:** Give the token an expiration time of max 6 months.


## How to use

#### Git Credential Manager Core

Once it's installed and configured, Git Credential Manager is called implicitly by Git. You don't have to do anything special, and GCM isn't intended to be called directly by the user. For example, when pushing (git push) to Azure DevOps, Bitbucket, or GitHub, a window will automatically open and walk you through the sign-in process. (This process will look slightly different for each Git host, and even in some cases, whether you've connected to an on-premises or cloud-hosted Git host.) Later Git commands in the same repository will re-use existing credentials or tokens that GCM has stored for as long as they're valid.


## Additional Resources

#### Git Credential Manager Core

1. https://github.blog/2020-07-02-git-credential-manager-core-building-a-universal-authentication-experience/
