#!/bin/bash

set -e

iphoneos="5.1.1"
export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"

ARCH="arm64"
export CFLAGS="-arch ${ARCH} -pipe -mdynamic-no-pic -Wno-trigraphs -fpascal-strings -O2 -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -miphoneos-version-min=$iphoneos -I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libxml2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
export AR="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ar"
export LDFLAGS="-arch ${ARCH} -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -miphoneos-version-min=7.0"
./configure --host="aarch64-apple-darwin" --enable-static=yes --enable-shared=no
make clean
make
cp objs/.libs/libfreetype.a "${HOME}/Desktop/libfreetype-${ARCH}.a"
S0="$ARCH"

ARCH="armv7"
export CFLAGS="-arch ${ARCH} -pipe -mdynamic-no-pic  -Wno-trigraphs -fpascal-strings -O2 -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -miphoneos-version-min=$iphoneos -I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libxml2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
export AR="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ar"
export LDFLAGS="-arch ${ARCH} -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -miphoneos-version-min=$iphoneos"
./configure --host="${ARCH}-apple-darwin" --enable-static=yes --enable-shared=no
make clean
make
cp objs/.libs/libfreetype.a "${HOME}/Desktop/libfreetype-${ARCH}.a"
S1="$ARCH"

iphoneos="7.0"
ARCH="i386"
export CFLAGS="-arch ${ARCH} -pipe  -Wno-trigraphs -fpascal-strings -O2 -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -miphoneos-version-min=$iphoneos -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
# export CPPFLAGS="-D__IPHONE_OS_VERSION_MIN_REQUIRED=${IPHONEOS_DEPLOYMENT_TARGET%%.*}0000"
export LDFLAGS="-arch ${ARCH} -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -miphoneos-version-min=$iphoneos"
./configure --disable-shared --enable-static --host="${ARCH}-apple-darwin"
make clean
make
cp objs/.libs/libfreetype.a "${HOME}/Desktop/libfreetype-${ARCH}.a"
S2="$ARCH"

ARCH="x86_64"
export CFLAGS="-arch ${ARCH} -pipe  -Wno-trigraphs -fpascal-strings -O2 -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -miphoneos-version-min=$iphoneos -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
# export CPPFLAGS="-D__IPHONE_OS_VERSION_MIN_REQUIRED=${IPHONEOS_DEPLOYMENT_TARGET%%.*}0000"
export LDFLAGS="-arch ${ARCH} -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -miphoneos-version-min=$iphoneos"
./configure --disable-shared --enable-static --host="${ARCH}-apple-darwin"
make clean
make
cp objs/.libs/libfreetype.a "${HOME}/Desktop/libfreetype-${ARCH}.a"
S3="$ARCH"


echo "\n\033[38;5;82mSuccess: $S0 $S1 $S2 $S3\033[0m"

lipo -create "${HOME}/Desktop/libfreetype-armv7.a" "${HOME}/Desktop/libfreetype-arm64.a" "${HOME}/Desktop/libfreetype-i386.a" "${HOME}/Desktop/libfreetype-x86_64.a" -output "${HOME}/Desktop/libfreetype.a"
lipolog="$(lipo -info ${HOME}/Desktop/libfreetype.a)"

echo "\n\033[38;5;2m$lipolog\033[0m"
echo "\n\033[38;5;82mCompleted!\033[0m"
