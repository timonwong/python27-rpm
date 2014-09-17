# Configurations

## Python configurations

### Package name for python
PYTHON_NAME=python27
PYTHON_MAJOR_VERSION=2.7
PYTHON_FULL_VERSION=2.7.8

### Package rpm file name
PYTHON_RPM=$(PYTHON_NAME)-$(PYTHON_FULL_VERSION)-1.$(shell uname -m).rpm

### Dictionary which this rpm will be installed to
PYTHON_INSTALL_DIR=/opt/python$(PYTHON_MAJOR_VERSION)

### Sources
PYTHON_SOURCE=Python-$(PYTHON_FULL_VERSION)
PYTHON_TARBALL=$(PYTHON_SOURCE).tgz
PYTHON_SOURCE_TARBALL_DOWNLOAD_MIRROR=http://mirrors.sohu.com/python

## Python libraries & tools configurations

SETUPTOOLS_VER=5.7
VIRTUALENV_VER=1.11.6
PIP_VER=1.5.6
MELD3_VER=1.0.0
SUPERVISOR_VER=3.1.2
WHEEL_VER=0.24.0


### Pypi mirros
PYPI_INDEX_URL=http://pypi.douban.com/simple
PYPI_SOURCE_URL=http://pypi.douban.com/packages/source
