#!/bin/bash
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --with-ensurepip=yes || return 1
make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1
chmod -v 755 "${SHED_FAKEROOT}/usr/lib/libpython3.6m.so"
chmod -v 755 "${SHED_FAKEROOT}/usr/lib/libpython3.so"
