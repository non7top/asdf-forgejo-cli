<div align="center">

# asdf-forgejo-cli [![Build](https://github.com/non7top/asdf-forgejo-cli/actions/workflows/build.yml/badge.svg)](https://github.com/non7top/asdf-forgejo-cli/actions/workflows/build.yml) [![Lint](https://github.com/non7top/asdf-forgejo-cli/actions/workflows/lint.yml/badge.svg)](https://github.com/non7top/asdf-forgejo-cli/actions/workflows/lint.yml)

[forgejo-cli](https://codeberg.org/forgejo-contrib/forgejo-cli) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `git`, `tar`, `gzip`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- Linux only: upstream publishes no macOS binaries. x86_64 for every release, aarch64 from 0.5.0.
- Upstream publishes no checksums or signatures, so downloads are protected by TLS only.

# Install

Plugin:

```shell
asdf plugin add forgejo-cli
# or
asdf plugin add forgejo-cli https://github.com/non7top/asdf-forgejo-cli.git
```

forgejo-cli:

```shell
# Show all installable versions
asdf list-all forgejo-cli

# Install specific version
asdf install forgejo-cli latest

# Set a version globally (on your ~/.tool-versions file)
asdf global forgejo-cli latest

# Now forgejo-cli commands are available
fj version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/non7top/asdf-forgejo-cli/graphs/contributors)!

# License

See [LICENSE](LICENSE), copyright [Vladimir Berezhnoy](https://github.com/non7top/)
