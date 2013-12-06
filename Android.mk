# Makefile for Expat library
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

# Build configuration
EXPAT_SRC_FILES := \
	lib/xmlparse.c \
	lib/xmlrole.c \
	lib/xmltok.c

# Choose compression level (and performance)
# Default (fast) can bve changed by by setting VERY_FAST=1
# or ULTRA_FAST=1
EXPAT_CFLAGS := -DHAVE_EXPAT_CONFIG_H
EXPAT_CFLAGS += -Wall -fexceptions \

# Build static library
include $(CLEAR_VARS)

LOCAL_MODULE:= libyahoo_expat
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(EXPAT_SRC_FILES)
LOCAL_CFLAGS := $(EXPAT_CFLAGS)

# Disable prelink if trying to build within AOSP tree
LOCAL_PRELINK_MODULE := false

# Building in ARM32 mode improve performance, while adding very little
# overhead on size of library since this module is very compact
LOCAL_ARM_MODE := arm

# For the static library to be linked within a shared library, need
# to compile it with PIC (Position Independant Code) enabled
LOCAL_CFLAGS += -fPIC -DPIC

ifneq ($(NDK_ROOT),)
# If building with NDK, force using gold linker
LOCAL_LDLIBS += -fuse-ld=gold 
endif

include $(BUILD_STATIC_LIBRARY)
