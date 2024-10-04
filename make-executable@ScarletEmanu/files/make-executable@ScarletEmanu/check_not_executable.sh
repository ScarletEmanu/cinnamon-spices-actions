#!/bin/bash
for i in "$@"; do
  [[ ! -x $i ]] && exit 0
done

exit 1
