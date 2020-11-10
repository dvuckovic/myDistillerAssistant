# myDistillerAssistant NSIS Configuration Script
# (d) MMVIII by dUcA

# Customization ###################################################################
!define PRODUCT "myDistillerAssistant"
!define PRODUCT_LONG "myDistillerAssistant for Windows"
!define VERSION "2.4"
!define YEAR "MMVIII"
###################################################################################

# EXE-overHeads ###################################################################
VIAddVersionKey "ProductName" "${PRODUCT} Setup"
VIProductVersion "${VERSION}.0.0"
VIAddVersionKey "FileDescription" "${PRODUCT_LONG} Setup"
VIAddVersionKey "FileVersion" "${VERSION}"
VIAddVersionKey "LegalCopyright" "(d) ${YEAR} by dUcA"
###################################################################################

# Basic stuff #####################################################################
Name "${PRODUCT}"
Caption "${PRODUCT} v${VERSION} Setup"
OutFile "${PRODUCT}.exe"
SetCompressor lzma
BrandingText "powered by Nullsoft Scriptable Install System"
SetFont "MS Sans Serif" "8"
CompletedText "${PRODUCT} Setup has completed successfully!"
LicenseForceSelection checkbox "I &Accept"
ShowInstDetails show
ShowUninstDetails show
###################################################################################

# Include #########################################################################
!include "MUI.nsh"
!include "Sections.nsh"
###################################################################################

# Definitions #####################################################################
Var v1
Var v2
Var ver
Var jofolder
Var stfolder
Var folderheader
Var foldertext
#Var manual_state
Var STARTMENU_FOLDER
Var MDA_INSTDIR
!define MUI_FONT_HEADER "MS Sans Serif"
!define MUI_FONTSIZE_HEADER "8"
!define MUI_FONTSTYLE_HEADER "700"
!define MUI_ICON "reader.ico"
!define MUI_UNICON "distiller.ico"
!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_DIRECTORYPAGE_VARIABLE $MDA_INSTDIR
!define MUI_STARTMENUPAGE_REGISTRY_ROOT HKCU
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${PRODUCT}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenuFolder"
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "${PRODUCT}"

###################################################################################

# Install pages ###################################################################
!insertmacro MUI_PAGE_LICENSE "license.txt"
  Page custom InstallDirs
  ReserveFile "installdirs.ini"
  Function InstallDirs
	!insertmacro MUI_HEADER_TEXT "Install folders" "$folderheader"
	!insertmacro MUI_INSTALLOPTIONS_DISPLAY "installdirs.ini"
  FunctionEnd
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
  Page custom FinishPage #EndFinishPage
  ReserveFile "finishpage.ini"
  Function FinishPage
	!insertmacro MUI_HEADER_TEXT "${PRODUCT} Setup succesfully completed" "Setup was succesfully completed"
	!insertmacro MUI_INSTALLOPTIONS_DISPLAY "finishpage.ini"
  FunctionEnd
# UnInstall pages ###################################################################
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
###################################################################################

# Language ########################################################################
!insertmacro MUI_LANGUAGE "English"
###################################################################################

Section "-Program files (required)"
	WriteRegStr HKCU "Software\${PRODUCT}" "" $MDA_INSTDIR
	!insertmacro MUI_INSTALLOPTIONS_READ $jofolder "installdirs.ini" "Field 3" "State"
	!insertmacro MUI_INSTALLOPTIONS_READ $stfolder "installdirs.ini" "Field 5" "State"
	WriteRegStr HKCU "Software\${PRODUCT}" "JobOptionsFolder" $jofolder
	WriteRegStr HKCU "Software\${PRODUCT}" "StartupFolder" $stfolder
	SetOutPath $jofolder
	File "cs4\jobOptions.joboptions"
	SetOutPath $stfolder
	IfFileExists "$stfolder\example.ps" 0
  		Delete /REBOOTOK "$stfolder\example.ps"
	File "CreoDistillerAssistant\CreoDistillerAssistant"
	DetailPrint "Writing registry values for Adobe PDF printer preferences..."
	WriteRegBin HKCU "Printers\DevModePerUser" "Adobe PDF" 410064006f006200650020005000440046000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001040205dc00f40453ef8101010009009a0b3408640001000f00b00402000100b004030001004100340000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000010000000200000001000000000000000000000000000000000000000000000050524956e220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001800000000001027102710270000102700000000000000000000c4020000000000000000000000000000000000000000000000000300000000000000300210005c4b03006843040000000000000000000000000000000000000000000000000000000000449f6be60500000004001200ff00ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030020000454244410000010000000000010000000100000001000000010000006a006f0062004f007000740069006f006e00730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000
	SetOutPath $MDA_INSTDIR
	#File "grid-manual.pdf"
	WriteUninstaller "$MDA_INSTDIR\uninstall.exe"
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
		CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
	#	CreateShortcut "$SMPROGRAMS\$STARTMENU_FOLDER\Grid Studio - Vodic kroz pripremu.lnk" "$MDA_INSTDIR\grid-manual.pdf"
		CreateShortcut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$MDA_INSTDIR\uninstall.exe"
	!insertmacro MUI_STARTMENU_WRITE_END
	SetAutoClose true
SectionEnd

Section "Uninstall"
	ReadRegStr $MDA_INSTDIR HKCU "Software\${PRODUCT}" ""
	ReadRegStr $jofolder HKCU "Software\${PRODUCT}" "JobOptionsFolder"
	ReadRegStr $stfolder HKCU "Software\${PRODUCT}" "StartupFolder"
	Delete /REBOOTOK "$jofolder\jobOptions.joboptions"
	Delete /REBOOTOK "$stfolder\CreoDistillerAssistant"
	Delete /REBOOTOK "$MDA_INSTDIR\*.*"
	RmDir /REBOOTOK $MDA_INSTDIR
	!insertmacro MUI_STARTMENU_GETFOLDER Application $STARTMENU_FOLDER
	Delete /REBOOTOK "$SMPROGRAMS\$STARTMENU_FOLDER\*.*"
	RMDir /REBOOTOK "$SMPROGRAMS\$STARTMENU_FOLDER"
	DeleteRegKey HKCU "Software\${PRODUCT}"
SectionEnd

Function .onInit
	StrCpy $MDA_INSTDIR "$PROGRAMFILES\${PRODUCT}"
	call GetAcrobatDistillerVersion
#Check0:
	StrCmp "$v1" "0" 0 Check4
NotInstalled:	
		StrCpy $ver "Distiller not installed!"
		StrCpy $folderheader "Adobe Acrobat Distiller installation not detected!"
		StrCpy $foldertext "Setup was unable to detect an Adobe Acrobat Distiller installation on your computer. Please verify that Adobe Acrobat package is installed properly. If you want you can continue with this setup and manually set appropriate Distiller folders."
		GoTo EndInit
Check4:
	StrCmp "$v1" "4" Compose4And5 Check5
Check5:
	StrCmp "$v1" "5" 0 Check6
Compose4And5:
		StrCpy $ver "Version $v1.$v2"
		ReadRegStr $R0 HKLM "SOFTWARE\Adobe\Acrobat Distiller\$v1.$v2" "InstallPath"
		StrCpy $jofolder "$R0\Settings"
		StrCpy $stfolder "$R0\Startup"
		GoTo EndInit
Check6:
	StrCmp "$v1" "6" Compose6And7 Check7
Check7:
	StrCmp "$v1" "7" 0 Check8 #Compose6And7 CheckOther
Compose6And7:
		StrCpy $ver "Version $v1.$v2"
		ReadRegStr $jofolder HKLM "SOFTWARE\Adobe\Acrobat Distiller\$v1.$v2" "JobOptionsFolder"
		StrCpy $stfolder "$jofolder" -10
		StrCpy $stfolder "$stfolder\Startup\"
		StrCpy $folderheader "Setup has detected Adobe Acrobat Distiller $v1.$v2 installation"
		StrCpy $foldertext "Setup has detected Settings and Startup folders of your Adobe Acrobat Distiller installation. Please verify them in order to continue with setup."
Check8:
	StrCmp "$v1" "8" Compose8 CheckOther
CheckOther:
	IntCmp $v1 8 0 NotInstalled 0 #7
Compose8:
		StrCpy $ver "Version $v1.$v2"
		ReadRegStr $jofolder HKLM "SOFTWARE\Adobe\Acrobat Distiller\$v1.0" "JobOptionsFolder"
		StrCpy $stfolder "$jofolder" -10
		StrCpy $stfolder "$stfolder\Distiller\Startup\"
		AccessControl::GrantOnFile $stfolder "Everyone" "FullAccess"
		StrCpy $folderheader "Setup has detected Adobe Acrobat Distiller $v1.$v2 installation"
		StrCpy $foldertext "Setup has detected Settings and Startup folders of your Adobe Acrobat Distiller installation. Please verify them in order to continue with setup."
EndInit:
	!insertmacro MUI_INSTALLOPTIONS_EXTRACT "installdirs.ini"
	!insertmacro MUI_INSTALLOPTIONS_WRITE "installdirs.ini" "Field 1" "Text" "$foldertext"
	!insertmacro MUI_INSTALLOPTIONS_WRITE "installdirs.ini" "Field 3" "State" "$jofolder"
	!insertmacro MUI_INSTALLOPTIONS_WRITE "installdirs.ini" "Field 5" "State" "$stfolder"
	!insertmacro MUI_INSTALLOPTIONS_EXTRACT "finishpage.ini"
FunctionEnd

Function GetAcrobatDistillerVersion
	ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\AcroDist.exe" ""
	StrCmp "$R0" "" DistillerNotInstalled
	GetDllVersion "$R0" $R0 $R1
	IntOp $R8 $R0 / 0x00010000
	IntOp $R9 $R0 & 0x0000FFFF
	Goto EndGetAcrobatDistillerVersion
DistillerNotInstalled:
	StrCpy $R8 "0"
	StrCpy $R9 "0"
EndGetAcrobatDistillerVersion:
	StrCpy $v1 "$R8"
	StrCpy $v2 "$R9"
FunctionEnd

#Function EndFinishPage
#	!insertmacro MUI_INSTALLOPTIONS_READ $manual_state "finishpage.ini" "Field 2" "State"
#	IntCmp $manual_state 1 0 +2
#	ExecShell "open" "$MDA_INSTDIR\grid-manual.pdf"
#	Quit
#FunctionEnd