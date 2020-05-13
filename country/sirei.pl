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
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">國家公告</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">國王的發佈公告。<br>公告內容２～１００個文字之間。</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	<form action="./country.cgi" method="post">
	指令：<input type=text name=mes size=80><br>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=sirei2>
	<input type=submit value=公告變更 CLASS=FC></form>
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
