sub item_send3{
	&chara_open;
	&ext_open;
	&time_data;
	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error("離下次可傳送時間剩$btime 秒。");}
	if($in{'player'} eq ""){&error("請輸入要接收物品的對象名稱。");}
	if($in{'player'} eq "$mname"){&error("無法傳物品給自己。");}
	if($in{'itno'} eq ""){&error("請選擇要傳送的物品。");}
	if($in{'num'} =~ m/[^0-9]/){&error("請輸入正確的數量");}
	if($in{'num'} <1){&error("請輸入正確的數量");}
	if($in{'itno'} < 0 || $in{'itno'} > 7){&error("請選擇要傳送的物品。");}
	if($in{'itkind'} ne "stone" && $in{'itkind'} ne "fruit" && $in{'itkind'} ne "act"){&error("傳送物品類型錯誤");}

	if($in{'itkind'} eq "stone"){
		if($in{'itno'} eq"0"){
			$it_nam="建國之石";
		}else{
			$it_nam="$ELE[$in{'itno'}]原料";
		}
		if($in{'num'}>$ext_mix[$in{'itno'}]){&error("你沒有足夠的$it_nam");}
	}elsif($in{'itkind'} eq "fruit"){
		@it_name=("力量之果", "生命之果", "智慧之果", "精神之果", "運氣之果", "速度之果");
		$it_nam=@it_name[$in{'itno'}];
		if($in{'num'}>$ext_ab_item[$in{'itno'}]){&error("你沒有足夠的$it_nam");}
	}elsif($in{'itkind'} eq "act"){
		$it_nam=$ACTITEM[$in{'itno'}];
		($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
		if($in{'num'}>$act[$in{'itno'}]){&error("你沒有足夠的$it_nam");}
	}

	$send_money = 100000*$in{'num'};
	$mbank -= $send_money;
	if($mbank<0){&error("傳送物品每樣需要扣除銀行裏的１０萬，你的存款目前不足$in{'num'}0萬。");}

	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			if(!open(cha,"$dir/$file")){
				&error("找不到檔案：$dir/$file。<br>\n");
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
	&ext_enemy_open;
	if($mtotal<0){&error("你沒有傳送資格。");}
	if($etotal<0){&error("對方沒有接收資格。");}
	if($in{'itkind'} eq "stone"){
		$ext_mix[$in{'itno'}]-=$in{'num'};
		$ext2_mix[$in{'itno'}]+=$in{'num'};
	}elsif($in{'itkind'} eq "fruit"){
		$ext_ab_item[$in{'itno'}]-=$in{'num'};
		$ext2_ab_item[$in{'itno'}]+=$in{'num'};
	}elsif($in{'itkind'} eq "act"){
		($act2[1],$act2[2],$act2[3],$act2[4],$act2[5],$act2[6],$act2[7],$act2[8],$act2[9])=split(/,/,$ext2_action);
		$act[$in{'itno'}]-=$in{'num'};
		$act2[$in{'itno'}]+=$in{'num'};
		$ext_action="$act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9]";
		$ext2_action="$act2[1],$act2[2],$act2[3],$act2[4],$act2[5],$act2[6],$act2[7],$act2[8],$act2[9]";
	}

	$name="<font color=$ELE_C[$con_ele]>$mname</font><font color=white>傳送給</font><font color=orange>$ename</font>";

	&insert_mes_to_top(
		"./logfile/mes/$mid.cgi",
		"$mid<>$eid<>$mname<>$mchara<>$name<>將$in{'num'}個<font color=red>$it_nam</font><font color=white>傳送給</font><font color=blue>$ename</font>。<>$tt<>\n",
		$MES_MAX
	);

	&insert_mes_to_top(
		"./logfile/mes/$eid.cgi",
		"$mid<>$eid<>$mname<>$mchara<>$name<><font color=blue>$mname傳送了$in{'num'}個</font><font color=red>$it_nam</font><font color=shite>給你。</font><>$tt<>\n",
		$MES_MAX
	);
	
	&maplog("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了$in{'num'}個<font color=red>$it_nam</font>給<font color=green>$ename</font>。");
	&maplog8("<font color=blueviolet>[傳送]</font><font color=blue>$mname</font>傳送了$in{'num'}個<font color=red>$it_nam</font>給<font color=green>$ename</font>。");
	
	&ext_input;
	&ext_enemy_input;
	&chara_input;
	&enemy_input;

	&header;
	$senditem="$in{'num'}個$it_nam";	
	print <<"EOF";
		<form action="./status.cgi" method=post id="backf">
			<input type=hidden name=senditem value=$senditem>
			<input type=hidden name=sendname value=$ename>
			<input type=hidden name=id value=$mid>
			<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
			<input type=hidden name=mode value=item_send>
		</form>
		<script language="javascript">
			document.getElementById('backf').submit();
		</script>
EOF
	&footer;
	exit;
}
1;
