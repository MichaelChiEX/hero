sub rule {
	&chara_open;
	&con_open;
	&town_open;
	&header;
	&status_print;
	if($con_id eq 0){&error("無法所國無法更新法規。");}
	open(IN,"./blog/rule/$con_id.cgi");
	@RULE_DATA = <IN>;
	close(IN);

	$no=0;
	$rule="<table border=0 bgcolor=000000 width=90%>";
	$rule.="<tr><td colspan=2 width=100% bgcolor=$ELE_BG[$con_ele] align=center><font color=$ELE_C[$con_ele]>$con_name國法規</font></td></tr>";
	foreach(@RULE_DATA){
		($lid,$lname,$lchara,$lcon,$lmes,$letc,$lhost,$ldaytime)=split(/<>/);
		$rule.="<tr><td width=1% bgcolor=$ELE_BG[$con_ele]><input type=radio name=no value=$no></td><td align=left bgcolor=$ELE_C[$con_ele] width=85% height=50><font color=000000>$lmes<br>($ldaytime $letc $lname)</b></font></td></tr>";
		$no++;
	}
	$rule.="</table>";

	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">$con_name國法規</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">$con_name國的法規。<br>在此可新增加要給$con_name國民的法規事項。<br></font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	<form action="./country.cgi" method="POST">
	$rule
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=rule_delete>
	<input type=hidden name=type value=1>
	<input type=submit CLASS=MFC value=法規刪除></form>
	<form action="./country.cgi" method="post">

	<img src="$IMG/chara/$mchara.gif">
	<textarea name="message" cols="40" rows="4"></TEXTAREA><br>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=rule_write>
	<input type=hidden name=type value=1>
	<input type=submit value=新增法規(只有官員可以操作） CLASS=MFC></form>
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
