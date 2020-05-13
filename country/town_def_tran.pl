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
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">訓練士兵</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">$town_name的城防強化作業，實行者名聲需大於５００。<br>請選擇訓練項目。<br>目前士兵攻／防值:$town_str/$town_def，攻/防上限：$max_up_tran，國家資金：$scon_gold</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
      本次訓練攻擊力費用$need_gold_str萬
        <form action="./country.cgi" method="post">
	<input type=hidden name=pow value=str>
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=town_def_tran2>
        <input type=submit value=提升攻擊力$up_str CLASS=FC></form>
      本次訓練防禦力費用$need_gold_def萬
        <form action="./country.cgi" method="post">
        <input type=hidden name=pow value=def>
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=town_def_tran2>
        <input type=submit value=提升防禦力$up_def CLASS=FC></form>
$BACKTOWNBUTTON
        </td>
    </tr>
  </tbody>
</table>
<center></center>
EOF

        &footer;
        exit;
}
1;

