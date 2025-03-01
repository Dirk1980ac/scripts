#!/bin/bash

for key in $(gpg2 --list-keys --fixed-list-mode --with-colons | grep "^pub:r:" | cut -f5 -d":"); do
	gpg2 --list-sigs $key > sig_details.txt
	gpg2 --with-colons --yes --batch --no-greeting --delete-keys $key
	echo
done
