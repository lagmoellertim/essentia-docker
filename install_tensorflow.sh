#!/usr/bin/env bash
set -euo pipefail

TENSORFLOW_VERSION="${1}"
USE_GPU="${2}"
ARCHITECTURE=$(dpkg --print-architecture)

if [ "$USE_GPU" = "1" ]; then
    DEB_FILE="libtensorflow-cc_${TENSORFLOW_VERSION}-gpu_${ARCHITECTURE}.deb"
else
    DEB_FILE="libtensorflow-cc_${TENSORFLOW_VERSION}_${ARCHITECTURE}.deb"
fi

wget -q https://github.com/ika-rwth-aachen/libtensorflow_cc/releases/download/v${TENSORFLOW_VERSION}/${DEB_FILE}
dpkg -i ${DEB_FILE}
rm -f ${DEB_FILE}

ln -sf /usr/local/lib/libtensorflow_cc.so /usr/local/lib/libtensorflow.so

mkdir -p /usr/local/lib/pkgconfig
cat <<EOF > /usr/local/lib/pkgconfig/tensorflow.pc
prefix=/usr/local
exec_prefix=
libdir=
libdir=/usr/local/lib
includedir=/usr/include

Name: TensorFlow
Description: TensorFlow C library
Version: ${TENSORFLOW_VERSION}
Libs: -L\${libdir} -ltensorflow -ltensorflow_framework
Cflags: -I\${includedir}
EOF

ldconfig