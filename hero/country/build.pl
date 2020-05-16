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
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">建國</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">建國準備。<br>請輸入２～６個字內的國家名稱並選擇國家的屬性。<br>建國需要花費<font color=red>$kengold</font> Gold及200顆建國之石。</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	<form action="./country.cgi" method="post">
	國家名稱：<input type=text name=country size=15 name=gold>國<br>
	國家屬性：$elelist<br><br>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<input type=hidden name=mode value=build2>
	<input type=submit value=建國 CLASS=FC></form>
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
