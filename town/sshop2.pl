sub sshop2{
	&chara_open;
	&time_data;
	if($in{'no'} eq ""){&error("請選擇要購買的物品。");}
		
	open(IN,"./data/sfree.cgi") or &error("檔案開啟錯誤town/sfree.pl(8)。");
	@FREE = <IN>;
	close(IN);

	($f_no,$f_ki,$f_name,$f_val,$f_dmg,$f_wei,$f_ele,$f_hit,$f_cl,$f_type,$f_sta,$f_flg,$f_id,$f_hname,$f_min,$f_max,$f_p,$f_last,$f_lname,$f_time,$f_pat)=split(/<>/,$FREE[$in{'no'}]);
	$bidgold=$f_max/10000;
	if($f_id eq $mid){&error("無法購買自己售出的物品。");}
	if($mbank < $f_max){&error("你銀行裏的金額不足$bidgold萬。");}
	if($f_name ne $in{'f_name'}){
		&error("你要購買的物品已經被買走或是資料已被更新<BR>請重新進入交易所確認。");
	}
	$date = time();
	if($bidgold <= $f_p){$hit=1;}
	
	if($f_time<$date){
		&error("請不要購買已結束交易的物品。");
	}

        open(IN,"./logfile/item/$mid.cgi") or &error("檔案開啟錯誤town/sshop2.pl(52)。");
        @ITEM = <IN>;
        close(IN);
        if(@ITEM>=$ITM_MAX){&error("你的持有物品數已達上限。(最大$ITM_MAX個)");}


		$bidc = "<font color=#AAAAFF>$mname</font>以<font color=yellow>$bidgold 萬</font>的價格購得<font color=green>$f_name</font>。";
                $mes_max=$MES3;
                $aite ="交易所訊息";

                open(IN,"./logfile/mes/$f_id.cgi");
                @MMES_DATA = <IN>;
                close(IN);
                unshift(@MMES_DATA, "$GMID<>$f_id<>交易所訊息<>gm<>交易所訊息<>$bidc<>$tt<>\n");
if($mid eq $GMID){
        splice(@MMES_DATA,20);
}else{
        splice(@MMES_DATA,$mes_max);
}
                open(OUT,">./logfile/mes/$f_id.cgi");
                print OUT @MMES_DATA;
                close(OUT);
		&maplog("<font color=green>[交易所]</font><font color=blue>$mname</font>以<font color=red>$bidgold 萬</font>的價格購得<font color=green>$f_name</font>。");
		
        splice(@FREE,$in{'no'},1);
        push(@ITEM,"$f_no<>$f_ki<>$f_name<>$f_val<>$f_dmg<>$f_wei<>$f_ele<>$f_hit<>$f_cl<>$f_type<>$f_sta<>$f_flg<>\n");

        open(OUT,">./data/sfree.cgi");
        print OUT @FREE;
        close(OUT);

        open(OUT,">./logfile/item/$mid.cgi");
        print OUT @ITEM;
        close(OUT);
	$mbank-=$f_max;
	$enemy_id=$f_id;
	&enemy_open;
	$ebank+=$f_max;
	&enemy_input;
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
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">$bidc</FONT></TD>
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
