include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-fancontrol
PKG_VERSION:=1.1.1
PKG_RELEASE:=2
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-fancontrol
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Simple fan control for GL-MT3600BE
  DEPENDS:=+luci-base +rpcd
  PKGARCH:=all
endef

define Package/luci-app-fancontrol/description
  Simple LuCI fan control page with global temperature protection, fan RPM,
  recommended and custom automatic temperature curves.
endef

define Build/Compile
endef

define Package/luci-app-fancontrol/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d $(1)/etc/config $(1)/usr/share/luci/menu.d $(1)/usr/share/rpcd/acl.d $(1)/usr/share/ucitrack $(1)/www/luci-static/resources/view/system
	$(INSTALL_BIN) ./root/usr/bin/fancontrol $(1)/usr/bin/fancontrol
	$(INSTALL_BIN) ./root/etc/init.d/fancontrol $(1)/etc/init.d/fancontrol
	$(CP) ./root/etc/config/* $(1)/etc/config/ 2>/dev/null || true
	$(CP) ./root/usr/share/luci/* $(1)/usr/share/luci/ 2>/dev/null || true
	$(CP) ./root/usr/share/rpcd/* $(1)/usr/share/rpcd/ 2>/dev/null || true
	$(CP) ./root/usr/share/ucitrack/* $(1)/usr/share/ucitrack/ 2>/dev/null || true
	$(CP) ./root/www/* $(1)/www/ 2>/dev/null || true
endef

define Package/luci-app-fancontrol/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || /etc/init.d/fancontrol enable >/dev/null 2>&1 || true
exit 0
endef

define Package/luci-app-fancontrol/prerm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || /etc/init.d/fancontrol stop >/dev/null 2>&1 || true
exit 0
endef

$(eval $(call BuildPackage,luci-app-fancontrol))
