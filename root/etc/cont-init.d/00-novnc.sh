#!/usr/bin/with-contenv bash

set -eu
set -o pipefail

if [ "$PATH_PREFIX" = "/" ]
then
  export SOCKET_PREFIX=""
else
  export SOCKET_PREFIX="$PATH_PREFIX"
fi

TEMP="$(envsubst '${PATH_PREFIX},${SOCKET_PREFIX}' < /etc/nginx/nginx.conf)"
printf '%s' "$TEMP" > /etc/nginx/nginx.conf


export PAGE_PREFIX="${SOCKET_PREFIX:1}/"
export PAGE_TITLE="KVM - ${VM_NAME}"
TEMP="$(envsubst '${PAGE_PREFIX},${PAGE_TITLE},${VNC_RESIZE},${RECON_DELAY}' < /novnc/index.html)"
printf '%s' "$TEMP" > /novnc/index.html

