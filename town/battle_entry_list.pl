sub battle_entry_list{
        open(IN,"./data/entry_list.cgi") or &error("檔案開案錯誤town/battle_entry.pl(10)。");
        @ENTRY = <IN>;
        close(IN);
	        foreach(@ENTRY){
	                ($ejoin,$eid,$ename,$echara,$etotal)=split(/<>/);
			if($nj[$ejoin] %2 eq "1"){
		                $entry_list[$ejoin].="<td align=right><img height=50 width=50 src=$IMG/chara/$echara.gif><BR><BR></td><td align=left style='color:blue'>$ename<BR>$etotal</td></tr>";
			}else{
	                        $entry_list[$ejoin].="<tr><td align=center><img height=50 width=50 src=$IMG/chara/$echara.gif><BR><BR></td><td align=left style='color:blue'>$ename<BR>$etotal</td>";
			}
			$nj[$ejoin]++;
			$entry_count[$ejoin]++;
	        }
        &header;
        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">天下第一武道會參賽者名單</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">你目前站在天下第一武道會的會場,觀看著本次參賽者的報名清單<BR>對戰名單將會在每週日上午八點出爐</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
        <table class=TC width=90% valign=top>
        <tr><td colspan=4 align=center bgcolor=#FFCCAA><font color=black size=3><b>§參賽者一覽§</b></font></td></tr><tr>
        <tr>
        <td align=center valign=top><font color=$FCOLOR2>英雄組-第$battle_time[3]輪比賽($entry_count[3]人)</font></td>
        <td align=center valign=top><font color=$FCOLOR2>高手組-第$battle_time[2]輪比賽($entry_count[2]人)</font></td>
        <td align=center valign=top><font color=$FCOLOR2>進階組-第$battle_time[1]輪比賽($entry_count[1]人)</font></td>
        <td align=center valign=top><font color=$FCOLOR2>新手組-第$battle_time[0]輪比賽($entry_count[0]人)</font></td>
        </tr>
        <tr>
        <td align=center bgcolor="#ffffff" valign=top>
<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="0">
$entry_list[3]
</table>
        </td>
        <td align=center bgcolor="#ffffff" valign=top>
<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="0">
$entry_list[2]
</table>
	</td>
        <td align=center bgcolor="#ffffff" valign=top>
<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="0">
$entry_list[1]
</table>
	</td>
        <td align=center bgcolor="#ffffff" valign=top>
<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="0">
$entry_list[0]
</table>
	</td>
        </tr>
        </TD>
    </TR>
  </TBODY>
</TABLE>
EOF
        &footer;
        exit;
}
1;
