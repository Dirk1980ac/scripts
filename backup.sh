#!/bin/sh

# Export GPG passphrase
export PASSPHRASE="$1"

# Backup datenbank
duplicity backup	--verbosity=notice \
			--name act \
			--sign-key E5A3A79778FE9B6E9C801BB553A07FEBB5CEA278 \
			--encrypt-key E5A3A79778FE9B6E9C801BB553A07FEBB5CEA278 \
			--encrypt-key A0A9E62144A0D5030E68E99D75A628B3D4D5B768 \
			--encrypt-key 7AC55E19315C45AF026A72751BB2394BF73BDD88 \
			--encrypt-key 44FBAAF57EC3373A962272828AD5E30BE500BC3D \
			--include $HOME/Dokumente \
			--include $HOME/Bilder \
			--include $HOME/.gnupg \
			--include $HOME/.config \
			--include $HOME/Vorlagen \
			--include $HOME/bin \
			--include $HOME/.zshrc \
			--include $HOME/.antigenrc \
			--include $HOME/.antzigen \
			--exclude '**' \
			$HOME \
			file:///net/kobayashi-maru/dgottschalk/backup/reliant

unset PASSPHRASE
