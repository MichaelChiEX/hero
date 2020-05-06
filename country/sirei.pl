sub sirei {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;

	if($con_id eq 0){&error("無所屬國無法使用。");}
	$e=0;
	$elelist="<select name=ele>";
	foreach(@ELE){
		$elelist.="<option value=$e>$ELE[$e]";
		$e++;
	}
	$elelist.="</select>";

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">國家公告</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">國王的發佈公告。<BR>公告內容２～１００個文字之間。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	<form action="./country.cgi" method="post">
	指令：<INPUT type=text name=mes size=80><BR>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=sirei2>
	<INPUT type=submit value=公告變更 CLASS=FC></form>
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
