NAME=Cedar-iOS
VERSION=0.11.3

GH_REPO=pivotal/cedar

### GNU/Make

MAKEFLAGS += --warn-undefined-variables

### Variables

PORTS_CACHE_DIR ?= $(HOME)/Library/Caches/Ports
PORTS_TEMP_DIR ?= /tmp/ports
PORTS_VENDOR_DIR ?= $(PWD)/Vendor

PORT_ROOT_DIR ?= $(PORTS_CACHE_DIR)/$(NAME)
PORT_INSTALL_DIR ?= $(PORTS_VENDOR_DIR)/$(NAME)

# https://github.com/pivotal/cedar/archive/v0.11.3.zip
ZIPBALL_URL=https://github.com/$(GH_REPO)/archive/v$(VERSION).zip

SOURCE_PATH=$(PORT_ROOT_DIR)/$(NAME)-$(VERSION)
ZIPBALL_PATH=$(PORT_ROOT_DIR)/$(NAME)-$(VERSION).zip
FRAMEWORK_PATH=$(PORT_ROOT_DIR)/$(NAME)-$(VERSION).framework

INSTALL_PATH=$(PORT_INSTALL_DIR)/$(NAME).framework

### Targets

.PHONY: install uninstall clean purge update

install: $(PORT_ROOT_DIR) $(PORT_INSTALL_DIR) $(ZIPBALL_PATH) $(SOURCE_PATH) $(INSTALL_PATH)

uninstall:
	rm -rf $(PORT_INSTALL_DIR)

clean:
	rm -rf $(PORT_ROOT_DIR)

purge: uninstall clean

update: uninstall install

### Paths

$(ZIPBALL_PATH):
	wget $(ZIPBALL_URL) -O $@

$(SOURCE_PATH):
	unzip $(ZIPBALL_PATH) -d $@

$(INSTALL_PATH): $(FRAMEWORK_PATH)
	cp -Rv $(FRAMEWORK_PATH) $@

$(FRAMEWORK_PATH):
	cd $(SOURCE_PATH)/cedar-$(VERSION) && rake frameworks:ios:build
	cp -Rv $(SOURCE_PATH)/cedar-$(VERSION)/build/Release-iphoneuniversal/$(NAME).framework $@

### Directories

$(PORT_ROOT_DIR):
	mkdir -p $@

$(PORT_INSTALL_DIR):
	mkdir -p $@

