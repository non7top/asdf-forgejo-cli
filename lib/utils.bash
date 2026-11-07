#!/usr/bin/env bash

set -euo pipefail

TOOL_REPO="https://codeberg.org/forgejo-contrib/forgejo-cli"
TOOL_NAME="forgejo-cli"
TOOL_TEST="fj version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	git ls-remote --tags --refs "$TOOL_REPO.git" 'v*' |
		cut -d/ -f3- |
		sed 's/^v//'
}

# True when version $1 >= $2.
version_ge() {
	[ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -n1)" = "$2" ]
}

# Upstream publishes Linux binaries only.
get_arch() {
	[ "$(uname -s)" = "Linux" ] || fail "no upstream binary for $(uname -s), only Linux is published"
	case "$(uname -m)" in
	x86_64 | amd64) echo "x86_64" ;;
	aarch64 | arm64) echo "aarch64" ;;
	*) fail "unsupported architecture: $(uname -m)" ;;
	esac
}

# The asset name changed twice upstream:
#   <= 0.3.0  forgejo-cli-linux.gz (x86_64 only, gzipped binary)
#   0.4.x     forgejo-cli-linux.tar.gz (x86_64 only)
#   >= 0.5.0  forgejo-cli-<arch>-linux.tar.gz
release_asset() {
	local version="$1" arch
	arch="$(get_arch)"
	if version_ge "$version" "0.5.0"; then
		echo "forgejo-cli-$arch-linux.tar.gz"
		return
	fi
	[ "$arch" = "x86_64" ] || fail "$arch builds start at 0.5.0, not available for $version"
	if version_ge "$version" "0.4.0"; then
		echo "forgejo-cli-linux.tar.gz"
	else
		echo "forgejo-cli-linux.gz"
	fi
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$TOOL_REPO/releases/download/v${version}/$(release_asset "$version")"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
