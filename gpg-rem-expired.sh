#!/bin/bash

expired_keys="$(gpg2 --list-keys --fixed-list-mode --with-colons | grep "^pub:e:" | cut -f5 -d":")"

for key in $expired_keys; do
    gpg2 --list-keys $key
    gpg2 --yes --batch --no-greeting --delete-key $key # will ask for confirmation
    echo
done
