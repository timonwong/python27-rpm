# Configurations

## Python configurations

### Package name for python
PYTHON_NAME=python27
PYTHON_MAJOR_VERSION=2.7
PYTHON_FULL_VERSION=2.7.6

### Package rpm file name
PYTHON_RPM=$(PYTHON_NAME)-$(PYTHON_FULL_VERSION)-1.$(shell uname -m).rpm

### Dictionary which this rpm will be installed to
PYTHON_INSTALL_DIR=/opt/python$(PYTHON_MAJOR_VERSION)

### Sources
PYTHON_SOURCE=Python-$(PYTHON_FULL_VERSION)
PYTHON_TARBALL=$(PYTHON_SOURCE).tgz
PYTHON_SOURCE_TARBALL_DOWNLOAD_MIRROR=http://mirrors.sohu.com/python

## Python libraries & tools configurations

SETUPTOOLS_VER=2.2
VIRTUALENV_VER=1.11.4
PIP_VER=1.5.4
MELD3_VER=1.0.0
SUPERVISOR_VER=3.0
WHEEL_VER=0.23.0


### Pypi mirros
PYPI_INDEX_URL=http://pypi.douban.com/simple
PYPI_SOURCE_URL=http://pypi.douban.com/packages/source
