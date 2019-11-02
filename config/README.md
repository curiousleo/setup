# Configuration files

## Local Git configuration

```console
$ git config -f ~/.gitconfig.local user.email 'curiousleo@users.noreply.github.com'
$ git config -f ~/.gitconfig.local user.name 'Leonhard Markert'
```

## Install configuration files

```console
$ ./install.sh
```

## Add configuration

- create a new subdirectory with the name of the program
- add it to the list of configs in `install.sh`
- run `./install.sh`
