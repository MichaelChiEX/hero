sub town_def_tran2 {
        &chara_open;
        &header;
        &status_print;
        &town_open;
        &con_open;
        $max_up_tran=$town_build_data[7]*100+1000;
        if($in{'pow'} eq"str"){
	        $up_value=int(($mstr+$mfai)/6);
	        $need_gold=int($town_hp*$up_str/10000)*10000;
        }else{
	        $up_value=int(($mvit+$mfai)/6);
	        $need_gold=int($town_hp*$up_def/10000)*10000;
        }


        if($con_id eq 0){&error("無所屬國無法進行士兵訓練。");}
        if($town_con ne $mcon){&error("你所在的城鎮不是自己國家所有，無法進行士兵訓練。");}
        if(!$hit){&error("國家資料異常。");}
        if($mcex<500){&error("名聲需要大於５００才可進行。");}
        if($in{'pow'} ne "str" && $in{'pow'} ne "def"){&error("請選擇正確的訓練項目。");}

        $date = time();
        $ktime = $KTIME - $date + $mdate2;
        if($ktime>0){&error("距離下次可實行的時間剩餘 $ktime 秒。");}

        if ($need_gold<10000){$need_gold=10000;}
        $con_gold-=$need_gold;
        if($con_gold<0){&error("國庫金額不足。");}
        if($in{'pow'} eq"str"){
        	$town_str+=$up_value;
        	$com="攻擊力";
        }else{
	        $town_def+=$up_value;
	        $com="防禦力";
	    }
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
        &maplog("<font color=blueviolet>[練兵]</font><font color=blue>$mname</font>對<font color=green>$town_name</font>進行練兵。");
        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">訓練士兵</FONT>/FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的士兵$com提升了$up_value。</FONT></TD>
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

