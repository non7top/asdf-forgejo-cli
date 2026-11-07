# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test forgejo-cli https://github.com/non7top/asdf-forgejo-cli.git "fj version"
```

Tests are automatically run in GitHub Actions on push and PR.
