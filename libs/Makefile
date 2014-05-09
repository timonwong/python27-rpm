# PYTHON27的RPM安装包名称
PYTHON_PACKAGE_PREFIX=python27
# PYTHON27的安装路径
PYTHON_INSTALL_DIR=/opt/python2.7

EPOCH=1

SETUPTOOLS_VER=2.2
SETUPTOOLS_NAME=setuptools-$(SETUPTOOLS_VER)
SETUPTOOLS_TARBALL=$(SETUPTOOLS_NAME).tar.gz
SETUPTOOLS_RPM=$(PYTHON_PACKAGE_PREFIX)-$(SETUPTOOLS_NAME)-$(EPOCH).noarch.rpm

VIRTUALENV_VER=1.11.4
VIRTUALENV_NAME=virtualenv-$(VIRTUALENV_VER)
VIRTUALENV_TARBALL=$(VIRTUALENV_NAME).tar.gz
VIRTUALENV_RPM=$(PYTHON_PACKAGE_PREFIX)-$(VIRTUALENV_NAME)-$(EPOCH).noarch.rpm

PIP_VER=1.5.4
PIP_NAME=pip-$(PIP_VER)
PIP_TARBALL=$(PIP_NAME).tar.gz
PIP_RPM=$(PYTHON_PACKAGE_PREFIX)-$(PIP_NAME)-$(EPOCH).noarch.rpm

MELD3_VER=1.0.0
MELD3_NAME=meld3-$(MELD3_VER)
MELD3_TARBALL=$(MELD3_NAME).tar.gz
MELD3_RPM=$(PYTHON_PACKAGE_PREFIX)-$(MELD3_NAME)-$(EPOCH).noarch.rpm

SUPERVISOR_VER=3.0
SUPERVISOR_NAME=supervisor-$(SUPERVISOR_VER)
SUPERVISOR_TARBALL=$(SUPERVISOR_NAME).tar.gz
SUPERVISOR_RPM=$(PYTHON_PACKAGE_PREFIX)-$(SUPERVISOR_NAME)-$(EPOCH).noarch.rpm

WHEEL_VER=0.23.0
WHEEL_NAME=wheel-$(WHEEL_VER)
WHEEL_TARBALL=$(WHEEL_NAME).tar.gz
WHEEL_RPM=$(PYTHON_PACKAGE_PREFIX)-$(WHEEL_NAME)-$(EPOCH).noarch.rpm


PYPI_INDEX_URL=http://pypi.douban.com/simple
PYPI_SOURCE_URL=http://pypi.douban.com/packages/source

TARBALLS=$(SETUPTOOLS_TARBALL) \
	$(VIRTUALENV_TARBALL) \
	$(PIP_TARBALL) \
	$(WHEEL_TARBALL) \
	$(MELD3_TARBALL) \
	$(SUPERVISOR_TARBALL)

RPMS=$(SETUPTOOLS_RPM) \
	$(VIRTUALENV_RPM) \
	$(PIP_RPM) \
	$(WHEEL_RPM) \
	$(MELD3_RPM) \
	$(SUPERVISOR_RPM)

FPM_FLAGS=--verbose -s python -t rpm -f \
	--python-bin $(PYTHON_INSTALL_DIR)/bin/python \
	--python-package-name-prefix $(PYTHON_PACKAGE_PREFIX) \
	-d '$(PYTHON_PACKAGE_PREFIX)'


.PHONY: all clean tarballs build-folders \
	setuptools virtualenv wheel meld3 supervisor pip \
	echo-all

all: $(RPMS)

echo-all:
	echo $(RPMS)

clean:
	-rm -f $(TARBALLS)
	-rm -rf src/
	-rm -f $(RPMS)

tarballs: $(TARBALLS)

setuptools: $(SETUPTOOLS_RPM)

virtualenv: $(VIRTUALENV_RPM)

wheel: $(WHEEL_RPM)

meld3: $(MELD3_RPM)

supervisor: $(SUPERVISOR_RPM)

pip: $(PIP_RPM)

$(TARBALLS):
# 下载源码包
	curl --progress-bar -LO $(PYPI_SOURCE_URL)/$(shell echo $@ | head -c 1)/$(shell echo $@ | cut -d'-' -f 1)/$@

$(SETUPTOOLS_RPM): $(SETUPTOOLS_TARBALL)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(SETUPTOOLS_NAME)/setup.py
	-sudo rpm -Uvh $@

$(VIRTUALENV_RPM): $(VIRTUALENV_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		-d '$(PYTHON_PACKAGE_PREFIX)-setuptools' \
		src/$(VIRTUALENV_NAME)/setup.py
	-sudo rpm -Uvh $@

$(WHEEL_RPM): $(WHEEL_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(WHEEL_NAME)/setup.py
	-sudo rpm -Uvh $@

$(MELD3_RPM): $(MELD3_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(MELD3_NAME)/setup.py
	-sudo rpm -Uvh $@

$(SUPERVISOR_RPM): $(SUPERVISOR_TARBALL) $(MELD3_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		-d '$(PYTHON_PACKAGE_PREFIX)-meld3' \
		src/$(SUPERVISOR_NAME)/setup.py
	-sudo rpm -Uvh $@

$(PIP_RPM): $(PIP_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(PIP_NAME)/setup.py
	-sudo rpm -Uvh $@
