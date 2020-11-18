TARGET = iphone:clang:13.0:13.0
THEOS_DEVICE_IP = 10.0.0.139
THEOS_DEVICE_PORT = 22
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
