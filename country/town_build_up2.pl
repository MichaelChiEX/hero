sub town_build_up2 {
        &chara_open;
        &header;
        &status_print;
        &town_open;
        &con_open;
	if($in{'pow'} eq "10" && $town_build_data[10] eq"15"){&error("$town_build_name[10]等級上限為１５級，無法再升級！");}
        if($con_id eq 0){&error("無所屬國無法進行城鎮軍事建設。");}
        if($town_con ne $mcon){&error("你所在的城鎮不是自己國家所有，無法進行建設。");}
        if(!$hit){&error("國家資料異常。");}
        $up_lv=$town_build_data[$in{'pow'}];
        if ($up_lv eq""){$up_lv=0;}
        if($town_build_name[$in{'pow'}] eq ""){&error("請選擇正確的升級設施");}
        if($in{'pow'} eq "0"){&error("請選擇正確的升級設施");}
        $need_cex=($up_lv*200)+500;
        if($mcex<$need_cex){&error("名聲需要大於$need_cex才可進行。");}
		$need_gold=($up_lv+1)*10000000;
        $date = time();
        $ktime = $KTIME - $date + $mdate2;
        if($ktime>0){&error("距離下次可實行的時間剩餘 $ktime 秒。");}
        $con_gold-=$need_gold;
        if($con_gold<0){&error("國庫金額不足。");}
        $up_lv+=1;
		$town_build_data[$in{'pow'}]=$up_lv;
		$town_max=10000+$town_build_data[3]*1000;
		
        $mdate2=time();

        &con_input;
        &chara_input;
        &town_input;
        &maplog("<font color=blueviolet>[強化]</font><font color=blue>$mname</font>對<font color=green>$town_name</font>進行$town_build_name[$in{'pow'}]強化作業<font color=green>$com</font>上昇了<font color=red>1級</font>。");
        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">城強化作業</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的$town_build_name[$in{'pow'}]等級上昇了1級。</FONT></TD>
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

