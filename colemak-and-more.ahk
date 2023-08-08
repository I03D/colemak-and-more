; Colemak Mod-DH mapping for ANSI boards

#SingleInstance Force

layout := "en_col"
alttab := "none"

mouseless := False
xm := 0
ym := 0
speed := 15

Lalt::return
Ralt::return

SC035::
{
	if GetKeyState("LWin","p")||GetKeyState("RWin","p") {
		Run "explorer"
	} else {
		Send "{SC035}"
	}
}

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

#HotIf (mouseless) && !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p"))
SC011::click "WU"
SC012::click "WD"
SC01F::
{
	global mouseless
	if mouseless {
		mouseless := false
	} else if !(GetKeyState("Lalt","p") || GetKeyState("Ralt","p")) {
		if (layout == "en") {
			Send "s"
		} else if (layout == "en_col") {
			Send "r"
		} else {
			Send "ы"
		}
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

check_delay() {
	global delay
	if GetKeyState("a","p") {
		delay := 3
	} else {
		delay := 15
	}
}

SC024::
{
	global alttab
	global layout
	global mouseless

	if not mouseless {
		if (alttab == "half") {
			Send "{Ralt Down}{tab}"
			alttab := "enabled"
		} else if (alttab == "enabled") {
			Send "{RShift Down}{tab}{RShift Up}"
		} else if (alttab == "none") {
			if (layout == "en") {
				Send "j"
			} else if (layout == "en_col") {
				Send "n"
			} else {
				Send "о"
			}
		}
	}
}

SC027::{
	global alttab
	global layout
	global mouseless

	if not mouseless {
		if (alttab == "half") {
			Send "{Ralt Down}{tab}"
			alttab := "enabled"
		} else if (alttab == "none") {
			if (layout == "en") {
				Send ";"
			} else if (layout == "en_col") {
				Send "o"
			} else {
				Send "ж"
			}
		} else if (alttab == "enabled") {
			Send "{tab}"
		}
	}
}
;
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
;
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

SC01E::
{
	if mouseless {
		global speed
		speed := 5
	} else {
		Send "a"
	}
}

SC01E Up::
{
	global speed
	speed := 15
}

#HotIf (mouseless)

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

#HotIf

; Использовать AltTab и ShiftAltTab в будущем. (/docs/v2/Hotkeys.htm#alttab)
LWin Up::{
	global alttab
	global layout

	if (alttab == "enabled") {
		Send "{Ralt Up}"
		if (layout == "ru") {
			Send "{Space}"
		}
	} else {
		Send "{LWin}"
	}

	alttab := "none"
}

RWin Up::{
	global alttab
	global layout
	if (alttab == "enabled") {
		Send "{Ralt Up}"
		if (layout == "ru") {
			Send "{Space}"
		}
	} else {
		Send "{RWin}"
	}
	alttab := "none"
}

capslock::
{
	global mouseless
	if mouseless {
		mouseless := False
	} else Send "{Esc}"
}

SC021::
{
	global mouseless
	if mouseless {
		Click "Down"
		KeyWait "f"
		Click "Up"
	} else {
		if (layout == "en") {
			Send "f"
		} else if (layout == "en_col") {
			Send "t"
		} else {
			Send "а"
		}
	}
}

SC020::
{
	global mouseless
	if mouseless {
		Click "Right, Down"
		KeyWait "d"
		Click "Right, Up"
	} else {
		if (layout == "en") {
			Send "d"
		} else if (layout == "en_col") {
			Send "s"
		} else {
			Send "в"
		}
	}
}

#HotIf (layout == "en_col")
;SC010::q
;SC011::w
SC012::f
SC013::p
SC014::b
SC015::j
SC016::l
SC017::u
SC018::y
SC019::;



;SC01E::a
SC01F::r
SC020::s
SC021::t
;SC022::g
SC023::m
SC024::n
SC025::e
SC026::i
SC027::o

SC02c::x
SC02d::c
SC02e::d
;SC02f::v
SC030::z
SC031::k
SC032::h

; set Backspace to CapsLock key

; sc03a::backspace
#HotIf
