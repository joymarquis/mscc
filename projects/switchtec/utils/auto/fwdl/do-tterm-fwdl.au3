
#include <../lib/libqing-1.1.au3>


$str_task = "fwdl"

$cl_win = "[CLASS:VTWin32; REGEXPTITLE:Tera Term]"
$cl_win_error = "[CLASS:#32770; REGEXPTITLE:Tera Term:.*Error]"
$cl_win_error_btn_ok = "[CLASS:Button; INSTANCE:1]"
$str_cmd = "C:\_opt\teraterm-4.88\ttermpro.exe /C=4 /BAUD=230400"

do_progress_on("starting", $str_task)
do_run($cl_win, $str_cmd, True)

do_progress_set(10, "waitting")
do_win_wait_exist($cl_win)
do_win_active($cl_win)


Sleep(3000)
If WinExists($cl_win_error) Then
	do_win_active($cl_win_error)
	do_btn_click($cl_win_error, $cl_win_error_btn_ok, "Ok")
EndIf

do_progress_set(20, "done")
Sleep(3000)





Exit


; spec
Sleep(5000)

do_win_active($cl_win)

Sleep(5000)
do_progress_set(100, "completed")

MsgBox($MB_SYSTEMMODAL, $str_task, "end")
