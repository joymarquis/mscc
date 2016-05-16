#include <Constants.au3>
#include <GuiListBox.au3>
#include <GuiListView.au3>
#include <GuiButton.au3>
#include <GuiComboBox.au3>

#include <Array.au3>
#include <Inet.au3>
#include <Timers.au3>
#include <Date.au3>
#include <File.au3>


Opt("TrayIconDebug", 1)
Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 0)

Opt("TCPTimeout", 1000)


$global_operation_delay_ms = 200



Func do_dirname_get($_str_cmd)
	$_p_drv = ""
	$_p_dir = ""
	$_p_fn = ""
	$_p_ext = ""
	$_path_array = _PathSplit($_str_cmd, $_p_drv, $_p_dir, $_p_fn, $_p_ext)
	return $_p_drv & $_p_dir
EndFunc

Func do_basename_get($_str_cmd)
	$_p_drv = ""
	$_p_dir = ""
	$_p_fn = ""
	$_p_ext = ""
	$_path_array = _PathSplit($_str_cmd, $_p_drv, $_p_dir, $_p_fn, $_p_ext)
	return $_p_fn & $_p_ext
EndFunc


Func do_run($_cl_win, $_str_cmd, $_str_path = "", $_is_force_restart = False)
	; check
	If WinExists($_cl_win) Then
		WinActivate($_cl_win)
		If $_is_force_restart Then
			$ret = WinKill($_cl_win)
		Else
			$ret = WinGetProcess($_cl_win)
			MsgBox($MB_SYSTEMMODAL + $MB_ICONWARNING, "test", "already run: pid=" & $ret)
			Exit
		EndIf
	EndIf

	; run
	If $_str_path = "" Then
		$_str_path = do_dirname_get($_str_cmd)
	EndIf
	$ret = Run($_str_cmd, $_str_path)
	If $ret = 0 Then
		  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", "run fail: " & $_str_cmd & "|" & $_str_path)
		  Exit
	EndIf

	WinWaitActive($_cl_win)
EndFunc


$time_marked = _Timer_Init()
Func do_time_mark()
	$time_marked = _Timer_Init()
EndFunc
do_time_mark()

Func do_time_diff_sec_get()
	Return Round(_Timer_Diff($time_marked) / 1000, 2)
EndFunc

Func do_time_diff_min_get()
	Return Round(do_time_diff_sec_get() / 60, 2)
EndFunc


Func do_splash_on()
   SplashTextOn("test", "test started.", 320, 240, -1, -1, $DLG_TEXTVCENTER, "", 16)
EndFunc

Func do_splash_off()
   SplashOff()
EndFunc


Func do_tooltip_set($_info, $_title = "tip")
	ToolTip($_info, 32, 400, $_title, $TIP_INFOICON, $TIP_BALLOON + $TIP_FORCEVISIBLE)
EndFunc


Func do_progress_on($_title, $_info)
	ProgressOn($_title, $_info, "0", 32, 32, $DLG_MOVEABLE)
EndFunc

Func do_progress_set($_percent, $_info, $_delay_ms = 0)
    ProgressSet($_percent, $_percent, $_info)
	Sleep($_delay_ms)
EndFunc

Func do_progress_off()
   ProgressOff()
EndFunc


Func do_msg_info($_title, $_info)
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONINFORMATION, $_title, $_info)
EndFunc

Func do_msg_err_exit($_title, $_info, $_timeout_s = 0)
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, $_title, $_info, $_timeout_s)
	  Exit 1
EndFunc

Func do_win_wait_exist($_cl_win)
	While True
		If WinExists($_cl_win) Then
			WinActivate($_cl_win)
			Return True
		EndIf
		Sleep(1000)
	WEnd
EndFunc

Func do_win_active($_cl_win, $_timeout_s = 300)
	If $_timeout_s > 86400 Then
		do_msg_err_exit($_cl_win, "time second value too large: " & $_timeout_s)
	EndIf
	If $_timeout_s < 1 Then
		$_timeout_s = 1
	EndIf
	For $i = 1 To $_timeout_s
		If WinActive($_cl_win) > 0 Then
			Return
		EndIf
		Sleep(1000)
		WinActivate($_cl_win)
	Next
	do_msg_err_exit($_cl_win, "window " & $_cl_win & " can not active: " & $_timeout_s)
EndFunc

Func do_win_active_loose($_cl_win, $_timeout_s = 5)
	If WinActive($_cl_win) = 0 Then
		WinActivate($_cl_win)
	EndIf
EndFunc

Func do_btn_click($_cl_win, $_cl_btn, $_str_btn)
   do_win_active($_cl_win)
   ControlFocus($_cl_win, "", $_cl_btn)
   do_win_active($_cl_win)
   ControlClick($_cl_win, "", $_cl_btn)
EndFunc

Func do_btn_is_txt_set($_cl_win, $_cl_btn, $_str_btn)
   $_h_btn = ControlGetHandle($_cl_win, "", $_cl_btn)
   do_win_active($_cl_win)
   If _GUICtrlButton_GetText($_h_btn) = $_str_btn Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc


Func do_combo_sel($_cl_win, $_cl_combo, $_combo_id, $_info)
   $_h_combo = ControlGetHandle($_cl_win, "", $_cl_combo)
   do_win_active($_cl_win)
   _GUICtrlComboBox_SetCurSel($_h_combo, $_combo_id)
   do_win_active($_cl_win)
   $ret = _GUICtrlComboBox_GetCurSel($_h_combo)
   If $ret <> $_combo_id Then
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", $_info & " " & $ret & " " & $_combo_id)
	  Exit
   EndIf
EndFunc

Func do_combo_sel_str($_cl_win, $_cl_combo, $_str_item, $_info)
   $_h_combo = ControlGetHandle($_cl_win, "", $_cl_combo)
   do_win_active($_cl_win)
   $ret = _GUICtrlComboBox_SelectString($_h_combo, $_str_item)
   If $ret = -1 Then
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", $_info & " not found: " & $_str_item)
	  Exit
   EndIf
   $_msg = $_info & ": " & $_str_item
   do_combo_sel($_cl_win, $_cl_combo, $ret, $_msg)
EndFunc

Func do_lview_sel($_cl_win, $_cl_lview, $_lview_id, $_info)
   $_h_lview = ControlGetHandle($_cl_win, "", $_cl_lview)
   do_win_active($_cl_win)
   _GUICtrlListView_SetItemSelected($_h_lview, $_lview_id)
   do_win_active($_cl_win)
   $ret = _GUICtrlListView_GetItemSelected($_h_lview, $_lview_id)
   If $ret <> $_lview_id Then
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", $_info & " " & $ret & " " & $_lview_id)
	  Exit
   EndIf
EndFunc

Func do_lview_sel_str($_cl_win, $_cl_lview, $_str_item, $_info)
   $_h_lview = ControlGetHandle($_cl_win, "", $_cl_lview)
   do_win_active($_cl_win)
   $ret = _GUICtrlListView_FindText($_h_lview, $_str_item)
   If $ret = -1 Then
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", $_info & " not found: " & $_str_item)
	  Exit
   EndIf
   $_msg = $_info & ": " & $_str_item
   do_lview_sel($_cl_win, $_cl_lview, $ret, $_msg)
EndFunc

Func do_list_sel($_cl_win, $_cl_list, $_list_id, $_info)
   $_h_list = ControlGetHandle($_cl_win, "", $_cl_list)
   do_win_active($_cl_win)
   _GUICtrlListBox_SetCurSel($_h_list, $_list_id)
   Sleep($global_operation_delay_ms)
   do_win_active($_cl_win)
   $ret = _GUICtrlListBox_GetCurSel($_h_list)
   If $ret <> $_list_id Then
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", $_info & " " & $ret & " " & $_list_id)
	  Exit
   EndIf
   Sleep($global_operation_delay_ms)
EndFunc

Func do_list_sel_str($_cl_win, $_cl_list, $_str_item, $_info)
   $_h_list = ControlGetHandle($_cl_win, "", $_cl_list)
   do_win_active($_cl_win)
   $ret = _GUICtrlListBox_SelectString($_h_list, $_str_item)
   If $ret = -1 Then
	  MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", $_info & " not found: " & $_str_item)
	  Exit
   EndIf
   Sleep($global_operation_delay_ms)
   $_msg = $_info & ": " & $_str_item
   do_list_sel($_cl_win, $_cl_list, $ret, $_msg)
EndFunc


Func do_mail($_subject, $_array_body, $_from_name = "test_bot")
	;$ret = _INetSmtpMail("bby1smtp02", $_from_name, $_from_name & "@pmc-sierra.com", "qing.hou@pmcs.com", $_subject, $_array_body, "lab-test", -1, 0)
	$ret = _INetSmtpMail("216.241.231.247", $_from_name, $_from_name & "@pmc-sierra.com", "qing.hou@pmcs.com", $_subject, $_array_body, "lab-test", -1, 0)
	$_err = @error
	If $ret <> 1 Then
		MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "test", "mail error: " & $_err)
		Exit
	EndIf
EndFunc

