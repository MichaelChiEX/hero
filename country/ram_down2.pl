sub ram_down2 {
	&chara_open;
&error("系統更新中....");
	&status_print;
	&town_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無法進行計略。");}
	if($town_con ne $mcon){&error("無法對自己的國家城鎮進行計略。");}
	if(!$hit){&error("國家資料異常。");}
	if($mcex<500){&error("需要名聲５００以上才可執行。");}
	if($in{'gold'} eq ""){&error("請輸入金額。");}
	if($in{'gold'} =~ m/[^0-9]/){&error("請輸入正確的金額。");}
	if($in{'gold'} <0){&error("請輸入正確的金額。");}
	if($in{'gold'} >300){&error("金額不可超到３００萬。");}

	$date = time();
        if($town_build_data[10] eq""){$town_build_data[10]=0;}
        $KTIME-=$town_build_data[10]*20;
        $ktime = $KTIME - $date + $mdate2;
	if($ktime>0){&error("下次可以進行計略的時間剩餘 $ktime 秒。");}


	if($in{'tid'} eq ""){&error("請選擇要實行的計略項目。");}
	foreach(@TOWN_DATA){
		($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y,$town2_build,$town2_etc)=split(/<>/);
		if($in{'tid'} eq $town2_id){$t2hit=1;last;}
		$tx++;
	}
	if($town2_etc eq""||!$t2hit){&error("請選擇要實施的城鎮。");}
	if($town2_id eq "0"||$town2_con eq 0||$town2_con eq $town_con){&error("無法對此城鎮進行計略。");}
	
	($town2_hp,$town2_max,$town2_str,$town2_def,$town2_dex,$town2_flg,$town2_sta,$town2_mix_lv[1],$town2_mix_lv[2],$town2_mix_lv[3],$town2_mix_lv[4],$town2_mix_lv[5],$town2_mix_lv[6],$town2_mix_lv[7],$town2_mix[1],$town2_mix[2],$town2_mix[3],$town2_mix[4],$town2_mix[5],$town2_mix[6],$town2_mix[7])=split(/,/,$town2_etc);

	
	$gold=$in{'gold'}*10000;
	$con_gold-=$gold;
	if($con_gold<0){&error("國車金額不足。");}
	$up=int($in{'gold'}*((100+$mint)/600));
	
	if($in{'pow'} eq"t_str"){
		$com="攻擊力";
		$town2_str-=$up;
		if($town2_str<400){$town2_str=400;}
	}elsif($in{'pow'} eq"t_def"){
		$com="耐久力";
		$town2_def-=$up;
		if($town2_def<400){$town2_def=400;}
	}else{&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}

	$town2_etc="$town2_hp,$town2_max,$town2_str,$town2_def,$town2_dex,$town2_flg,$town2_sta,$town2_mix_lv[1],$town2_mix_lv[2],$town2_mix_lv[3],$town2_mix_lv[4],$town2_mix_lv[5],$town2_mix_lv[6],$town2_mix_lv[7],$town2_mix[1],$town2_mix[2],$town2_mix[3],$town2_mix[4],$town2_mix[5],$town2_mix[6],$town2_mix[7]";
	if($town2_id ne ""){
		@N_TOWN=();
		foreach(@TOWN_DATA){
			($town4_id,$town4_name,$town4_con,$town4_ele,$town4_gold,$town4_arm,$town4_pro,$town4_acc,$town4_ind,$town4_tr,$town4_s,$town4_x,$town4_y,$town4_build,$town4_etc)=split(/<>/);
			if("$town2_id" eq "$town4_id"){
				push(@N_TOWN,"$town2_id<>$town2_name<>$town2_con<>$town2_ele<>$town2_gold<>$town2_arm<>$town2_pro<>$town2_acc<>$town2_ind<>$town2_tr<>$town2_s<>$town2_x<>$town2_y<>$town2_build<>$town2_etc<>\n");
			}else{
				push(@N_TOWN,"$_");
			}
		}
		open(OUT,">./data/towndata.cgi") or &error('檔案開啟錯誤country/ram_down2.pl(58)。');
		print OUT @N_TOWN;
		close(OUT);
	}
	else{&error("資料出現異常，<a href='./login.cgi'>請重新登入</a>。");}
	$mdate2=time();

	&con_input;
	&chara_input;

	&header;
	
	&maplog("<font color=red>[計略]</font><font color=blue>$mname</font>實行計略→</font color=green>$town2_name</font>的$com下降<font color=red>$up</font>。");
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">計略</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town2_name的$com下降$up。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
$BACKTOWNBUTTON
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
