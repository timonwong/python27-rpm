include ../config.mk

EPOCH=1

SETUPTOOLS_NAME=setuptools-$(SETUPTOOLS_VER)
SETUPTOOLS_TARBALL=$(SETUPTOOLS_NAME).tar.gz
SETUPTOOLS_RPM=$(PYTHON_NAME)-$(SETUPTOOLS_NAME)-$(EPOCH).noarch.rpm

VIRTUALENV_NAME=virtualenv-$(VIRTUALENV_VER)
VIRTUALENV_TARBALL=$(VIRTUALENV_NAME).tar.gz
VIRTUALENV_RPM=$(PYTHON_NAME)-$(VIRTUALENV_NAME)-$(EPOCH).noarch.rpm

PIP_NAME=pip-$(PIP_VER)
PIP_TARBALL=$(PIP_NAME).tar.gz
PIP_RPM=$(PYTHON_NAME)-$(PIP_NAME)-$(EPOCH).noarch.rpm

MELD3_NAME=meld3-$(MELD3_VER)
MELD3_TARBALL=$(MELD3_NAME).tar.gz
MELD3_RPM=$(PYTHON_NAME)-$(MELD3_NAME)-$(EPOCH).noarch.rpm

SUPERVISOR_NAME=supervisor-$(SUPERVISOR_VER)
SUPERVISOR_TARBALL=$(SUPERVISOR_NAME).tar.gz
SUPERVISOR_RPM=$(PYTHON_NAME)-$(SUPERVISOR_NAME)-$(EPOCH).noarch.rpm

WHEEL_NAME=wheel-$(WHEEL_VER)
WHEEL_TARBALL=$(WHEEL_NAME).tar.gz
WHEEL_RPM=$(PYTHON_NAME)-$(WHEEL_NAME)-$(EPOCH).noarch.rpm


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
	--python-package-name-prefix $(PYTHON_NAME) \
	-d '$(PYTHON_NAME)'


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
	curl --progress-bar -LO $(PYPI_SOURCE_URL)/$(shell echo $@ | head -c 1)/$(shell echo $@ | cut -d'-' -f 1)/$@

$(SETUPTOOLS_RPM): $(SETUPTOOLS_TARBALL)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(SETUPTOOLS_NAME)/setup.py
	-rpm -Uvh $@

$(VIRTUALENV_RPM): $(VIRTUALENV_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		-d '$(PYTHON_NAME)-setuptools' \
		src/$(VIRTUALENV_NAME)/setup.py
	-rpm -Uvh $@

$(WHEEL_RPM): $(WHEEL_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(WHEEL_NAME)/setup.py
	-rpm -Uvh $@

$(MELD3_RPM): $(MELD3_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(MELD3_NAME)/setup.py
	-rpm -Uvh $@

$(SUPERVISOR_RPM): $(SUPERVISOR_TARBALL) $(MELD3_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		-d '$(PYTHON_NAME)-meld3' \
		src/$(SUPERVISOR_NAME)/setup.py
	-rpm -Uvh $@

$(PIP_RPM): $(PIP_TARBALL) $(SETUPTOOLS_RPM)
	-mkdir -p src
	tar -xf $< -C src/
	fpm $(FPM_FLAGS) \
		src/$(PIP_NAME)/setup.py
	-rpm -Uvh $@
