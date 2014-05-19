include config.mk

SOURCE_DIR=/tmp/sourcedir-$(PYTHON_NAME)-$(PYTHON_FULL_VERSION)
BUILD_DIR=/tmp/installdir-$(PYTHON_NAME)-$(PYTHON_FULL_VERSION)

all: build install

clean:
	-rm -f "$(PYTHON_TARBALL)"
	-rm -f "$(PYTHON_RPM)"
	-rm -rf "$(PYTHON_SOURCE)"
	-rm -rf "$(BUILD_DIR)"

tarball: $(PYTHON_TARBALL)

build: $(PYTHON_RPM)

install: build
	-rpm -Uvh $(PYTHON_RPM)

$(PYTHON_TARBALL):
# Download python source
	curl --progress-bar -LO $(PYTHON_SOURCE_TARBALL_DOWNLOAD_MIRROR)/$(PYTHON_FULL_VERSION)/$(PYTHON_TARBALL)

$(PYTHON_RPM): $(PYTHON_TARBALL)
	-mkdir -p "$(SOURCE_DIR)"
	-mkdir -p "$(BUILD_DIR)"
	tar -xvf $< -C "$(SOURCE_DIR)/"

# Build python
	cd $(SOURCE_DIR)/$(PYTHON_SOURCE) && \
		LDFLAGS="-Wl,-rpath=\"$(PYTHON_INSTALL_DIR)/lib\" $(LDFLAGS)" \
			./configure --prefix="$(PYTHON_INSTALL_DIR)" --enable-unicode=ucs4 \
				--enable-shared --enable-ipv6 && \
		make -j2 && \
		make install DESTDIR="$(BUILD_DIR)"

# Package python into rpm
	fpm -f -s dir -t rpm -n $(PYTHON_NAME) -v '$(PYTHON_FULL_VERSION)' \
		-p "$@" \
		-d 'openssl' \
		-d 'bzip2' \
		-d 'zlib' \
		-d 'expat' \
		-d 'db4' \
		-d 'sqlite' \
		-d 'ncurses' \
		-d 'readline' \
		--directories="$(PYTHON_INSTALL_DIR)/lib/python$(PYTHON_MAJOR_VERSION)/" \
		--directories="$(PYTHON_INSTALL_DIR)/include/python$(PYTHON_MAJOR_VERSION)/" \
		-C "$(BUILD_DIR)" .


.PHONY: all clean build install tarball
