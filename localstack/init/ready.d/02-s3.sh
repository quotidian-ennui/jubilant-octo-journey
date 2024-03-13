#!/usr/bin/env bash
set -eo pipefail
set -x

buckets='s3://zzlc-s3-work
  s3://zzlc
'

make_buckets() {
  for bucket in $buckets;
  do
    awslocal s3 mb "$bucket"
  done
}

init_files() {
  for bucket in $buckets;
  do
    awslocal s3 cp "$0" "$bucket/dummy/example.txt"
  done
}

ls_files() {
  for bucket in $buckets;
  do
    awslocal s3 ls "$bucket" --recursive
  done
}


make_buckets
init_files
ls_files

set +x
