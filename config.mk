# Configurations

## Python configurations

## Package name for python
PYTHON_NAME=python27
PYTHON_MAJOR_VERSION=2.7
PYTHON_FULL_VERSION=2.7.6

## Package rpm file name
PYTHON_RPM=$(PYTHON_NAME)-$(PYTHON_FULL_VERSION)-1.$(shell uname -m).rpm

## Dictionary which this rpm will be installed to
PYTHON_INSTALL_DIR=/opt/python$(PYTHON_MAJOR_VERSION)

## Sources
PYTHON_SOURCE=Python-$(PYTHON_FULL_VERSION)
PYTHON_TARBALL=$(PYTHON_SOURCE).tgz
PYTHON_SOURCE_TARBALL_DOWNLOAD_MIRROR=http://mirrors.sohu.com/python

## Compiler setting
