; Colemak Mod-DH mapping for ANSI boards

layout := "en_col"
alttab := "none"

#SuspendExempt
!SC034::en_layout()
!SC026::en_col_layout()
!SC027::rus_layout()
;!д::en_col_layout()

!SC016::Left
!SC017::Down
!SC018::Up
!SC019::Right

!8::home
!-::end
!9::pgDn
!0::pgUp

!SC032::Run "browse.py"

rus_layout(){
	global layout
	if (layout != "ru"){
		Send "{LShift Down}{LAlt}{Lshift Up}"
	}
	suspend 1
	layout := "ru"
}

en_col_layout(){
	global layout
	if (layout == "ru") {
		Send "{RShift Down}{LAlt}{Rshift Up}"
	}
	suspend 0
	layout := "en_col"
}

en_layout(){
	global layout
	if (layout == "ru"){
		Send "{RShift Down}{LAlt}{Rshift Up}"
	}
	suspend 1
	layout := "en"
}



!'::enter
!SC025::Send "{Lalt Down}{F4}{Lalt Up}"

!SC031::DllCall("User32\LockWorkStation")
;#SC020::Send "{Lwin Down}d{Lwin Up}"

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

SC024::{
	global alttab
	global layout

	if (alttab == "none") {
		if (layout == "en") {
			Send "j"
		} else if (layout == "en_col") {
			Send "n"
		} else {
			Send "о"
		}
	} else if (alttab == "half") {
		Send "{Ralt Down}{RShift Down}{tab}{RShift Up}"
		alttab := "enabled"
	} else {
		Send "{RShift Down}{tab}{RShift Up}"
	}
}

SC027::{
	global alttab
	global layout

	if (alttab == "none") {
		if (layout == "en") {
			Send ":"
		} else if (layout == "en_col") {
			Send "o"
		} else {
			Send "ж"
		}
	} else if (alttab == "half") {
		Send "{Ralt Down}{tab}"
		alttab := "enabled"
	} else {
		Send "{tab}"
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

capslock::esc
#SuspendExempt False


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
