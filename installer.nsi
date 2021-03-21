Unicode true

# Startup

!include DotNetChecker.nsh
!include MUI2.nsh
!include FileFunc.nsh
!insertmacro Locate
Var /GLOBAL switch_overwrite
!include MoveFileFolder.nsh
!include LogicLib.nsh

# Installer Attributes

Name "Extravi's ReShade Presets"
Outfile "Setup - Extravi's ReShade-Preset.exe"
Caption "Setup - Extravi's ReShade Presets"
BrandingText "Extravi's ReShade Presets"

RequestExecutionLevel user
 
InstallDir "$LOCALAPPDATA\Extravi's ReShade Presets"

# Version Info
!define PRODUCT_NAME "Extravi's ReShade Presets"
!define PRODUCT_DESCRIPTION "Extravi's ReShade Presets"
!define COPYRIGHT "Copyright © 2021 sitiom, Extravi"
!define PRODUCT_VERSION "1.0.0.0"
!define SETUP_VERSION 1.0.0.0

VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion" "${PRODUCT_VERSION}"
VIAddVersionKey "FileDescription" "${PRODUCT_DESCRIPTION}"
VIAddVersionKey "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey "FileVersion" "${SETUP_VERSION}"

# Interface Settings

InstType "Full";1

# Pages

!define MUI_ICON "extravi-reshade.ico"
!define MUI_UNICON "extravi-reshade.ico"
!define MUI_ABORTWARNING
!define MUI_WELCOMEFINISHPAGE_BITMAP "extravi-reshade.bmp"
!define MUI_WELCOMEPAGE_TEXT "This will install Extravi's ReShade Presets on your computer.$\r$\n\
$\r$\n\
It is recommended that you close Roblox before continuing.$\r$\n\
$\r$\n\
Problems with the set up may occur. In which case, it is advised you join Extravi's Discord server for your questions.$\r$\n\
$\r$\n\
Click Next to continue."
!define MUI_LICENSEPAGE_RADIOBUTTONS
!define MUI_COMPONENTSPAGE_NODESC
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_TEXT "Setup has finished installing Extravi's ReShade Presets on your computer. The effects will be applied the next time you launch Roblox.$\r$\n\
$\r$\n\
Click Finish to exit Setup."
!define MUI_FINISHPAGE_SHOWREADME "https://www.youtube.com/channel/UCOZnRzWstxDLyW30TjWEevQ?sub_confirmation=1"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Subscribe to Extravi on Youtube"
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Join Discord Server"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenDiscordLink"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "Extravi's ReShade-Preset\license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Languages

!insertmacro MUI_LANGUAGE "English"

Var robloxPath

# Sections

Section "Microsoft .NET Framework v4.8 (required)"
  SectionIn 1 RO

  !insertmacro CheckNetFramework 48
SectionEnd

Section "ReShade (required)"
  SectionIn 1 RO
  
  SetOutPath $INSTDIR

  ; Uninstall Regkeys
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayIcon" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayName" "Extravi's ReShade Presets"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayVersion" "1.0.0"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "QuietUninstallString" "$INSTDIR\uninstall.exe /S"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "Publisher" "Extravi"

  WriteUninstaller "$INSTDIR\uninstall.exe"

  inetc::get /NOCANCEL "https://codeload.github.com/crosire/reshade-shaders/zip/master" "reshade-shaders-master.zip"
  nsisunz::Unzip "reshade-shaders-master.zip" "$INSTDIR"
  Delete "reshade-shaders-master.zip"

  inetc::get /NOCANCEL "https://codeload.github.com/prod80/prod80-ReShade-Repository/zip/master" "prod80-ReShade-Repository-master.zip"
  nsisunz::Unzip "prod80-ReShade-Repository-master.zip" "$INSTDIR"
  Delete "prod80-ReShade-Repository-master.zip"
  
  inetc::get /NOCANCEL "https://codeload.github.com/martymcmodding/qUINT/zip/master" "qUINT-master.zip"
  nsisunz::Unzip "qUINT-master.zip" "$INSTDIR"
  Delete "qUINT-master.zip"

  StrCpy $switch_overwrite 1

  !insertmacro MoveFolder "reshade-shaders-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "reshade-shaders-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\reshade-shaders-master"

  !insertmacro MoveFolder "prod80-ReShade-Repository-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "prod80-ReShade-Repository-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\prod80-ReShade-Repository-master"

  !insertmacro MoveFolder "qUINT-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\qUINT-master"

  SetOutPath $robloxPath

  File "Extravi's ReShade-Preset\opengl32.dll"
  File "Extravi's ReShade-Preset\Reshade.ini"
SectionEnd

SectionGroup /e "Presets"

Section "Super Reflective"
  SectionIn 1
  File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Super Reflective.ini"
SectionEnd
Section "Reflective"
  SectionIn 1
  File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Reflective.ini"
SectionEnd
Section "Ultra"
  SectionIn 1
  File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Ultra.ini"
SectionEnd
Section "High"
  SectionIn 1
  File "Extravi's ReShade-Preset\Extravi's ReShade-Preset High.ini"
SectionEnd
Section "Medium"
  SectionIn 1
  File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Medium.ini"
SectionEnd
Section "Low"
  SectionIn 1
  File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Low.ini"
SectionEnd
Section "Chromakey"
  SectionIn 1
  File "Extravi's ReShade-Preset\Greenscreen.ini"
SectionEnd
SectionGroupEnd

Section "uninstall"
    ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "un.SetRobloxPath"

    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets"

    Delete "$INSTDIR\uninstall.exe"
    RMDir $INSTDIR

    Delete "$robloxPath\Extravi's ReShade-Preset Super Reflective.ini"
    Delete "$robloxPath\Extravi's ReShade-Preset Reflective.ini"
    Delete "$robloxPath\Extravi's ReShade-Preset Ultra.ini"
    Delete "$robloxPath\Extravi's ReShade-Preset High.ini"
    Delete "$robloxPath\Extravi's ReShade-Preset Medium.ini"
    Delete "$robloxPath\Extravi's ReShade-Preset Low.ini"
    Delete "$robloxPath\Greenscreen.ini"
    Delete "$robloxPath\Reshade.ini"
    RMDir /r "$robloxPath\reshade-shaders"
    Delete "$robloxPath\opengl32.dll"
SectionEnd

# Functions

Function .onInit
  ${Locate} "$PROGRAMFILES\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "Exit"

  StrCpy $robloxPath ""
  ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "SetRobloxPath"  
  
  ${If} $robloxPath == ""
    MessageBox MB_ICONEXCLAMATION "Roblox installation not found. Install Roblox on https://www.roblox.com/download/client and try again."
    ExecShell open "https://www.roblox.com/download/client"
    Abort
  ${EndIf}
FunctionEnd

Function "Exit"
  MessageBox MB_ICONEXCLAMATION "Cannot install when Roblox is located in C:\Program Files (x86). Please reinstall Roblox as non-admin and try again."
  Abort
FunctionEnd

Function "SetRobloxPath"
  SetOutPath $R8
  StrCpy $robloxPath $R8
  StrCpy $0 StopLocate
  Push $0
FunctionEnd
Function "un.SetRobloxPath"
  SetOutPath $R8
  StrCpy $robloxPath $R8
  StrCpy $0 StopLocate
  Push $0
FunctionEnd

Function "OpenDiscordLink"
  ExecShell "open" "https://discord.gg/WkjUCwD"
FunctionEnd
