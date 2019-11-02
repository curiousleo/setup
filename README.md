# setup

[Generate a new SSH key:](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)

```console
$ ssh-keygen -t rsa -b 4096 -C "curiousleo@users.noreply.github.com"
```

[Add it to your GitHub account.](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account) Then run the following:

```console
$ git clone git@github.com:curiousleo/setup.git ~/.setup
```

Then see [config](config/README.md) and [nixos](nixos/README.md).
