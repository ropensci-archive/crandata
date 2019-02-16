#!/bin/bash

# Stuff to make this work in cron
PATH="/bin:/usr/bin:/usr/local/bin:$PATH"  #Provide the path
cd "${0%/*}"       #Set working directory to location of this script

set -e  # stop script if error

# Sync all source packages from CRAN
rsync -tzm -i --no-links --dirs --delete --include="*.tar.gz" --exclude="*" cran.r-project.org::CRAN/src/contrib/ tarballs > logs/rsync_latest.log
cp logs/rsync_latest.log logs/rsync_`date "+%Y_%m_%d__%H_%M_%S"`.log

# Unzip newly updated packages
echo "New/updated packages"
cat logs/rsync_latest.log | grep ">" | grep -o "\S*$" 
cat logs/rsync_latest.log | grep ">" | grep -o "\S*$" | xargs -i tar xfm tarballs/{} -C packages/
echo "Deleted packages"

