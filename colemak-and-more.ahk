; Colemak Mod-DH mapping for ANSI boards

#SingleInstance Force

layout := "en_col"
alttab := "none"
altmode := False

mouseless := False
xm := 0
ym := 0
speed := 25

LAlt::return
RAlt::return
!Space::
{
	MsgBox("test")
	global altmode
	altmode := True
	Send "{LAlt Down}"
}
!Space Up::
{
	MsgBox("test")
	global altmode
	altmode := False
	Send "{LAlt Up}"
}

#HotIf (altmode)
Space::Return
#HotIf

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

#HotIf (GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))
SC035::Run "cmd"
SC02C::Send "{Volume_Down}"
SC02D::Send "{Volume_Up}"
SC02E::SoundSetVolume 12
SC01F::
{
	MsgBox("Close / Press Ok to reload...")
	Reload
}

'::enter
SC025::Send "{Lalt Down}{F4}{Lalt Up}"

SC010::^Del
SC013::^SC00E
SC011::Send "{Delete}"
SC012::Send "{Backspace}"

SC031::DllCall("User32\LockWorkStation")

;#SC020::Send "{Lwin Down}d{Lwin Up}"

; Скрипт предполагает наличие ярлыка Chrome - chrome.exe (chrome.exe.lnk)
SC032::Run "browse.py"

8::home
-::end
9::pgDn
0::pgUp

SC033::
{
	global mouseless
	mouseless := !mouseless
	if mouseless {
		SetTimer MoveM, 16
	}
}

SC016::Left
SC017::Down
SC018::Up
SC019::Right

SC034::en_layout()
SC026::en_col_layout()
SC027::rus_layout()
;!д::en_col_layout()

#HotIf



capslock::
{
	global mouseless
	if mouseless {
		mouseless := False
	} else Send "{Esc}"
}

#HotIf (mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))

SC01E::
{
	global speed
	speed := 5
}

SC01E Up::
{
	global speed
	speed := 25
}

SC024::
SC025::
SC026::
SC027::
SC024 Up::
SC025 Up::
SC026 Up::
SC027 Up::
{
	global xm
	global ym
	global speed

	xm := 0
	ym := 0

	If GetKeyState("j","p") && !GetKeyState(";","p") {
		xm := -1
		jk := True
	} else {
		jk := False
	}
	
	If GetKeyState(";","p") && !GetKeyState("j","p") {
		xm := 1
		sk := True
	} else {
		sk := False
	}
	
	If GetKeyState("l","p") && !GetKeyState("k","p") {
		ym := -1
		lk := True
	} else {
		lk := False
	}
	
	If GetKeyState("k","p") && !GetKeyState("l","p") {
		ym := 1
		kk := True
	} else {
		kk := False
	}
}

SC021::
{
	Click "Down"
	KeyWait "f"
	Click "Up"
}

SC02F::
{
	Click "Middle, Down"
	KeyWait "d"
	Click "Middle, Up"
}

SC020::
{
	Click "Right, Down"
	KeyWait "d"
	Click "Right, Up"
}

SC011::
{
	While GetKeyState("w","p") {
		click "WU"	
		Sleep(50)
	}
}
SC012::
{
	While GetKeyState("e","p") {
		click "WD"	
		Sleep(50)
	}
}
SC01F::
{
	global mouseless
	if mouseless {
		mouseless := false
	}
}

#HotIf


;SC023::MouseMove 20, 30, 50, "R"

rus_layout(){
	global layout
	Send "{RShift Down}{RAlt}{Rshift Up}"
	layout := "ru"
}

en_col_layout(){
	global layout
	Send "{RShift Down}{RAlt}{Rshift Up}"
	Send "{RShift Down}{LAlt}{Rshift Up}"
	layout := "en_col"
}

en_layout(){
	global layout
	Send "{RShift Down}{RAlt}{Rshift Up}"
	Send "{RShift Down}{LAlt}{Rshift Up}"
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
;		if (alttab == "half") {
;			Send "{Ralt Down}{tab}"
;			alttab := "enabled"
;		} else if (alttab == "enabled") {
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
;		if (alttab == "half") {
;			Send "{Ralt Down}{tab}"
;			alttab := "enabled"
;		} else if (alttab == "none") {
;			if (layout == "en") {
;				Send ";"
;			} else if (layout == "en_col") {
;				Send "o"
;			} else {
;				Send "ж"
;			}
;		} else if (alttab == "enabled") {
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

#HotIf (!mouseless)
; Переключение окон посредством alt+j, alt+; :

; AltTab, ShiftAltTab и прочие команды работают хуже второго способа.
; Если вкратце, то ShiftAltTab должна вызываться только тогда, когда альттаб-меню уже открыто, иначе мы возвращаемся не на одно окно назад, а на два.
; Насколько я понимаю, это невозможно, потому что это особенная функция.
; Клавиша, к которой привязывается эта функция, не может вызывать что-то ещё / не может содержать условия, а значит, просто так не проверить, открыто ли уже альттаб-меню.
; Да, если команды вроде AltTab находятся внутри фигурных скобок, то они распознаются как переменные или необъявленные функции. По крайней мере, сейчас. 10.08.2023, версия 2.0.4.



;Первый способ:

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
;	if (alttab == "enabled") {
;		Send "{Ralt Up}"
;		if (layout == "ru") {
;			Send "{Space}"
;		}
;	} else {
;		Send "{RWin}"
;	}
;	alttab := "none"
;}

#HotIf

; Второй способ:

Lwin::{
	global alttab
	if (alttab == "none") {
		alttab := "half"
	}
}

Rwin::{
	global alttab
	if (alttab == "none") {
		alttab := "half"
	}
}

LWin Up::{
	global alttab
	if (alttab == "enabled") {
		Sleep(25)
		Send "{LAlt Up}"
		alttab := "none"
	}
}

RWin Up::{
	global alttab
	if (alttab == "enabled") {
		Sleep(25)
		Send "{LAlt Up}"
		alttab := "none"
	}
}

#HotIf (GetKeyState("LWin","p")||GetKeyState("RWin","p"))

SC035::Run "explorer"
SC027::
{
	global alttab
	If (alttab == "half") {
		Send "{LAlt Down}"
		alttab := "enabled"
	}
	
	Send "{Tab}"
}

SC024::
{
	global alttab
	If (alttab == "half") {
		Send "{LAlt Down}"
		alttab := "enabled"
		Send "{Tab}"
	} else {
		Send "{RShift Down}{Tab}{RShift Up}"
	}
}

#HotIf

#HotIf (layout == "en_col") && !mouseless

;SC010::q
;SC011::w
*SC012::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}f"
	}
}
*SC013::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}p"
	}
}
*SC014::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}b"
	}
}
*SC015::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}j"
	}
}
*SC016::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}l"
	}
}
*SC017::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}u"
	}
}
*SC018::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}y"
	}
}
*SC019::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind};"
	}
}

;SC01E::a
*SC01F::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}r"
	}
}
*SC020::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}s"
	}
}
*SC021::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}t"
	}
}
;SC022::g
*SC023::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}m"
	}
}
*SC024::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}n"
	}
}
*SC025::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}e"
	}
}
*SC026::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}i"
	}
}
*SC027::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}o"
	}
}

*SC02c::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}x"
	}
}
*SC02d::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}c"
	}
}
*SC02e::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}d"
	}
}
;SC02f::v
*SC030::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}z"
	}
}
*SC031::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}k"
	}
}
*SC032::
{
	If (layout == "en_col") && !mouseless
	{
		Send "{blind}h"
	}
}

; set Backspace to CapsLock key

; sc03a::backspace

#HotIf

