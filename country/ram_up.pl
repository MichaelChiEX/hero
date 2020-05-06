sub ram_up {
	&chara_open;
&error("舊系統停用");
	&status_print;
	&con_open;
	&town_open;
	if($con_id eq 0){&error("無所屬國無法走行開發城鎮。");}
	if($town_con ne $mcon){&error("你所在的城鎮不是自己國家所有，無法進行開發。");}

	$list="<select name=pow>";
	$list.="<option value=t_hp>修復城壁";
	$list.="<option value=t_maxhp>強化城壁";
	$list.="<option value=t_str>強化攻擊力";
	$list.="<option value=t_def>強化耐久力";
	$list.="</select>";

	&header;
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">城鎮強化</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/siro.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$town_name的城防強化作業，實行者名聲需大於１００。<BR>請選擇強化的項目及金額。<BR>國家資金：$scon_gold</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	<form action="./country.cgi" method="post">
	$list
	<INPUT type=text size=5 name=gold>萬（不可超過３００萬）
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=ram_up2>
	<INPUT type=submit value=強化 CLASS=FC></form>
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
