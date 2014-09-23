################################################################################
#
# oscam
#
################################################################################

OSCAM_SITE            = http://www.streamboard.tv/svn/oscam/trunk
OSCAM_SITE_METHOD     = svn
OSCAM_VERSION         = 9865
OSCAM_LICENSE         = GPLv3
OSCAM_LICENSE_FILES   = COPYING

define OSCAM_CONFIGURE_CMDS
	(cd $(@D); \
	./config.sh --enable WEBIF WITH_SSL; \
	);
endef

define OSCAM_BUILD_CMDS
	$(MAKE) CROSS="$(TARGET_CROSS)" LIBUSB=1 CONF_DIR=/etc/oscam OSCAM_BIN=Distribution/oscam -C $(@D)
endef

define OSCAM_INSTALL_INIT_SYSV
	$(INSTALL) -D package/oscam/S99oscam             $(TARGET_DIR)/etc/init.d/S99oscam
	$(INSTALL) -D package/oscam/etc_oscam_oscam.conf $(TARGET_DIR)/etc/oscam/oscam.conf
endef

define OSCAM_INSTALL_TARGET_CMDS
	cp $(@D)/Distribution/oscam $(TARGET_DIR)/usr/bin/oscam
endef

$(eval $(generic-package))
