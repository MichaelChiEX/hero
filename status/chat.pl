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

	if($in{'mes_sel'} eq ""){&error_alert("請輸入正確的發言對象。");}
	if($in{'mes'} eq ""){&error_alert("請輸入發送訊息。");}
	if(length($in{'mes'}) > 300){&error_alert("發送訊息請小於１５０個全形文字。");}

	$pid = &id_change("$mid");
	$aite=$in{'mes_sel'};

	if($in{'mes_sel'} eq "1"){
		$MESFILE="./meslog/all.cgi";
		$name="<a href=\"javascript:void(0);\" onClick=\"javascript:opstatue('$pid');\"><font color=$ELE_C[$con_ele]>$mname</a>＠$con_name國</font>";
		
		$eid=1;
		$gm_file="./meslog/gmall.cgi";
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
		
		$eid=2;
		$gm_file="./meslog/gmall_con$con_id.cgi";
		$gm_mes="2<>($mid)$mname＠$con_name國：<>$in{'mes'}<>$daytime<>\n";
	}
	elsif($in{'mes_sel'} eq"3"){
		if($in{'aite'} eq""){&error_alert("請輸入正確的受言人。");}
		if($in{'aite'} eq"$mname"){&error_alert("無法發言給自己。");}

		$dir="./logfile/chara";
		opendir(dirlist,"$dir");
		while($file = readdir(dirlist)){
			if($file =~ /\.cgi/i){
				open(chara,"$dir/$file");
				@chara = <chara>;
				close(chara);
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
		$aite ="$mname";

		&insert_mes_to_top("./logfile/mes/$mid.cgi", "$mid<>$eid<>$aite<>$mchara<>$name<>$in{'mes'}<>$tt<>\n", $MES_MAX);
		
		$gm_file="./meslog/gmall3.cgi";
		$gm_mes="3<>($mid)$mname對($eid)$ename：<>$in{'mes'}<>$daytime<>\n";
	}elsif($in{'mes_sel'} eq "4"){
		if($munit eq ""){&error_alert("你目前沒有組隊。");}

		open(IN,"./data/unit.cgi");
		@UNIT_DATA = <IN>;
		close(IN);
		
		foreach(@UNIT_DATA){
			($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
			if($uid eq $munit && $munit ne ""){
				$unit=$uname;$hit=1;last;
			}
		}

		$eid=4;
		$MESFILE="./meslog/unit/$munit.cgi";
		$name="<a href=\"javascript:void(0);\" onClick=\"javascript:opstatue('$pid');\"><font color=$ELE_C[$con_ele]>$mname</a>＠$unit</font>";
	}else{&error_alert("選擇失敗。$in{'mes_sel'}");}

	&insert_mes_to_top($MESFILE, "$mid<>$eid<>$aite<>$mchara<>$name<>$smess<>$tt<>\n", $MES_MAX);

	if($gm_file){
		&insert_mes_to_top($gm_file, $gm_mes);
	}
	
	print "Cache-Control: no-cache\n";
	print "Pragma: no-cache\n";
	print "Content-type: text/html\n\n";

	print <<"EOF";

	<script>
	setTimeout("parent.get_all_data()","2000");
	</script>
EOF

	exit;
}

1;
