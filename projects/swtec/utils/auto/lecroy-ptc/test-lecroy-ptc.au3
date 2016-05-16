
#include <../lib/libqing-1.1.au3>


$case_name = "lecroy_ptc"

$str_cmd = "C:\Program Files (x86)\LeCroy\PCIe Protocol Suite\ScriptAutomationTestTool\PEAutoTestTool.exe"

Local $mail_body[1] = [ "[" & _Now() & "]" ]


If $CmdLine[0] = 1 Then
	$case_id = $CmdLine[1]
Else
	do_msg_err_exit($case_name, "Usage: " & do_basename_get(@ScriptFullPath) & " <all|part|d3|aspm>")
EndIf

; conf
If $case_id = "all" Then
	$case_str_selected = $case_name & ": " & $case_id
ElseIf $case_id = "part" Then
	$case_str_selected = $case_name & ": " & $case_id
ElseIf $case_id = "d3" Then
	$case_str_selected = $case_name & ": " & $case_id
ElseIf $case_id = "aspm" Then
	$case_str_selected = $case_name & ": " & $case_id
Else
	$msg = "invalid case id: " & $case_id
	do_msg_err_exit($case_name, $msg)
EndIf


; define
$str_keyword_d3 = "D3State"
$str_keyword_aspm = "ASPM"
$str_keyword_trans_1_1 = "Trans 1-1 TXN_"


Local $arr_case_all[0]
Local $arr_case_picked[0]
$cnt_case_all = 0
$cnt_case_picked = 0


$cl_win = "[CLASS:#32770; REGEXPTITLE:^Teledyne LeCroy PCI Express Script Automation Test Tool$]"
$cl_combo = "[CLASS:ComboBox; INSTANCE:5]"
$cl_lview = "[CLASS:SysListView32; INSTANCE:1]"
$cl_btn = "[CLASS:Button; INSTANCE:10]"
$cl_btn_done = "[CLASS:Button; INSTANCE:9]"

$cl_win_txt_main = "Please select whether to test against"
$cl_win_txt_done = "Test Completed."


do_progress_on($case_str_selected, "preparing")
do_run($cl_win, $str_cmd)

do_progress_set(10, "waitting")
do_win_wait_exist($cl_win)
do_win_active($cl_win)


; wait window really active
Sleep(5000)

do_win_active($cl_win)
ControlFocus($cl_win, "", $cl_combo)
do_win_active($cl_win)
ControlSend($cl_win, "", $cl_combo, "{HOME}")
;do_win_active($cl_win)
;ControlClick($cl_win, "", $cl_combo)
;do_win_active($cl_win)
;ControlClick($cl_win, "", $cl_combo)
;do_combo_sel_str($cl_win, $cl_combo, "PCIe 3.0 Compliance", "info")


; case
$h_lview = ControlGetHandle($cl_win, "", $cl_lview)
do_win_active($cl_win)
$cnt_case_all = _GUICtrlListView_GetItemCount($h_lview)

ControlFocus($cl_win, "", $cl_lview)

If $case_id = "all" Then
	_GUICtrlListView_SetItemSelected($h_lview, -1)
ElseIf $case_id = "part" Then
	_GUICtrlListView_SetItemSelected($h_lview, -1)
	For $_i = 0 To ($cnt_case_all - 1)
		do_win_active($cl_win)
		$_str_item = _GUICtrlListView_GetItemText($h_lview, $_i)
		If StringInStr($_str_item, $str_keyword_d3) Then
			_GUICtrlListView_SetItemSelected($h_lview, $_i, False)
		ElseIf StringInStr($_str_item, $str_keyword_aspm) Then
			_GUICtrlListView_SetItemSelected($h_lview, $_i, False)
		ElseIf StringInStr($_str_item, $str_keyword_trans_1_1) Then
			_GUICtrlListView_SetItemSelected($h_lview, $_i, False)
		Else
			_GUICtrlListView_SetItemSelected($h_lview, $_i)
			_ArrayAdd($arr_case_picked, $_str_item)
			$cnt_case_picked += 1
		EndIf
	Next
ElseIf $case_id = "d3" Then
	_GUICtrlListView_SetItemSelected($h_lview, -1, False)
	For $_i = 0 To ($cnt_case_all - 1)
		do_win_active($cl_win)
		$_str_item = _GUICtrlListView_GetItemText($h_lview, $_i)
		If StringInStr($_str_item, $str_keyword_d3) Then
			_GUICtrlListView_SetItemSelected($h_lview, $_i, True)
			_ArrayAdd($arr_case_picked, $_str_item)
			$cnt_case_picked += 1
		EndIf
	Next
ElseIf $case_id = "aspm" Then
	_GUICtrlListView_SetItemSelected($h_lview, -1, False)
	For $_i = 0 To ($cnt_case_all - 1)
		do_win_active($cl_win)
		$_str_item = _GUICtrlListView_GetItemText($h_lview, $_i)
		If StringInStr($_str_item, $str_keyword_aspm) Then
			_GUICtrlListView_SetItemSelected($h_lview, $_i, True)
			_ArrayAdd($arr_case_picked, $_str_item)
			$cnt_case_picked += 1
		EndIf
	Next
Else
	$msg = "invalid case id: " & $case_id
	do_msg_err_exit($case_name, $msg)
EndIf

; debug
;   _ArraySort($arr_case_picked)
;   _ArrayDisplay($arr_case_picked, " num_picked=" & $cnt_case_picked, Default, 16)


do_progress_set(20, "starting")


; run
do_btn_click($cl_win, $cl_btn, "")


; wait start
$i = 0
While Not do_btn_is_txt_set($cl_win, $cl_btn, "Stop Tests")
	If Mod($i, 2) = 0 Then
			do_progress_set(20, "starting ping: " & do_time_diff_sec_get())
	Else
			If WinExists($cl_win) Then
					do_progress_set(30, "starting pong: " & do_time_diff_sec_get())
			Else
					do_progress_set(90, "app dead")
					do_msg_err_exit($case_str_selected, "app dead")
			EndIf
	EndIf
	$i += 1
	Sleep(100)
WEnd

; wait complete
$i = 0
While do_btn_is_txt_set($cl_win, $cl_btn, "Stop Tests")
	If Mod($i, 2) = 0 Then
			do_progress_set(50, "inprogress ping: " & do_time_diff_sec_get())
	Else
			If WinExists($cl_win) Then
					do_progress_set(60, "inprogress pong: " & do_time_diff_sec_get())
			Else
					do_progress_set(90, "app dead")
					do_msg_err_exit($case_str_selected, "app dead")
			EndIf
	EndIf
	$i += 1
	Sleep(2000)
WEnd


do_progress_set(90, "emailing")
_ArrayAdd($mail_body, "========")
_ArrayAdd($mail_body, "num_fail=" & "?" & " num_picked=" & $cnt_case_picked)
_ArrayAdd($mail_body, "duration_min=" & do_time_diff_min_get())
_ArrayAdd($mail_body, "--------")
_ArrayConcatenate($mail_body, $arr_case_picked)
_ArrayAdd($mail_body, "--------")
_ArrayAdd($mail_body, "[" & _Now() & "]")

do_mail($case_str_selected, $mail_body, $case_name)

; test end
do_progress_set(100, "completed: duration_min=" & do_time_diff_min_get())

do_msg_info($case_str_selected, "duration_min=" & do_time_diff_min_get())
