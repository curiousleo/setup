# vale styles

To add a style:

```console
 $ git remote add vale-style-xxx
 $ git subtree add --squash --prefix=config/vale/.local/share/vale-styles/XXX-repo vale-style-xxx master
 $ cd config/vale/.local/share/vale-styles/
 $ ln -s XXX-repo/XXX/ XXX
```

Then add `XXX` to the "based on" styles in `.vale.ini`.
