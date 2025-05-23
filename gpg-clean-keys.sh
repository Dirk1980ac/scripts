#!/bin/bash
# 1) Clean Keys
echo "Clean Keys:"
for keyid in $(gpg -k --with-colons | grep ^pub | cut -d':' -f5); do
	# 2) Get the public key ID from GPG.
	echo "$keyid"
	# 3) Check and clean cross-certify keys using GPG.
	gpg2 --batch --quiet \
		--edit-key "$keyid" check clean cross-certify save quit > /dev/null 2>&1
	# 4) Check the success or failure of the cleaning operation.
	if [[ $? -eq 0 ]]; then
		echo "...OK"
	else
		echo "...FAIL)"
	fi
done
echo done.
