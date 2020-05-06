sub ram_up2 {
	&chara_open;
&error("舊系統停用");
	&header;
	&status_print;
	&town_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無法進行強化。");}
	if($town_con ne $mcon){&error("你所在的城鎮不是自己國家所有，無法進行開發。");}
	if(!$hit){&error("國家資料異常。");}
	if($mcex<100){&error("名聲需要大於１００才可進行。");}
	if($in{'gold'} eq ""){&error("請輸入金額。");}
	if($in{'gold'} =~ m/[^0-9]/){&error("請輸入正確的金額。");}
	if($in{'gold'} <0){&error("請輸入正確的金額。");}
	if($in{'gold'} >300){&error("每次強化花費不得大於３００萬。");}

	$date = time();
	$ktime = $KTIME - $date + $mdate2;
	if($ktime>0){&error("距離下次可實行的時間剩餘 $ktime 秒。");}

	$gold=$in{'gold'}*10000;
	$con_gold-=$gold;
	if($con_gold<0){&error("國庫金額不足。");}
	$up=int($in{'gold'}*((100+$mint)/300));
	
	if($in{'pow'} eq"t_maxhp"){
		$com="城壁最大值";
		$up=$up*10;
		$town_max+=$up;
		if($town_max>20000){$town_max=20000;}
	}elsif($in{'pow'} eq"t_hp"){
		$com="城壁";
		$up=$up*100;
		$town_hp+=$up;
		if($town_hp>$town_max){$town_hp=$town_max;}
	}elsif($in{'pow'} eq"t_str"){
		$com="攻擊力";
		$town_str+=$up;
		if($town_str>2000){$town_str=2000;}
	}elsif($in{'pow'} eq"t_def"){
		$com="耐久力";
		$town_def+=$up;
		if($town_def>2000){$town_def=2000;}
	}else{&error("資料傳輸錯誤，<a href='./login.cgi'>請重新登入</a>。");}
	$mdate2=time();

	&con_input;
	&chara_input;
	&town_input;
	&maplog("<font color=blueviolet>[強化]</font><font color=blue>$mname</font>對<font color=green>$town_name</font>進行強化作業<font color=green>$com</font>上昇了<font color=red>$up</font>。");
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">城強化作業</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的$com上昇了$up。</FONT></TD>
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
