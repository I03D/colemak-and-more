; Colemak Mod-DH mapping for ANSI boards

layout := "en_col"
alttab := "none"
mouseless := False
delay := 15

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
	global delay

	if mouseless {
		time := delay
		if GetKeyState("l","p") {
			while GetKeyState("j","p") {
				check_delay()
				MouseMove(-1,-1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(1,0,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else if GetKeyState("k","p") {
			while GetKeyState("j","p") {
				check_delay()
				MouseMove(-1,1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(1,0,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else {
			while GetKeyState("j","p") {
				check_delay()
				MouseMove(-1,0,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(1,0,100,"R")
					Sleep 1
					time := delay
				}
			}
		}

			
	} else if (alttab == "half") {
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

SC027::{
	global alttab
	global layout
	global mouseless

	if mouseless {
		time := delay
		if GetKeyState("l","p") {
			while GetKeyState(";","p") {
				check_delay()
				MouseMove(1,-1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(-1,0,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else if GetKeyState("k","p") {
			while GetKeyState(";","p") {
				check_delay()
				MouseMove(1,1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(-1,0,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else {
			while GetKeyState(";","p") {
				check_delay()
				MouseMove(1,0,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(-1,0,100,"R")
					Sleep 1
					time := delay
				}
			}
		}
	} else if (alttab == "half") {
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

SC025::{
	global mouseless

	if mouseless {
		time := delay
		if GetKeyState("j","p") {
			while GetKeyState("k","p") {
				check_delay()
				MouseMove(-1,1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(0,-1,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else if GetKeyState(";","p") {
			while GetKeyState("k","p") {
				check_delay()
				MouseMove(1,1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(0,-1,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else {
			while GetKeyState("k","p") {
				check_delay()
				MouseMove(0,1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(0,-1,100,"R")
					Sleep 1
					time := delay
				}
			}
		}
	}
}

SC026::{
	global mouseless

	if mouseless {
		time := delay
		if GetKeyState("j","p") {
			while GetKeyState("l","p") {
				check_delay()
				MouseMove(-1,-1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(0,1,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else if GetKeyState(";","p") {
			while GetKeyState("l","p") {
				check_delay()
				MouseMove(1,-1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(0,1,100,"R")
					Sleep 1
					time := delay
				}
			}
		} else {
			while GetKeyState("l","p") {
				check_delay()
				MouseMove(0,-1,100,"R")
				time := time - 1
				if (time == 0) {
					MouseMove(0,1,100,"R")
					Sleep 1
					time := delay
				}
			}
		}
	} else {
		if (layout == "en") {
			Send "l"
		} else if (layout == "en_col") {
			Send "i"
		} else {
			Send "д"
		}
	}
}

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
