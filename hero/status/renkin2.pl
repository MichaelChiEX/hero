sub renkin2 {
	&chara_open;
	&town_open;
	$val_off=0;
	if($in{'num'} eq ""){&error("請輸入製作的數量。");}
	if($in{'num'} =~ m/[^0-9]/){&error("請輸入正確製作的數量。");}
	if($in{'num'} <0){&error("請輸入正確製作的數量。");}
	if($in{'no'} eq ""){&error("請選擇你要煉製的物品。");}

	open(IN,"./logfile/ability/$mid.cgi");
	@ABDATA = <IN>;
	close(IN);

	foreach(@ABDATA){
		($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
		$mabdmg[$kabtype]=$kabdmg/10;
	}

	open(IN,"./data/renkin.cgi") or &error("煉金資料開啟錯誤。");
	@it_data = <IN>;
	close(IN);
	$it_num=@it_data;

	if($in{'no'} >= $it_num){&error("請正確選擇要煉製的物品。");}
	($it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos,$it_lv)=split(/<>/,$it_data[$in{'no'}]);
	$it_val = int($it_val*(1-$val_off/100));
	$lose_abp = $it_val*$in{'num'};

	if($it_lv > $mabdmg[21]){
		&maplog("<font color=red>[警告]</font><font color=blue>$mname</font><font color=red>嘗試製作自己無法練成的物品。</font>");
		&error("請不要進行不正當的操作。");
	}
	
	if($mabp<$lose_abp){&error("你的熟練度不足$it_val。");}
	$mabp-=$lose_abp;
	if($it_sta ne"100"){
		open(IN,"./logfile/item/$in{'id'}.cgi");
		@ITEM = <IN>;
		close(IN);
		if((@ITEM+$in{'num'})>$ITM_MAX){&error("你身上的物品已滿。(最大可持有$ITM_MAX個物品在身上)");}
		for($i=0;$i<$in{'num'};$i++){
			push(@ITEM,"$in{'no'}<>3<>$it_name<>0<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
		}
		open(OUT,">./logfile/item/$in{'id'}.cgi");
		print OUT @ITEM;
		close(OUT);
	}else{
		&ext_open;
		$tmpab=$ext_ab_item[$it_dmg];
		$ext_ab_item[$it_dmg]+=$in{'num'};
		&ext_input;
	}
	&chara_input;

	&header;
	print <<"EOF";
	<table border="0" width="80%" align=center height="150" CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="$FCOLOR"><font color="$FCOLOR2">煉金</font></td>
			</tr>
			<tr>
				<td bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/inn.jpg"></td>
				<td bgcolor="#330000"><font color="$FCOLOR2">
					你成功的製作了<font color=blue>$it_name</font><br>本次的煉金消耗了你<font color=red>$lose_abp</font>熟練度。<br>
					<font color=red>$it_name</font>。</font>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center" bgcolor="ffffff">
					<form action="./status.cgi" method=post id="statusf" target="actionframe">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=renkin>
						<input type=submit value="回到鍊金畫面">
					</form>
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
