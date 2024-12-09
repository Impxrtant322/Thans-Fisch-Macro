#SingleInstance, force
CoordMode, Pixel, Client
CoordMode, Mouse, Client
CoordMode, ToolTip, Client

; ==============================================================
; SETTINGS
; COMMON SETTINGS
ControlRod := 0.05
navigationKey := "\"
shaketimeout := 50
alternatecolors := False

; DONT TOUCH UNLESS YOU KNOW WHAT YOU'RE DOING
clickholdtime := 50
valreducedholdtime := 20
sleepTime := 15

; ==============================================================
if (A_ScreenDPI*100//96 != 100) {
	Run, ms-settings:display
	msgbox, 0x1030, WARNING!!, % "Your Display Scale seems to be a value other than 100`%. This means the macro will NOT work correctly!`n`nTo change this, right click on your Desktop -> Click 'Display Settings' -> Under 'Scale & Layout', set Scale to 100`% -> Close and Restart Roblox before starting the macro.", 60
	ExitApp
}
If !FileExist("Settings.ini") {
	Msgbox,,Fisch Macro,You don't have a settings file yet. Would you like to create one? Press OK to proceed
	IniWrite, %ControlRod%, Settings.ini, Common, Control
	IniWrite, %clickholdtime%, Settings.ini, No Touch, clickHoldTime
	IniWrite, %valreducedholdtime%, Settings.ini, No Touch, ValReducedHoldTime
	IniWrite, %sleepTime%, Settings.ini, No Touch, sleeptime
	IniWrite, %navigationKey%, Settings.ini, Common, NavigationKey
	IniWrite, %shaketimeout%, Settings.ini, Common, shakeTimeout
	IniWrite, %alternatecolors%, Settings.ini, Common, AlternateColor
}
IniRead, Control, Settings.ini, Common, Control
If (Control = "ERROR") {
	IniWrite, %ControlRod%, Settings.ini, Common, Control
	Control := ControlRod
}
IniRead, clickHoldTime, Settings.ini, No Touch, clickHoldTime
If (clickHoldTime = "ERROR") {
	IniWrite, %clickholdtime%, Settings.ini, No Touch, clickHoldTime
	clickHoldTime := clickholdtime
}
IniRead, ValReducedHoldTime, Settings.ini, No Touch, ValReducedHoldTime
If (ValReducedHoldTime = "ERROR") {
	IniWrite, %valreducedholdtime%, Settings.ini, No Touch, ValReducedHoldTime
	ValReducedHoldTime := valreducedholdtime
}
IniRead, sleeptime, Settings.ini, No Touch, sleeptime
If (sleeptime = "ERROR") {
	IniWrite, %sleepTime%, Settings.ini, No Touch, sleeptime
	sleeptime := sleepTime
}
IniRead, NavigationKey, Settings.ini, Common, NavigationKey
If (NavigationKey = "ERROR") {
	IniWrite, %navigationKey%, Settings.ini, Common, NavigationKey
	NavigationKey := navigationKey
}
IniRead, shakeTimeout, Settings.ini, Common, shakeTimeout
If (shakeTimeout = "ERROR") {
	IniWrite, %shaketimeout%, Settings.ini, Common, shakeTimeout
	shakeTimeout := shaketimeout
}
IniRead, AlternateColors, Settings.ini, Common, AlternateColor
If (AlternateColors = "ERROR") {
	IniWrite, %alternatecolors%, Settings.ini, Common, AlternateColor
	AlternateColors := alternatecolors
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
	global cameraDebounce := 0
	global ShakeTimeout := shakeTimeout * 2
	global shakeTimeoutCurrent := 0
	global NavigationKey := NavigationKey
	global barVelocity := 0
	global lastCheckedBarLocation := 0
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
	global fishBarYAlt := Floor(WindowHeight - (WindowHeight * (150 / 1080)))
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
	global offset := rodControl > 0.06 ? 0 : 30
	global catchBarColor := (AlternateColors = "True" || AlternateColors = "true") ? "0xFFFFFF" : "0xf1f1f1"
	global fishBarColor := (AlternateColors = "True" || AlternateColors = "true") ? "0x7d8aa6" : "0x434b5b"
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
	global Timer := A_TickCount
	Loop,
	{
		tooltip, Current Task: Shaking %ShakeTimeoutCurrent%/%ShakeTimeout%, %TooltipX%, %Tooltip2%, 2
		fishDebounce := 0
		debounce := 0
		sleep 175
		Send {down}
		sleep 25
		send {enter}
		shakeTimeoutCurrent += 1
		If (shakeTimeoutCurrent >= ShakeTimeout) {
			shakeTimeoutCurrent := 0
			Reels()
			Timer := A_TickCount
		}
		PixelSearch, Px, Py, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, catchBarColor, 20, FastRGB
		if (ErrorLevel = 0) {
			PixelSearch, Px, Py, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
			If (ErrorLevel = 0) {
				if(fishDebounce = 0) {
					total := total + 1
					fishDebounce := 1
					debounce := 0
					shakeTimeoutCurrent := 0
				}
				MouseMove, WindowWidth * 0.5, WindowHeight * 0.5
				Loop
				{
					PixelSearch, Px, Py, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
					if (ErrorLevel = 1) {
						Reels()
						tooltip
						Timer := A_TickCount
						Break
					}
					PixelSearch, Px, Py, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, catchBarColor, 20,FastRGB
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
							PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
							If (ErrorLevel = 1) {
								Break
							} else {
								tooltip, ., CurrentTarget, toolTipBarY - 3, 6
								If (CurrentTarget <= ((Control / 2) + fishBarLeftX + (Control / 4))) {
									tooltip, |, fishBarLeftX, toolTipBarY, 8
									tooltip, , fishBarLeftX + (Control / 2), toolTipBarY, 7
									tooltip, <, (Control / 2) + fishBarLeftX + (Control / 4), toolTipBarY, 9
									tooltip go left, WindowWidth / 2, ToolTipBarY + 25, 10
								} else If (CurrentTarget >= (fishBarRightX - (Control / 2) - (Control / 4))) {
									tooltip, >, fishBarRightX - Control + 40, toolTipBarY, 8
									tooltip, |, fishBarRightX, toolTipBarY, 9
									tooltip, , fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 7
									Click, Down
									tooltip go right, WindowWidth / 2, ToolTipBarY + 25, 10
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
										Tooltip, % "Fish at right for: " A_Index " ticks", WindowWidth / 2, ToolTipBarY + 25, 10
										PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
										If (ErrorLevel = 0) {
											tooltip, ., CurrentTarget, toolTipBarY - 3, 6
											tooltip, >, fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 8
											tooltip, |, fishBarRightX, toolTipBarY, 9
											tooltip, , fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 7
											If (CurrentTarget <= (fishBarRightX - (Control / 2) - (Control / 4))) {
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
									PixelSearch, CurrentBarPosition,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, catchBarColor, 20,FastRGB
									If (ErrorLevel = 0) {
										PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
										CurrentBarPositionLeft := CurrentBarPosition
										CurrentBarPositionRight := CurrentBarPosition + Control
										CurrentBarPositionMiddle := CurrentBarPosition + (Control / 2)
										CurrentBarCloseRight := CurrentBarPositionMiddle + (Control / 4)
										CurrentBarCloseLeft := CurrentBarPosition + (Control / 4)
										Distance := 0
										if (lastCheckedBarLocation = 0) {
											lastCheckedBarLocation := CurrentBarPositionMiddle
										} else {
											barVelocity := CurrentBarPositionMiddle - lastCheckedBarLocation
										}
										if (CurrentBarCloseLeft - offset < CurrentTarget && CurrentTarget < CurrentBarCloseRight + offset) {
											tooltip, i'd idle | Bar Velocity: %barVelocity%, WindowWidth / 2, ToolTipBarY + 25, 10
											tooltip, ., CurrentTarget, toolTipBarY - 3, 6
											tooltip, V, CurrentBarPositionMiddle, toolTipBarY, 7
											tooltip, |, CurrentBarPositionLeft, toolTipBarY, 8
											tooltip, |, CurrentBarPositionRight, toolTipBarY, 9
											if (barVelocity > 60) {
												sleep 130
											} else if (barVelocity > 15 && (CurrentTarget - CurrentBarPositionMiddle) < 0) {
												sleep 75
											} else if (barVelocity < -40) {
												Click, Down
												sleep 130
												Click, Up
											} else if (barVelocity < 0 && (CurrentTarget - CurrentBarPositionMiddle) > 0) {
												Click, Down
												sleep 100
												Click, Up
											} else if (barVelocity < 0) {
												Click, Down
												sleep 80
												Click, Up
											}
											Reels(clickHoldTime - 10)
										} else {
											if (CurrentBarCloseLeft > CurrentTarget) {
												Distance := CurrentTarget - CurrentBarCloseLeft - (Control / 8)
											} else if (CurrentBarCloseRight < CurrentTarget) {
												Distance := CurrentTarget - CurrentBarPositionMiddle
											}
											Percentage := (Distance / Control) * 100
											Tooltip % "Percent: " Percentage " Distance: " Distance " Bar Position: " CurrentBarPositionMiddle, WindowWidth / 2, ToolTipBarY + 25, 10
											tooltip, ., CurrentTarget, toolTipBarY - 3, 6
											tooltip, V, CurrentBarPositionMiddle, toolTipBarY, 7
											tooltip, |, CurrentBarPositionLeft, toolTipBarY, 8
											tooltip, |, CurrentBarPositionRight, toolTipBarY, 9
											if (Percentage >= 0) {
												Val := Floor(140 + ((440 - 140) * (Percentage / 100))) + 100
												tooltip % "Holding left click for: " Val " ticks " Distance, WindowWidth / 2, ToolTipBarY + 25, 10
												If (Val = 0) {
													Reels(clickHoldTime)
												} else {
													Reels(Abs(Distance) > 200 ? Val : Val / 1.5)
												}
											} else {
												Val := 0 + ((100 - 0) * (Percentage / 100))
												Val := Floor((-1 * Val))
												if (Val < 30) {
													tooltip, i'd idle, WindowWidth / 2, ToolTipBarY + 25, 10
													Reels(clickHoldTime - 10)
												} else {
													tooltip % Val - 50 " sleeptime", WindowWidth / 2, ToolTipBarY + 25, 10
													;Sleep Abs(Distance) > 250 ? sleeptime / 5 : sleeptime / 6
												}
											}
										}
										lastCheckedBarLocation := CurrentBarPositionMiddle
									} else {
										PixelSearch, CurrentBarPosition,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, 0x808789, 10,FastRGB
										If (ErrorLevel = 0) {
											PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
											CurrentBarPositionLeft := CurrentBarPosition
											CurrentBarPositionRight := CurrentBarPosition + Control
											CurrentBarPositionMiddle := CurrentBarPosition + (Control / 2)
											CurrentBarCloseRight := CurrentBarPositionMiddle + (Control / 4)
											CurrentBarCloseLeft := CurrentBarPosition + (Control / 4)
											Distance := 0
											if (lastCheckedBarLocation = 0) {
												lastCheckedBarLocation := CurrentBarPositionMiddle
											} else {
												barVelocity := CurrentBarPositionMiddle - lastCheckedBarLocation
											}
											if (CurrentBarCloseLeft - offset < CurrentTarget && CurrentTarget < CurrentBarCloseRight + offset) {
												tooltip, i'd idle | Bar Velocity: %barVelocity%, WindowWidth / 2, ToolTipBarY + 25, 10
												tooltip, ., CurrentTarget, toolTipBarY - 3, 6
												tooltip, V, CurrentBarPositionMiddle, toolTipBarY, 7
												tooltip, |, CurrentBarPositionLeft, toolTipBarY, 8
												tooltip, |, CurrentBarPositionRight, toolTipBarY, 9
												if (barVelocity > 60) {
													sleep 130
												} else if (barVelocity > 15 && (CurrentTarget - CurrentBarPositionMiddle) < 0) {
													sleep 75
												} else if (barVelocity < -40) {
													Click, Down
													sleep 130
													Click, Up
												} else if (barVelocity < 0 && (CurrentTarget - CurrentBarPositionMiddle) > 0) {
													Click, Down
													sleep 100
													Click, Up
												} else if (barVelocity < 0) {
													Click, Down
													sleep 80
													Click, Up
												}
												Reels(clickHoldTime - 10)
											} else {
												if (CurrentBarCloseLeft > CurrentTarget) {
													Distance := CurrentTarget - CurrentBarCloseLeft - (Control / 8)
												} else if (CurrentBarCloseRight < CurrentTarget) {
													Distance := CurrentTarget - CurrentBarPositionMiddle
												}
												Percentage := (Distance / Control) * 100
												Tooltip % "Percent: " Percentage " Distance: " Distance " Bar Position: " CurrentBarPositionMiddle, WindowWidth / 2, ToolTipBarY + 25, 10
												tooltip, ., CurrentTarget, toolTipBarY - 3, 6
												tooltip, V, CurrentBarPositionMiddle, toolTipBarY, 7
												tooltip, |, CurrentBarPositionLeft, toolTipBarY, 8
												tooltip, |, CurrentBarPositionRight, toolTipBarY, 9
												if (Percentage >= 0) {
													Val := Floor(140 + ((440 - 140) * (Percentage / 100))) + 100
													tooltip % "Holding left click for: " Val " ticks " Distance, WindowWidth / 2, ToolTipBarY + 25, 10
													If (Val = 0) {
														Reels(clickHoldTime)
													} else {
														Reels(Abs(Distance) > 200 ? Val : Val / 1.5)
													}
												} else {
													Val := 0 + ((100 - 0) * (Percentage / 100))
													Val := Floor((-1 * Val))
													if (Val < 30) {
														tooltip, i'd idle, WindowWidth / 2, ToolTipBarY + 25, 10
														Reels(clickHoldTime - 10)
													} else {
														tooltip % Val - 50 " sleeptime", WindowWidth / 2, ToolTipBarY + 25, 10
														;Sleep Abs(Distance) > 250 ? sleeptime / 5 : sleeptime / 6
													}
												}
											}
											lastCheckedBarLocation := CurrentBarPositionMiddle
										} else {
											break
										}
									}
								}
							}
						}
						PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
						If (CurrentTarget > 408) {
							AtRight := True
							tooltip, ., CurrentTarget, toolTipBarY - 3, 6
							tooltip, >, fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 8
							tooltip, |, fishBarRightX, toolTipBarY, 9
							tooltip, , fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 7
							Click, Down
							tooltip Search right, WindowWidth / 2, ToolTipBarY + 25, 10
							Timer := A_TickCount
							Loop {
								PixelSearch, CurrentBarPosition,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, catchBarColor, 20,FastRGB
								if(ErrorLevel = 0) {
									break
								} else {
									PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5,FastRGB
									if(ErrorLevel = 1) {
										break
									} if(ErrorLevel = 0) {
										if(Timer - A_TickCount > 2500) {
											break
										}
									}
								}
							}
							Click, Up
						}
					} else {
						PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
						If (ErrorLevel = 0) {
							tooltip, ., CurrentTarget, toolTipBarY - 3, 6
							If (CurrentTarget <= ((Control / 2) + fishBarLeftX + (Control / 4))) {
								tooltip, |, fishBarLeftX, toolTipBarY, 8
								tooltip, , fishBarLeftX + (Control / 2), toolTipBarY, 7
								tooltip, <, (Control / 2) + fishBarLeftX + (Control / 4), toolTipBarY, 9
								tooltip go left, WindowWidth / 2, ToolTipBarY + 25, 10
							}  else If (CurrentTarget >= (fishBarRightX - (Control / 2) - (Control / 4))) {
								tooltip, >, fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 8
								tooltip, |, fishBarRightX, toolTipBarY, 9
								tooltip, , fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 7
								Click, Down
								tooltip go right, WindowWidth / 2, ToolTipBarY + 25, 10
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
									Tooltip, % "Fish at right for: " A_Index " ticks", WindowWidth / 2, ToolTipBarY + 25, 10
									PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
									If (ErrorLevel = 0) {
										tooltip, ., CurrentTarget, toolTipBarY - 3, 6
										tooltip, >, fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 8
										tooltip, |, fishBarRightX, toolTipBarY, 9
										tooltip, , fishBarRightX - (Control / 2) - (Control / 4), toolTipBarY, 7
										If (CurrentTarget <= (fishBarRightX - (Control / 2) - (Control / 4))) {
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
									Tooltip, i reel 100, WindowWidth / 2, ToolTipBarY + 25, 10
									Reels(clickHoldTime, True)
								}
							}
							PixelSearch, CurrentTarget,, fishBarLeftX, fishBarYAlt, fishBarRightX, fishBarYAlt, fishBarColor, 5, FastRGB
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
		global TooltipX
		global Tooltip2
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
			PixelSearch,,, fishBarLeftX, fishBarY, fishBarRightX, fishBarY, catchBarColor, 20, FastRGB
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
	global cameraDebounce
	global cameraIconX
	global cameraIconY
	global TooltipX
	global Tooltip2
	tooltip, Current Task: Checking Camera Mode, %TooltipX%, %Tooltip2%, 2
	MouseMove, cameraIconX, cameraIconY
	if(cameraDebounce = 0) {
		Click, Down
		sleep 150
		Click, Up
		sleep 150
		Click, Down
		sleep 150
		Click, Up
		cameraDebounce := 1
	}
	sleep 150
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