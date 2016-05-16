<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1409203824075" ID="ID_1049309355" MODIFIED="1409279301621" TEXT="firmware_upgrade_thru_network">
<node CREATED="1409208362441" ID="ID_1210711463" MODIFIED="1409213690456" POSITION="right" TEXT="Info">
<node CREATED="1409208365881" ID="ID_1829939343" MODIFIED="1409208415324" TEXT="Janus Linux account">
<node CREATED="1409208386154" ID="ID_1971809792" MODIFIED="1409208397914" TEXT="user=root pass=pmcsp"/>
</node>
<node CREATED="1409208415737" ID="ID_542684280" MODIFIED="1409213978663" TEXT="available service in Janus Linux">
<node CREATED="1409208434785" ID="ID_89012121" MODIFIED="1409208519953" TEXT="sshd server: remote login, remote file copy"/>
</node>
<node CREATED="1409210778327" ID="ID_1037313862" MODIFIED="1409214012612" TEXT="MLNX NIC10G driver">
<node CREATED="1409210804917" ID="ID_1728829507" MODIFIED="1409213557251" TEXT="download from: http://www.mellanox.com/page/software_overview_eth"/>
<node CREATED="1409213566629" ID="ID_253309287" MODIFIED="1409213599060" TEXT="install is required if using help_host with Windows OS"/>
<node CREATED="1409214025715" ID="ID_840636384" MODIFIED="1409214057680" TEXT="install may not be required if using help_host with recent Linux distribution"/>
</node>
</node>
<node CREATED="1409203868128" ID="ID_1760598805" MODIFIED="1409205940626" POSITION="right" TEXT="Requirement">
<node CREATED="1409203882607" ID="ID_112666553" MODIFIED="1409213194614" TEXT="a Janus runs healthy firmware and Linux">
<node CREATED="1409214348102" ID="ID_531980982" MODIFIED="1409214362749" TEXT="with BCM NIC1G or MLNX NIC10G installed"/>
</node>
<node CREATED="1409205157150" ID="ID_711819989" MODIFIED="1409213207208" TEXT="a help_host runs either Linux(Recommended) or Windows">
<node CREATED="1409214364019" ID="ID_588538390" MODIFIED="1409214417410" TEXT="with NIC1G or MLNX NIC10G installed for connecting with Janus"/>
<node CREATED="1409217708643" ID="ID_1409459560" MODIFIED="1409217761037" TEXT="requires a RS232 serial port"/>
</node>
<node CREATED="1409203887734" ID="ID_796393307" MODIFIED="1409214447965" TEXT="a network connection (1G or 10G) between Janus and help_host">
<node CREATED="1409204370122" ID="ID_1876528433" MODIFIED="1409209295166" TEXT="on Janus">
<node CREATED="1409207537695" ID="ID_1688519903" MODIFIED="1409215128712" TEXT="use network interface eth0, confirm by checking the serial console output during re-plugging the NIC cable"/>
</node>
<node CREATED="1409207549086" ID="ID_915715256" MODIFIED="1409209298146" TEXT="on help_host">
<node CREATED="1409205308262" ID="ID_1417817464" MODIFIED="1409214090565" TEXT="Linux: supposed to use network interface eth0"/>
<node CREATED="1409205358350" ID="ID_1296547512" MODIFIED="1409209166483" TEXT="Windows: supposed to use network interface NIC1"/>
</node>
</node>
<node CREATED="1409203918206" ID="ID_979053900" MODIFIED="1409203987053" TEXT="required help_host software">
<node CREATED="1409203979376" ID="ID_1300928222" MODIFIED="1409205263856" TEXT="a favorite serial terminal to access firmware serial console">
<node CREATED="1409204110314" ID="ID_370397839" MODIFIED="1409208737679" TEXT="Linux example: minicom"/>
<node CREATED="1409204094177" ID="ID_1304646262" MODIFIED="1409204109202" TEXT="Windows example: putty, teraterm"/>
</node>
<node CREATED="1409204058192" ID="ID_1485125110" MODIFIED="1409205258513" TEXT="a favorite scp client to transfer firmware image">
<node CREATED="1409204151798" ID="ID_1822224496" MODIFIED="1409208737406" TEXT="Linux example: scp command"/>
<node CREATED="1409204143049" ID="ID_1196906573" MODIFIED="1409204151468" TEXT="Windows example: winscp"/>
</node>
</node>
<node CREATED="1409207733980" ID="ID_1033734318" MODIFIED="1409210006011" TEXT="required files: flash_block.data, install_mod.cpio">
<node CREATED="1409207863014" ID="ID_579683144" MODIFIED="1409214142491" TEXT="release package containing the files">
<node CREATED="1409207745669" ID="ID_1972374481" MODIFIED="1409207818329" TEXT="\\diqing\shareddocs\engineering\ESD\Projects\Janus\firmware\build\sp-sdk-0.06.01.24\internal\_internal-sp-sdk-binary-0.06.01.24.tar.bz2"/>
</node>
<node CREATED="1409207920208" ID="ID_1837474041" MODIFIED="1409210021346" TEXT="path to store the files in help_host">
<node CREATED="1409207889250" ID="ID_1361035521" MODIFIED="1409210013007" TEXT="Linux: /host/path/to/"/>
<node CREATED="1409207945835" ID="ID_1228957837" MODIFIED="1409210016338" TEXT="Windows: c:\host\path\to\"/>
</node>
</node>
</node>
<node CREATED="1409203874300" ID="ID_1015015305" MODIFIED="1409203876811" POSITION="right" TEXT="Configure">
<node CREATED="1409214170308" ID="ID_1488346027" MODIFIED="1409214180804" TEXT="configure the network interface">
<node CREATED="1409214181341" ID="ID_1727410247" MODIFIED="1409214186137" TEXT="on Janus">
<node CREATED="1409214186747" ID="ID_1801923481" MODIFIED="1409215247473" TEXT="not nessary, driver is built in or auto detectable for suggested NIC"/>
</node>
</node>
<node CREATED="1409204196386" ID="ID_190255055" MODIFIED="1409204238439" TEXT="configure the network IP address">
<node CREATED="1409204238992" ID="ID_751478217" MODIFIED="1409209319837" TEXT="on Janus">
<node CREATED="1409204242029" ID="ID_1236921040" MODIFIED="1409204475798" TEXT="run configure command in Janus serial console">
<node CREATED="1409204263044" ID="ID_209962435" MODIFIED="1409204348814" TEXT="ifconfig eth0 192.168.44.11 netmask 255.255.255.0 mtu 1500 up"/>
</node>
</node>
<node CREATED="1409205139353" ID="ID_1376247742" MODIFIED="1409209322232" TEXT="on help_host">
<node CREATED="1409205283909" ID="ID_1117884839" MODIFIED="1409209585608" TEXT="Linux: run configure command in Linux console">
<node CREATED="1409204263044" ID="ID_1469478209" MODIFIED="1409207352050" TEXT="ifconfig eth0 192.168.44.22 netmask 255.255.255.0 mtu 1500 up"/>
</node>
<node CREATED="1409207357881" ID="ID_1351608214" MODIFIED="1409208743817" TEXT="Windows: configure the NIC1 with following parameters">
<node CREATED="1409207425937" ID="ID_327485630" MODIFIED="1409207453383" TEXT="ip=192.168.44.22"/>
<node CREATED="1409207455330" ID="ID_506573092" MODIFIED="1409207457155" TEXT="netmask=255.255.255.0"/>
<node CREATED="1409207457564" ID="ID_255319747" MODIFIED="1409207502225" TEXT="mtu=1500 (change this in device manager)"/>
</node>
</node>
</node>
</node>
<node CREATED="1409203877417" ID="ID_61624459" MODIFIED="1409203880663" POSITION="right" TEXT="Step">
<node CREATED="1409208156898" ID="ID_266221218" MODIFIED="1409208166408" TEXT="bootup Janus and help_host"/>
<node CREATED="1409209461898" ID="ID_1143784299" MODIFIED="1409209479760" TEXT="login from Janus serial console"/>
<node CREATED="1409209481203" ID="ID_857326361" MODIFIED="1409209493930" TEXT="in serial console">
<node CREATED="1409209494483" ID="ID_1284786592" MODIFIED="1409209560554" TEXT="create directory by command">
<node CREATED="1409209510746" ID="ID_1332318932" MODIFIED="1409209519389" TEXT="mkdir -p /target/path/to/"/>
</node>
</node>
<node CREATED="1409209526292" ID="ID_1159243503" MODIFIED="1409209535617" TEXT="in help_host">
<node CREATED="1409209536077" ID="ID_698228929" MODIFIED="1409213827743" TEXT="Linux: copy the flash_block.data, install_mod.cpio to Janus path by dd command">
<node CREATED="1409209599999" ID="ID_1419618771" MODIFIED="1409210069417" TEXT="scp /host/path/to/* root@192.168.44.11:/target/path/to/"/>
</node>
<node CREATED="1409209656690" ID="ID_91659780" MODIFIED="1409210060900" TEXT="Windows: use winscp to copy the flash_block.data, install_mod.cpio">
<node CREATED="1409209752925" ID="ID_591170237" MODIFIED="1409209861534" TEXT="connect to 192.168.44.11with SCP protocol and login using root"/>
<node CREATED="1409209767457" ID="ID_33396873" MODIFIED="1409209815052" TEXT="navigate on host panel for directory c:\host\path\to\"/>
<node CREATED="1409209788602" ID="ID_839960956" MODIFIED="1409209827775" TEXT="navigate on target panel for directory /target/path/to/"/>
<node CREATED="1409209828220" ID="ID_1953597904" MODIFIED="1409210085532" TEXT="drag the file flash_block.data, install_mod.cpio from host panel to target panel"/>
</node>
</node>
<node CREATED="1409209898007" ID="ID_22945560" MODIFIED="1409209902905" TEXT="in serial console">
<node CREATED="1409209909114" ID="ID_1974405337" MODIFIED="1409210105883" TEXT="update the firmware into flash by command">
<node CREATED="1409210140047" ID="ID_1363448416" MODIFIED="1409210675806" TEXT="ATTENTION">
<node CREATED="1409210670666" ID="ID_1312708036" MODIFIED="1409213757140" TEXT="SLOW step it is, please wait at most 5 minutes until command completes"/>
<node CREATED="1409210680315" ID="ID_40096627" MODIFIED="1409213772642" TEXT="if execution failed, please retry the dd command before reboot"/>
</node>
<node CREATED="1409210106468" ID="ID_1367090172" MODIFIED="1409210578863" TEXT="dd if=/target/path/to/flash_block.data of=/dev/mtdblock0"/>
</node>
<node CREATED="1409210208539" ID="ID_477730803" MODIFIED="1409210328302" TEXT="update the corresponding kernel module into root file system by command">
<node CREATED="1409210242954" ID="ID_132437293" MODIFIED="1409210352880" TEXT="cd / &amp;&amp; cpio -id &lt; /target/path/to/install_mod.cpio"/>
</node>
</node>
</node>
</node>
</map>
