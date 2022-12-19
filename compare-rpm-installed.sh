#!/usr/bin/env bash
# Time-stamp: <2022-12-19 15:59:50 peml>

set -o errexit
set -o nounset
set -o pipefail

me=$(basename "$0")

# enable debug mode, by running your script as TRACE=1 ./script.sh
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi


if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo "Usage: $me path/to/an/extracted/rpm

prints all files in the rpm that is changed in the local filesystem

"
    exit
fi

#cd "$(dirname "$0")"
src="$1"

main() {

    cd "$src"
    find . -type f | sed 's!\./!/!' |
        while read -r p; do
            if ! cmp  -s -- "./$p" "$p"; then
                echo "diff $p ${src}$p"
            fi
        done

}

main "$@"
