#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --with-ensurepip=yes &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libpython3.7m.so" &&
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libpython3.so" || exit 1
# Install Documentation
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    wget https://docs.python.org/ftp/python/doc/3.7.0/python-3.7.0-docs-html.tar.bz2 &&
    install -v -dm755 "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}/html" &&
    tar --strip-components=1  \
        --no-same-owner       \
        --no-same-permissions \
        -C "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}/html" \
        -xvf python-3.7.0-docs-html.tar.bz2
else
    rm -rf "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}"
fi
