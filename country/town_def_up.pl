sub town_def_up {
        &chara_open;
        &status_print;
        &con_open;
        &town_open;
        if($con_id eq 0){&error("無所屬國無法進行徵兵。");}
        if($town_con ne $mcon){&error("你所在的城鎮不是自己國家所有，無法進行徵兵。");}
		$max_up_scr=$town_build_data[8]*100;
		$need_gold=int(3000000/$mfai);
        &header;
        print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">城鎮強化</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">$town_name的城防強化作業，實行者名聲需大於５００。<br>請輸入徵兵人數。<br>目前士兵數:$town_hp人，軍營容量：$town_max人，國家資金：$scon_gold</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <form action="./country.cgi" method="post">
        本次徵兵最多可徵得$max_up_scr人，每人需花費$need_gold Gold<br>
        徵兵<input type=text name=updata value=1 size=10>人
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=town_def_up2>
        <input type=submit value=徵兵 CLASS=FC></form>
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
