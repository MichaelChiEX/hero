sub fex{
	&chara_open;
	&time_data;
	if($in{'itno'} eq ""){&error("請選擇要拍賣的品物。");}
	if($in{'mingold'} eq "" || $in{'maxgold'} eq "" ||  $in{'hour'} eq ""){&error("請輸入拍賣價格。");}
	if($in{'maxgold'} <= $in{'mingold'}){&error("起標價不可大於直接購買價。");}
	if($in{'mingold'} <1 || $in{'maxgold'} < 1 || $in{'hour'} < 1){&error("請正確輸入拍賣價格及拍賣時間。");}
	if($in{'hour'} > 48){&error("拍賣時間不可大於２天。");}
	
	$date = time();
	
	$mingold=int($in{'mingold'})*10000;
	$maxgold=int($in{'maxgold'})*10000;
	$lastdate=$date + $in{'hour'}*3600;
	$mg2=$mingold/10000;
	$mx2=$maxgold/10000;	
	open(IN,"./logfile/item/$in{'id'}.cgi") or &error("檔案開啟錯誤town/fex.pl(16)。");
	@ITEM = <IN>;
	close(IN);
	($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_flg)=split(/<>/,$ITEM[$in{'itno'}]);
	if($it_no eq"priv"){&error("此物品無法進行拍賣！");}	
	$xit_val=$it_val*3;
	if($maxgold > $xit_val && $it_val ne 0 && $it_ki ne 4 && $it_ki ne 7){
		&error("你的拍賣金額太大，請重新出價。");
	}

	open(IN,"./data/free.cgi") or &error("檔案開啟錯誤town/fex.pl(26)。");
	@FREE = <IN>;
	close(IN);

	foreach(@FREE){
		($f2_no,$f2_ki,$f2_name,$f2_val,$f2_dmg,$f2_wei,$f2_ele,$f2_hit,$f2_cl,$f2_type,$f2_sta,$f2_flg,$f2_id,$f2_hname,$f2_min,$f2_max,$f2_p,$f2_last,$f2_lname,$f2_time,$f2_pat)=split(/<>/);
		if($mid eq "$f2_id"){
			&error("無法同時進行兩件以上物品的拍賣。");
		}
	}
	
	&maplog("<font color=green>[拍賣]</font><font color=blue>$mname</font>拍賣<font color=red>$it_name($it_dmg/$it_wei)</font>，以底價<font color=green>$mg2萬</font>、直接購買價<font color=green>$mx2萬</font>進行拍賣。");
	
	push(@FREE,"$it_no<>$it_ki<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>$mid<>$mname<>$mingold<>$maxgold<>0<>$mid<><>$lastdate<>$pat<>\n");
	open(OUT,">./data/free.cgi");
	print OUT @FREE;
	close(OUT);

	splice(@ITEM,$in{'itno'},1);

	open(OUT,">./logfile/item/$in{'id'}.cgi");
	print OUT @ITEM;
	close(OUT);

	&chara_input;
	&header;
	
print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#000000" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">拍賣所</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">拍賣所店員：<BR><font color=#AAAAFF>$it_name</font>以底價<font color=green>$mg2萬</font>、直接購買金額<font color=green>$mx2萬</font>為期<font color=green>$in{'hour'}小時</font>進行拍賣。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
	<form action="./town.cgi" method="POST">
	<INPUT type=hidden name=mode value=fshop>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=submit CLASS=FC value=回到拍賣所></TD></form>
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
