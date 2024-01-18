#SingleInstance Force

layout := "en_col"
alttab := "none"
altmode := False

allowStartMenu := True

mouseless := False
xm := 0
ym := 0
speed := 25

;LAlt::return
;RAlt::return

;!SC039::
;{
;	MsgBox("test")
;	global altmode
;	altmode := True
;	Send "{LAlt Down}"
;}
;
;!SC039 Up::
;{
;	MsgBox("test")
;	global altmode
;	altmode := False
;	Send "{LAlt Up}"
;}

*SC039::
{
	global altmode
	If (GetKeyState("LAlt","p")) || (GetKeyState("RAlt","p")) {
		altmode := True
		Send "{LAlt Down}"
	} else If !mouseless {
		Send "{SC039}"
	}
}

*SC039 Up::
{
	global altmode
	If altmode {
		altmode := False
		Send "{LAlt Up}"
	}
}

;SC035::
;{
;	if GetKeyState("LWin","p")||GetKeyState("RWin","p") {
;		Run "explorer"
;	} else {
;		Send "{SC035}"
;	}
;}

MoveM() {
	global xm
	global ym
	global speed

	MouseMove(xm*speed, ym*speed, , "R")
}

*SC035::
{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Run "cmd"
	} Else If GetKeyState("LWin","p") {
		Run "explorer"
		allowStartMenu := False
	} Else If GetKeyState("RWin","p") {
		Run "explorer"
		allowStartMenu := False
	} Else If !mouseless
	{
		Send "{blind}{SC035}"
	}
}
*SC02C::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{Volume_Down}"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}x"
		} else {
			Send "{blind}{z}"
		}

	}
}
*SC02D::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{Volume_Up}"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}c"
		} else {
			Send "{blind}{x}"
		}

	}
}
*SC02E::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		SoundSetVolume 12
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}d"
		} else {
			Send "{blind}{c}"
		}
	}
}
*SC01F::{
	global alttab
	global mouseless

	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		MsgBox("Close / Press Ok to reload...")
		Reload
	} Else If ((mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		If mouseless {
			mouseless := false
		}
	} Else If alttab == "enabledw" {
		Send "{Escape}"
		alttab := "half-disabledw"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}r"
		} Else {
			Send "{blind}{s}"
		}
	}
}

*SC028::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{Enter}"
	} Else If !mouseless
	{
		Send "{blind}{SC028}"
	}
}
SC03E::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{Lalt Down}{F4}{Lalt Up}"
	}
}
	
*SC025::{
	global alttab

	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{Lalt Down}{F4}{Lalt Up}"
	} Else If (GetKeyState("LWin","p") || GetKeyState("RWin","p")) {
		If alttab == "enabledw" {
			Send "{Escape}"
			alttab := "half-disabledw"
		} Else {
			Send "{RWin Down}{SC025}{RWin Up}"
		}
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}e"
		} else {
			Send "{blind}{k}"
		}
	} Else {
		global ym

		ym := 1
	}
}
*SC025 Up::
{
	global ym
	If ym == 1 {
		ym := 0
	}
}

*SC010::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{LControl Down}{Del}{LControl Up}"
	} Else If !mouseless
	{
		Send "{blind}{q}"
	}
}
*SC013::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{LControl Down}{Bs}{LControl Up}"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}p"
		} else {
			Send "{blind}{r}"
		}

	}
}
*SC011::
{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{Delete}"
	} Else If (mouseless) {
		While GetKeyState("w","p") {
			click "WU"	
			Sleep(50)
		}
	} Else If !mouseless
	{
		Send "{blind}{w}"
	}
}

*SC031::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		DllCall("User32\LockWorkStation")
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}k"
		} else {
			Send "{blind}{n}"
		}
	}
}

;#SC020::Send "{Lwin Down}d{Lwin Up}"

; Скрипт предполагает наличие ярлыка Chrome - chrome.exe (chrome.exe.lnk)
*SC032::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Run "python browse.py"
	} Else If !mouseless {
		If (layout == "en_col") {
			Send "{blind}h"
		} else {
			Send "{blind}{m}"
		}

	}
}

*SC009::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{home}"
	} else {
		Send "{blind}{SC009}"
	}
}
*SC00C::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{end}"
	} else {
		Send "{blind}{SC00C}"
	}
}
*SC00A::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{pgDn}"
	} else {
		Send "{blind}{SC00A}"
	}
}
*SC00B::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{pgUp}"
	} else {
		Send "{blind}{SC00B}"
	}
}

*SC033::
{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		global mouseless
		mouseless := !mouseless
		if mouseless {
			SetTimer MoveM, 16
		}
	} Else If !mouseless
	{
		Send "{blind}{SC33}"
	}
}

*SC016::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{Left}"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}l"
		} else {
			Send "{blind}{u}"
		}
	}
}
*SC017::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{Down}"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}u"
		} else {
			Send "{blind}{i}"
		}

	}
}

*SC018::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{Up}"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}y"
		} else {
			Send "{blind}{o}"
		}

	}
}

*SC019::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{blind}{Right}"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind};"
		} else {
			Send "{blind}{p}"
		}

	}
}

*SC034::{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		global mouseless
		mouseless := False
		en_layout()
	} Else If !mouseless
	{
		Send "{blind}{SC034}"
	}
}

*SC026::{
	Global mouseless

	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		global mouseless
		mouseless := False
		en_col_layout()
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}i"
		} else {
			Send "{blind}{l}"
		}
	} Else {
		global ym

		ym := -1
	}
}
*SC026 Up::
{
	global ym
	If ym == -1 {
		ym := 0
	}
}
*SC027::{
	If (GetKeyState("LWin","p")||GetKeyState("RWin","p")) {
		global alttab
		If (alttab == "half-enabledw" || alttab == "half-disabledw") {
			Send "{LAlt Down}"
			alttab := "enabledw"
		}
		
		Send "{Tab}"
	} else If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		global mouseless
		mouseless := False
		rus_layout()
	} Else If !mouseless {
		If (layout == "en_col") {
			Send "{blind}o"
		} else {
			Send "{blind}{SC027}"
		}

	} Else {
		global xm

		xm := 1
	}
}
*SC027 Up::
{
	global xm
	If xm == 1 {
		xm := 0
	}
}
;!д::en_col_layout()


capslock::
{
	If mouseless == True {
		global mouseless
		mouseless := False
	} Else If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		global mouseless
		mouseless := False
	} else Send "{Esc}"
}
!capslock::Send "{capslock}"

*SC01E::
{
	If ((mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		global speed
		speed := 5
	} Else If !mouseless
	{
		Send "{blind}{SC01E}"
	}
}

*SC01E Up::
{
	If ((mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		global speed
		speed := 25
	}
}

;SC024::
;SC025::
;SC026::
;SC027::
;SC024 Up::
;SC025 Up::
;SC026 Up::
;SC027 Up::
;{
;	If (mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p")) {
;		global xm
;		global ym
;		global speed
;
;		xm := 0
;		ym := 0
;
;		If GetKeyState("j","p") && !GetKeyState(";","p") {
;			xm := -1
;		}
;		
;		If GetKeyState(";","p") && !GetKeyState("j","p") {
;			xm := 1
;		}
;		
;		If GetKeyState("l","p") && !GetKeyState("k","p") {
;			ym := -1
;		}
;		
;		If GetKeyState("k","p") && !GetKeyState("l","p") {
;			ym := 1
;		}
;	}
;}

*SC021::
{
	If ((mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Click "Down"
		KeyWait "f"
		Click "Up"
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}t"
		} else {
			Send "{blind}{f}"
		}

	}
}

*SC02F::
{
	If !mouseless && !altmode && (GetKeyState("Lalt","p") || GetKeyState("Ralt","p")) {
		SoundSetVolume 0
	} Else If (mouseless) {
		Click "Middle, Down"
		KeyWait "v"
		Click "Middle, Up"
	} Else If !mouseless
	{
		Send "{blind}{v}"
	}
}

*SC020::
{
	global alttab
	global allowStartMenu

	If ((mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Click "Right, Down"
		KeyWait "d"
		Click "Right, Up"
	} Else If (GetKeyState("LWin","p") || GetKeyState("RWin","p")) {
		If alttab == "enabledw" {
			Send "{Escape}"
			alttab := "half-disabledw"
		} Else {
			Send "{RWin Down}d{RWin Up}"
			allowStartMenu := False
		}
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}s"
		} else {
			Send "{blind}{d}"
		}

	}
}

;SC023::MouseMove 20, 30, 50, "R"

rus_layout() {
	global layout
	Send "{Ralt Down}{Shift}{Ralt Up}"
	layout := "ru"
}

en_col_layout() {
	global layout
	Send "{Ralt Down}{Shift}{Ralt Up}"
	Send "{Lalt Down}{Shift}{Lalt Up}"
	layout := "en_col"
}

en_layout() {
	global layout
	Send "{Ralt Down}{Shift}{Ralt Up}"
	Send "{Lalt Down}{Shift}{Lalt Up}"
	layout := "en"
}





;check_delay() {
;	global delay
;	if GetKeyState("a","p") {
;		delay := 3
;	} else {
;		delay := 25
;	}
;}

;SC024::
;{
;	global alttab
;	global layout
;	global mouseless
;
;	if not mouseless {
;		if (alttab == "half-enabledw") {
;			Send "{Ralt Down}{tab}"
;			alttab := "enabledw"
;		} else if (alttab == "enabledw") {
;			Send "{RShift Down}{tab}{RShift Up}"
;		} else if (alttab == "none") {
;			if (layout == "en") {
;				Send "j"
;			} else if (layout == "en_col") {
;				Send "n"
;			} else {
;				Send "о"
;			}
;		}
;	}
;}

;SC027::{
;	global alttab
;	global layout
;	global mouseless
;
;	if not mouseless {
;		if (alttab == "half-enabledw") {
;			Send "{Ralt Down}{tab}"
;			alttab := "enabledw"
;		} else if (alttab == "none") {
;			if (layout == "en") {
;				Send ";"
;			} else if (layout == "en_col") {
;				Send "o"
;			} else {
;				Send "ж"
;			}
;		} else if (alttab == "enabledw") {
;			Send "{tab}"
;		}
;	}
;}

;SC025::{
;	global alttab
;	global layout
;	global mouseless
;	global ym
;
;	ym := 1
;
;	if not mouseless {
;		if (layout == "en") {
;			Send "k"
;		} else if (layout == "en_col") {
;			Send "e"
;		} else {
;			Send "л"
;		}
;	}
;}

;SC026::{
;	global alttab
;	global layout
;	global mouseless
;	global ym
;
;	ym := -1
;
;	if not mouseless {
;		if (layout == "en") {
;			Send "l"
;		} else if (layout == "en_col") {
;			Send "i"
;		} else {
;			Send "д"
;		}
;	}
;}

; Переключение окон посредством alt+j, alt+; :

; AltTab, ShiftAltTab и прочие команды работают хуже второго способа.
; Если вкратце, то ShiftAltTab должна вызываться только тогда, когда альттаб-меню уже открыто, иначе мы возвращаемся не на одно окно назад, а на два.
; Насколько я понимаю, это невозможно, потому что это особенная функция.
; Клавиша, к которой привязывается эта функция, не может вызывать что-то ещё / не может содержать условия, а значит, просто так не проверить, открыто ли уже альттаб-меню.
; Да, если команды вроде AltTab находятся внутри фигурных скобок, то они распознаются как переменные или необъявленные функции. По крайней мере, сейчас. 10.08.2023, версия 2.0.4.



;Первый способ:

;#HotIf (!mouseless)
;LWin Up::AltTabMenuDismiss
;;	Send "{LWin}"
;;	alttab := "none"
;;}
;
;LWin & SC027::AltTab
;RWin & SC027::AltTab
;
;LWin & SC024::ShiftAltTab
;RWin & SC024::ShiftAltTab

;#HotIf (GetKeyState("LWin","p")||GetKeyState("RWin","p"))
;	SC024::ShiftAltTab
;	SC025::MsgBox("test")
;#HotIf

;RWin Up::AltTabMenuDismiss
;	global alttab
;	global layout
;	AltTabMenuDismiss
;	if (alttab == "enabledw") {
;		Send "{Ralt Up}"
;		if (layout == "ru") {
;			Send "{Space}"
;		}
;	} else {
;		Send "{RWin}"
;	}
;	alttab := "none"
;}

;#HotIf

; Второй способ:

Lwin::{
	global allowStartMenu
	;allowStartMenu := True

	global alttab
	If (alttab == "none") {
		alttab := "half-enabledw"
	}
}

Rwin::{
	global allowStartMenu
	;allowStartMenu := True

	global alttab
	if (alttab == "none") {
		alttab := "half-enabledw"
	}
}


LWin Up::{
	global alttab
	if (alttab == "enabledw" || alttab == "half-disabledw") {
		Sleep(50)
		; Приходится различать half- "-enabledw" и "disabledw", потому что не не всегда зажат альт, чтобы его отпускать.
		Send "{LAlt Up}"
		alttab := "none"
	} Else If allowStartMenu {
		Send "{LWin}"
	}
}

RWin Up::{
	global alttab
	if (alttab == "enabledw" || alttab == "half-disabledw") {
		Sleep(25)
		Send "{LAlt Up}"
		; Приходится различать "half-" "-enabledw" и "disabledw", потому что не не всегда зажат альт, чтобы его отпускать.
		alttab := "none"
	} Else If allowStartMenu {
		Send "{RWin}"
	}
}

Lalt::{
	global alttab
	If (alttab == "none") {
		alttab := "half-enabledt"
	}
}

Ralt::{
	global alttab
	If (alttab == "none") {
		alttab := "half-enabledt"
	}
}

Lalt Up::{
	global altmode
	If altmode {
		Send "{LAlt Up}"
		altmode := False
	}

	global alttab
	if (alttab == "enabledt" || alttab == "half-disabledt") {
		Sleep(25)
		Send "{LAlt Up}"
		; Приходится различать "half-" "-enabledt" и "disabledt", потому что не не всегда зажат альт, чтобы его отпускать.
		alttab := "none"
	}
}

;#HotIf (GetKeyState("LWin","p")||GetKeyState("RWin","p"))

*SC024::
{
	If (GetKeyState("LWin","p")||GetKeyState("RWin","p")) {
		global alttab
		If (alttab == "half-enabledw" || alttab == "half-disabledw") {
			Send "{LAlt Down}"
			alttab := "enabledw"
			Send "{Tab}"
		} else {
			Send "{RShift Down}{Tab}{RShift Up}"
		}
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}n"
		} else {
			Send "{blind}{j}"
		}

	} Else {
		global xm

		xm := -1
	}
}
*SC024 Up::
{
	global xm
	If xm == -1 {
		xm := 0
	}
}

;#HotIf

;#HotIf (layout == "en_col") && !mouseless

;SC010::q
;SC011::w
*SC012::
{
	If ((GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))) && !altmode {
		Send "{Backspace}"
	} Else If ((GetKeyState("LWin","p") || GetKeyState("RWin","p"))) {
		Run "explorer"
	} Else If (mouseless) {
		While GetKeyState("e","p") {
			click "WD"	
			Sleep(50)
		}
	} Else If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}f"
		} else {
			Send "{blind}{e}"
		}

	}
}
*SC014::
{
	If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}b"
		} else {
			Send "{blind}{t}"
		}

	}
}
*SC015::
{
	If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}j"
		} else {
			Send "{blind}{y}"
		}

	}
}

;SC01E::a
;SC022::g
*SC023::
{
	If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}m"
		} else {
			Send "{blind}{h}"
		}

	}
}
;SC02F::v
*SC030::
{
	If !mouseless
	{
		If (layout == "en_col") {
			Send "{blind}z"
		} else {
			Send "{blind}{b}"
		}

	}
}

;#HotIf

SC0F::
{
	global alttab
	If (alttab == "half-enabledt" || alttab == "half-disabledt") {
		Send "{LAlt Down}"
		alttab := "enabledt"
		Send "{Tab}"
	} else {
		Send "{tab}"
	}
}

+SC0F::
{
	global alttab
	If (alttab == "half-enabledt" || alttab == "half-disabledt") {
		Send "{LAlt Down}"
		alttab := "enabledt"
		Send "{RShift Down}{Tab}{RShift Up}"
	} else {
		Send "{Rshift Down}{tab}{RShift Up}"
	}
}
