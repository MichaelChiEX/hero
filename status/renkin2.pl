sub renkin2 {
	&chara_open;
	&town_open;
	$val_off=0;
        if($in{'num'} eq ""){&error("請輸入製作的數量。");}
        if($in{'num'} =~ m/[^0-9]/){&error("請輸入正確製作的數量。");}
        if($in{'num'} <0){&error("請輸入正確製作的數量。");}

	#アビリティ情報
        open(IN,"./logfile/ability/$mid.cgi");
        @ABDATA = <IN>;
        close(IN);

        foreach(@ABDATA){
                ($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
                $mab[$kabtype]=1;
                $mabdmg[$kabtype]=$kabdmg/10;
        }

	$idata="renkin";
	if($in{'no'} eq ""){&error("請選擇你要煉製的物品。");}
	

	open(IN,"./data/$idata.cgi") or &error("煉金資料開啟錯誤[$idata]。");
	@it_data = <IN>;
	close(IN);
	$it_num=@it_data;
	$num=$in{'no'};
	if($it_num>$num){
		($it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos,$it_lv)=split(/<>/,$it_data[$in{'no'}]);
	}
	$it_val=int($it_val*(1-$val_off/100));

	if($it_lv > $mabdmg[21]){
		&maplog("<font color=red>[警告]</font><font color=blue>$mname</font><font color=red>嘗試製作自己無法練成的物品。</font>");
		&error("請不要進行不正當的操作。");
	}
	
	if($mabp<$it_val*$in{'num'}){&error("你的熟練度不足$it_val。");}
	$mabp-=$it_val*$in{'num'};
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
	if($tmpab eq""){$tmpab=0;}
	$tmpab+=$in{'num'};
	if ($STORITM_MAX<$tmpab){&error("你的倉庫容量目前為$STORITM_MAX不足$tmpab個");}
	$ext_ab_item[$it_dmg]=$tmpab;
	&ext_input;
}
	#&maplog("<font color=orange>[煉金]</font><font color=blue>$mname</font>成功製作了<font color=blue>$it_name</font>。");
	&chara_input;
	$lose_abp=$it_val*$in{'num'};
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">煉金</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">你成功的製作了<font color=blue>$it_name</font><BR>本次的煉金消耗了你<font color=red>$lose_abp</font>熟練度。<BR><font color=red>$it_name</font>。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
<form action="./status.cgi" method=post id="statusf" target="actionframe">
      <input type=hidden name=id value=$mid>
      <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
      <input type=hidden name=mode value=renkin>
	<input type=submit value="回到鍊金畫面">
</form>
$BACKTOWNBUTTON
    </TD>
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF
	&footer;
	exit;
	
}
1;
