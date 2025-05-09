#!/bin/sh

notfounddlls="KERNEL32.dll"
dllbase="/usr/x86_64-w64-mingw32/sys-root/mingw/bin"

nc=1
while [ $nc -gt 0 ]; do
	nc=0
	for f in *.exe *.dll; do
		for dep in $(strings "$f" | grep -i '\.dll$'); do
			if    [ ! -e "$dep" ] && ! echo "$notfounddlls" | grep -iwq "$dep"; then
				dllloc=$(      find "$dllbase" -iname "$dep")
				if       [ -n "$dllloc" ]; then
					cp          "$dllloc" .
					echo          "Copying $(basename "$dllloc")"
					nc=$((nc + 1))
				else
					notfounddlls="$notfounddlls $dep"
				fi
			fi
		done
	done
done
echo "System DLLS: $notfounddlls"
