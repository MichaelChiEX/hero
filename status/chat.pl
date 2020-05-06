sub chat {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	&time_data;

	
	if($con_king eq"$mid"){$smess="<font color=orange>[國王]</font>$in{'mes'}";}
	elsif($mid eq $GMID){$smess="<font color=yellow>[ＧＭ]</font>$in{'mes'}";}
	else{$smess="<font color=red>[國]</font>$in{'mes'}";}
	for($k=0;$k<6;$k++){
		if($y_chara[$k] eq $mid){$smess="<font color=#ff0099>[$y_name[$k]]</font>$in{'mes'}";}
	}

	if($in{'mes_sel'} eq ""){&error_alert("請選擇正確的發言對象。");}
	if($in{'mes'} eq ""){&error_alert("請輸入發送訊息。");}
	if(length($in{'mes'}) > 300){&error_alert("發送訊息請小於１５０個全形文字。");}

	$pid = &id_change("$mid");

	$aite=$in{'mes_sel'};
	$gm_mes="";
	if($in{'mes_sel'} eq "1"){
		$MESFILE="./meslog/all.cgi";
		$name="<a href=\"javascript:void(0);\" onClick=\"javascript:opstatue('$pid');\"><font color=$ELE_C[$con_ele]>$mname</a>＠$con_name國</font>";
		$mes_max=$MES1;$eid=1;
		$gm_mes="1<>($mid)$mname＠$con_name國：<>$in{'mes'}<>$daytime<>\n";
	}
	elsif($in{'mes_sel'} eq "2"){
		$MESFILE="./meslog/$con_id.cgi";

		open(IN,"./data/unit.cgi");
		@UNIT_DATA = <IN>;
		close(IN);

		foreach(@UNIT_DATA){
		($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
			if($uid eq $munit && $munit ne ""){
				$hit=1;$unit=$uname;last;
			}
		}
		if(!$hit){$unit="無所屬";}
		$name="<a href=\"javascript:void(0);\" onClick=\"javascript:opstatue('$pid');\"><font color=$ELE_C[$con_ele]>$mname</a>＠$unit</font>";
		$mes_max=$MES2;$eid=2;
		$gm_mes="2<>($mid)$mname＠$con_name國：<>$in{'mes'}<>$daytime<>\n";
	}
	##個宛
	elsif($in{'mes_sel'} eq"3"){
		if($in{'aite'} eq""){&error_alert("請輸入或選擇正確的受言人。");}
		if($in{'aite'} eq"$mname"){&error_alert("無法發言給自己。");}
		$dir="./logfile/chara";
		opendir(dirlist,"$dir");
		$i=0;
		while($file = readdir(dirlist)){
			if($file =~ /\.cgi/i){
				$datames = "查詢：$dir/$file<br>\n";
				if(!open(chara,"$dir/$file")){
					&error_alert("$dir/$file權限設定錯誤。<br>\n");
				}
				@chara = <chara>;
				close(chara);
				$list[$i]="$file";
				($eid,$epass,$ename,$eurl,$echara) = split(/<>/,$chara[0]);
				
				if($ename eq"$in{'aite'}"){$mh=1;last;}
			}
			if($mn>10000){&error_alert("ループ");}
			$mn++;
		}
		closedir(dirlist);
		if(!$mh){&error_alert("找不到你輸入的受言人。");}
		$MESFILE="./logfile/mes/$eid.cgi";
		$name="<a href=\"javascript:void(0);\" onClick=\"javascript:opstatue('$pid');\"><font color=$ELE_C[$con_ele]>$mname</a>對</font><font color=orange>$ename說：</font>";
		$mes_max=$MES3;
		$aite ="$mname";

		open(IN,"./logfile/mes/$mid.cgi");
		@MMES_DATA = <IN>;
		close(IN);
		unshift(@MMES_DATA, "$mid<>$eid<>$aite<>$mchara<>$name<>$in{'mes'}<>$tt<>\n");
if($mid eq $GMID){
	splice(@MMES_DATA,20);
}else{
	splice(@MMES_DATA,$mes_max);
}
		open(OUT,">./logfile/mes/$mid.cgi");
		print OUT @MMES_DATA;
		close(OUT);
		$gm_mes="3<>($mid)$mname對($eid)$ename：<>$in{'mes'}<>$daytime<>\n";
	}elsif($in{'mes_sel'} eq "4"){
		open(IN,"./data/unit.cgi");
		@UNIT_DATA = <IN>;
		close(IN);
		if($munit eq ""){&error_alert("你目前沒有組隊。");}
		foreach(@UNIT_DATA){
		($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
			if($uid eq $munit && $munit ne ""){
				$unit=$uname;$hit=1;last;
			}
		}
		if(!$hit){$unit="無所屬";}

		$MESFILE="./meslog/unit/$munit.cgi";
		$name="<a href=\"javascript:void(0);\" onClick=\"javascript:opstatue('$pid');\"><font color=$ELE_C[$con_ele]>$mname</a>＠$unit</font>";
		$mes_max=$MES2;$eid=4;
	}elsif($in{'mes_sel'} ne""){
		$enemy_id=$in{'mes_sel'};
		&enemy_open;

		$MESFILE="./logfile/mes/$eid.cgi";
		$name="<a href=\"javascript:void(0);\" onClick=\"window.open('./status_print.cgi?id=$pid', 'newwin', 'width=750,height=500,scrollbars =yes')\"><font color=$ELE_C[$con_ele]>$mname</a>對</font><font color=orange>$ename說：</font>";
		$mes_max=$MES3;
		$aite ="$mname";

		open(IN,"./logfile/mes/$mid.cgi");
		@MMES_DATA = <IN>;
		close(IN);
		unshift(@MMES_DATA, "$mid<>$eid<>$aite<>$mchara<>$name<>$in{'mes'}<>$tt<>\n");
		splice(@MMES_DATA,$mes_max);

		open(OUT,">./logfile/mes/$mid.cgi");
		print OUT @MMES_DATA;
		close(OUT);
		$gm_mes="3<>($mid)$mname對($eid)$ename：<>$in{'mes'}<>$daytime<>\n";
	}
	else{&error_alert("選擇失敗。$in{'mes_sel'}");}

	
	open(IN,"$MESFILE");
	@MES_DATA = <IN>;
	close(IN);
#	if($in{'mes'} eq"clear"){
#		$smess="♪～";
#		@N_MES=();
#		foreach(@MES_DATA){
#			($mes_id,$mes_aite,$mes_eid,$mes_chara,$mes_name,$mes_mes,$mes_daytime)=split(/<>/);
#			if($mid eq "$mes_id"){next;}
#			else{push(@N_MES,"$_");}
#		}
#		@MES_DATA=@N_MES;
#	}
	unshift(@MES_DATA,"$mid<>$eid<>$aite<>$mchara<>$name<>$smess<>$tt<>\n");
if("$MESFILE" eq"./logfile/mes/$GMID.cgi"){
        splice(@MES_DATA,20);
}else{
	splice(@MES_DATA,$mes_max);
}

	open(OUT,">$MESFILE");
	print OUT @MES_DATA;
	close(OUT);
if($in{'mes_sel'} eq"1"){
	open(IN,"./meslog/gmall.cgi");
	@MES_GM=<IN>;
	close(IN);
	unshift(@MES_GM,$gm_mes);
        open(OUT,">./meslog/gmall.cgi");
        print OUT @MES_GM;
        close(OUT);
}elsif($in{'mes_sel'} eq"2"){
        open(IN,"./meslog/gmall_con$con_id.cgi");
        @MES_GM2=<IN>;
        close(IN);
        unshift(@MES_GM2,$gm_mes);
        open(OUT,">./meslog/gmall_con$con_id.cgi");
        print OUT @MES_GM2;
        close(OUT);
}else{
        open(IN,"./meslog/gmall3.cgi");
        @MES_GM3=<IN>;
        close(IN);
        unshift(@MES_GM3,$gm_mes);
        open(OUT,">./meslog/gmall3.cgi");
        print OUT @MES_GM3;
        close(OUT);
}
        print "Cache-Control: no-cache\n";
        print "Pragma: no-cache\n";
        print "Content-type: text/html\n\n";

	print <<"EOF";

	<script language=javascript>

setTimeout("parent.get_all_data()","2000");
</script>
EOF

	exit;
}
#----------------------#
#  パスワード暗号處理  #
#----------------------#
sub id_change {
	local($inpw) = $_[0];

	@yy = unpack("C*", $inpw);
	$word="";
	foreach(@yy){
		$word .= "$_\,";
	}
	chomp($word);
	$encrypt = reverse($word);

	return $encrypt;
}
1;
