sub action {
#	if($ACTOPEN eq 0){&error("目前沒有活動!");}
	
	&chara_open;
	&status_print;
	&town_open;
	&equip_open;
        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);

        open(IN,"./data/actchangeitem.cgi");
        @CHITEM = <IN>;
        close(IN);

	#活動物品
	open(IN,"./data/actionitem.cgi");
        @REA = <IN>;
        close(IN);
#	$ino=$ACTOPEN-1;
	$ino=0;
	&ext_open;
        ($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
	if($act[8] ne"" && $act[8]>0){
	$getbutton.="        <form action=./town.cgi method=post>";
$getbutton.="        <TR><TD colspan=8 align=center bgcolor=ffffff>";
$getbutton.="        <INPUT type=hidden name=id value=$mid>";
$getbutton.="        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>";
$getbutton.="        <INPUT type=hidden name=mode value=action3>";
$getbutton.="        <INPUT type=submit CLASS=FC value=使用無限冒險抽獎券></TD></TR></form>";
	
	}
        for($i=1;$i<9;$i++){
                $actlist1.="<TD bgcolor=\"$ELE_C[$mele]\" align=\"center\">$ACTITEM[$i]</TD>";
	        $actlist2.="<TD bgcolor=\"$ELE_C[$mele]\" align=\"center\">$act[$i]</TD>";
        }
        if($ACTOPEN >0){
	        $titles="目前活動為「<font color=#AAAAFF>$ACTNAME[$ACTOPEN]活動";
        }else{
                $titles="「<font color=#AAAAFF>目前沒有活動";
       }

		$no2=0;
		$maxactitem=0;
		$maxactitem2=0;
		$no1=0;
        	foreach(@CHITEM){
                ($it_actno,$it_actnum,$it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
#	        foreach(@REA){
#        ($ait_name,$ait_val,$ait_dmg,$ait_wei,$ait_ele,$ait_hit,$ait_cl,$ait_type,$ait_sta,$ait_pos) = split(/<>/);
		($ait_name,$ait_val)=split(/<>/,$REA[$it_actno-1]);
			$chtable.="<TR><TD bgcolor=white><input type=\"radio\" value=\"$no1\" name=\"no\"></td><TD bgcolor=white><font size=2>$it_name</font></td><TD bgcolor=white><font size=2>$ait_name</font></td><TD bgcolor=white><font size=2>$it_actnum個</font></td></TR>";
		$no1++;
		}
#	}
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		$sel_val=int($it_val/2);
		$ittable.="<TR><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$sel_val</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD></TR>";
		$no2++;
	}

	&header;
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">$ACTNAME[$ACTOPEN]活動兌換所</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc">$titles</font>」
</TD>
    </TR>
    <TR>
      <TD align=center bgcolor="ffffff" colspan=2 width=55%>
$actcomitem
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=7 align=center><font color=ffffcc>可兌換物品一覽</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>需要物品</td><td bgcolor=white>需要數量</td>
	</tr>
	<form action="./town.cgi" method="post">
	$chtable
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=action2>
	<INPUT type=submit CLASS=FC value=確定兌換></TD></TR></form>
	</table>
	
	<TD bgcolor="#ffffff" align=center valign=top>
<TABLE border="0" align=center width="100%" height="1" CLASS=MC>
  <TBODY>
    <TR>
      <TD colspan="9" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>活動物品</font></TD>
    </TR>
    <TR>
      $actlist1
    </TR>
    <TR>
      $actlist2
    </TR>
$getbutton
  </TBODY>
</TABLE>
	$STPR<BR>
	<table colspan=3 width=90% align=center CLASS=MC>
	<tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
	</table>
	<table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
	<BR>
	<TR><td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>所持物一覽($no2/$ITM_MAX)</font></td></tr>
	<TR>
	<td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font></td><td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td><td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
	</TR>
	$ittable
	</TD>
	</TR></font>
	</table>
	</TD>
    </TR>
    <TR>
    <TD colspan="3" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF

	&footer;
	exit;
}
1;
