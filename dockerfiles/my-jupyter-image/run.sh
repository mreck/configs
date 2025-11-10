#!/bin/sh

set -e
[ -z "$image_name" ] && echo 'ERROR: "image_name" env var is not set' && exit 1
notebook_work_dir="$(pwd)/work"
mkdir -p "$notebook_work_dir"
docker run --rm -p 8888:8888 -v "$notebook_work_dir:/home/jovyan" "$image_name"
