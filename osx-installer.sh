# https://support.apple.com/en-us/HT201372
# https://osxdaily.com/2020/04/13/how-download-full-macos-installer-terminal/
# https://www.intoguide.com/download-macos-catalina-iso-file-latest-version/
# https://www.intoguide.com/download-macos-10-15-catalina-vmdk-files-virtual-machine-image/

Catalina:*
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

Mojave:*
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

High Sierra:*
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

El Capitan:
sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app
