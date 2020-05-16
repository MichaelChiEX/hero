sub suport_money {
	&chara_open;
	&status_print;
	&con_open;
	
	if($con_id eq 0){&error("無所屬國無法貢獻。");}
	&header;
	
	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">貢獻</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">對<font color=#AAAAFF>$con_name國</font>貢獻你的資金。<br>貢獻資料將會提昇你在本國的名聲，有了名聲你將享有更多的優惠。<br>國家資金：<font color=yellow>$scon_gold</font></font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	$STPR
	<form action="./country.cgi" method="post">
	<input type=text size=5 name=gold>萬
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=suport_money2>
	<input type=submit value=貢獻 CLASS=FC></form>
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
