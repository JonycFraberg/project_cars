#!/bin/sh
echo -ne '\033c\033]0;Urban Drive\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Urban Drive v0.1.x86_64" "$@"
