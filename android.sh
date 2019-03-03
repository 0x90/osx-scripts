#!/bin/bash
#Link: https://sskaje.me/2015/05/macports-install-adb/

echo "Install Android SDK Manager + NDK"
sudo port install android android-ndk
port contents android|grep \/android$

echo "Install Android SDK Platform-tools and Android SDK Build-tools"
sudo /opt/local/share/java/android-sdk-macosx/tools/android
#sh /opt/local/share/java/android-sdk-macosx/tools/android

echo "Add to PATH /opt/local/share/java/android-sdk-macosx/platform-tools/adb"


export PYTHON_CONFIGURE_OPTS="--enable-shared --with-system-expat"
