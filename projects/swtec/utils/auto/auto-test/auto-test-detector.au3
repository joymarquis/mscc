
#include <../lib/libqing-1.1.au3>

$case_name = "switchtec_auto_test"

Local $mail_body[1] = [ "[" & _Now() & "]" ]


$cl_win = "[CLASS:SunAwtFrame; REGEXPTITLE:Executor]"


; test init
do_progress_on($case_name, "preparing")

do_progress_set(10, "waitting")
do_win_wait_exist($cl_win)
do_progress_set(11, "starting")
do_win_active($cl_win)

do_progress_set(20, "starting")


; wait complete
$i = 0
Local $log_a[1] = [ "log begin" ]
While True
	do_win_active($cl_win)
	ControlSend($cl_win, "", "", "^4^4")
	ControlSend($cl_win, "", "", "^{END}")
	ControlSend($cl_win, "", "", "+{UP}+{UP}+{UP}+{UP}")
	ControlSend($cl_win, "", "", "^c")
	ControlSend($cl_win, "", "", "^{END}")

	$log = ClipGet()
	If @error <> 0 Then
		do_msg_err_exit($case_name, "can not access clipboard: " & @error)
	EndIf

	If StringRegExp($log, "The firmware of saratoga device .* has been downloaded.*Please set the current device ID") = 1 Then
		do_progress_set(55, "inprogress paused")
		Local $mail_body[] = [ "[" & _Now() & "]", @CRLF, $log ]
		do_mail($case_name, $mail_body, $case_name)
		do_msg_info($case_name, "Paused:" & @CRLF & @CRLF & $log)
	EndIf

	If StringRegExp($log, "Suite PASSED!") = 1 Or StringRegExp($log, "Suite FAILED!") = 1 Then
		do_progress_set(90, "completing")
		Local $mail_body[] = [ "[" & _Now() & "]", @CRLF, $log ]
		do_mail($case_name, $mail_body, $case_name)
		do_progress_set(100, "completed: duration_min=" & do_time_diff_min_get())
		do_msg_info($case_name, "Completed" & @CRLF & @CRLF & $log)
		Exit
	EndIf

	If Mod($i, 2) = 0 Then
		do_progress_set(50, "inprogress ping: " & do_time_diff_sec_get())
	Else
		If WinExists($cl_win) Then
			do_progress_set(60, "inprogress pong: " & do_time_diff_sec_get())
		Else
			do_progress_set(90, "executor dead")
			do_msg_err_exit($case_name, "executor dead")
		EndIf
	EndIf
	Sleep(2000)
	$i += 1
WEnd
