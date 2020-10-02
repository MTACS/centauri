TARGET = iphone:clang:13.0:13.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Centauri

Centauri_FILES = Tweak.xm
Centauri_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += centauriprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
