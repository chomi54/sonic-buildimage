# openssh package

OPENSSH_VERSION := 9.2p1
OPENSSH_VERSION_FULL := $(OPENSSH_VERSION)-2+deb12u5

export OPENSSH_VERSION OPENSSH_VERSION_FULL
ifeq ($(BLDENV),bookworm)
OPENSSH_DSC_URL = https://snapshot.debian.org/archive/debian/20250219T030925Z/pool/main/o/openssh/openssh_$(OPENSSH_VERSION_FULL).dsc
else
OPENSSH_DSC_URL = https://deb.debian.org/debian/pool/main/o/openssh/openssh_$(OPENSSH_VERSION_FULL).dsc
endif
export OPENSSH_DSC_URL

OPENSSH_SERVER = openssh-server_$(OPENSSH_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(OPENSSH_SERVER)_SRC_PATH = $(SRC_PATH)/openssh
$(OPENSSH_SERVER)_DEPENDS +=  $(LIBNL3_DEV) $(LIBNL_ROUTE3_DEV)
SONIC_MAKE_DEBS += $(OPENSSH_SERVER)

OPENSSH_CLIENT = openssh-client_$(OPENSSH_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(eval $(call add_derived_package,$(OPENSSH_SERVER),$(OPENSSH_CLIENT)))

OPENSSH_SFTP_SERVER = openssh-sftp-server_$(OPENSSH_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(eval $(call add_derived_package,$(OPENSSH_SERVER),$(OPENSSH_SFTP_SERVER)))

# The .c, .cpp, .h & .hpp files under src/{$DBG_SRC_ARCHIVE list}
# are archived into debug one image to facilitate debugging.
#
DBG_SRC_ARCHIVE += openssh
