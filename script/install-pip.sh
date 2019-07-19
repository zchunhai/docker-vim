#!/bin/bash
set -eux

PYTHON_PIP_VERSION=19.1.1
wget --no-check-certificate -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'
python get-pip.py \
    --disable-pip-version-check \
    --no-cache-dir \
    "pip==$PYTHON_PIP_VERSION";
pip --version
pip install --no-cache-dir Flake8

find /usr -depth \
    \( \
        \( -type d -a \( -name test -o -name tests \) \) \
        -o \
        \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
    \) -exec rm -rf '{}' +
rm -f get-pip.py
