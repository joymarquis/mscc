<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1400035777043" ID="ID_1774071308" MODIFIED="1400120840104" TEXT="opt">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400059112909" ID="ID_1808683460" MODIFIED="1400120840104" POSITION="right" TEXT="function">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400035825474" ID="ID_657224237" MODIFIED="1400120840104" TEXT="networkReadHandler1">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400049252290" ID="ID_1606231555" MODIFIED="1400120840104" TEXT="fillInData">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400049298288" ID="ID_1215765701" MODIFIED="1400120840104" TEXT="handleRead">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400050994772" ID="ID_816481032" MODIFIED="1400120840104" TEXT="handleRead">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400049377139" ID="ID_1344182650" MODIFIED="1400120840088" TEXT="countPacket">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400049390376" ID="ID_926749674" MODIFIED="1400748340992" TEXT="fTotNumPackets += 1.0;&#xa;fTotNumBytes += packetSize;">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400049556906" ID="ID_1128203953" MODIFIED="1400120840088" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_3463543" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_846827826,ID_264410973,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
</node>
</node>
<node CREATED="1400050109824" ID="ID_1426421640" MODIFIED="1401177371564" STYLE="fork" TEXT="outputToAllMembersExcept">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#990000" CREATED="1400050123248" ID="ID_76161622" MODIFIED="1400120840088" TEXT="memmove(trailerInPacket, trailer-trailerOffset, trailerSize);">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400050134496" ID="ID_594554086" MODIFIED="1400120840088" TEXT="TODO">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1400035832705" ID="ID_1339857054" MODIFIED="1400120840088" TEXT="injectReport">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#990000" CREATED="1400035838250" ID="ID_485444861" MODIFIED="1401177371567" STYLE="fork" TEXT="memmove(fInBuf, packet, packetSize);">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400036044673" ID="ID_1036887361" MODIFIED="1400120840088" TEXT="consider optimize">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400035862813" ID="ID_87083909" MODIFIED="1401173302464" TEXT="processIncomingReport">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400036665161" ID="ID_397650131" MODIFIED="1401177371573" TEXT="ADVANCE(n)">
<arrowlink DESTINATION="ID_397650131" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_117917707" STARTARROW="None" STARTINCLINATION="0;0;"/>
<linktarget COLOR="#b0b0b0" DESTINATION="ID_397650131" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_117917707" SOURCE="ID_397650131" STARTARROW="None" STARTINCLINATION="0;0;"/>
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400035870870" ID="ID_225407074" MODIFIED="1400120840088" TEXT="#define ADVANCE(n) pkt += (n); packetSize -= (n)">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400035886260" ID="ID_632108681" MODIFIED="1400120840088" TEXT="packetSize is rarely used, can calculate by pointer subtraction when using">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node CREATED="1400036154026" ID="ID_285878508" MODIFIED="1402024314807" TEXT="noteIncomingSR">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400036209093" ID="ID_1707449333" MODIFIED="1400120840088" TEXT="noteIncomingSR">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400036325462" ID="ID_1567617662" MODIFIED="1400120840088" TEXT="gettimeofday(&amp;fLastReceivedSR_time, NULL);">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node COLOR="#ff0000" CREATED="1400036331522" ID="ID_1798313713" MODIFIED="1400572818899" TEXT="double microseconds = (ntpTimestampLSW*15625.0)/0x04000000; // 10^6/2^32">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
</node>
<node COLOR="#ff0000" CREATED="1400036337567" ID="ID_1166893097" MODIFIED="1400572819806" TEXT="fSyncTime.tv_usec = (unsigned)(microseconds+0.5);">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400036862202" ID="ID_830095621" MODIFIED="1401177371577" TEXT="(*fSRHandlerTask)()">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400036878863" ID="ID_1757215922" MODIFIED="1400120840088" TEXT="used?">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400040111826" ID="ID_700810877" MODIFIED="1401177371583" TEXT="noteIncomingRR">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400040357826" ID="ID_751488689" MODIFIED="1400120840088" TEXT="noteIncomingRR">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400040692980" ID="ID_72382861" MODIFIED="1400120840088" TEXT="  gettimeofday(&amp;fTimeReceived, NULL); ">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400042160373" ID="ID_1976499229" MODIFIED="1401177371585" TEXT="(*(rrHandler-&gt;rrHandlerTask))()">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400042175458" ID="ID_1827065439" MODIFIED="1400120840088" TEXT="used?">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400042195333" ID="ID_338468720" MODIFIED="1401177371588" TEXT="(*fRRHandlerTask)()">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400042198540" ID="ID_1996169541" MODIFIED="1400120840088" TEXT="used?">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400042399796" ID="ID_1587749753" MODIFIED="1402024383751" TEXT="onReceive">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400042404952" ID="ID_68848127" MODIFIED="1400120840088" TEXT="OnReceive">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400043031543" ID="ID_897528428" MODIFIED="1400120840088" TEXT="dTimeNow">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400043038048" ID="ID_1495963447" MODIFIED="1400120840088" TEXT="struct timeval timeNow;&#xa;gettimeofday(&amp;timeNow, NULL);">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400043056612" ID="ID_723396500" MODIFIED="1400120840088" TEXT="timeval">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400043070013" ID="ID_124351324" MODIFIED="1400120840088" TEXT="return (double)">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400043089225" ID="ID_498446895" MODIFIED="1400120840088" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400042601639" ID="ID_1715739957" MODIFIED="1400120840073" TEXT="double *avg_rtcp_size,&#xa;double *tp,&#xa;double tc,&#xa;double tn)">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400042634782" ID="ID_1848209942" MODIFIED="1400120840073" TEXT="HEAVY: float and calc">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400042549924" ID="ID_984120445" MODIFIED="1400572904591" TEXT="*avg_rtcp_size = (1./16.)*ReceivedPacketSize(p) +&#xa;               (15./16.)*(*avg_rtcp_size);">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400042554355" ID="ID_1391900184" MODIFIED="1400120840073" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_264410973" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_846827826,ID_264410973,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
</node>
<node CREATED="1400042968923" ID="ID_1958976813" MODIFIED="1400120840073" TEXT="Reschedule">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400042971224" ID="ID_1498688215" MODIFIED="1400120840073" TEXT="reschedule">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400043010755" ID="ID_1260796622" MODIFIED="1400120840073" TEXT="schedule">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400043024554" ID="ID_1126846106" MODIFIED="1400120840073" TEXT="double secondsToDelay = nextTime - dTimeNow();">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400043028126" ID="ID_1902654641" MODIFIED="1400120840073" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400043031543" ID="ID_1574840337" MODIFIED="1400120840073" TEXT="dTimeNow">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400043038048" ID="ID_1363989601" MODIFIED="1402024454808" TEXT="gettimeofday(&amp;timeNow, NULL);">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400043056612" ID="ID_26644146" MODIFIED="1400120840073" TEXT="timeval">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400043070013" ID="ID_1506219094" MODIFIED="1400120840073" TEXT="return (double)">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400043089225" ID="ID_1493308693" MODIFIED="1400120840073" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400043145668" ID="ID_1531579985" MODIFIED="1400120840073" TEXT="(*byeHandler)()">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400043151206" ID="ID_1619011515" MODIFIED="1400120840073" TEXT="used?">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400041368508" ID="ID_1849533519" MODIFIED="1400120840073" TEXT="struct timeval presentationTime; // computed by: ">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1400043574472" ID="ID_1471840105" MODIFIED="1400120840073" TEXT="noteIncomingPacket">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400043766612" ID="ID_1280328937" MODIFIED="1400209628079" TEXT="noteIncomingPacket">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400043841564" ID="ID_1358972031" MODIFIED="1400747723957" TEXT="struct timeval timeNow;&#xa;gettimeofday(&amp;timeNow, NULL);">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400043845760" ID="ID_1773870812" MODIFIED="1400120840057" TEXT="HEAVY: timeval and float calc">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400053077892" ID="ID_324614848" MODIFIED="1400747754634" TEXT="unsigned gap&#xa;      = (timeNow.tv_sec - fLastPacketReceptionTime.tv_sec)*MILLION&#xa;      + timeNow.tv_usec - fLastPacketReceptionTime.tv_usec; ">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400053087245" ID="ID_1838062740" MODIFIED="1400120840057" TEXT="timeval">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400044048095" ID="ID_8046756" MODIFIED="1400747756411" TEXT="arrival += (unsigned)&#xa;    ((2.0*timestampFrequency*timeNow.tv_usec + 1000000.0)/2000000);">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400044062712" ID="ID_1587143438" MODIFIED="1400120840041" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400044096058" ID="ID_1204698255" MODIFIED="1400747772289" TEXT="fJitter += (1.0/16.0) * ((double)d - fJitter);">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400044098718" ID="ID_1642791701" MODIFIED="1400120840041" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400044128141" ID="ID_1414765838" MODIFIED="1400747773955" TEXT="double timeDiff = timestampDiff/(double)timestampFrequency;">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400044130489" ID="ID_1975922698" MODIFIED="1400120840041" TEXT="float">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400041373367" ID="ID_1812681381" MODIFIED="1400747705141" TEXT="struct timeval timeNow;&#xa;gettimeofday(&amp;timeNow, NULL);&#xa;">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1400044426894" ID="ID_1028841939" MODIFIED="1400120840041" TEXT="doGetNextFrame1">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400044542548" ID="ID_1286171148" MODIFIED="1400120840041" TEXT="getNextCompletedPacket">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400044558422" ID="ID_988189937" MODIFIED="1400747669712" TEXT="struct timeval timeNow;&#xa;gettimeofday(&amp;timeNow, NULL);">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400044568734" ID="ID_423993637" MODIFIED="1400120840041" TEXT="timeval">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node CREATED="1400044729293" ID="ID_421852690" MODIFIED="1401177371678" TEXT="use">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#990000" CREATED="1400044731562" ID="ID_766336839" MODIFIED="1400120840026" TEXT="memmove(to, newFramePtr, bytesUsed);">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400044748403" ID="ID_1203328565" MODIFIED="1400120840026" TEXT="TODO">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node COLOR="#ff0000" CREATED="1400044840979" ID="ID_649580973" MODIFIED="1400120840026" TEXT="fPresentationTime">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#338800" CREATED="1400044843998" ID="ID_954275264" MODIFIED="1400120840026" TEXT="timeval">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node CREATED="1400044918957" ID="ID_581028918" MODIFIED="1401177371683" TEXT="afterGetting">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#ff0000" CREATED="1400044920322" ID="ID_1368502953" MODIFIED="1400120840026" TEXT="(*(source-&gt;fAfterGettingFunc))()">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400044932943" ID="ID_1050203158" MODIFIED="1400120840026" TEXT="used?">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1400059213570" ID="ID_1917648574" MODIFIED="1401177384193" POSITION="left" TEXT="option">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_761113915" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_846827826,ID_264410973,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
<node COLOR="#006699" CREATED="1400057261373" ID="ID_72321229" MODIFIED="1400120840026" TEXT="calculated as float but used as int">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_90094011" CLONE_IDS="ID_72321229,ID_690991917," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
<node CREATED="1400059115679" ID="ID_900396219" MODIFIED="1401177384246" POSITION="left" TEXT="class">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400042775426" ID="ID_949295314" MODIFIED="1400120840026" TEXT="HashTable{}">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#990000" CREATED="1400036456401" ID="ID_1516393084" MODIFIED="1400120840026" TEXT="fTable-&gt;Add()">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node COLOR="#990000" CREATED="1400042120546" ID="ID_391231067" MODIFIED="1400120840026" TEXT="fTable-&gt;Lookup()">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node COLOR="#990000" CREATED="1400042120546" ID="ID_1989839440" MODIFIED="1400120840026" TEXT="fTable-&gt;Remove()">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400049596912" ID="ID_1777309163" MODIFIED="1400120840026" TEXT="NetInterfaceTrafficStats{}">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400049619205" ID="ID_1476847018" MODIFIED="1400120840026" TEXT="float fTotNumPackets;">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_1730902397" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_264410973,ID_846827826,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
<node CREATED="1400051417839" ID="ID_333451954" MODIFIED="1400120840026" TEXT="float fTotNumBytes;">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_592751817" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_264410973,ID_846827826,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
</node>
<node CREATED="1400051353814" ID="ID_696678273" MODIFIED="1400120840026" TEXT="BufferedPacket{}">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400051381254" ID="ID_552166045" MODIFIED="1400120840026" TEXT="struct timeval fPresentationTime; // corresponding to &quot;fRTPTimestamp&quot; ">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1400051390482" ID="ID_823481107" MODIFIED="1400120840026" TEXT="struct timeval fTimeReceived;">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400036194780" ID="ID_1103814" MODIFIED="1400120840026" TEXT="RTPReceptionStats{}">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400051821699" ID="ID_756057575" MODIFIED="1400120840026" TEXT="double fJitter;">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400057261373" ID="ID_690991917" MODIFIED="1400120840026" TEXT="calculated as float but used as int">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_90094011" CLONE_IDS="ID_72321229,ID_690991917," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
<node CREATED="1400051831565" ID="ID_1727725163" MODIFIED="1400120840026" TEXT="struct timeval fLastReceivedSR_time;">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1400051845325" ID="ID_1578132983" MODIFIED="1400120840026" TEXT="struct timeval fLastPacketReceptionTime;">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1400051852399" ID="ID_307488013" MODIFIED="1400120840026" TEXT="struct timeval fTotalInterPacketGaps;">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1400051859193" ID="ID_1861263779" MODIFIED="1400120840026" TEXT="struct timeval fSyncTime;">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400040160228" ID="ID_1151383032" MODIFIED="1400120840026" TEXT="RTPTransmissionStats{}">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400040172779" ID="ID_793315093" MODIFIED="1400120840026" TEXT="struct timeval fTimeCreated, fTimeReceived; ">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1400052345961" ID="ID_120581565" MODIFIED="1400120840026" TEXT="RTCPInstance{}">
<font NAME="SansSerif" SIZE="12"/>
<node CREATED="1400052358816" ID="ID_1061187345" MODIFIED="1400120840026" TEXT="double fAveRTCPSize; ">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_846827826" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_264410973,ID_846827826,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
<node CREATED="1400052376132" ID="ID_575953537" MODIFIED="1400120840026" TEXT="double fPrevReportTime;">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_773918749" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_264410973,ID_846827826,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
<node CREATED="1400052382458" ID="ID_1102489985" MODIFIED="1400120840026" TEXT="double fNextReportTime;">
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#006699" CREATED="1400056387985" ID="ID_326632994" MODIFIED="1400120840026" TEXT="counted but not been used">
<font NAME="SansSerif" SIZE="12"/>
<hook NAME="accessories/plugins/ClonePlugin.properties">
<Parameters CLONE_ID="CLONE_1505913319" CLONE_IDS="ID_592751817,ID_761113915,ID_264410973,ID_846827826,ID_773918749,ID_3463543,ID_326632994,ID_1730902397," CLONE_ITSELF="true"/>
</hook>
</node>
</node>
</node>
</node>
</node>
</map>
