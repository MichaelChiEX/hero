sub sshop3{
	&chara_open;
	&time_data;
	if($in{'itno'} eq ""){&error("請選擇要出售的品物。");}
	if($in{'maxgold'} < 1 || $in{'hour'} < 1){&error("請正確輸入售價結束時間。");}
	if($in{'hour'} > 48){&error("出售時間不可大於２天。");}
	
	$date = time();
	
	$maxgold=int($in{'maxgold'})*10000;
	$lastdate=$date + $in{'hour'}*3600;
	
	open(IN,"./logfile/item/$in{'id'}.cgi") or &error("檔案開啟錯誤town/fex.pl(16)。");
	@ITEM = <IN>;
	close(IN);
	($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_flg)=split(/<>/,$ITEM[$in{'itno'}]);
	if($it_no eq"priv"){&error("此物品無法交易！");}	
	$xit_val=$it_val*3;

	open(IN,"./data/sfree.cgi") or &error("檔案開啟錯誤town/shop3.pl。");
	@FREE = <IN>;
	close(IN);

	foreach(@FREE){
		($f2_no,$f2_ki,$f2_name,$f2_val,$f2_dmg,$f2_wei,$f2_ele,$f2_hit,$f2_cl,$f2_type,$f2_sta,$f2_flg,$f2_id,$f2_hname,$f2_min,$f2_max,$f2_p,$f2_last,$f2_lname,$f2_time,$f2_pat)=split(/<>/);
		if($mid eq "$f2_id"){
			&error("無法同時進行兩件以上物品的交易。");
		}
	}
        if ($in{'maxgold'}>9999) {
                $fs_p2=int($in{'maxgold'}/10000)."億";
        }
	if ($in{'maxgold'}%10000 >0){
                $fs_p2.=($in{'maxgold'}%10000)."萬";
        }	
	&maplog("<font color=green>[交易所]</font><font color=blue>$mname</font>以<font color=green>$fs_p2</font>的價格出售<font color=red>$it_name($it_dmg/$it_wei)</font>。");
	
	push(@FREE,"$it_no<>$it_ki<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>$mid<>$mname<>$mingold<>$maxgold<>0<>$mid<><>$lastdate<>$pat<>\n");
	open(OUT,">./data/sfree.cgi");
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
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">交易所</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">交易所店員：<BR><font color=#AAAAFF>$it_name</font>以<font color=green>$in{'maxgold'}萬</font>的價格為期<font color=green>$in{'hour'}小時</font>進行出售。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
	<form action="./town.cgi" method="POST">
	<INPUT type=hidden name=mode value=sshop>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=submit CLASS=FC value=回到交易所></TD></form>	
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
