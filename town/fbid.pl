sub fbid{
	&chara_open;
	&time_data;
	if($in{'no'} eq ""){&error("請選擇要購買的物品。");}
	if($in{'gold'} eq "" ){&error("請輸入要出的價格。");}
	if($in{'gold'} <= 0){&error("請正確輸入出價。");}
	
	open(IN,"./data/free.cgi") or &error("檔案開啟錯誤town/fbid.pl(8)。");
	@FREE = <IN>;
	close(IN);

	($f_no,$f_ki,$f_name,$f_val,$f_dmg,$f_wei,$f_ele,$f_hit,$f_cl,$f_type,$f_sta,$f_flg,$f_id,$f_hname,$f_min,$f_max,$f_p,$f_last,$f_lname,$f_time,$f_pat)=split(/<>/,$FREE[$in{'no'}]);
	$bidgold=int($in{'gold'})*10000;
	if($f_id eq $mid){&error("無法購買自己拍賣的物品。");}
	if($bidgold < $f_min){&error("你出的價格比拍賣品的最低價還要低。");}
	if($bidgold > $f_max){&error("你出的價格比拍賣品的最高價還要高。");}
	if($f_max <= $f_p){&error("請先處理上一個購買物品。");}
	if($mbank < $bidgold){&error("你銀行裏的金額不足你出的價。");}
	$date = time();
	if($bidgold <= $f_p){$hit=1;}
	
	if($f_time<$date){
		&maplog("<font color=red>[警告]</font><font color=#AAAAFF>$mname</font>嘗試購買已結束拍賣的物品<font color=red>$f_name</font>。");
		&error("請不要購買已結束拍賣的物品。");
	}
	$g2=int($in{'gold'});
	$bidc = "<font color=#AAAAFF>$mname</font>以<font color=yellow>$g2 萬</font>的價格進行<font color=green>$f_name</font>的競標。";

	if($f_max<=$bidgold){
		$bidc = "<font color=#AAAAFF>$mname</font>以<font color=yellow>$g2 萬</font>的價格直接標得<font color=green>$f_name</font>。";
		&maplog("<font color=red>[得標]</font><font color=blue>$mname</font>以<font color=red>$g2 萬</font>的價格直接標得<font color=green>$f_name</font>。");
                $mes_max=$MES3;
                $aite ="拍賣訊息";

                open(IN,"./logfile/mes/$f_id.cgi");
                @MMES_DATA = <IN>;
                close(IN);
                unshift(@MMES_DATA, "$GMID<>$f_id<>拍賣訊息<>gm<>拍賣訊息<>$bidc<>$tt<>\n");
if($mid eq $GMID){
        splice(@MMES_DATA,20);
}else{
        splice(@MMES_DATA,$mes_max);
}
                open(OUT,">./logfile/mes/$f_id.cgi");
                print OUT @MMES_DATA;
                close(OUT);		
	}
	$no = 0;
	@NFREE=();
	foreach(@FREE){
		($f2_no,$f2_ki,$f2_name,$f2_val,$f2_dmg,$f2_wei,$f2_ele,$f2_hit,$f2_cl,$f2_type,$f2_sta,$f2_flg,$f2_id,$f2_hname,$f2_min,$f2_max,$f2_p,$f2_last,$f2_lname,$f2_time,$f2_pat)=split(/<>/);
		if($in{'no'} eq "$no" && !$hit){
			push(@NFREE,"$f2_no<>$f2_ki<>$f2_name<>$f2_val<>$f2_dmg<>$f2_wei<>$f2_ele<>$f2_hit<>$f2_cl<>$f2_type<>$f2_sta<>$f2_flg<>$f2_id<>$f2_hname<>$f2_min<>$f2_max<>$bidgold<>$mid<>$mname<>$f2_time<>$f2_pat<>\n");
		}else{
			push(@NFREE,"$_");
		}
		$no++;
	}

	open(OUT,">./data/free.cgi");
	print OUT @NFREE;
	close(OUT);

	&chara_input;
	&header;
	
print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#000000" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">出價</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">$bidc</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
	<form action="./town.cgi" method="POST">
	<INPUT type=hidden name=mode value=fshop>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=submit CLASS=FC value=回拍賣所></TD></form>
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
