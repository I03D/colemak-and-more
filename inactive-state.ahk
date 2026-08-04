TraySetIcon("inactive.ico")

*SC01F::
{
	If ((GetKeyState("LAlt","p") || GetKeyState("RAlt","p"))) {
		If ((GetKeyState("RWin","p") || GetKeyState("LWin","p"))) {
			iniPath := A_ScriptDir "\config.ini"
			fromFile := IniRead(iniPath, "Inactive-state", "From", "")

			path := fromFile
			Run path
			ExitApp
		}
	}
}

