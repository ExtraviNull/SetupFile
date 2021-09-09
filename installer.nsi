Unicode true

####################################################################
# Includes

!include MUI2.nsh
!include FileFunc.nsh
!include LogicLib.nsh

!insertmacro Locate
Var /GLOBAL switch_overwrite
!include MoveFileFolder.nsh

####################################################################
# File Info

!define PRODUCT_NAME "Extravi's ReShade-Preset"
!define PRODUCT_DESCRIPTION "Shader presets made by Extravi."
!define COPYRIGHT "Copyright © 2021 sitiom, Extravi"
!define VERSION "1.1.0"

VIProductVersion "${VERSION}.0"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion" "${VERSION}"
VIAddVersionKey "FileDescription" "${PRODUCT_DESCRIPTION}"
VIAddVersionKey "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey "FileVersion" "${VERSION}.0"

####################################################################
# Installer Attributes

ManifestDPIAware true

Name "${PRODUCT_NAME}"
Outfile "Setup - ${PRODUCT_NAME}.exe"
Caption "Setup - ${PRODUCT_NAME}"
BrandingText "${PRODUCT_NAME}"

RequestExecutionLevel user
 
InstallDir "$LOCALAPPDATA\${PRODUCT_NAME}"

####################################################################
# Interface Settings

InstType "Full";1

####################################################################
# Pages

!define MUI_ICON "extravi-reshade.ico"
!define MUI_UNICON "extravi-reshade.ico"
!define MUI_ABORTWARNING
!define MUI_WELCOMEFINISHPAGE_BITMAP "extravi-reshade.bmp"
!define MUI_WELCOMEPAGE_TEXT "This will install ${PRODUCT_NAME} on your computer.$\r$\n\
$\r$\n\
It is recommended that you close Roblox before continuing.$\r$\n\
$\r$\n\
Problems with the set up may occur. In which case, it is advised you join Extravi's Discord server for your questions.$\r$\n\
$\r$\n\
Click Next to continue."
!define MUI_LICENSEPAGE_RADIOBUTTONS
!define MUI_COMPONENTSPAGE_NODESC
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_TEXT "Setup has finished installing ${PRODUCT_NAME} on your computer. The effects will be applied the next time you launch Roblox.$\r$\n\
$\r$\n\
Click Finish to exit Setup."
!define MUI_FINISHPAGE_SHOWREADME "https://www.youtube.com/watch?v=rNa5VHjHeGM"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Please like the video it really does help a lot :)"
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Join Discord Server"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenDiscordLink"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "Extravi's ReShade-Preset\license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_SHOW "StartTaskbarProgress"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

####################################################################
# Language

!insertmacro MUI_LANGUAGE "English"

####################################################################
# Sections

Var robloxPath

Section "ReShade (required)"
  SectionIn 1 RO
  
  SetOutPath $INSTDIR

  WriteUninstaller "$INSTDIR\uninstall.exe"

  ; Uninstall Regkeys
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayIcon" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayVersion" "${VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "QuietUninstallString" "$INSTDIR\uninstall.exe /S"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "Publisher" "Extravi"

  NSCurl::http GET "https://github.com/crosire/reshade-shaders/archive/refs/heads/master.zip" "reshade-shaders-master.zip" /END
  nsisunz::Unzip "reshade-shaders-master.zip" "$INSTDIR"
  Delete "reshade-shaders-master.zip"

  NSCurl::http GET "https://github.com/prod80/prod80-ReShade-Repository/archive/refs/heads/master.zip" "prod80-ReShade-Repository-master.zip" /END
  nsisunz::Unzip "prod80-ReShade-Repository-master.zip" "$INSTDIR"
  Delete "prod80-ReShade-Repository-master.zip"
  
  NSCurl::http GET "https://github.com/martymcmodding/qUINT/archive/refs/heads/master.zip" "qUINT-master.zip" /END
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

  File "Extravi's ReShade-Preset\dxgi.dll"
  File "Extravi's ReShade-Preset\dxgi.log"
  File "Extravi's ReShade-Preset\ReShade.ini"
  File "Extravi's ReShade-Preset\SegoeUI.ttf"
SectionEnd

SectionGroup /e "Presets"
  Section "Ultra"
    SectionIn 1
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Ultra Auto Depth of Field.ini"
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Ultra Light Depth of Field.ini"
  SectionEnd
  Section "Low"
    SectionIn 1
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Low Auto Depth of Field.ini"
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Low Light Depth of Field.ini"
  SectionEnd
 Section "Glossy"
    SectionIn 1
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Glossy.ini"
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset Crazy Glossy.ini"
  SectionEnd
   Section "FakeRTGI"
    SectionIn 1
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset FakeRTGI Auto Depth of Field.ini"
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset FakeRTGI Light Depth of Field.ini"
  SectionEnd
    Section "RTGI Compute Shader"
    SectionIn 1
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset RTGI Compute Shader 1.00 Auto Depth of Field.ini"
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset RTGI Compute Shader 1.00 Light Depth of Field.ini"
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset RTGI Compute Shader 2.30 Auto Depth of Field.ini"
    File "Extravi's ReShade-Preset\Extravi's ReShade-Preset RTGI Compute Shader 2.30 Light Depth of Field.ini"
  SectionEnd
SectionGroupEnd

Section "uninstall"
  ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "un.SetRobloxPath"

  Delete "$INSTDIR\uninstall.exe"
  RMDir /r $INSTDIR

  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets"

  Delete "$robloxPath\Extravi's ReShade-Preset Ultra Auto Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset Ultra Light Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset Low Auto Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset Low Light Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset FakeRTGI Auto Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset FakeRTGI Light Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset Glossy.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset Crazy Glossy.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset RTGI Compute Shader 1.00 Auto Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset RTGI Compute Shader 1.00 Light Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset RTGI Compute Shader 2.30 Auto Depth of Field.ini"
  Delete "$robloxPath\Extravi's ReShade-Preset RTGI Compute Shader 2.30 Light Depth of Field.ini"
  Delete "$robloxPath\ReShade.ini"
  RMDir /r "$robloxPath\reshade-shaders"
  Delete "$robloxPath\dxgi.dll"
  Delete "$robloxPath\dxgi.log"
  Delete "$robloxPath\SegoeUI.ttf"
SectionEnd

####################################################################
# Functions

Function .onInit
  ${Locate} "$PROGRAMFILES\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "Troubleshoot"

  StrCpy $robloxPath ""
  ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "SetRobloxPath"  
  
  ${If} $robloxPath == ""
    MessageBox MB_ICONEXCLAMATION "Roblox installation not found. Install Roblox on https://www.roblox.com/download/client and try again."
    ExecShell open "https://www.roblox.com/download/client"
    Abort
  ${EndIf}
FunctionEnd

Function "Troubleshoot"
    MessageBox MB_YESNO|MB_ICONEXCLAMATION "Cannot install when Roblox is located in C:\Program Files (x86). Would you like to reinstall Roblox automatically and try again, if that is the case it's recommended that you close Roblox before continuing." IDYES yes
        Abort
    yes:
    CreateDirectory "$LOCALAPPDATA\Troubleshoot"
    SetOutPath "$LOCALAPPDATA\Troubleshoot"
    File "Troubleshoot\RobloxPlayerLauncher.bat"
    File "Troubleshoot\RobloxPlayerLauncher.exe"
    File "Troubleshoot\Troubleshoot.bat"
    File "Troubleshoot\Troubleshoot.exe"
    ExecWait "$LOCALAPPDATA\Troubleshoot\Troubleshoot.bat"
    MessageBox MB_YESNO|MB_ICONQUESTION "Removed Roblox from C:\Program Files (x86). Would you like continue to install Roblox. It may take 10 seconds or more to start." IDYES yes2
        Abort
    yes2:
    Sleep 9000
    ExecWait "$LOCALAPPDATA\Troubleshoot\RobloxPlayerLauncher.bat"
    Sleep 9000
    MessageBox MB_ICONQUESTION "Roblox has been reinstalled. Please relaunch the installer and try again. If this did not work it is advised you join Extravi's Discord server for your questions."
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

Function "StartTaskbarProgress"
  w7tbp::Start
FunctionEnd

Function "OpenDiscordLink"
  ExecShell "open" "https://discord.gg/WkjUCwD"
FunctionEnd
