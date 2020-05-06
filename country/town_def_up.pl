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
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">城鎮強化</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的城防強化作業，實行者名聲需大於５００。<BR>請輸入徵兵人數。<BR>目前士兵數:$town_hp人，軍營容量：$town_max人，國家資金：$scon_gold</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
        <form action="./country.cgi" method="post">
        本次徵兵最多可徵得$max_up_scr人，每人需花費$need_gold Gold<br>
        徵兵<INPUT type=text name=updata value=1 size=10>人
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=town_def_up2>
        <INPUT type=submit value=徵兵 CLASS=FC></form>
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
