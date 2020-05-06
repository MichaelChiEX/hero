sub money_send2{
	&chara_open;
	&time_data;
	$date = time();
	$BTIME=30;
        if($member_fix_time){
                $BTIME=15;
        }
        if ($mid eq $GMID){
                $BTIME=5;
        }
        $btime = $BTIME - $date + $mdate;
        if($btime>0){&error("離下次可傳送時間剩$btime 秒。");}
	if($in{'player'} eq ""){&error("請輸入接收者名稱。");}
	if($in{'gold'} eq ""){&error("請輸入金額。");}
	if($in{'gold'} <= 0){&error("請輸入正確的金額。");}
	if($in{'gold'} =~ m/[^0-9]/){&error("請輸入正確的金額。");}
	if($in{'player'} eq "$mname"){&error("無法傳送金錢給自己。");}	
	$send_money=$in{'gold'}*10000;
	$mbank-=$send_money;
	if($mbank<0){&error("你的銀行存款不足$in{'gold'}萬。");}

	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	$i=0;
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			$datames = "查詢：$dir/$file<br>\n";
			if(!open(cha,"$dir/$file")){
				&error("找不到案檔：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			$list[$i]="$file";
			($rid,$rpass,$rname,$rurl) = split(/<>/,$cha[0]);
			if ($rname eq $in{'player'}){
				$enemy_id=$rid;
				$shit=1;
				last;
			}
		}
		$mn++;
	}
	closedir(dirlist);
	if (!$shit) {&error("傳送對象有誤");}	
	#$enemy_id="$in{'player'}";
	&enemy_open;
	if($mtotal<100){&error("需大於１００戰才可進行傳送，你沒有傳送資金的資格。");}
	if($etotal<500){&error("對方需大於５００戰才可接收你的資金。");}
	
	$name="<font color=$ELE_C[$con_ele]>$mname</font><font color=white>傳送給</font><font color=orange>$ename</font>";
		
	$MESFILE="./logfile/mes/$mid.cgi";
	open(IN,"$MESFILE");
	@MES_DATA = <IN>;
	close(IN);
	unshift(@MES_DATA,"$mid<>$eid<>$mname<>$mchara<>$name<><font color=white>傳送<font color=red>$in{'gold'}萬</font><font color=white>給<font color=blue>$ename</font>。<>$tt<>\n");
	if($mid eq $GMID){
		splice(@MES_DATA,20);
	}else{
		splice(@MES_DATA,$MES3);
	}
	open(OUT,">$MESFILE");
	print OUT @MES_DATA;
	close(OUT);

	$MESFILE2="./logfile/mes/$eid.cgi";
	open(IN,"$MESFILE2");
	@MES2_DATA = <IN>;
	close(IN);
	unshift(@MES2_DATA,"$mid<>$eid<>$mname<>$mchara<>$name<><font color=blue>$mname</font><font color=white>傳送了</font><font color=red>$in{'gold'}萬</font><font color=white>給你</font>。<>$tt<>\n");
	if($eid eq $GMID){
		splice(@MES2_DATA,20);
	}else{
                splice(@MES2_DATA,$MES3);
	}
	open(OUT,">$MESFILE2");
	print OUT @MES2_DATA;
	close(OUT);
	
	$ebank+=$send_money;
	if ($in{'gold'}>=100) {		
		&maplog("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了<font color=red>$in{'gold'}萬</font>給<font color=green>$ename</font>。");
        	&maplog8("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了<font color=red>$in{'gold'}萬</font>給<font color=green>$ename</font>。");
        }
	&enemy_input;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">傳送金錢</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=blue>$mname</font>傳送<font color=red>$in{'gold'}萬</font>給<font color=66ff66>$ename</font>。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">$STPR
$BACKTOWNBUTTON
	</TD>	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
