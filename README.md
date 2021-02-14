# Odd Camp Development Environment

## Shell commands

```
#alias odr='docker run -it -v ocde_asdf:/home/oddcamp/.asdf'
alias odcr='docker-compose run --rm app /usr/bin/env bash -l -c'
```

## Info

You need to prefix all calls towards `asdf` and any commands if you use the run or exec commands of docker compose due to not loading asdf at that point.

I.e.

```
docker-compose run --rm app /usr/bin/env bash -l -c "bin/dev_setup -d"
```
