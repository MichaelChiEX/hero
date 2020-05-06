sub all_rule {
	&chara_open;
	&con_open;
	&town_open;
	&header;
	&status_print;
	open(IN,"./blog/rule/0.cgi");
	@RULE_DATA = <IN>;
	close(IN);

	$no=0;
	$rule="<table border=0 bgcolor=000000 width=90%>";
	$rule.="<tr><td colspan=2 width=100% bgcolor=$ELE_BG[0] align=center><font color=$ELE_C[0]>世界法規</font></td></tr>";
	foreach(@RULE_DATA){
		($lid,$lname,$lchara,$lcon,$lmes,$letc,$lhost,$ldaytime)=split(/<>/);
		$rule.="<tr><td width=1% bgcolor=$ELE_BG[$lcon]><input type=radio name=no value=$no></td><td align=left bgcolor=$ELE_C[$lcon] width=85% height=50><font color=000000>$lmes<BR>($ldaytime $letc $lname)</b></font></td></tr>";
		$no++;
	}
	$rule.="</table>";

	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">世界法規</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">此處為世界法規大廳。<BR>想要安心的在這個世界生存，請詳細閱讀世界法規，避免失去自身的權益。<BR></FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	<form action="./country.cgi" method="POST">
	$rule
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=rule_delete>
	<INPUT type=hidden name=type value=2>
	<INPUT type=submit CLASS=MFC value=取消法規></form>
	<form action="./country.cgi" method="post">

	<img src="$IMG/chara/$mchara.gif">
	<TEXTAREA name="message" cols="40" rows="4"></TEXTAREA><BR>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=rule_write>
	<INPUT type=hidden name=type value=2>
	<INPUT type=submit value=新增法規 CLASS=MFC></form>
<input type="button" value="返回" CLASS=FC onclick="javascript:parent.backtown();">
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
