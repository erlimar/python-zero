#!/usr/bin/env bash
set -ou pipefail

# Copyright (c) Erlimar Silva Campos. All rights reserved.
# Licensed under the MIT License. More license information in LICENSE.

exists()
{
    if which $1 &>/dev/null; then
        return 0;
    else
        return 1
    fi
}

PYTHON=python3
PIP=pip3
OUTPUT=./venv

# Check PYTHON installation
if ! exists ${PYTHON}; then
    PYTHON=python
fi

if ! exists ${PYTHON}; then
    echo "Python not installed!"
    exit 1
fi

# Check PIP installation
if ! exists ${PIP}; then
    PIP=pip
fi

if ! exists ${PIP}; then
    echo "Pip not installed!"
    exit 1
fi

# Check PYTHON version
if ! ${PYTHON} -c "import sys; exit(0 if sys.version_info.major == 3 else 1)" &>/dev/null; then
    echo "Python version is not supported. Expected version 3."
    ${PYTHON} --version
    exit 1
fi

# Check VIRTUALENV installation
if ! ${PYTHON} -m virtualenv --version &>/dev/null; then
    echo "Virtualenv not installed."
    echo "Run:"
    echo "  \$ ${PIP} install --user virtualenv"
    exit 1
fi

# Initializes VENV
if [ ! -f "${OUTPUT}/bin/activate" ]; then
    ${PYTHON} -m virtualenv --python=${PYTHON} ${OUTPUT}
    
    if [ $? != 0 ]; then
        echo "Virtualenv command failed."
        exit $?
    fi
fi

if [ ! -f ${OUTPUT}/bin/activate ]; then
    echo "VENV initialization failed."
    exit 1
fi

echo "To start, exec: . ${OUTPUT}/bin/activate"

