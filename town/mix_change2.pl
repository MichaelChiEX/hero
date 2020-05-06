sub mix_change2 {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	&time_data;
	&ext_open;
	if($hour<9){&error("黑商可交換時間為09:00~24:00");}
	if($con_id eq 0){&error("無所國無法進行黑商原料交易。");}
        if($con_id ne $town_con){&error("非本國玩家無法進行黑商原料交易。");}
	if($in{'pow'} ne"1" && $in{'pow'} ne"2" && $in{'pow'} ne"3" && $in{'pow'} ne"4" &&  $in{'pow'} ne"5" &&$in{'pow'} ne"6" && $in{'pow'} ne"7"){
		&error("資料傳輸錯誤");
	}
                $date = time();
                $ktime = $KTIME - $date + $mdate2;
                if($ktime>0){&error("距離下次可交換的時間剩餘 $ktime 秒。");}

	if($town_ele eq $in{'pow'}){&error("本鎮黑商不提供$ELE[$in{'pow'}]原料的交換");}
	if($town_mix[$in{'pow'}] eq"" or $town_mix[$in{'pow'}] eq"0"){&error("$ELE[$in{'pow'}]原料目前沒貨供應交換");}
	if($ext_mix[$in{'pow'}] <1){&error("你身上沒有$ELE[$in{'pow'}]原料");}
	$ext_mix[$in{'pow'}]--;
	$ext_mix[$town_ele]++;
        $plus_up=1;
        if ($ANELE[$in{'pow'}] eq $town_ele){
	        $plus_up=1.5;
        }
	$need_cex=100*$plus_up;
	$town_mix[$in{'pow'}]--;
	$mcex-=$need_cex;
	if($mcex<0){&error("你的名聲不足$need_cex");}
	$mdate2 = time();
	&ext_input;
	&chara_input;
	&town_input;
	&header;
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">$ELE[$town_ele]原料黑商</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
<TD bgcolor="#330000"><FONT color="#ffffcc">你己使用「$ELE[$in{'pow'}]原料」交換「$ELE[$town_ele]原料」<br>目前名聲：<font color="yellow">$mcex</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
$BACKTOWNBUTTON
</TD>
  </TBODY>
</TABLE>
<script language="javascript">
function mix_ups(ele){
	mix_up.pow.value=ele;
	mix_up.submit();
}
</script>
<center></center>
EOF
	&footer;
	exit;
}
1;
