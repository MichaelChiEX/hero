sub battle_entry2{
	&chara_open;
	&town_open;
	&con_open;
	&time_data;
        $entry_level[0]="新手組";
        $entry_level[1]="進階組";
        $entry_level[2]="高手組";
        $entry_level[3]="英雄組";
	if(!$wday){&error("比賽當天無法報名或取消。");}
	if ($in{'join'} ne"0" && $in{'join'} ne"1" && $in{'join'} ne"2" && $in{'join'} ne"3"){&error("請選擇你要參賽的組別");}
	open(IN,"./data/entry_comp.cgi");
        @ECOMP = <IN>;
        close(IN);
	foreach(@ECOMP){
		($eeid,$eename)=split(/<>/);
		if($eeid eq "$mid"){
			&error("你已在上次的比賽得名,本次無法再次參加");
		}
	}

        ($maxstr,$maxvit,$maxint,$maxmen,$maxdex,$maxagi,$maxlv) = split(/,/,$mmax);
        $maxtotal=$maxstr+$maxvit+$maxint+$maxint+$maxmen+$maxdex+$maxagi;
        if ($maxtotal >5000){
                if ($in{'join'} ne"3"){&error("以你目前的能力只可參加英雄組的比賽");}
        }elsif ($maxtotal >3000){
                if ($in{'join'} ne"2"){&error("以你目前的能力只可參加高手組的比賽");}
        }elsif($maxtotal>2000){
		if ($in{'join'} ne "1"){&error("以你目前的能力只能參加進階組的比賽");}
        }else{
		if ($in{'join'} ne "0" && $in{'join'} ne "1"){&error("以你目前的能力只可參加進階或新手組的比賽");}
        }
	if ($in{'join'} eq"0"){
		if($mgold<3000000){&error("你身上的金錢不足300萬,無法報名參加比賽");}
		$mgold-=3000000;
	}elsif ($in{'join'} eq"1"){
                if($mgold<6000000){&error("你身上的金錢不足600萬,無法報名參加比賽");}
		$mgold-=6000000;
	}elsif ($in{'join'} eq"2"){
                if($mgold<10000000){&error("你身上的金錢不足1000萬,無法報名參加比賽");}
		$mgold-=10000000;
        }elsif ($in{'join'} eq"3"){
                if($mgold<20000000){&error("你身上的金錢不足2000萬,無法報名參加比賽");}
                $mgold-=20000000;
	}else{
		&error("資料傳輸有誤,請重新選擇");
	}
	open(IN,"./data/entry_list.cgi") or &error("檔案開案錯誤town/battle_entry2.pl(9)。");
	@ENTRY_DATA = <IN>;
	close(IN);
	foreach(@ENTRY_DATA){
		($e_join,$e_id,$e_name,$e_chara)=split(/<>/);
		if($e_id eq $mid){&error("你已在參賽者名單中。");}
	}
	$point=int(($mmaxhp+$mmaxmp)/3+$mstr+$mvit+$mint+$mfai+$mdex+$magi);
	&maplog("<font color=green>[天下第一武道大會]$mname報名參加了$entry_level[$in{'join'}]組比賽</font>");	
	push(@ENTRY_DATA,"$in{'join'}<>$mid<>$mname<>$mchara<>$maxtotal<><>\n");
	open(OUT,">./data/entry_list.cgi");
	print OUT @ENTRY_DATA;
	close(OUT);
	&chara_input;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">報名完成</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">天下第一武道會操作完成。<BR>請等待比賽開始。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
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
