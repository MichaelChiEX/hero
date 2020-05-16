sub item_send2{
	&chara_open;
	&time_data;
	
	$btime = 60 - $date + $mdate2;
	if($btime>0){&error("離下次可重整時間剩於$btime 秒。");}
	$mdate2=time();
	if($in{'player'} eq ""){&error("請輸入要接收物品的對象名稱。");}
	if($in{'player'} eq "$mname"){&error("無法傳物品給自己。");}
	if($in{'itno'} eq ""){&error("請選擇要傳送的物品。");}

	@nums=split(/,/, $in{'itno'});
	$item_count = @nums;
	$send_money = 100000*$item_count;
	$mbank -= $send_money;

	if($mbank<0){&error("傳送物品，每件需要扣除銀行裏的１０萬，你的存款目前不足１０萬x$i。");}

	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			$datames = "查詢：$dir/$file<br>\n";
			if(!open(cha,"$dir/$file")){
				&error("找不到案檔：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			($rid,$rpass,$rname,$rurl) = split(/<>/,$cha[0]);
			if ($rname eq $in{'player'}){
				$shit=1;
				$enemy_id=$rid;
				last;
			}
		}
	}
	closedir(dirlist);
	if(!$shit){&error("傳送對象有誤");}

	&enemy_open;
	if($mtotal<0){&error("你沒有傳送資格。");}
	if($etotal<0){&error("對方沒有接收資格。");}

	open(IN,"./logfile/item/$mid.cgi");
	@MITEM = <IN>;
	close(IN);

	open(IN,"./logfile/item/$eid.cgi");
	@EITEM = <IN>;
	close(IN);

	$ECOUNT=@EITEM;
	if($ECOUNT+$item_count>$ITM_MAX){
		&error("對方手上無法再多拿$i件物品");
	}

	$splicei=0;
	@send_item_name=();
	foreach(@nums){
		($itno,$in_type,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_flg)=split(/<>/,$MITEM[$_-$splicei]);
		if($it_name ne "" && $itno ne"priv"){
			splice(@MITEM,$_-$splicei,1);
			$splicei++;
			push(@send_item_name, $it_name);
			push(@EITEM,"$itno<>$in_type<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
		}
	}
	$send_item_name = join("、", @send_item_name);
	$name="<font color=$ELE_C[$con_ele]>$mname</font><font color=white>傳送給</font><font color=orange>$ename</font>";
	
	&insert_mes_to_top(
		"./logfile/mes/$mid.cgi", 
		"$mid<>$eid<>$mname<>$mchara<>$name<>將<font color=red>$send_item_name</font><font color=white>傳送給</font><font color=blue>$ename</font>。<>$tt<>\n", 
		$MES_MAX
	);

	&insert_mes_to_top(
		"./logfile/mes/$eid.cgi",
		"$mid<>$eid<>$mname<>$mchara<>$name<><font color=blue>$mname傳送了</font><font color=red>$send_item_name</font><font color=shite>給你。</font><>$tt<>\n",
		$MES_MAX
	);

	open(OUT,">./logfile/item/$mid.cgi");
	print OUT @MITEM;
	close(OUT);

	open(OUT,">./logfile/item/$eid.cgi");
	print OUT @EITEM;
	close(OUT);
	
	&maplog("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了<font color=red>$send_item_name</font>給<font color=green>$ename</font>。");
    &maplog8("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了<font color=red>$send_item_name</font>給<font color=green>$ename</font>。");	
	&enemy_input;
	&chara_input;
	
	&header;
	print <<"EOF";
		<form action="./status.cgi" method=post id="backf">
			<input type=hidden name=senditem value=$send_item_name>
			<input type=hidden name=sendname value=$ename>
			<input type=hidden name=id value=$mid>
			<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
			<input type=hidden name=mode value=item_send>
		</form>
		<script>
			document.getElementById('backf').submit();
		</script>
EOF
	&footer;
	exit;
}
1;
