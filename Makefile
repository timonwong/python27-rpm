NAME=python27
MAJOR_VERSION=2.7
VERSION=2.7.6
PYTHON_SOURCE=Python-$(VERSION)
PYTHON_TARBALL=$(PYTHON_SOURCE).tgz
INSTALL_DIR=/opt/python$(MAJOR_VERSION)
PYTHON_RPM=$(NAME)-$(VERSION)-1.$(shell uname -m).rpm

INTERMEDIATE_INSTALL_DIR=/tmp/installdir-$(NAME)-$(VERSION)


.PHONY: all clean build install tarball

all: build install

clean:
	-rm -f "$(PYTHON_TARBALL)"
	-rm -f "$(PYTHON_RPM)"
	-rm -rf "$(PYTHON_SOURCE)"
	-rm -rf "$(INTERMEDIATE_INSTALL_DIR)"

tarball: $(PYTHON_TARBALL)

build: $(PYTHON_RPM)

install: build
	-sudo rpm -Uvh *.rpm

$(PYTHON_TARBALL):
# Download python source
	curl --progress-bar -LO http://mirrors.sohu.com/python/$(VERSION)/$(PYTHON_TARBALL)

$(PYTHON_RPM): $(PYTHON_TARBALL)
	echo $@

	-mkdir -p src
	-mkdir -p $(INTERMEDIATE_INSTALL_DIR)
	tar -xvf $< -C src/

# Build python
	cd src/$(PYTHON_SOURCE) && \
		LDFLAGS="-Wl,-rpath=${INSTALL_DIR}/lib ${LDFLAGS}" \
			./configure --prefix=${INSTALL_DIR} --enable-unicode=ucs4 \
				--enable-shared --enable-ipv6 && \
		make -j2 && \
		make install DESTDIR=$(INTERMEDIATE_INSTALL_DIR)

# Package python into rpm
	fpm -s dir -t -f rpm -n $(NAME) -v '$(VERSION)' \
		-p "$@" \
		-d 'openssl' \
		-d 'bzip2' \
		-d 'zlib' \
		-d 'expat' \
		-d 'db4' \
		-d 'sqlite' \
		-d 'ncurses' \
		-d 'readline' \
		--directories=$(INSTALL_DIR)/lib/python$(MAJOR_VERSION)/ \
		--directories=$(INSTALL_DIR)/include/python$(MAJOR_VERSION)/ \
		-C $(INTERMEDIATE_INSTALL_DIR) .
