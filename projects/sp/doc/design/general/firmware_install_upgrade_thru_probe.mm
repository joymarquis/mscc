<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1409216307963" ID="ID_85309567" MODIFIED="1409218259502" TEXT="firmware_install_upgrade_thru_probe">
<node CREATED="1409208362441" ID="ID_1210711463" MODIFIED="1409221494939" POSITION="right" TEXT="Info">
<node CREATED="1409208365881" ID="ID_1829939343" MODIFIED="1409208415324" TEXT="Janus Linux account">
<node CREATED="1409208386154" ID="ID_1971809792" MODIFIED="1409208397914" TEXT="user=root pass=pmcsp"/>
</node>
</node>
<node CREATED="1409203868128" ID="ID_1760598805" MODIFIED="1409205940626" POSITION="right" TEXT="Requirement">
<node CREATED="1409218108477" ID="ID_1202723515" MODIFIED="1409218211640" TEXT="Attention: audience shall have basic knowledge on how to configure/use the GHS Probe"/>
<node CREATED="1409205157150" ID="ID_711819989" MODIFIED="1409216717821" TEXT="a help_host runs Windows">
<node CREATED="1409217809928" ID="ID_93495935" MODIFIED="1409217827272" TEXT="requires a RS232 serial port"/>
<node CREATED="1409217830295" ID="ID_1079416607" MODIFIED="1409217859928" TEXT="requires a NIC to connect to GHS Probe"/>
</node>
<node CREATED="1409216765764" ID="ID_1240065314" MODIFIED="1409216782693" TEXT="a GHS Probe attaches to Janus board"/>
<node CREATED="1409203887734" ID="ID_796393307" MODIFIED="1409216765092" TEXT="a network connection between help_host and Probe"/>
<node CREATED="1409203918206" ID="ID_979053900" MODIFIED="1409203987053" TEXT="required help_host software">
<node CREATED="1409203979376" ID="ID_1300928222" MODIFIED="1409205263856" TEXT="a favorite serial terminal to access firmware serial console">
<node CREATED="1409204094177" ID="ID_1304646262" MODIFIED="1409204109202" TEXT="Windows example: putty, teraterm"/>
</node>
<node CREATED="1409218476910" ID="ID_688986337" MODIFIED="1409218527886" TEXT="a favorite 3rd text editor which supports UNIX EOL format">
<node CREATED="1409218489897" ID="ID_959161694" MODIFIED="1409218500376" TEXT="Windows example: notepad++, ultraedit"/>
</node>
<node CREATED="1409218710225" ID="ID_537825215" MODIFIED="1409218718284" TEXT="GHS Multi 517d">
<node CREATED="1409218782487" ID="ID_1809543098" MODIFIED="1409219146351" TEXT="setup a GHS connection (NIC or USB) for your Probe, suppose the name is &quot;connect-to-my-probe&quot;"/>
</node>
</node>
<node CREATED="1409207733980" ID="ID_1033734318" MODIFIED="1409217974165" TEXT="required files: flash_block.data, sp_probe_config.txt">
<node CREATED="1409207863014" ID="ID_579683144" MODIFIED="1409214142491" TEXT="release package containing the files">
<node CREATED="1409207745669" ID="ID_1972374481" MODIFIED="1409207818329" TEXT="\\diqing\shareddocs\engineering\ESD\Projects\Janus\firmware\build\sp-sdk-0.06.01.24\internal\_internal-sp-sdk-binary-0.06.01.24.tar.bz2"/>
</node>
<node CREATED="1409207920208" ID="ID_1837474041" MODIFIED="1409210021346" TEXT="path to store the files in help_host">
<node CREATED="1409207945835" ID="ID_1228957837" MODIFIED="1409210016338" TEXT="Windows: c:\host\path\to\"/>
</node>
</node>
</node>
<node CREATED="1409203874300" ID="ID_1015015305" MODIFIED="1409203876811" POSITION="right" TEXT="Configure">
<node CREATED="1409218298827" ID="ID_334102657" MODIFIED="1409218303155" TEXT="configure the GHS Probe">
<node CREATED="1409218306001" ID="ID_126423709" MODIFIED="1409218330096" TEXT="attach the help_host&apos;s serial port to GHS Probe"/>
<node CREATED="1409218359062" ID="ID_1690039932" MODIFIED="1409218400719" TEXT="open the serial console for further GHS Probe operation"/>
<node CREATED="1409218330537" ID="ID_1957657533" MODIFIED="1409218446332" TEXT="reset the GHS Probe and wait until the serial console outputs the command prompt"/>
<node CREATED="1409218447101" ID="ID_1637717079" MODIFIED="1409218576094" TEXT="use 3rd text editor to open the c:\host\path\to\sp_probe_config.txt, and copy the whole content"/>
<node CREATED="1409218576751" ID="ID_143717416" MODIFIED="1409218638322" TEXT="paste the content into the serial console and make sure all command are been applied into the GHS Probe"/>
<node CREATED="1409218612143" ID="ID_1257687286" MODIFIED="1409218692758" TEXT="Attention: you&apos;ll get strange behavior if some steps failed"/>
</node>
</node>
<node CREATED="1409203877417" ID="ID_61624459" MODIFIED="1409221357099" POSITION="right" TEXT="Step">
<node CREATED="1409208156898" ID="ID_266221218" MODIFIED="1409208166408" TEXT="bootup Janus and help_host"/>
<node CREATED="1409219265415" ID="ID_1110454716" MODIFIED="1409219821020" TEXT="connect to Probe with connection &quot;connect-to-my-probe&quot;, the GHS debugger interface shall appears now"/>
<node CREATED="1409219347670" ID="ID_53818882" MODIFIED="1409219836565" TEXT="reset and halt the Janus by type in &quot;Debugger-MULTI-CMD panel&quot; with following command">
<node CREATED="1409219566675" ID="ID_743215660" MODIFIED="1409219570245" TEXT="reset halt"/>
</node>
<node CREATED="1409219882343" ID="ID_413331397" MODIFIED="1409219971438" TEXT="open the GHS &quot;Flash Programmer&quot; in Debugger window">
<node CREATED="1409219989673" ID="ID_973981978" MODIFIED="1409220035071" TEXT="highlight the &quot;MIPS32, Id 0&quot; in &quot;Target panel&quot; by single click"/>
<node CREATED="1409219972239" ID="ID_681763650" MODIFIED="1409220090609" TEXT="click menu&gt;Target&gt;Flash, a &quot;MULTI Fast Flash Programmer&quot; shall appears"/>
</node>
<node CREATED="1409220096590" ID="ID_362812304" MODIFIED="1409220494614" TEXT="make sure the Programmer paramters are set as figure below">
<node CREATED="1409220478046" ID="ID_731592691" MODIFIED="1409220478046">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <img src="firmware_install_upgrade_thru_probe_1919417640011870888.jpeg" />
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1409220495913" ID="ID_194854861" MODIFIED="1409220514234" TEXT="click &quot;Program Flash&quot; to start"/>
<node CREATED="1409220534998" ID="ID_122050067" MODIFIED="1409220625968" TEXT="Close the Programmer and Debugger when programmer completing without error within 5 minutes"/>
<node CREATED="1409220642567" ID="ID_1874749680" MODIFIED="1409220850333" TEXT="connect help_host RS232 to Janus UART0(115200-8n1), which is the Linux/Bootrom shared UART"/>
<node CREATED="1409220863985" ID="ID_1828447407" MODIFIED="1409230365346" TEXT="open the serial console utility in help_host to read the Linux/Bootrom info"/>
<node CREATED="1409220900805" ID="ID_1949442407" MODIFIED="1409221587378" TEXT="power reset the Janus board"/>
<node CREATED="1409220627373" ID="ID_1007735760" MODIFIED="1409220911583" TEXT="the &quot;BOOTROM&quot; message shall appears in the serial console"/>
<node CREATED="1409220934674" ID="ID_1724165936" MODIFIED="1409220998650" TEXT="login with root when Linux login prompt appears"/>
<node CREATED="1409220998946" ID="ID_1546619381" MODIFIED="1409221086350" TEXT="check the output for command &quot;uname -r&quot;, the result shall be &quot;2.6.35.9-sp-0.06.01.24&quot;"/>
<node CREATED="1409221092073" ID="ID_715466239" MODIFIED="1409221237912" TEXT="the next step is to follow release_note:sec-5.6.3 to upgrade the rootfs"/>
</node>
</node>
</map>
