#!/bin/bash

if [ -n "${SHIPYARD_TOKEN}" ]; then
	CONFIG_PATH="${CARGO_CONFIG_FILE:-$HOME/.cargo/config.toml}"
	mkdir -p "$(dirname $CONFIG_PATH)"
	cat <<-EOF | tee $CONFIG_PATH
	[unstable]
	registry-auth = true

	[registry]
	global-credential-providers = ["cargo:token"]

	[registries.lithic]
	index = "ssh://git@ssh.shipyard.rs/lithic/crate-index.git"
	token = "${SHIPYARD_TOKEN}"

	[http]
	user-agent = "shipyard ${SHIPYARD_TOKEN}"

	[net]
	git-fetch-with-cli = true
	EOF

	echo "Wrote cargo config to $CONFIG_PATH"
else
	echo "No SHIPYARD_TOKEN provided, skipping cargo config setup" >> /dev/stderr
fi

exec "/bin/bash"
