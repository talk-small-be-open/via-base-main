#!/bin/bash
set -eo pipefail

function remove_old_files {

  # Delete old temporary files, only known filepattern, dangerous else!
  find . -not -newermt "3 days ago" \( -type f -or -type l \) \( -iname "*.zip" -or -iname "*.pdf" -or -iname "*.mp?" -or -iname "*.json" -or -iname "*.html" -or -iname "serverside-captcha-*" \) -delete

  # Delete empty dirs
  find . -empty -type d  -delete
}


pushd /opt/via/tmp

remove_old_files

popd
pushd /opt/via/via_base/tmp

remove_old_files

popd

