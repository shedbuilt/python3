#!/bin/bash
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --with-ensurepip=yes && \
make -j $SHED_NUM_JOBS && \
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libpython3.6m.so"
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libpython3.so"
