PYTHON_PACKAGE_PREFIX=python27
PYTHON_INSTALL_DIR=/opt/python2.7

SETUPTOOLS_VER=2.2
SETUPTOOLS_NAME=setuptools-$(SETUPTOOLS_VER)
SETUPTOOLS_TARBALL=$(SETUPTOOLS_NAME).tar.gz

VIRTUALENV_VER=1.11.4
VIRTUALENV_NAME=virtualenv-$(VIRTUALENV_VER)
VIRTUALENV_TARBALL=$(VIRTUALENV_NAME).tar.gz

PIP_VER=1.5.4
PIP_NAME=pip-$(PIP_VER)
PIP_TARBALL=$(PIP_NAME).tar.gz

WHEEL_VER=0.23.0
WHEEL_NAME=wheel-$(WHEEL_VER)
WHEEL_TARBALL=$(WHEEL_NAME).tar.gz

PYPI_SOURCE_MIRROR=http://pypi.douban.com/packages/source

TARBALLS=$(SETUPTOOLS_TARBALL) $(VIRTUALENV_TARBALL) $(PIP_TARBALL) $(WHEEL_TARBALL)

FPM_FLAGS=--verbose -s python -t rpm \
	-p output/ -f \
	--python-bin $(PYTHON_INSTALL_DIR)/bin/python \
	--python-package-name-prefix $(PYTHON_PACKAGE_PREFIX) \
	-d '$(PYTHON_PACKAGE_PREFIX)'


.PHONY: all clean tarballs build-folders setuptools virtualenv pip


all: setuptools virtualenv pip wheel


clean:
	-rm -f $(TARBALLS)
	-rm -rf src/
	-rm -rf output/


$(TARBALLS):
	curl --progress-bar -LO $(PYPI_SOURCE_MIRROR)/$(shell echo $@ | head -c 1)/$(shell echo $@ | cut -d'-' -f 1)/$@
	-mkdir -p src/
	tar -C src/ -xf $@

tarballs: $(TARBALLS)


build-folders:
	-mkdir -p src
	-mkdir -p output

setuptools: $(SETUPTOOLS_TARBALL) build-folders
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(SETUPTOOLS_NAME)/setup.py


virtualenv: $(VIRTUALENV_TARBALL) setuptools build-folders
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		-d '$(PYTHON_PACKAGE_PREFIX)-setuptools' \
		src/$(VIRTUALENV_NAME)/setup.py

pip: $(PIP_TARBALL) build-folders
	-sudo yum -y install output/$(PYTHON_PACKAGE_PREFIX)-setuptools-*.noarch.rpm
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(PIP_NAME)/setup.py


wheel: $(WHEEL_TARBALL) build-folders
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(WHEEL_NAME)/setup.py
