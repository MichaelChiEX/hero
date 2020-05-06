sub item_send5{
	&chara_open;
	&time_data;
	$date = time();
        $btime = 10 - $date + $mdate;
        if($btime>0){&error("離下次可傳送時間剩$btime 秒。");}
	if($in{'player'} eq ""){&error("請輸入要接收物品的對象名稱。");}
	if($in{'player'} eq "$mid"){&error("無法將物品傳給自己。");}
	if($in{'itno'} eq ""){&error("請選擇要傳送的物品。");}
	if($in{'num'} =~ m/[^0-9]/){&error("請輸入正確的數量");}
        if($in{'num'} <1){&error("請輸入正確的數量");}
	if($in{'itno'} ne"0" && $in{'itno'} ne"1" && $in{'itno'} ne"2" && $in{'itno'} ne"3" && $in{'itno'} ne"4" && $in{'itno'} ne"5" && $in{'itno'} ne"6" && $in{'itno'} ne"7" && $in{'itno'} ne"8"){&error("請選擇要傳送的活動物品。");}	

        $it_nam=$ACTITEM[$in{'itno'}];
	&ext_open;
	($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
	if($act[$in{'itno'}] eq "" || $act[$in{'itno'}] eq"0"){
		&error("你沒有$it_nam");
	}
	if($in{'num'}>$act[$in{'itno'}]){&error("你沒有足夠的$it_nam");}
	$send_money = 100000*$in{'num'};
	$mbank -= $send_money;

	if($mbank<0){&error("傳送物品每樣需要扣除銀行裏的１０萬，你的存款目前不足$in{'num'}0萬。");}
	if($in{'player'} eq "$mname"){&error("無法傳物品給自己。");}
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
				$shit=1;
				$enemy_id=$rid;
				last;
			}
		}
		$mn++;
	}
	closedir(dirlist);
	if(!$shit){&error("傳送對象有誤");}

	#$enemy_id="$in{'player'}";
	&enemy_open;
	&ext_enemy_open;
	($act2[1],$act2[2],$act2[3],$act2[4],$act2[5],$act2[6],$act2[7],$act2[8],$act2[9])=split(/,/,$ext2_action);
	if($mtotal<0){&error("你沒有傳送資格。");}
	if($etotal<0){&error("對方沒有接收資格。");}
	$act[$in{'itno'}]-=$in{'num'};
	$act2[$in{'itno'}]+=$in{'num'};

	$name="<font color=$ELE_C[$con_ele]>$mname</font><font color=white>傳送給</font><font color=orange>$ename</font>";
	$MESFILE="./logfile/mes/$mid.cgi";
	open(IN,"$MESFILE");
	@MES_DATA = <IN>;
	close(IN);
	unshift(@MES_DATA,"$mid<>$eid<>$mname<>$mchara<>$name<>將$in{'num'}個<font color=red>$it_nam</font><font color=white>傳送給</font><font color=blue>$ename</font>。<>$tt<>\n");
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
	unshift(@MES2_DATA,"$mid<>$eid<>$mname<>$mchara<>$name<><font color=blue>$mname傳送了$in{'num'}個</font><font color=red>$it_nam</font><font color=shite>給你。</font><>$tt<>\n");
	if($eid eq $GMID){
		splice(@MES2_DATA,$MES3);
	}else{
                splice(@MES2_DATA,20);
	}
	open(OUT,">$MESFILE2");
	print OUT @MES2_DATA;
	close(OUT);
	
	&maplog("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了$in{'num'}個<font color=red>$it_nam</font>給<font color=green>$ename</font>。");
        &maplog8("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了$in{'num'}個<font color=red>$it_nam</font>給<font color=green>$ename</font>。");
	$ext_action="$act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9]";
	$ext2_action="$act2[1],$act2[2],$act2[3],$act2[4],$act2[5],$act2[6],$act2[7],$act2[8],$act2[9]";
	&ext_input;
        &ext_enemy_input;
	&enemy_input;
	$senditem="$in{'num'}個$it_nam";
	&header;
	
	print <<"EOF";
               <form action="./status.cgi" method=post id="backf">
		<input type=hidden name=senditem value=$senditem>
		<input type=hidden name=sendname value=$ename>
                <input type=hidden name=id value=$mid>
                <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=mode value=item_send>
</form>
<script language="javascript">
document.getElementById('backf').submit();
</script>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
