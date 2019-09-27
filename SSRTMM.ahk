#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
SetWorkingDir C:\Program Files (x86)\Steam\steamapps\common\Spyro Reignited Trilogy\Falcon\Content\Paks\~mods
version=b1

datafolder=%A_ScriptDir%\data
modfolder=%A_ScriptDir%\Mods
intlmodfolder=C:\Program Files (x86)\Steam\steamapps\common\Spyro Reignited Trilogy\Falcon\Content\Paks\~mods

IfExist, intlmodfolder
	sleep, 1
else {
	FileCreateDir, %intlmodfolder%
}	
IfExist, %datafolder%
	sleep, 1
else {
	FileCreateDir, %datafolder%
}
IfExist, %modfolder% 
	sleep, 1
else {
	FileCreateDir, %modfolder%
}

modno:=ComObjCreate("Scripting.FileSystemObject").GetFolder(modfolder).Files.Count
intlmodno:=ComObjCreate("Scripting.FileSystemObject").GetFolder(intlmodfolder).Files.Count

loop, %intlmodno% {
text%A_Index%=
}

global datafolder
global modfolder
global intlmodfolder
global modno
global intlmodno
global textid

line:=0

Start:
Gui, tmp:Add, Button, y500 w50 gAddMod, Add Mod
Gui, tmp:Add, Button, y500 w50 gRefreshModList, Refresh Mod List
Gui, tmp:Add, Button, y500 w75 gRemoveMod, Remove Mod
Gui, tmp:Show, w1000, Simple Spyro Reignited Trilogy Mod Manmanager
gosub, ListMods
return

AddMod:
FileSelectFile, in,, %modfolder%,, *.pak
FileCopy, %in%, %intlmodfolder%
return

ListMods:
FileDelete, %datafolder%\Intlmods.txt
getintlmods()
ListMods()
return

RefreshModList:
Reload
return

RemoveMod:
FileSelectFile, in,, %intlmodfolder%,, *.pak
FileDelete, %in%
return

ListMods() {
textx:=10
texty:=10
IniRead, modnamelist, %A_ScriptDir%\data\Intlmods.txt
modnamelist := StrSplit(modnamelist , "`n")
loop
{
	if (A_Index > intlmodno)
	{
		texty:=10
		line:=0
		break
	}
	textid:= "text" A_Index
	Gui, tmp:Add, Text, x%textx% y%texty% cblue v%textid%, % modnamelist[A_Index]
	
	texty+=20
	line++
	If (line > 23)
	{
		textx:= 200
		texty:=10
		line:=0
	}
}
}

refreshmodlist()
{
IniRead, modnamelist, %A_ScriptDir%\data\Intlmods.txt
modnamelist := StrSplit(modnamelist , "`n")
Loop, %intlmodno%
{
	textid:= "text" A_Index
	GuiControl, , %textid%, % modnamelist[A_Index]
}
}

getmods() {
loop, %A_ScriptDir%\Mods\*.pak
{
	SplitPath, A_LoopFileFullPath,,, 1, modname, 2
	IniWrite, %A_Index%, %datafolder%\Modlist.txt, %modname%, modid
}
}

getintlmods() {
loop, %A_WorkingDir%\*.pak
{
	SplitPath, A_LoopFileFullPath,,, 1, modname, 2
	IniWrite, btk6washere, %datafolder%\Intlmods.txt, %modname%
}
}

tmpGuiClose:
FileDelete, %datafolder%\Intlmods.txt
ExitApp