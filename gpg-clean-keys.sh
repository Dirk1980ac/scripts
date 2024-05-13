#!/bin/bash

echo "Clean Keys:\n"
for keyid in $(gpg -k --with-colons | grep ^pub | cut -d':' -f5); do
    echo -n "$keyid"
    gpg2 --batch --quiet --edit-key "$keyid" check clean cross-certify save quit > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "...OK"
    else
        echo "...FAIL)"
    fi
done
echo done.