# list of supported architectures 
# https://developer.android.com/ndk/guides/application_mk.html

# mips32 have a bug with 64bit atomic counter, so if you need 
# this platform - plz, use gcc build
# armeabi-v7a
APP_ABI := arm64-v8a
APP_PLATFORM := android-24
NDK_TOOLCHAIN_VERSION := clang

# list of build-in STL's supported by NDK. 
# switch to clang STL in case of using this compiler
# https://developer.android.com/ndk/guides/cpp-support.html#runtimes

# Until NDK r16, the NDK's libc++ is only of beta quality. 
# Beginning with NDK r16, libc++ will be the preferred STL. 
# A future NDK release will remove the other options.
APP_STL := c++_shared

APP_CFLAGS += \
    -DMAGICKCORE_HDRI_ENABLE=1 \
    -DMAGICKCORE_QUANTUM_DEPTH=16 \
    -O3 \
    -fopenmp

APP_CPPFLAGS += \
    -DMAGICKCORE_HDRI_ENABLE=1 \
    -DMAGICKCORE_QUANTUM_DEPTH=16 \
    -O3 \
    -fopenmp

APP_LDFLAGS += \
    -fopenmp

STATIC_BUILD := true
BUILD_MAGICK_BIN := true


# fix windows paths causing build to fail (too many sources)
# only affects gradle build (build from cmdline works fine)
LOCAL_SHORT_COMMANDS := true
APP_SHORT_COMMANDS := true