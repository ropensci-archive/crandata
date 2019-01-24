#!/usr/bin/env bash

rsync -tlzv  cran.r-project.org::CRAN/src/contrib/*tar.gz tarballs | tee /dev/tty | grep gz | xargs -i tar xf tarballs/{} -C packages/
