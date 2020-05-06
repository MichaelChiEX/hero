sub town_def_tran {
        &chara_open;
        &status_print;
        &con_open;
        &town_open;
        if($con_id eq 0){&error("無所屬國無法進行士兵訓練。");}
        if($town_con ne $mcon){&error("你所在的城鎮不是自己國家所有，無法進行士兵訓練。");}
        $max_up_tran=$town_build_data[7]*100+1000;
        $up_str=int(($mstr+$mfai)/6);
        $up_def=int(($mvit+$mfai)/6);
        $need_gold_str=int($town_hp*$up_str/10000);
        $need_gold_def=int($town_hp*$up_def/10000);
        if ($need_gold <1){$need_gold=1;}
        &header;
        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">訓練士兵</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的城防強化作業，實行者名聲需大於５００。<BR>請選擇訓練項目。<BR>目前士兵攻／防值:$town_str/$town_def，攻/防上限：$max_up_tran，國家資金：$scon_gold</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
      本次訓練攻擊力費用$need_gold_str萬
        <form action="./country.cgi" method="post">
	<INPUT type=hidden name=pow value=str>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=town_def_tran2>
        <INPUT type=submit value=提升攻擊力$up_str CLASS=FC></form>
      本次訓練防禦力費用$need_gold_def萬
        <form action="./country.cgi" method="post">
        <INPUT type=hidden name=pow value=def>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=town_def_tran2>
        <INPUT type=submit value=提升防禦力$up_def CLASS=FC></form>
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

