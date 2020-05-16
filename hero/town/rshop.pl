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
		$armtable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=no value=$no></td><td bgcolor=white><font size=2>$arm_name</font></td><td bgcolor=white align=right><font size=2>$arm_val Gold</font></td><td bgcolor=white><font size=2>$arm_dmg</font></td><td bgcolor=white><font size=2>$arm_wei</font></td><td bgcolor=white><font size=2>$ELE[$arm_ele]</font></td><td bgcolor=white><font size=2>$arm_type</font></td></tr>";
		$no++;
	}

	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$no2=0;
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		$sel_val=int($it_val/2);
		$ittable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></td><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$sel_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td><td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td></tr>";
		$no2++;
	}

	&header;
	
	print <<"EOF";
<table border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <tbody>
    <tr>
      <td colspan="3" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">魔女的店</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></td>
      <td bgcolor="#330000" colspan="3"><font color="#ffffcc">[魔女]<br>歡迎來到魔女的店。<br>請選購魔女的商品。</font></td>
    </tr>
    <tr>
      <td align=center bgcolor="ffffff" colspan=2 width=55%>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>商品一覽</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>價格</td><td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td><td bgcolor=white>種類</td>
	</tr>
	<form action="./town.cgi" method="post">
	$armtable
	<tr><td colspan=7 align=center bgcolor="ffffff">
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=itype value=$itype>
	<input type=hidden name=mode value=rbuy>
	<input type=submit CLASS=FC value=購入></td></tr></form>
	</table>
	
	<td bgcolor="#ffffff" align=center>
	$STPR<br>
	<table colspan=3 width=90% align=center CLASS=MC>
	<tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
	</table>
	<table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
	<br>
	<tr><td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>持有物</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font></td><td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td><td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
	</tr>
	<form action="./town.cgi" method="POST">
	$ittable
	<tr><td colspan=7 align=center bgcolor=ffffff>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=itype value=$itype>
	</td></form>
	</tr></font>
	</table>
	</td>
    </tr>
    <tr>
    <td colspan="3" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
	</td>
    </tr>
  </tbody>
</table>
EOF

	&footer;
	exit;
}
1;
