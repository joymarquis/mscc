
#include <../lib/libqing-1.1.au3>


$case_name = "switchtec_pcie_cv"

$str_cmd = "C:\Program Files\PCIECV App\PCIECVApp.exe"

Local $mail_body[1] = [ "[" & _Now() & "]" ]

If $CmdLine[0] = 1 Then
	$case_id = $CmdLine[1]
Else
	do_msg_err_exit($case_name, "Usage: " & do_basename_get(@ScriptFullPath) & " <dsp|dspdb|dspdp|dspmf|epm1|epm2|epmgmt|usp>")
EndIf

; conf
If $case_id = "epm2" Or $case_id = "epmgmt" Then
	$dev_str_selected = "VID=11f8, DID=8546, Bus=0004, Dev=0000, Fnc=0001"
	$dev_width_str_selected = "x16"
	$case_str_selected = $case_name & ": " & $case_id
	$list_id_selected = 0
ElseIf $case_id = "epm1" Then
	$dev_str_selected = "VID=11f8, DID=8546, Bus=0004, Dev=0000, Fnc=0000"
	$dev_width_str_selected = "x16"
	$case_str_selected = $case_name & ": " & $case_id
	$list_id_selected = 0
ElseIf $case_id = "usp" Then
	$dev_str_selected = "VID=11f8, DID=8546, Bus=0004, Dev=0000, Fnc=0000"
	$dev_width_str_selected = "x16"
	$case_str_selected = $case_name & ": " & $case_id
	$list_id_selected = 6
ElseIf $case_id = "uspx8" Then
	$dev_str_selected = "VID=11f8, DID=8546, Bus=0004, Dev=0000, Fnc=0000"
	$dev_width_str_selected = "x16"
	$case_str_selected = $case_name & ": " & $case_id
	$list_id_selected = 6
ElseIf $case_id = "dsp" Or $case_id = "dspdp" Or $case_id = "dspdb" Then
	$dev_str_selected = "VID=11f8, DID=8546, Bus=0005, Dev=0001, Fnc=0000"
	$dev_width_str_selected = "x8"
	$case_str_selected = $case_name & ": " & $case_id
	$list_id_selected = 7
ElseIf $case_id = "dspmf" Then
	$dev_str_selected = "VID=11f8, DID=8546, Bus=0005, Dev=0000, Fnc=0002"
	$dev_width_str_selected = "x8"
	$case_str_selected = $case_name & ": " & $case_id
	$list_id_selected = 7
Else
	$msg = "invalid case id: " & $case_id
	do_msg_err_exit($case_name, $msg)
EndIf


; define
$str_pass = "Passed:"
$str_fail = "Failed:"
$str_nrun = "Not Run:"

Local $arr_case_all_[0]
Local $arr_case_fail[0]
Local $arr_case_pass[0]
Local $arr_case_nrun[0]
$cnt_case_all_ = 0
$cnt_case_fail = 0
$cnt_case_pass = 0
$cnt_case_nrun = 0



$cl_win = "[CLASS:#32770; REGEXPTITLE:^$]"
$cl_win_console = "[CLASS:ConsoleWindowClass; REGEXPTITLE:PCIECVApp.exe]"
$cl_list = "[CLASS:ListBox; INSTANCE:1]"
$cl_btn = "[CLASS:Button; INSTANCE:1]"

$cl_win_txt_main = "Please select whether to test against"
$cl_win_txt_done = "Test Completed."


; test init
do_progress_on($case_str_selected, "preparing")
do_run($cl_win, $str_cmd)

do_progress_set(10, "waitting")
do_win_wait_exist($cl_win)
do_win_active($cl_win)


do_progress_set(10, "starting")

; spec
do_list_sel($cl_win, $cl_list, 0, "spec")
do_btn_click($cl_win, $cl_btn, "")

; vf
do_list_sel($cl_win, $cl_list, 0, "vf")
do_btn_click($cl_win, $cl_btn, "")

; case
do_list_sel($cl_win, $cl_list, $list_id_selected, "case")
do_btn_click($cl_win, $cl_btn, "")

; dev
do_list_sel_str($cl_win, $cl_list, $dev_str_selected, $case_str_selected)
do_btn_click($cl_win, $cl_btn, "")

; reset
do_list_sel($cl_win, $cl_list, 0, "reset")
do_btn_click($cl_win, $cl_btn, "")

; speed
do_list_sel($cl_win, $cl_list, 0, "speed")
do_btn_click($cl_win, $cl_btn, "")

; test item
do_list_sel($cl_win, $cl_list, 0, "test item")
do_btn_click($cl_win, $cl_btn, "")

; width
do_list_sel_str($cl_win, $cl_list, $dev_width_str_selected, "width")


do_progress_set(10, "starting", 2000)

; test run
do_btn_click($cl_win, $cl_btn, "")

; wait complete
$i = 0
While WinWait($cl_win, $cl_win_txt_done, 2) = 0
	If Mod($i, 2) = 0 Then
		do_progress_set(50, "inprogress ping: " & do_time_diff_sec_get())
	Else
		If WinExists($cl_win_console) Then
			do_progress_set(60, "inprogress pong: " & do_time_diff_sec_get())
		Else
			do_progress_set(90, "console dead")
			do_msg_err_exit($case_str_selected, "console dead")
		EndIf
	EndIf
	$i += 1
WEnd

do_btn_click($cl_win, $cl_btn, "Continue")


do_progress_set(80, "cleaning up")

; result
Func do_list_get_result($_cl_win, $_cl_list, $_info)
	$_h_list = ControlGetHandle($_cl_win, "", $_cl_list)
	do_win_active($_cl_win)
	$cnt_case_all_ = _GUICtrlListBox_GetCount($_h_list)

	For $_i = 0 To ($cnt_case_all_ - 1)
		do_win_active($_cl_win)
		$_str_item = _GUICtrlListBox_GetText($_h_list, $_i)
		If StringInStr($_str_item, $str_pass) Then
			_ArrayAdd($arr_case_pass, $_str_item)
			$cnt_case_pass += 1
		ElseIf StringInStr($_str_item, $str_fail) Then
			_ArrayAdd($arr_case_fail, $_str_item)
			$cnt_case_fail += 1
		ElseIf StringInStr($_str_item, $str_nrun) Then
			_ArrayAdd($arr_case_nrun, $_str_item)
			$cnt_case_nrun += 1
		Else
			MsgBox($MB_SYSTEMMODAL, "test", $_info & ": invalid item: " & $_str_item)
		EndIf
		_ArrayAdd($arr_case_all_, $_str_item)
	Next

	_ArraySort($arr_case_all_)
;   _ArrayDisplay($arr_case_all_, "num_fail=" & $cnt_case_fail & " num_all=" & $cnt_case_all_, Default, 16)
EndFunc
do_list_get_result($cl_win, $cl_list, "result")

do_btn_click($cl_win, $cl_btn, "")

do_list_sel_str($cl_win, $cl_list, "Exit", "ending1")
do_btn_click($cl_win, $cl_btn, "")
do_list_sel_str($cl_win, $cl_list, "Exit", "ending2")
do_btn_click($cl_win, $cl_btn, "")

; email
do_progress_set(90, "emailing")
_ArrayAdd($mail_body, "========")
_ArrayAdd($mail_body, "num_fail=" & $cnt_case_fail & " num_all=" & $cnt_case_all_)
_ArrayAdd($mail_body, "duration_min=" & do_time_diff_min_get())
_ArrayAdd($mail_body, "--------")
_ArrayConcatenate($mail_body, $arr_case_all_)
_ArrayAdd($mail_body, "--------")
_ArrayAdd($mail_body, "[" & _Now() & "]")

do_mail($case_str_selected, $mail_body, $case_name)

; test end
do_progress_set(100, "completed: duration_min=" & do_time_diff_min_get())

do_msg_info($case_str_selected, "duration_min=" & do_time_diff_min_get())
