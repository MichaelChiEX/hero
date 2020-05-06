sub battle_entry_history{
        open(IN,"./data/entry_list.cgi") or &error("檔案開案錯誤town/battle_entry.pl(10)。");
        @ENTRY = <IN>;
        close(IN);
	        open(IN,"./data/entry_list_0.cgi") or &error("檔案開案錯誤town/battle_entry.pl(0)。");
	        @ENTRY0 = <IN>;
	        close(IN);
                open(IN,"./data/entry_list_1.cgi") or &error("檔案開案錯誤town/battle_entry.pl(1)。");
                @ENTRY1 = <IN>;
                close(IN);
                open(IN,"./data/entry_list_2.cgi") or &error("檔案開案錯誤town/battle_entry.pl(2)。");
                @ENTRY2 = <IN>;
                close(IN);
                open(IN,"./data/entry_list_3.cgi") or &error("檔案開案錯誤town/battle_entry.pl(3)。");
                @ENTRY3 = <IN>;
                close(IN);
                open(IN,"./data/battle_time.cgi");
                $BTIME = <IN>;
                close(IN);
	        ($battle_time[0],$battle_time[1],$battle_time[2],$battle_time[3],$battle_time[4])=split(/<>/,$BTIME);
                $nj=0;
                $ntime=0;
                foreach(@ENTRY0){
                        ($eid,$ename,$echara,$etotal,$estatus,$ebattletime,$elog)=split(/<>/);
                        if($ntime ne $ebattletime){
				if($ntime>0){
                                $entry_list[0].="</table></td>";$nj=0;
				}
                        	$entry_list[0].="<td valign=top><table border=0 width=100% id=tablen>";
				$showntime=$ntime+1;
                                $entry_list[0].="<tr><td colspan=2 align=center><font color=#333333>第$showntime輪比賽</td></tr>";
                        }
                        if($estatus eq"L"){
                                $estatus="(敗)";
                        }elsif($estatus eq"W"){
                                $estatus="<b><font color=red>(勝)</font></b>";
                        }else{
                        }
                        if($nj %4 eq 0 || $nj %4 eq 1){
                                $bgcolor="#FFFFFF";
                        }else{
                                $bgcolor="#AAAAFF";
                        }
                        if($nj %2 eq 1){
	                        $entry_list[0].="<tr><td align=center colspan=2 style='color:red'><a href='javascript:void(0);' onclick=\"javascript:showbattle('$elog');\">VS</a></td></tr>\n";
			}else{
                                $entry_list[0].="<tr bgcolor=#AAAAFF><td height=5 colspan=2></td></tr>\n";
			}
                        $entry_list[0].="<tr><td align=right><img height=50 width=50 src=$IMG/chara/$echara.gif></td><td align=left style='color:blue'>$ename<BR>$etotal<BR>$estatus</td></tr>";
                        $entry_count[0]++;
                        $nj++;
                        $ntime=$ebattletime;
                }
                $nj=0;
                $ntime=0;
		$entry_list[0].="</table>";
                foreach(@ENTRY1){
                        ($eid,$ename,$echara,$etotal,$estatus,$ebattletime,$elog)=split(/<>/);
                        if($ntime ne $ebattletime){
                                if($ntime>0){
                                $entry_list[1].="</table></td>";$nj=0;
                                }
                                $entry_list[1].="<td valign=top><table border=0 width=100% id=tablen>";
                                $showntime=$ntime+1;
                                $entry_list[1].="<tr><td colspan=2 align=center><font color=#333333>第$showntime輪比賽</td></tr>";
                        }
                        if($estatus eq"L"){
                                $estatus="(敗)";
                        }elsif($estatus eq"W"){
                                $estatus="<b><font color=red>(勝)</font></b>";
                        }else{
                        }
                        if($nj %4 eq 0 || $nj %4 eq 1){
                                $bgcolor="#FFFFFF";
                        }else{
                                $bgcolor="#AAAAFF";
                        }
                        if($nj %2 eq 1){
                                $entry_list[1].="<tr><td align=center colspan=2 style='color:red'><a href='javascript:void(0);' onclick=\"javascript:showbattle('$elog');\">VS</a></td></tr>\n";
                        }else{
                                $entry_list[1].="<tr bgcolor=#AAAAFF><td height=5 colspan=2></td></tr>\n";
                        }
                        $entry_list[1].="<tr><td align=right><img height=50 width=50 src=$IMG/chara/$echara.gif></td><td align=left style='color:blue'>$ename<BR>$etotal<BR>$estatus</td></tr>";
                        $entry_count[1]++;
                        $nj++;
                        $ntime=$ebattletime;
                }
		$entry_list[1].="</table>";
                $nj=0;
                $ntime=0;
                foreach(@ENTRY2){
                        ($eid,$ename,$echara,$etotal,$estatus,$ebattletime,$elog)=split(/<>/);
                        if($ntime ne $ebattletime){
                                if($ntime>0){
                                $entry_list[2].="</table></td>";$nj=0;
                                }
                                $entry_list[2].="<td valign=top><table border=0 width=100% id=tablen>";
                                $showntime=$ntime+1;
                                $entry_list[2].="<tr><td colspan=2 align=center><font color=#333333>第$showntime輪比賽</td></tr>";
                        }
                        if($estatus eq"L"){
                                $estatus="(敗)";
                        }elsif($estatus eq"W"){
                                $estatus="<b><font color=red>(勝)</font></b>";
                        }else{
                        }
                        if($nj %4 eq 0 || $nj %4 eq 1){
                                $bgcolor="#FFFFFF";
                        }else{
                                $bgcolor="#AAAAFF";
                        }
                        if($nj %2 eq 1){
                                $entry_list[2].="<tr><td align=center colspan=2 style='color:red'><a href='javascript:void(0);' onclick=\"javascript:showbattle('$elog');\">VS</a></td></tr>\n";
                        }else{
                                $entry_list[2].="<tr bgcolor=#AAAAFF><td height=5 colspan=2></td></tr>\n";
                        }
                        $entry_list[2].="<tr><td align=right><img height=50 width=50 src=$IMG/chara/$echara.gif></td><td align=left style='color:blue'>$ename<BR>$etotal<BR>$estatus</td></tr>";
                        $entry_count[2]++;
                        $nj++;
                        $ntime=$ebattletime;
                }
		$entry_list[2].="</table>";
                $nj=0;
                $ntime=0;
                foreach(@ENTRY3){
                        ($eid,$ename,$echara,$etotal,$estatus,$ebattletime,$elog)=split(/<>/);
                        if($ntime ne $ebattletime){
                                if($ntime>0){
                                $entry_list[3].="</table></td>";$nj=0;
                                }
                                $entry_list[3].="<td valign=top><table border=0 width=100% id=tablen>";
                                $showntime=$ntime+1;
                                $entry_list[3].="<tr><td colspan=2 align=center><font color=#333333>第$showntime輪比賽</td></tr>";
                        }
                        if($estatus eq"L"){
                                $estatus="(敗)";
                        }elsif($estatus eq"W"){
                                $estatus="<b><font color=red>(勝)</font></b>";
                        }else{
                        }
                        if($nj %4 eq 0 || $nj %4 eq 1){
                                $bgcolor="#FFFFFF";
                        }else{
                                $bgcolor="#AAAAFF";
                        }
                        if($nj %2 eq 1){
                                $entry_list[3].="<tr><td align=center colspan=2 style='color:red'><a href='javascript:void(0);' onclick=\"javascript:showbattle('$elog');\">VS</a></td></tr>\n";
                        }else{
                                $entry_list[3].="<tr bgcolor=#AAAAFF><td height=5 colspan=2></td></tr>\n";
                        }
                        $entry_list[3].="<tr><td align=right><img height=50 width=50 src=$IMG/chara/$echara.gif></td><td align=left style='color:blue'>$ename<BR>$etotal<BR>$estatus</td></tr>";
                        $entry_count[3]++;
                        $nj++;
                        $ntime=$ebattletime;
                }
                $entry_list[3].="</table>";
	&header;
        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">天下第一武道會參賽者名單</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">你目前站在天下第一武道會的會場,觀看著本次參賽者的報名清單<BR>目前對戰情況如下</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
        <table class=TC width=90% valign=top>
        <tr><td colspan=4 align=center bgcolor=#FFCCAA><font color=black size=3><b>§對戰情況§</b></font></td></tr><tr>
        <tr>
        <td align=center valign=top><a href="#" onclick="javascript:shows(3);"><font color=$FCOLOR2>英雄組</a></font></td>
        <td align=center valign=top><a href="#" onclick="javascript:shows(2);"><font color=$FCOLOR2>高手組</a></font></td>
        <td align=center valign=top><a href="#" onclick="javascript:shows(1);"><font color=$FCOLOR2>進階組</a></font></td>
        <td align=center valign=top><a href="#" onclick="javascript:shows(0);"><font color=$FCOLOR2>新手組</a></font></td>
        </tr>
        <tr>
        <td align=center colspan=4 bgcolor="#ffffff" valign=top>
<table border="0" width="100%" id="table3" cellspacing="3" cellpadding="0">
<tr><td colspan=11 align=center style="color:#3333AA;font-size:24px"><b>英雄組</a></td></tr>
<tr>
$entry_list[3]
</tr>
</table>
<table border="0" width="100%" id="table2" cellspacing="3" cellpadding="0">
<tr><td colspan=11 align=center style="color:#3333AA;font-size:24px"><b>高手組</a></td></tr>
<tr>
$entry_list[2]
</tr>
</table>
<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="0" style="display:none;">
<tr><td colspan=11 align=center style="color:#3333AA;font-size:24px"><b>進階組</a></td></tr>
<tr>
$entry_list[1]
</tr>
</table>
<table border="0" width="100%" id="table0" cellspacing="3" cellpadding="0" style="display:none;">
<tr><td colspan=11 align=center style="color:#3333AA;font-size:24px"><b>新手組</a></td></tr>
<tr>
$entry_list[0]
</tr>
</table>
        </td>
        </tr>
        </TD>
    </TR>
  </TBODY>
</TABLE>
<script language="javascript">
function shows(sv){
	document.getElementById('table0').style.display='none';
	document.getElementById('table1').style.display='none';
	document.getElementById('table2').style.display='none';
        document.getElementById('table3').style.display='none';
	document.getElementById('table'+sv).style.display='';
}
function showbattle(sv){
        if (sv !=''){
                window.open('/hero_data/battle/entry/'+sv+'.html','比賽實況');
        }else{
                alert('此戰沒有紀錄存在!');
        }
}
</script>
EOF
        &footer;
        exit;
}
1;
