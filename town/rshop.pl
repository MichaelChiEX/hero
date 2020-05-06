sub rshop {
	&chara_open;
	&status_print;
	&town_open;
	&equip_open;
	$val_off=0;
	
	$idata="ritem";$itype=3;
	open(IN,"./data/$idata.cgi") or &error("檔案開啟錯誤[$idata]town/rshop.pl(9)。");
	@ARM_DATA = <IN>;
	close(IN);
	$no=0;
	foreach(@ARM_DATA){
		($arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos)=split(/<>/);
		$arm_val2=$arm_val;
		$arm_val=int($arm_val*(1-$val_off/100));
		$armtable.="<TR><TD width=5% bgcolor=ffffcc><input type=radio name=no value=$no></TD><TD bgcolor=white><font size=2>$arm_name</font></TD><TD bgcolor=white align=right><font size=2>$arm_val Gold</font></TD><TD bgcolor=white><font size=2>$arm_dmg</font></TD><TD bgcolor=white><font size=2>$arm_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$arm_ele]</font></TD><TD bgcolor=white><font size=2>$arm_type</font></TD></TR>";
		$no++;
	}

	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$no2=0;
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		$sel_val=int($it_val/2);
		$ittable.="<TR><TD width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></TD><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$sel_val</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD></TR>";
		$no2++;
	}

	&header;
	
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">魔女的店</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc">[魔女]<BR>歡迎來到魔女的店。<BR>請選購魔女的商品。</FONT></TD>
    </TR>
    <TR>
      <TD align=center bgcolor="ffffff" colspan=2 width=55%>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>商品一覽</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>價格</td><td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td><td bgcolor=white>種類</td>
	</tr>
	<form action="./town.cgi" method="post">
	$armtable
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$itype>
	<INPUT type=hidden name=mode value=rbuy>
	<INPUT type=submit CLASS=FC value=購入></TD></TR></form>
	</table>
	
	<TD bgcolor="#ffffff" align=center>
	$STPR<BR>
	<table colspan=3 width=90% align=center CLASS=MC>
	<tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
	</table>
	<table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
	<BR>
	<TR><td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>持有物</font></td></tr>
	<TR>
	<TD bgcolor=ffffcc></TD><td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font></td><td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td><td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
	</TR>
	<form action="./town.cgi" method="POST">
	$ittable
	<TR><TD colspan=7 align=center bgcolor=ffffff>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$itype>
	</TD></form>
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
