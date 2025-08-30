#!/bin/env bash

# Check if a password argument was provided
if [[ $# -eq 0 ]]; then
	echo "Usage: backup.sh <password>"
	exit 1
fi

# Export GPG passphrase for duplicity to use
export SIGN_PASSPHRASE="$1"

# Run Duplicity with the specified options and parameters
duplicity \
	--verbosity=notice \
	--full-if-older-than=3M \
	--volsize=1024 \
	--name act \
	--sign-key 82C39B0F4FED68CDFF63F7000EA6FF1FE712FE10 \
	--encrypt-key 82C39B0F4FED68CDFF63F7000EA6FF1FE712FE10 \
	--encrypt-key A0A9E62144A0D5030E68E99D75A628B3D4D5B768 \
	--include "${HOME}"/Dokumente \
	--include "${HOME}"/Bilder \
	--include "${HOME}"/Musik \
	--include "${HOME}"/.config \
	--include "${HOME}"/.gnupg \
	--include "${HOME}"/Vorlagen \
	--include "${HOME}"/bin \
	--include "${HOME}"/.ssh \
	--include "${HOME}"/.zshrc \
	--include "${HOME}"/.kodi \
	--include "${HOME}"/.password-store \
	--include "${HOME}"/.antigenrc \
	--include "${HOME}"/.zshrc \
	--include "${HOME}"/.antigen \
	--include "${HOME}"/scripts \
	--include "${HOME}"/rpmbuild/SPECS \
	--include "${HOME}"/rpmbuild/SOURCES \
	--exclude '**' \
	"${HOME}" \
	file:///net/lexington/dgottschalk/backup/reliant

# Unset the GPG passphrase after the backup is complete
unset  SIGN_PASSPHRASE
