#!/bin/bash

_TITLE="Error: Permission Change Failed"
TITLE="$(/usr/bin/gettext "$_TITLE")"
_TEXT="Unable to make the file executable:"
TEXT="$(/usr/bin/gettext "$_TEXT")"

numErrors=0

for i in "$@"; do
  if [[ -x $i ]]; then
    continue
  fi

  #Get ownership
  OWNER=$(stat -c %U "$i")
  if [[ $OWNER != $USER ]] ; then
    pkexec --user "$OWNER" chmod +x "$i"
  else
    chmod +x "$i"
  fi
  if [[ $? -eq 1 ]]; then
    $TEXT+=" $i"
    ((numErrors+=1))
  fi
done

[[ ! $numErrors -eq 0 ]] && notify-send -i dialog-error $TITLE $TEXT
