#SingleInstance, force
CoordMode, Pixel, Client
CoordMode, Mouse, Client
CoordMode, ToolTip, Client

; ==============================================================
; SETTINGS

ControlRod := 0.05
clickholdtime := 50
valreducedholdtime := 20
sleepTime := 15
navigationKey := "\"

; ==============================================================
if (A_ScreenDPI*100//96 != 100) {
	Run, ms-settings:display
	msgbox, 0x1030, WARNING!!, % "Your Display Scale seems to be a value other than 100`%. This means the macro will NOT work correctly!`n`nTo change this, right click on your Desktop -> Click 'Display Settings' -> Under 'Scale & Layout', set Scale to 100`% -> Close and Restart Roblox before starting the macro.", 60
	ExitApp
}
If !FileExist("Settings.ini") {
	Msgbox,,Fisch Macro,You don't have a settings file yet. Would you like to create one? Press OK to proceed
	IniWrite, %ControlRod%, Settings.ini, Fisch, Control
	IniWrite, %clickholdtime%, Settings.ini, Fisch, clickHoldTime
	IniWrite, %valreducedholdtime%, Settings.ini, Fisch, ValReducedHoldTime
	IniWrite, %sleepTime%, Settings.ini, Fisch, sleeptime
	IniWrite, %navigationKey%, Settings.ini, Fisch, NavigationKey
}
IniRead, Control, Settings.ini, Fisch, Control
If (Control = "ERROR") {
	IniWrite, %ControlRod%, Settings.ini, Fisch, Control
	Control := ControlRod
}
IniRead, clickHoldTime, Settings.ini, Fisch, clickHoldTime
If (clickHoldTime = "ERROR") {
	IniWrite, %clickholdtime%, Settings.ini, Fisch, clickHoldTime
	clickHoldTime := clickholdtime
}
IniRead, ValReducedHoldTime, Settings.ini, Fisch, ValReducedHoldTime
If (ValReducedHoldTime = "ERROR") {
	IniWrite, %valreducedholdtime%, Settings.ini, Fisch, ValReducedHoldTime
	ValReducedHoldTime := valreducedholdtime
}
IniRead, sleeptime, Settings.ini, Fisch, sleeptime
If (sleeptime = "ERROR") {
	IniWrite, %sleepTime%, Settings.ini, Fisch, sleeptime
	sleeptime := sleepTime
}
IniRead, NavigationKey, Settings.ini, Fisch, NavigationKey
If (NavigationKey = "ERROR") {
	IniWrite, %navigationKey%, Settings.ini, Fisch, NavigationKey
	NavigationKey := navigationKey
}
global RodControl := Control
Control := StrSplit(Control, "|")
If (Control[2]) {
	Msgbox The control settings are outdated.`nRestored the settings to their default values.
	IniWrite, ControlRod, Settings.ini, Fisch, Control
	ExitApp
}
If (!Control) {
	Msgbox, Failed to retrieve control from settings.ini
	ExitApp
}
Calculations() {
	WinGetActiveStats, Title, WindowWidth, WindowHeight, WindowLeft, WindowTop
	global TooltipX := WindowWidth/1.1
	global Tooltip1 := (WindowHeight/2)-(20*9)
	global Tooltip2 := (WindowHeight/2)-(20*8)
	global Tooltip3 := (WindowHeight/2)-(20*7)
	global Tooltip4 := (WindowHeight/2)-(20*6)
	global Tooltip5 := (WindowHeight/2)-(20*5)
	global Tooltip6 := (WindowHeight/2)-(20*4)
	global Tooltip7 := (WindowHeight/2)-(20*3)
	global Tooltip8 := (WindowHeight/2)-(20*2)
	global Tooltip9 := (WindowHeight/2)-(20*1)
	global Tooltip10 := (WindowHeight/2)
	global Tooltip11 := (WindowHeight/2)+(20*1)
	global Tooltip12 := (WindowHeight/2)+(20*2)
	global Tooltip13 := (WindowHeight/2)+(20*3)
	global Tooltip14 := (WindowHeight/2)+(20*4)
	global Tooltip15 := (WindowHeight/2)+(20*5)
	global Tooltip16 := (WindowHeight/2)+(20*6)
	global Tooltip17 := (WindowHeight/2)+(20*7)
	global Tooltip18 := (WindowHeight/2)+(20*8)
	global Tooltip19 := (WindowHeight/2)+(20*9)
	global Tooltip20 := (WindowHeight/2)+(20*10)
	global caught := 0
	global total := 0
	global debounce := 0
	global fishDebounce := 0
	global NavigationKey := NavigationKey
	tooltip, Made By thansar62, %TooltipX%, %Tooltip1%, 1
	tooltip, Current Task: Paused, %TooltipX%, %Tooltip2%, 2
	tooltip, Screen: %WindowWidth% x %WindowHeight%, %TooltipX%, %Tooltip3%, 3
	tooltip, Press "P" to Start, %TooltipX%, %Tooltip4%, 4
	tooltip, Press "O" to Reload, %TooltipX%, %Tooltip5%, 5
	tooltip, Press "M" to Exit, %TooltipX%, %Tooltip6%, 6
	tooltip, Rod Control: %RodControl%, %TooltipX%, %Tooltip8%, 8
	tooltip, Caught: %caught% / %total%, %TooltipX%, %Tooltip12%, 12
}
Calculations()
$o:: reload
$m:: exitapp
$p::
	global currentWindow := GetRobloxHWND()
	if currentWindow {
		WinActivate, ahk_exe RobloxPlayerbeta.exe
	} else {
		Msgbox Roblox need to be opened
		ExitApp
	}
	Calculations()
	client := WinGetClientPos(currentWindow)
	global WindowWidth := client.W
	global WindowHeight := client.H
	global WindowLeft := client.x
	global WindowTop := client.y
	global Control := Floor((WindowWidth *  (232 / 1920) + 0.1) + ((RodControl * 100) * (WindowWidth * (8 / 1920))))
	global fishBarY := Floor(WindowHeight - (WindowHeight * (155 / 1080)))
	global fishBarLeftX := Floor(WindowWidth * (575 / 1920))
	global fishBarRightX := Floor(WindowWidth - (WindowWidth * (575 / 1920)))
	global progressBarY := Floor(WindowHeight - (WindowHeight * (98 / 1080)))
	global progressBarLeftX := Floor(WindowWidth * (760 / 1920))
	global progressBarRightX := Floor(WindowWidth - (WindowWidth * (755 / 1920)))
	global progressBarChecker := progressBarRightX - 20
	global cameraIconX := Floor(WindowWidth - (WindowWidth * (30 / 1920)))
	global cameraIconY := Floor(WindowHeight * (37 / 1080))
	global toolTipBarY := Floor(WindowHeight - (WindowHeight * (80 / 1080)))
	global NavigationKey := NavigationKey
	tooltip, Made By Thansar25, %TooltipX%, %Tooltip1%, 1
	tooltip, Screen: %WindowWidth% x %WindowHeight%, %TooltipX%, %Tooltip3%, 3
	tooltip, Current Task: Waiting..., %TooltipX%, %Tooltip2%, 2
	tooltip, Press "O" to Reload, %TooltipX%, %Tooltip4%, 4
	tooltip, Press "M" to Exit, %TooltipX%, %Tooltip5%, 5
	tooltip, , , , 6
	tooltip, Caught: %caught% / %total%, %TooltipX%, %Tooltip12%, 12
	if(WindowWidth != 1920 || WindowHeight != 1080) {
		MsgBox, Please FULL SCREEN (Roblox Settings -> Full Screen -> On) and also ensure your display settings (Windows Search Bar -> Display Settings -> Display Resolution -> 1920 x 1080) are correct.
		Reload
	}
	Reels()
	Timer := A_TickCount
	Loop,
	{
		tooltip, Current Task: Shaking, %TooltipX%, %Tooltip2%, 2
		fishDebounce := 0
		debounce := 0
		sleep 175
		Send {down}{enter}
		If (A_TickCount - Timer >= 40000) {
			Reels()
			Timer := A_TickCount
		}
		PixelSearch, Px, Py, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0xf1f1f1, 20, FastRGB
		if (ErrorLevel = 0) {
			PixelSearch, Px, Py, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
			If (ErrorLevel = 0) {
				if(fishDebounce = 0) {
					total := total + 1
					fishDebounce := 1
					debounce := 0
				}
				MouseMove, WindowWidth * 0.5, WindowHeight * 0.5
				Loop
				{
					PixelSearch, Px, Py, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
					if (ErrorLevel = 1) {
						Reels()
						tooltip
						Timer := A_TickCount
						Break
					}
					PixelSearch, Px, Py, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0xf1f1f1, 20,FastRGB
					If (ErrorLevel = 0) {
						tooltip, Current Task: Catching, %TooltipX%, %Tooltip2%, 2
						Loop
						{
							if(debounce = 0) {
								PixelSearch, xTarget,, progressBarRightX, progressBarY, progressBarLeftX, progressBarY, 0xFFFFFF, 100, FastRGB
								if(ErrorLevel = 1) {
								} else {
									if(xTarget >= progressBarChecker) {
										debounce := 1
										caught := caught + 1
									}
								}
							}
							tooltip, Caught: %caught% / %total%, %TooltipX%, %Tooltip12%, 12
							PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
							If (ErrorLevel = 1) {
								Break
							} else {
								tooltip, ., CurrentTarget, toolTipBarY - 3, 6
								If (CurrentTarget <= ((Control / 2) + fishBarLeftX)) {
									tooltip, |, fishBarLeftX, toolTipBarY, 8
									tooltip, , fishBarLeftX + (Control / 2), toolTipBarY, 7
									tooltip, <, (Control / 2) + fishBarLeftX, toolTipBarY, 9
									tooltip go left
								} else If (CurrentTarget >= (fishBarRightX - (Control / 2))) {
									tooltip, >, fishBarRightX - Control + 40, toolTipBarY, 8
									tooltip, |, fishBarRightX, toolTipBarY, 9
									tooltip, , fishBarRightX - (Control / 2), toolTipBarY, 7
									Click, Down
									tooltip go right
									Loop
									{
										if(debounce = 0) {
											PixelSearch, xTarget,, progressBarRightX, progressBarY, progressBarLeftX, progressBarY, 0xFFFFFF, 100, FastRGB
											if(ErrorLevel = 1) {
											} else {
												if(xTarget >= progressBarChecker) {
													debounce := 1
													caught := caught + 1
												}
											}
										}
										Tooltip, % A_Index
										PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
										If (ErrorLevel = 0) {
											tooltip, ., CurrentTarget, toolTipBarY - 3, 6
											tooltip, >, fishBarRightX - (Control / 2), toolTipBarY, 8
											tooltip, |, fishBarRightX, toolTipBarY, 9
											tooltip, , fishBarRightX - (Control / 2), toolTipBarY, 7
											If (CurrentTarget <= (fishBarRightX - (Control / 2))) {
												tooltip,,,, 8
												Break
											}
										} else {
											Break
										}
									}
									Click, Up
									AtRight := True
								} else {
									PixelSearch, CurrentBarPosition,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0xf1f1f1, 20,FastRGB
									If (ErrorLevel = 0) {
										PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
										CurrentBarPositionLeft := CurrentBarPosition
										CurrentBarPositionRight := CurrentBarPosition + Control
										CurrentBarPositionMiddle := CurrentBarPosition + (Control / 2)
										Distance := CurrentTarget - CurrentBarPositionMiddle
										Percentage := (Distance / Control) * 100
										Tooltip % Percentage "x" Distance "x" CurrentBarPosition
										tooltip, ., CurrentTarget, toolTipBarY - 3, 6
										tooltip, V, CurrentBarPositionMiddle, toolTipBarY, 7
										tooltip, |, CurrentBarPositionLeft, toolTipBarY, 8
										tooltip, |, CurrentBarPositionRight, toolTipBarY, 9
										if (Percentage >= 0) {
											Val := Floor(140 + ((440 - 140) * (Percentage / 100)))
											tooltip % Val
											If (Val = 0) {
												Reels(clickHoldTime)
											} else {
												Reels(Val - ValReducedHoldTime)
											}
										} else {
											Val := 0 + ((100 - 0) * (Percentage / 100))
											Val := Floor((-1 * Val))
											if (Val < 30) {
												tooltip, i'd click
												Reels(clickHoldTime - 10)
											} else {
												tooltip % Val - 50 " sleeptime"
												Sleep sleeptime
											}
										}
									} else {
										PixelSearch, CurrentBarPosition,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x4c4437, 35,FastRGB
										If (ErrorLevel = 0) {
											PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 3, FastRGB
											CurrentBarPositionLeft := CurrentBarPosition
											CurrentBarPositionRight := CurrentBarPosition + Control
											CurrentBarPositionMiddle := CurrentBarPosition + (Control / 2)
											Distance := CurrentTarget - CurrentBarPositionMiddle
											Percentage := (Distance / Control) * 100
											Tooltip % Percentage "x" Distance "x" CurrentBarPosition
											tooltip, ., CurrentTarget, toolTipBarY - 3, 6
											tooltip, V, CurrentBarPositionMiddle, toolTipBarY, 7
											tooltip, |, CurrentBarPositionLeft, toolTipBarY, 8
											tooltip, |, CurrentBarPositionRight, toolTipBarY, 9
											if (Percentage >= 0) {
												Val := Floor(140 + ((440 - 140) * (Percentage / 100)))
												tooltip % Val
												If (Val = 0) {
													Reels(clickHoldTime)
												} else {
													Reels(Val - ValReducedHoldTime)
												}
											} else {
												Val := 0 + ((100 - 0) * (Percentage / 100))
												Val := Floor((-1 * Val))
												if (Val < 30) {
													tooltip, i'd click
													Reels(clickHoldTime - 10)
												} else {
													tooltip % Val - 50 " sleeptime"
													Sleep sleeptime
												}
											}
										} else {
											break
										}
									}
								}
							}
						}
						PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
						If (CurrentTarget > 408) {
							AtRight := True
							tooltip, ., CurrentTarget, toolTipBarY - 3, 6
							tooltip, >, fishBarRightX - (Control / 2), toolTipBarY, 8
							tooltip, |, fishBarRightX, toolTipBarY, 9
							tooltip, , fishBarRightX - (Control / 2), toolTipBarY, 7
							Click, Down
							tooltip Search right
							Loop {
								PixelSearch, CurrentBarPosition,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0xf1f1f1, 20,FastRGB
								if(ErrorLevel = 0) {
									break
								} else {
									PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 3,FastRGB
									if(ErrorLevel = 1) {
										break
									}
								}
							}
							Click, Up
						}
					} else {
						PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
						If (ErrorLevel = 0) {
							tooltip, ., CurrentTarget, toolTipBarY - 3, 6
							If (CurrentTarget <= ((Control / 2) + fishBarLeftX)) {
								tooltip, |, fishBarLeftX, toolTipBarY, 8
								tooltip, , fishBarLeftX + (Control / 2), toolTipBarY, 7
								tooltip, <, (Control / 2) + fishBarLeftX, toolTipBarY, 9
								tooltip go left
							}  else If (CurrentTarget >= (fishBarRightX - (Control / 2))) {
								tooltip, >, fishBarRightX - (Control / 2), toolTipBarY, 8
								tooltip, |, fishBarRightX, toolTipBarY, 9
								tooltip, , fishBarRightX - (Control / 2), toolTipBarY, 7
								Click, Down
								tooltip go right
								Loop
								{
									if(debounce = 0) {
										PixelSearch, xTarget,, progressBarRightX, progressBarY, progressBarLeftX, progressBarY, 0xFFFFFF, 100, FastRGB
										if(ErrorLevel = 1) {
										} else {
											if(xTarget >= progressBarChecker) {
												debounce := 1
												caught := caught + 1
											}
										}
									}
									Tooltip, % A_Index
									PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
									If (ErrorLevel = 0) {
										tooltip, ., CurrentTarget, toolTipBarY - 3, 6
										tooltip, >, fishBarRightX - (Control / 2), toolTipBarY, 8
										tooltip, |, fishBarRightX, toolTipBarY, 9
										tooltip, , fishBarRightX - (Control / 2), toolTipBarY, 7
										If (CurrentTarget <= (fishBarRightX - (Control / 2))) {
											tooltip,,,, 8
											Break
										}
									} else {
										Break
									}
								}
								Click, Up
							} else {
								If (AtRight and (CurrentTarget >= 408)) {
									Sleep 100
									AtRight := false
								} else {
									Tooltip, i reel 100
									Reels(clickHoldTime, True)
								}
							}
							PixelSearch, CurrentTarget,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x434b5b, 5, FastRGB
							If (CurrentTarget > 408) {
								AtRight := True
								tooltip, ., CurrentTarget, toolTipBarY - 3, 6
							}
						}
					}
				}
			}
		}
	}
ExitApp
Reels(x := 0, Stop := false) {
	If (!x) {
		checkCameraMode()
		tooltip, Current Task: Casting, %TooltipX%, %Tooltip2%, 2
		tooltip,, , , 6
		tooltip,, , , 7
		tooltip,, , , 8
		tooltip,, , , 9
		tooltip,, , , 10
		tooltip,, , , 11
		Sleep 1750
		MouseMove, WindowWidth / 2, WindowHeight / 2
		Click, Down
		Sleep 1000
		Click, Up
		tooltip, Current Task: Waiting for shake, %TooltipX%, %Tooltip2%, 2
		Sleep 2000
		Send %NavigationKey%
		Return True
	}
	Click, Down
	Timer := A_TickCount
	Loop
	{
		If (Stop) {
			PixelSearch,,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0xf1f1f1, 20, FastRGB
			If (ErrorLevel = 0) {
				Whitebar := true
				tooltip, Current Task: Fishing, %TooltipX%, %Tooltip2%, 2
				Break
			}
		}
		If (A_TickCount - Timer >= x) {
			Break
		}
	}
	Click, Up
	Return % Whitebar
}
GetRobloxHWND() {
	if (hwnd := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe"))
		return hwnd
}
checkCameraMode() {
	tooltip, Current Task: Checking Camera Mode, %TooltipX%, %Tooltip2%, 2
	MouseMove, cameraIconX, cameraIconY
	PixelSearch, , , cameraIconX, cameraIconY, cameraIconX, cameraIconY, 0xedeae8, 20, Fast RGB
	if(ErrorLevel = 0) {
		MouseClick, Left, cameraIconX, cameraIconY
		checkCameraMode()
	} else if (ErrorLevel = 1) {
		Sleep 500
	} else {
		msgBox, Error handling Camera Mode
		exitApp
	}
	cameraDebounce := 1
}

WinGetClientPos( Hwnd ) {
	VarSetCapacity( size, 16, 0 )
	DllCall( "GetClientRect", UInt, Hwnd, Ptr, &size )
	DllCall( "ClientToScreen", UInt, Hwnd, Ptr, &size )
	x := NumGet(size, 0, "Int")
	y := NumGet(size, 4, "Int")
	w := NumGet( size, 8, "Int" )
	h := NumGet( size, 12, "Int" )
	return { X: x, Y: y, W: w, H: h }
}