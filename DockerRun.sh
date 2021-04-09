#!/usr/bin/env sh

rm -rf _site

docker run --rm --volume=$(pwd):/srv/jekyll -it -p 4000:4000 jekyll/jekyll jekyll s --config _config.yml --incremental
