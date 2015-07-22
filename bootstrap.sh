#!/bin/sh
set -e

cd `dirname $0`
./cleanup.sh

if test -f m4/ax_lib_event.m4 ; then : ; else
  if test -d m4 ; then : ; else
    mkdir m4
  fi
  echo >&2 "Please copy ax_lib_event.m4 from Thrift (under aclocal)"
  echo >&2 "to the 'm4' directory.  Or run"
  echo >&2 "  wget -O m4/ax_lib_event.m4 'https://raw.githubusercontent.com/apache/thrift/master/aclocal/ax_lib_event.m4'"
  echo >&2 "Then re-run bootstrap.sh"
  exit 1
fi

autoscan
autoreconf --install
