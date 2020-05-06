sub rbuy {
	&chara_open;
	&town_open;
	$val_off=0;
	if($mcon eq $town_con && $town_con ne 0){
		$val_off=int($mcex/100)+1;
		if($val_off>15){$val_off=15;}
	}
	$idata="ritem";
	if($in{'no'} eq ""){&error("請選擇要購買的物品。");}
	if($moya%1000 ne "1"){
		&maplog("<font color=red>[警告]</font><font color=blue>$mname</font>嘗試利用不正當的方法購買魔女的物品。");
		&error("請不要再嘗試了！。");
	}

	open(IN,"./data/$idata.cgi") or &error("檔案開啟錯誤town/rbuy.pl(16)。");
	@it_data = <IN>;
	close(IN);
	$it_num=@it_data;
	$num=$in{'no'};
	if($it_num>$num){
		($it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos)=split(/<>/,$it_data[$in{'no'}]);
	}
	$it_val=int($it_val*(1-$val_off/100));
	
	if($mgold<$it_val){&error("所持金不足。");}
	$mgold-=$it_val;

	$townget=$town_ind/300;
	$town_gold+=int($it_val/((1500-$town_ind)/250));
	
	open(IN,"./logfile/item/$in{'id'}.cgi");
	@ITEM = <IN>;
	close(IN);
	if(@ITEM>=$ITM_MAX){&error("你目前手上的物品已滿。(最大$ITM_MAX個)");}

	push(@ITEM,"$in{'no'}<>3<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
	open(OUT,">./logfile/item/$in{'id'}.cgi");
	print OUT @ITEM;
	close(OUT);

	&maplog("<font color=blueviolet>[魔女]</font><font color=blue>$mname</font>在魔女的店購入了某項物品。");
	$moya=int(rand(10000));
	&chara_input;
	&town_input;

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">魔女的店</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">[魔女]<BR>魔女將<font color=green>$it_name</font>給你。$ames<br>總共花費<font color=yellow>$it_val<font> Gold。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
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
