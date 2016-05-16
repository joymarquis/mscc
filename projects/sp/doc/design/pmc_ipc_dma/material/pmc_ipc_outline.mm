<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1383889447534" ID="ID_7333996" MODIFIED="1384334803363" STYLE="fork" TEXT="PMC IPC DMA">
<node CREATED="1384331837154" ID="ID_1536005481" MODIFIED="1384335782565" POSITION="left" TEXT="Overall">
<node CREATED="1384332151442" ID="ID_1523107489" MODIFIED="1384335778423" TEXT="Document">
<node CREATED="1384334987362" ID="ID_763249587" MODIFIED="1384335007213" TEXT="plan"/>
<node CREATED="1384331872921" ID="ID_477681597" MODIFIED="1384332513878" TEXT="requirement"/>
<node CREATED="1384331885525" ID="ID_1618479965" MODIFIED="1384346591202" TEXT="proposal"/>
<node CREATED="1384331861325" ID="ID_1644015129" MODIFIED="1384332518294" TEXT="detail design"/>
<node CREATED="1384334994803" ID="ID_1285081702" MODIFIED="1384334998110" TEXT="unit test"/>
</node>
<node CREATED="1384332399657" ID="ID_847653546" MODIFIED="1384335310176" TEXT="Environment">
<node CREATED="1384335430552" ID="ID_1059206887" MODIFIED="1384335432979" TEXT="development">
<node CREATED="1384332403900" ID="ID_561104513" MODIFIED="1384335313882" TEXT="RC platform">
<node CREATED="1384332447823" ID="ID_487579212" MODIFIED="1384335461885" TEXT="PMCSSOC"/>
</node>
<node CREATED="1384335318143" ID="ID_174031446" MODIFIED="1384335321326" TEXT="EP platform">
<node CREATED="1384335322239" ID="ID_1706203121" MODIFIED="1384335325438" TEXT="PMCSSOC"/>
</node>
</node>
<node CREATED="1384335433394" ID="ID_1436137590" MODIFIED="1384335477581" TEXT="test">
<node CREATED="1384332403900" ID="ID_254260108" MODIFIED="1384335562969" TEXT="RC platform">
<node CREATED="1384332447823" ID="ID_1620345013" MODIFIED="1384334780618" TEXT="PMCSSOC (prefered)"/>
<node CREATED="1384332444870" ID="ID_1814856017" MODIFIED="1384332456318" TEXT="x86"/>
<node CREATED="1384332450980" ID="ID_578324846" MODIFIED="1384332452063" TEXT="x64"/>
<node CREATED="1384334512606" ID="ID_105363563" MODIFIED="1384335567969" TEXT="other 32-bit Arch (if have, optional)"/>
<node CREATED="1384334526902" ID="ID_1403772210" MODIFIED="1384335573188" TEXT="other 64-bit Arch (if have, optional)"/>
</node>
<node CREATED="1384335318143" ID="ID_1281682038" MODIFIED="1384335321326" TEXT="EP platform">
<node CREATED="1384335322239" ID="ID_398101312" MODIFIED="1384335325438" TEXT="PMCSSOC"/>
</node>
</node>
</node>
</node>
<node CREATED="1384332712546" ID="ID_1482700924" MODIFIED="1384335787128" POSITION="right" TEXT="Feature">
<node CREATED="1384334333700" ID="ID_757402165" MODIFIED="1384335754257" TEXT="General">
<node CREATED="1384334357124" ID="ID_1847803500" MODIFIED="1384335756964" TEXT="Compatible with 64-bit arch at source level"/>
<node COLOR="#006699" CREATED="1384334386110" ID="ID_1880772159" MODIFIED="1384335761933" TEXT="(optional) Consider standalone API/LIB/MOD for IPC-DMA layer">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1384312020734" ID="ID_1355645199" MODIFIED="1384334717696" TEXT="EP">
<node CREATED="1384331781781" ID="ID_1666310951" MODIFIED="1384335750388" TEXT="Hardware">
<node CREATED="1384312039727" ID="ID_1893462893" MODIFIED="1384334710917" TEXT="FIFO configure">
<node CREATED="1384312042153" ID="ID_1648217444" MODIFIED="1384335767206" TEXT="EP">
<node CREATED="1384312064305" ID="ID_1563196163" MODIFIED="1384334655591" TEXT="freeq-host-read"/>
<node CREATED="1384312136011" ID="ID_1163448428" MODIFIED="1384334659647" TEXT="postq-host-read"/>
</node>
<node CREATED="1384312060257" ID="ID_182167317" MODIFIED="1384334706962" TEXT="RC and EP">
<node CREATED="1384342563456" ID="ID_215717112" MODIFIED="1384342599769" TEXT="RC write mode">
<node CREATED="1384312101238" ID="ID_1337772196" MODIFIED="1384334665006" TEXT="postq-host-write"/>
<node CREATED="1384312118820" ID="ID_1657054734" MODIFIED="1384342559252" TEXT="compq-host-read"/>
</node>
<node CREATED="1384342569014" ID="ID_962480713" MODIFIED="1384342603695" TEXT="RC read mode">
<node CREATED="1384312106971" ID="ID_1881440378" MODIFIED="1384334669850" TEXT="compq-host-write"/>
</node>
</node>
<node CREATED="1384338277510" ID="ID_828173213" MODIFIED="1384338293917" TEXT="Interrupts for all FIFO"/>
</node>
<node CREATED="1384312150496" ID="ID_796289831" MODIFIED="1384346659734" TEXT="PCIe configure">
<node CREATED="1384312162438" ID="ID_1964906488" MODIFIED="1384342278915" TEXT="local interrupt">
<node CREATED="1384312173459" ID="ID_136244208" MODIFIED="1384334678071" TEXT="INTx"/>
<node COLOR="#006699" CREATED="1384312182671" ID="ID_1256414775" MODIFIED="1384334682759" TEXT="(optional) MSI"/>
<node COLOR="#006699" CREATED="1384334437426" ID="ID_1661262449" MODIFIED="1384334687478" TEXT="(optional) MSI-X"/>
</node>
<node CREATED="1384342264662" ID="ID_718358877" MODIFIED="1384342289632" TEXT="interrput to RC">
<node CREATED="1384342292271" ID="ID_1503755018" MODIFIED="1384342305083" TEXT="Host write done">
<node CREATED="1384342316838" ID="ID_413774860" MODIFIED="1384342321807" TEXT="Used by EP to notify RC that the data write operation has finished"/>
</node>
<node CREATED="1384342305548" ID="ID_1764176212" MODIFIED="1384342309263" TEXT="Host read pending">
<node CREATED="1384342323566" ID="ID_1269292048" MODIFIED="1384342340690" TEXT="Used by EP to notify RC that new data is available for read operation"/>
</node>
</node>
<node CREATED="1384332593005" ID="ID_601979958" MODIFIED="1384332605893" TEXT="fifo memory region">
<node CREATED="1384332609244" ID="ID_1019554973" MODIFIED="1384335845554" TEXT="postq-host-write"/>
<node CREATED="1384332622443" ID="ID_350326241" MODIFIED="1384335851552" TEXT="compq-host-write"/>
<node CREATED="1384332625557" ID="ID_300852753" MODIFIED="1384335855647" TEXT="compq-host-read"/>
</node>
</node>
</node>
<node CREATED="1384331751270" ID="ID_1174006730" MODIFIED="1384334722813" TEXT="Linux">
<node CREATED="1384332806653" ID="ID_1209623466" MODIFIED="1384332808065" TEXT="kernel">
<node CREATED="1384343053943" ID="ID_1449516832" MODIFIED="1384343057569" TEXT="components">
<node CREATED="1384312401768" ID="ID_1462559323" MODIFIED="1384334730004" TEXT="PCI driver"/>
<node CREATED="1384331599294" ID="ID_1657867833" MODIFIED="1384331834703" TEXT="netdev driver"/>
<node CREATED="1384312392618" ID="ID_1419081655" MODIFIED="1384334738374" TEXT="IPC-DMA API/LIB"/>
</node>
<node CREATED="1384343062587" ID="ID_267624705" MODIFIED="1384343064149" TEXT="flow"/>
<node CREATED="1384343064997" ID="ID_598260776" MODIFIED="1384343067473" TEXT="structure"/>
<node CREATED="1384343068354" ID="ID_518919304" MODIFIED="1384343074815" TEXT="function"/>
</node>
<node CREATED="1384332813078" ID="ID_1946952446" MODIFIED="1384332814409" TEXT="app">
<node CREATED="1384332830634" ID="ID_1416161449" MODIFIED="1384334744614" TEXT="TCP bw test"/>
<node CREATED="1384332862678" ID="ID_1724111087" MODIFIED="1384332870680" TEXT="ethtool test"/>
</node>
</node>
</node>
<node CREATED="1384312026038" ID="ID_963469218" MODIFIED="1384334720067" TEXT="RC">
<node CREATED="1384331764824" ID="ID_735641695" MODIFIED="1384334725621" TEXT="Linux">
<node CREATED="1384332819895" ID="ID_150666612" MODIFIED="1384332821123" TEXT="kernel">
<node CREATED="1384343053943" ID="ID_850838111" MODIFIED="1384343057569" TEXT="components">
<node CREATED="1384312401768" ID="ID_938306861" MODIFIED="1384334730004" TEXT="PCI driver"/>
<node CREATED="1384331599294" ID="ID_1748374282" MODIFIED="1384331834703" TEXT="netdev driver"/>
<node CREATED="1384312392618" ID="ID_281582128" MODIFIED="1384334738374" TEXT="IPC-DMA API/LIB"/>
</node>
<node CREATED="1384343062587" ID="ID_1398438638" MODIFIED="1384343064149" TEXT="flow"/>
<node CREATED="1384343064997" ID="ID_876745245" MODIFIED="1384343067473" TEXT="structure"/>
<node CREATED="1384343068354" ID="ID_911541293" MODIFIED="1384343074815" TEXT="function"/>
</node>
<node CREATED="1384332824541" ID="ID_318657883" MODIFIED="1384332825497" TEXT="app">
<node CREATED="1384332848564" ID="ID_1682986880" MODIFIED="1384334761501" TEXT="TCP bw test"/>
<node CREATED="1384332872144" ID="ID_131246058" MODIFIED="1384332875140" TEXT="ethtool test"/>
</node>
</node>
</node>
</node>
</node>
</map>
