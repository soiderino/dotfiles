#!/bin/sh

# 1 - free pagecache
# 2 - free dentries and inodes
# 3 - free all

value=3

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

echo "Clearing page cache, dentries, and inodes..."
sync; echo 3 > /proc/sys/vm/drop_caches

echo "RAM cleaning completed."

exit 0
