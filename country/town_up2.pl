sub town_up2 {
	&chara_open;
	&status_print;
	&town_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無法進行開發。");}
	if($town_con ne $mcon){&error("請在本國的城鎮開發。");}
	if($mcex<500){&error("名聲需要大於５００才可進行開發。");}
        &time_data;
        if($hour<12){&error("黑商可行賄時間為12:00~24:00");}
	if(!$hit){&error("國家資料異常。");}
	if($in{'gold'} eq ""){&error("請輸入開發金額。");}
	if($in{'gold'} =~ m/[^0-9]/){&error("請輸入正確的開發金額。");}
	if($in{'gold'} <0){&error("請輸入正確的開發金額。");}
	
	$gold=$in{'gold'}*10000;
	$up=int($in{'gold'}*((100+$mint)/300));
	
	if($in{'pow'} eq"t_arm"){
		$com="武器開發值";
		$town_arm+=$up;
		if($town_arm>999){$town_arm=999;}
	}elsif($in{'pow'} eq"t_pro"){
		$com="防具開發值";
		$town_pro+=$up;
		if($town_pro>999){$town_pro=999;}
	}elsif($in{'pow'} eq"t_acc"){
		$com="飾品開發值";
		$town_acc+=$up;
		if($town_acc>999){$town_acc=999;}
	}elsif($in{'pow'} eq"t_ind"){
		$com="產業值";
		$town_ind+=$up;
		if($town_ind>999){$town_ind=999;}
	}elsif($in{'pow'} eq"1" || $in{'pow'} eq"2" || $in{'pow'} eq"3" || $in{'pow'} eq"4" || $in{'pow'} eq"5" || $in{'pow'} eq"6" || $in{'pow'} eq"7"){
	        $date = time();
        	$ktime = $KTIME - $date + $mdate2;
	        if($ktime>0){&error("距離下次可實行的時間剩餘 $ktime 秒。");}
		$com="原料黑商$ELE[$in{'pow'}]原料交換等級";
		if ($town_mix_lv[$in{'pow'}] eq ""){$town_mix_lv[$in{'pow'}]="0";}
	        if($con_ele eq $town_ele){
        	        $plus_up=0.7;
	        }elsif($ANELE[$town_ele] eq $con_ele){
        	        $plus_up=1.3;
	        }else{
        	        $plus_up=1;
	        }
		$gold=($town_mix_lv[$in{'pow'}]+1)*10000000*$plus_up;
		$mcex-=($town_mix_lv[$in{'pow'}]+1)*10*$plus_up;
                $town_mix_lv[$in{'pow'}]++;
		$mixhit=1;
		$up=$town_mix_lv[$in{'pow'}];
		
	}else{&error("資料傳輸有誤。");}
        $con_gold-=$gold;
        if($con_gold<0){&error("國庫資金不足。");}
	if($mixhit){
                &maplog("<font color=green>[開發]</font><font color=blue>$mname</font>對<font color=green>$town_name</font>的<font color=green>$com</font>上昇至<font color=red>$up</font>。");
		$mdate2 = time();
		&chara_input;
	}else{
		&maplog("<font color=green>[開發]</font><font color=blue>$mname</font>對<font color=green>$town_name</font>的<font color=green>$com</font>進行開發，上昇了<font color=red>$up</font>。");
	}
	&town_input;
	&con_input;

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">城鎮開發</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的$com得到上昇了$up。</FONT></TD>
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
