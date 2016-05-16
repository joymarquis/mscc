<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1410240223136" ID="ID_1188261267" MODIFIED="1410506439549" TEXT="rootfs optimize plan">
<node CREATED="1410240260682" ID="ID_1766968973" MODIFIED="1410506525082" POSITION="right" TEXT="(15d-30d) evaluation and development">
<node CREATED="1410414129456" ID="ID_1446023536" MODIFIED="1410505989155" TEXT="(4d-8d) kernel rebuild">
<node CREATED="1410419165445" ID="ID_438785002" MODIFIED="1410501534735" TEXT="evaluation">
<node CREATED="1410419169756" ID="ID_1262446179" MODIFIED="1410419175108" TEXT="Codebench compiler"/>
<node CREATED="1410419175492" ID="ID_802865629" MODIFIED="1410500929321" TEXT="optimize options"/>
</node>
<node CREATED="1410414423680" ID="ID_1640943921" MODIFIED="1410414425531" TEXT="functional">
<node CREATED="1410414150764" ID="ID_1645682474" MODIFIED="1410416155384" TEXT="upgrade compiler from Debian to Codebench"/>
<node CREATED="1410414155560" ID="ID_1860260603" MODIFIED="1410414177350" TEXT="add possible optimize option"/>
</node>
<node CREATED="1410414432699" ID="ID_1572568236" MODIFIED="1410414459846" TEXT="process">
<node CREATED="1410414398051" ID="ID_884514941" MODIFIED="1410414430270" TEXT="build script update"/>
</node>
<node CREATED="1410500965669" ID="ID_1056935295" MODIFIED="1410500966842" TEXT="risk">
<node CREATED="1410500967256" ID="ID_921960515" MODIFIED="1410500987618" TEXT="compiler build compatibility issue">
<node CREATED="1410501005484" ID="ID_1223964637" MODIFIED="1410501023940" TEXT="early resolve on evaluation stage"/>
</node>
<node CREATED="1410500987908" ID="ID_1472059870" MODIFIED="1410501004333" TEXT="optimize options compatibility issue">
<node CREATED="1410501015447" ID="ID_413724368" MODIFIED="1410501093920" TEXT="early unit test and further system level verify"/>
</node>
</node>
</node>
<node CREATED="1410414114883" ID="ID_1883947325" MODIFIED="1410506002272" TEXT="(5d-10d) rootfs rebuild">
<node CREATED="1410419560852" ID="ID_1086260096" MODIFIED="1410501538654" TEXT="evaluation">
<node CREATED="1410419563761" ID="ID_1043684900" MODIFIED="1410419619551" TEXT="Linux MIPS distributions easy to apply library optimize"/>
<node CREATED="1410419575839" ID="ID_1933738513" MODIFIED="1410419636383" TEXT="libc variants: glibc, eglibc, uclibc, musl"/>
</node>
<node CREATED="1410414463119" ID="ID_469330030" MODIFIED="1410414465238" TEXT="functional">
<node CREATED="1410414179585" ID="ID_1040042894" MODIFIED="1410417077057" TEXT="evaluate Linux MIPS distributions">
<node CREATED="1410417101140" ID="ID_273615727" MODIFIED="1410417122735" TEXT="mostly on libc library performance"/>
</node>
<node CREATED="1410414201257" ID="ID_18628623" MODIFIED="1410414213079" TEXT="compiler option"/>
<node CREATED="1410414217948" ID="ID_174683333" MODIFIED="1410414224277" TEXT="application optimize guide"/>
</node>
<node CREATED="1410414470447" ID="ID_817314551" MODIFIED="1410414474731" TEXT="process">
<node CREATED="1410414413637" ID="ID_1518064812" MODIFIED="1410414418965" TEXT="build script update"/>
</node>
<node CREATED="1410501099542" ID="ID_471107349" MODIFIED="1410501101127" TEXT="risk">
<node CREATED="1410501101680" ID="ID_1612236972" MODIFIED="1410501138948" TEXT="Linux MIPS distribution hard limitation">
<node CREATED="1410501573216" ID="ID_1803121567" MODIFIED="1410505147663" TEXT="libc can not upgrade to latest optimized version"/>
<node CREATED="1410501583692" ID="ID_412496695" MODIFIED="1410505198451" TEXT="compiler not available on target to build application locally"/>
</node>
</node>
</node>
<node CREATED="1410415005397" ID="ID_543862830" MODIFIED="1410506022648" TEXT="(3d-5d) initramfs recreate">
<node CREATED="1410415012190" ID="ID_460318556" MODIFIED="1410415013860" TEXT="functional">
<node CREATED="1410415014286" ID="ID_1772100464" MODIFIED="1410415110533" TEXT="upgrade by take utility from the new rootfs"/>
<node CREATED="1410415111717" ID="ID_517680305" MODIFIED="1410415133820" TEXT="init script update according to new rootfs change"/>
</node>
<node CREATED="1410416621784" ID="ID_1364011166" MODIFIED="1410416623595" TEXT="process">
<node CREATED="1410416624095" ID="ID_1277603598" MODIFIED="1410416628036" TEXT="build script update"/>
</node>
</node>
<node CREATED="1410416521159" ID="ID_1355651750" MODIFIED="1410506218967" TEXT="(3d-7d) iSCSI driver update">
<node CREATED="1410416557575" ID="ID_166202635" MODIFIED="1410416559371" TEXT="functional">
<node CREATED="1410416559909" ID="ID_1060531944" MODIFIED="1410416567735" TEXT="upgrade to stable SCST"/>
<node CREATED="1410416730117" ID="ID_1229518132" MODIFIED="1410416756963" TEXT="take performance patch from SCST to kernel"/>
<node CREATED="1410416568301" ID="ID_991196538" MODIFIED="1410416575682" TEXT="evaluate other iSCSI solution"/>
</node>
<node CREATED="1410416629909" ID="ID_1512096660" MODIFIED="1410416632999" TEXT="process">
<node CREATED="1410416633680" ID="ID_1155987010" MODIFIED="1410416637921" TEXT="build script update"/>
</node>
</node>
</node>
<node CREATED="1410416931726" ID="ID_156000263" MODIFIED="1410507717045" POSITION="right" TEXT="(8d-20d) verify and performance">
<node CREATED="1410414577382" ID="ID_688744157" MODIFIED="1410506094073" TEXT="(3d-5d) system level verify">
<node CREATED="1410414618654" ID="ID_1364039744" MODIFIED="1410414631303" TEXT="bootup"/>
<node CREATED="1410414631560" ID="ID_27101864" MODIFIED="1410414644829" TEXT="network"/>
<node CREATED="1410414645526" ID="ID_1848080876" MODIFIED="1410414653011" TEXT="storage"/>
</node>
<node CREATED="1410414253537" ID="ID_832464838" MODIFIED="1410506256975" TEXT="(5d-15d) performance evaluation">
<node CREATED="1410414259468" ID="ID_1770615029" MODIFIED="1410506907767" TEXT="memcpy">
<node CREATED="1410414726888" ID="ID_1752692196" MODIFIED="1410414735227" TEXT="mbw-1.4"/>
</node>
<node CREATED="1410414264927" ID="ID_862334529" MODIFIED="1410414696136" TEXT="network TCP">
<node CREATED="1410414705487" ID="ID_1599925767" MODIFIED="1410414708106" TEXT="nuttcp"/>
</node>
<node CREATED="1410414696880" ID="ID_414113228" MODIFIED="1410414700827" TEXT="network UDP">
<node CREATED="1410414709017" ID="ID_1737182874" MODIFIED="1410414710573" TEXT="nuttcp"/>
</node>
<node CREATED="1410414330812" ID="ID_1105834574" MODIFIED="1410506911984" TEXT="iSCSI">
<node CREATED="1410414344202" ID="ID_1450471700" MODIFIED="1410414772933" TEXT="upgraded stable SCST"/>
<node CREATED="1410414362610" ID="ID_1465204433" MODIFIED="1410414374974" TEXT="evaluate other iSCSI solution"/>
</node>
<node CREATED="1410414288332" ID="ID_1533792344" MODIFIED="1410506916534" TEXT="NFS/SAMBA"/>
</node>
</node>
<node CREATED="1410416946285" ID="ID_869081901" MODIFIED="1410506284334" POSITION="right" TEXT="(6d-12d) release">
<node CREATED="1410414485576" ID="ID_467237973" MODIFIED="1410506275678" TEXT="(3d-7d) maintenance">
<node CREATED="1410415269889" ID="ID_1748121811" MODIFIED="1410506983868" TEXT="document">
<node CREATED="1410415271540" ID="ID_193573857" MODIFIED="1410415276880" TEXT="release notes"/>
</node>
<node CREATED="1410415241937" ID="ID_1329279799" MODIFIED="1410415243115" TEXT="release">
<node CREATED="1410415243581" ID="ID_1675792754" MODIFIED="1410415248198" TEXT="script update"/>
<node CREATED="1410415248570" ID="ID_1435120713" MODIFIED="1410415252786" TEXT="release checklist"/>
</node>
</node>
<node CREATED="1410415308940" ID="ID_1943418310" MODIFIED="1410506171314" TEXT="(3d-5d) release process"/>
</node>
</node>
</map>
