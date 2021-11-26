#!/bin/sh

install_wine()
{
  # https://github.com/Gcenx/homebrew-wine
  brew tap gcenx/wine
  brew install --cask --no-quarantine wine-crossover
}


configure_wine()
{
  # echo export WINEARCH=win64>>$HOME/.zshrc
  # echo export WINEPREFIX=$HOME/.wine64>>$HOME/.zshrc
  # echo export WINEARCH=win32>>$HOME/.zshrc
  # echo export WINEPREFIX=$HOME/.wine32>>$HOME/.zshrc

  # to suppress Wine debug output
  # WINEDEBUG=-all
  # WINEDEBUG fixme-all

  # winecfg
  #wineboot
  # # wine reg add "HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Session Manager\\Environment\\Environment" /v "SystemDrive" /t REG_SZ /d "C:" /f

}

install_winetricks_src()
{
  mkdir -p ~/.local/bin
  cd ~/.local/bin
  wget -nc https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
  chmod +x winetricks
}

winetricks --self-update
  # winetricks win10
  # winetricks win7
  # wineboot -r
}

install_wine_packages()
{

  #winetricks allfonts
  winetricks corefonts
  winetricks cmd
  winetricks comctl32
  winetricks comctl32ocx
  winetricks comdlg32ocx
  winetricks riched30
  winetricks richtx32
  winetricks mdac28
  winetricks jet40
  winetricks mfc42
  winetricks msxml6
  winetricks vb6run
  winetricks vcrun2003
  winetricks vcrun2005
  winetricks vcrun2008
  winetricks vcrun2012
  winetricks vcrun2013
  winetricks vcrun2015
  winetricks vcrun6sp6

  winetricks -q dotnet40 corefonts


  winetricks urlmon wininet
winetricks -q msi2 gdiplus

winetricks gdiplus wmp9 riched20 msxml6 d3dx9_43

  # wget http://captvty.fr/getgdiplus -O kb975337.exe
  # wine kb975337.exe /x:kb975337 /q
  # cp kb975337/asms/10/msft/windows/gdiplus/gdiplus.dll ~/.wine/drive_c/windows/system32
  # wine reg add HKCU\\Software\\Wine\\DllOverrides /v gdiplus /d native,builtin /f

  winetricks -q comctl32
  winetricks -q ie8


  winetricks -q hosts
}

install_wine_packages_dev()
  winetricks -q dbghelp
  winetricks -q mingw mingw-gdb
  winetricks -q python27
}

install_wine
configure_wine
install_wine_packages
