sub town_def_up2 {
        &chara_open;
        &header;
        &status_print;
        &town_open;
        &con_open;
        $max_up_scr=$town_build_data[8]*100;


        if($con_id eq 0){&error("無所屬國無法進行徵兵。");}
        if($town_con ne $mcon){&error("你所在的城鎮不是自己國家所有，無法進行徵兵。");}
        if(!$hit){&error("國家資料異常。");}
        if($mcex<100){&error("名聲需要大於１００才可進行。");}
        if($in{'updata'} eq ""){&error("請輸入徵兵人數。");}
        if($in{'updata'} =~ m/[^0-9]/){&error("請輸入正確的徵兵人數。");}
        if($in{'updata'} <0){&error("請輸入正確的徵兵人數。");}
        if($in{'updata'} >$max_up_scr){&error("目前最大徵兵人數不得超過$max_up_scr人。");}
        $need_gold=int(int(3000000/$mfai)*$in{'updata'}/10000)*10000;
        $date = time();
        $ktime = $KTIME - $date + $mdate2;
        if($ktime>0){&error("距離下次可實行的時間剩餘 $ktime 秒。");}

		if ($need_gold<10000){$need_gold=10000;}
        $con_gold-=$need_gold;
        if($con_gold<0){&error("國庫金額不足。");}
        $town_str2=$town_str*$town_hp+$in{'updata'}*1000;
        $town_def2=$town_def*$town_hp+$in{'updata'}*1000;
        $town_hp+=$in{'updata'};
        if ($town_hp>$town_max){
        	$town_hp=$town_max;
        }
        $town_str=int($town_str2/$town_hp);
        $town_def=int($town_def2/$town_hp);
        #攻擊最大上限
        if ($town_str>($town_build_data[7]*100+1000)){
        	$town_str=$town_build_data[7]*100+1000;
        }
        #防禦最大上限
        if ($town_def>($town_build_data[7]*100+1000)){
        	$town_def=$town_build_data[7]*100+1000;
        }
        $mdate2=time();

        &con_input;
        &chara_input;
        &town_input;
        &maplog("<font color=blueviolet>[徵兵]</font><font color=blue>$mname</font>對<font color=green>$town_name</font>進行徵兵作業，徵得<font color=green>士兵</font><font color=red>$in{'updata'}</font>。");
        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">徵兵作業</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的士兵增加到$town_hp人。</FONT></TD>
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

