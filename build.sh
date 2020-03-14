#!/bin/sh
set -eu

PROGRAM=${0##*/}

usage() {
    echo "Usage: $PROGRAM ARCH"
}

[ $# -lt 1 ] && usage && exit 0

YAML="pld.yaml"
ARCH=$1

if [ "$ARCH" != "i686" -a "$ARCH" != "x86_64" ]; then
    echo "only i686 and x86_64 are supported"
    exit 1
fi

which distrobuilder >/dev/null

SERIAL=$(date -u +%Y%m%d%H%M)
set -x

distrobuilder build-lxd $YAML . \
              -o source.url=pldlinux/$ARCH:latest \
              -o image.description="PLD Linux ($SERIAL)" \
              -o image.architecture=$ARCH \
              -o image.serial=$SERIAL \
              --type=unified
