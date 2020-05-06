sub build {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	&ext_open;
	$kengold=$BUGOLD;
	if($con_id ne 0){&error("無屬國者才可進行建國。");}
	$e=0;
	$elelist="<select name=ele>";
	foreach(@ELE){
		if($e ne 0){
			$elelist.="<option value=$e>$ELE[$e]";
		}
		$e++;
	}
	$elelist.="</select>";
	&header;

	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">建國</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">建國準備。<BR>請輸入２～６個字內的國家名稱並選擇國家的屬性。<BR>建國需要花費<font color=red>$kengold</font> Gold及200顆建國之石。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	<form action="./country.cgi" method="post">
	國家名稱：<INPUT type=text name=country size=15 name=gold>國<BR>
	國家屬性：$elelist<BR><BR>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=build2>
	<INPUT type=submit value=建國 CLASS=FC></form>
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
