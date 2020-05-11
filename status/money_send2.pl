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
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			if(!open(cha,"$dir/$file")){
				&error("找不到案檔：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			($rid,$rpass,$rname,$rurl) = split(/<>/,$cha[0]);
			if ($rname eq $in{'player'}){
				$enemy_id=$rid;
				$shit=1;
				last;
			}
		}
	}
	closedir(dirlist);
	if (!$shit) {&error("傳送對象有誤");}	

	&enemy_open;
	if($mtotal<100){&error("需大於１００戰才可進行傳送，你沒有傳送資金的資格。");}
	if($etotal<500){&error("對方需大於５００戰才可接收你的資金。");}
	$ebank+=$send_money;
	
	$name="<font color=$ELE_C[$con_ele]>$mname</font><font color=white>傳送給</font><font color=orange>$ename</font>";
		
	&insert_mes_to_top(
		"./logfile/mes/$mid.cgi",
		"$mid<>$eid<>$mname<>$mchara<>$name<><font color=white>傳送<font color=red>$in{'gold'}萬</font><font color=white>給<font color=blue>$ename</font>。<>$tt<>\n",
		$MES_MAX
	);

	&insert_mes_to_top(
		"./logfile/mes/$eid.cgi",
		"$mid<>$eid<>$mname<>$mchara<>$name<><font color=blue>$mname</font><font color=white>傳送了</font><font color=red>$in{'gold'}萬</font><font color=white>給你</font>。<>$tt<>\n",
		$MES_MAX
	);

	&maplog("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了<font color=red>$in{'gold'}萬</font>給<font color=green>$ename</font>。");
	&maplog8("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了<font color=red>$in{'gold'}萬</font>給<font color=green>$ename</font>。");
	
	&chara_input;
	&enemy_input;
	&header;
	
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">傳送金錢</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></td>
				<td bgcolor="#330000">
					<font color="#ffffcc">
						<font color=blue>$mname</font>傳送<font color=red>$in{'gold'}萬</font>給<font color=66ff66>$ename</font>。
					</font>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">$STPR
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
