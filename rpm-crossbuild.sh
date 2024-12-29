#!/bin/bash

# Print a hopefully useful help text.
help() {
	cat <<EOF
Usage:
$0 -i <directory> -o <directory>

Options:
	-i <directory>		Input directory (mandatory)
	-o <directory>		Output directory (mandatory)
	-h			Show this help
EOF
	exit 1
}

# Check command line options
while getopts "i:o:h" flag; do
	case $flag in
	i) input=$OPTARG ;;
	o) output=$OPTARG ;;
	h) help ;;
	*)
		echo 'Unknown option.'
		exit 1
		;;
	esac
done

# Show help if a mandatory option is missing
if [ -z "$input" ] || [ -z "$output" ]; then
	help
elif [ ! -d "$input" ]; then
	echo "$input is not a file."
	exit
elif [ ! -d "$output" ]; then
	mkdir $output
fi

podman run \
	--rm \
	-it \
	--security-opt label=type:unconfined_t \
	--pull=newer \
	--platform linux/arm64 \
	-v $input:/input:ro \
	-v $output:/output \
	docker.io/dirk1980/rpm-crossbuild:latest
