#!/usr/bin/env bash
# Time-stamp: <2022-12-19 15:55:26 peml>

set -o errexit
set -o nounset
set -o pipefail

me=$(basename "$0")

# enable debug mode, by running your script as TRACE=1 ./script.sh
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

usage="Usage: ${me} <rpm-file> <destination>

  ${me} extracts all files in an rpm and puts it in <destination>
  if <destination> exists and is not empty it aborts

"

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo "$usage"
    exit 0
fi

# want two arguments
[ "$#" -ne 2 ] && >&2 echo "$usage" && exit 1


rpm=$(realpath "$1")
dest="$2"

main() {

if [[ ! -f "$rpm" ]]; then
    echo "$rpm: read error"
    exit 1
fi


# check if dir and is empty
if [[ -f "$dest" ]]; then
    echo "$dest not a dir or not empty"
    exit 1
fi

if [ -d "$dest" ]
then
    if [ "$(ls -A "$dest")" ]; then
        echo "$dest not a dir or not empty"
        exit 1
    fi
else
    mkdir "$dest"
fi

cd "$dest"
rpm2cpio "$rpm" | cpio -idmv

}

main "$@"
