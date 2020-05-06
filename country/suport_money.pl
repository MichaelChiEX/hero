sub suport_money {
	&chara_open;
	&status_print;
	&con_open;
	
	if($con_id eq 0){&error("無所屬國無法貢獻。");}
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">貢獻</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">對<font color=#AAAAFF>$con_name國</font>貢獻你的資金。<BR>貢獻資料將會提昇你在本國的名聲，有了名聲你將享有更多的優惠。<BR>國家資金：<font color=yellow>$scon_gold</font></FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR
	<form action="./country.cgi" method="post">
	<INPUT type=text size=5 name=gold>萬
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=suport_money2>
	<INPUT type=submit value=貢獻 CLASS=FC></form>
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
