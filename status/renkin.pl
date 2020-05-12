sub renkin {
	&chara_open;
	&status_print;
	&equip_open;
	&ext_open;	

	open(IN,"./logfile/ability/$mid.cgi");
	@ABDATA = <IN>;
	close(IN);

	foreach(@ABDATA){
		($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
		$mabdmg[$kabtype]=$kabdmg/10;
	}

	open(IN,"./data/renkin.cgi");
	@ARM_DATA = <IN>;
	close(IN);
	$no=0;
	for($no=0; $no<=$#ARM_DATA; $no++){
		($arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos,$arm_lv)=split(/<>/, @ARM_DATA[$no]);
		if($arm_lv <= $mabdmg[21]){
			$armtable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=no value=$no></td><td bgcolor=white><font size=2>$arm_name</font></td><td bgcolor=white align=right><font size=2>$arm_val Point</font></td><td bgcolor=white><font size=2>$arm_dmg</font></td><td bgcolor=white><font size=2>$arm_wei</font></td><td bgcolor=white><font size=2>$ELE[$arm_ele]</font></td></tr>";
		}
	}

	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	for($no2=0; $no2<=$#ITEM; $no2++){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,@ITEM[$no2]);
		$sel_val=int($it_val/2);
		$ittable.="<tr><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$sel_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td><td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td></tr>";
	}

	&header;
	
	print <<"EOF";
	<table border="0" width="90%" align=center bgcolor="#000000" height="150" class=TC>
		<tbody>
			<tr>
				<td colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">煉金</FONT></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></td>
				<td bgcolor="#330000" colspan="3"><FONT color="#ffffcc">在此可以利用你的熟練度製作以下的物品但你必須先學會煉金的相關技能。<br>請選擇你要製作的物品及輸入要製作的數量。</FONT></td>
			</tr>
			<tr>
				<td align=center bgcolor="ffffff" colspan=2 width=55%>
					<table border=0 width="100%" bgcolor=$FCOLOR class=TC>
						<tr>
							<td colspan=6 align=center><font color=ffffcc>可煉成品一覽</font></td>
						</tr>
						<tr>
							<td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>消費熟練度</td>
							<td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td>
						</tr>
						<form action="./status.cgi" method="post">
						$armtable
						<tr>
							<td colspan=7 align=center bgcolor="ffffff">
								<input type=hidden name=id value=$mid>
								<input type=hidden name=pass value=$mpass>
								<input type=hidden name=rmode value=$in{'rmode'}>
								<input type=hidden name=mode value=renkin2>
								<input type=text name=num value=1 size=5>
								<input type=submit class=FC value=煉金>
							</td>
						</tr>
						</form>
					</table>
				</td>
				<td bgcolor="#ffffff" align=center>
					$STPR<br>
					<table colspan=3 width=90% align=center class=MC>
						<tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
						<tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
						<tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
						<tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
					</table>
					<br>
					<table border="0" align=center width="100%" height="1" class=MC>
						<tbody>
							<tr>
							<td colspan="6" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>能力果</font></td>
							</tr>
							<tr>
							<td bgcolor="$ELE_C[$mele]" align="center">力量之果</td>
							<td bgcolor="$ELE_C[$mele]" align="center">生命之果</td>
							<td bgcolor="$ELE_C[$mele]" align="center">智慧之果</td>
							<td bgcolor="$ELE_C[$mele]" align="center">精神之果</td>
							<td bgcolor="$ELE_C[$mele]" align="center">幸運之果</td>
							<td bgcolor="$ELE_C[$mele]" align="center">速度之果</td>
							</tr>
							<tr>
							<td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[0]</td>
							<td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[1]</td>
							<td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[2]</td>
							<td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[3]</td>
							<td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[4]</td>
							<td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[5]</td>
							</tr>
						</tbody>
					</table>
					<br>
					<table border=0 width="90%" align=center bgcolor=$FCOLOR class=TC>
						<tr>
							<td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>所持物一覽($no2/$ITM_MAX)</font></td>
						</tr>
						<tr>
							<td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font></td>
							<td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td>
							<td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
						</tr>
						$ittable
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
