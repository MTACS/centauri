TARGET = iphone:clang:13.0:13.0
ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CentauriPrefs

CentauriPrefs_FILES = CentauriRootListController.m
CentauriPrefs_FRAMEWORKS = UIKit
CentauriPrefs_PRIVATE_FRAMEWORKS = Preferences
CentauriPrefs_INSTALL_PATH = /Library/PreferenceBundles
CentauriPrefs_CFLAGS = -fobjc-arc -Wdeprecated-declarations -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk
