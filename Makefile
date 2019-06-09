include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:11.2:11.0
export ARCHS = arm64

BUNDLE_NAME = 4GOnly
4GOnly_BUNDLE_EXTENSION = bundle
4GOnly_FILES = 4GOnly.m
4GOnly_PRIVATE_FRAMEWORKS = ControlCenterUIKit CoreTelephony
4GOnly_INSTALL_PATH = /Library/ControlCenter/Bundles/

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
