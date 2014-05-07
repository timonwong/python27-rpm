NAME=python27
MAJOR_VERSION=2.7
VERSION=2.7.6
PYTHON_SOURCE=Python-$(VERSION)
PYTHON_TARBALL=$(PYTHON_SOURCE).tgz
INSTALL_DIR=/opt/python$(MAJOR_VERSION)

INTERMEDIATE_INSTALL_DIR=/tmp/installdir-$(NAME)-$(VERSION)


.PHONY: all clean package source

all: package

clean:
	-rm -rf "$(PYTHON_SOURCE)"
	-rm -rf "$(INTERMEDIATE_INSTALL_DIR)"


$(PYTHON_TARBALL):
# Download python source
	curl -LO http://mirrors.sohu.com/python/$(VERSION)/$(PYTHON_TARBALL)


source: $(PYTHON_TARBALL)


package: $(PYTHON_TARBALL)
	-mkdir -p src
	-mkdir -p $(INTERMEDIATE_INSTALL_DIR)
	tar -xvf $(PYTHON_SOURCE).tgz -C src/

	# Build python
	cd src/$(PYTHON_SOURCE) && \
		LDFLAGS="-Wl,-rpath=${INSTALL_DIR}/lib ${LDFLAGS}" \
			./configure --prefix=${INSTALL_DIR} --enable-unicode=ucs4 \
				--enable-shared --enable-ipv6 && \
		make -j2 && \
		make install DESTDIR=$(INTERMEDIATE_INSTALL_DIR)

	-rm -f "$(NAME)-$(VERSION)"-*.rpm
	fpm -s dir -t rpm -n $(NAME) -v '$(VERSION)' \
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
