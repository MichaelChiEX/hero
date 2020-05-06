sub bank {
	&chara_open;
	&header;
	&status_print;
	$inn_gold=int(($mmaxhp-20)/3+$mmaxmp/3+($mstr+$mvit+$mint+$mdex+$mfai+$magi)/5);
	if($inn_gold<5){$inn_gold=5;}
	#if($mgold<$inn_gold && $mbank<$inn_gold){$mes="お金をお持ちで無いようですね。今回は特別サービスにしますよ。";}
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">銀行</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">歡迎光臨 $mname 你目前在銀行共有$mbank Gold。<BR>請選擇服務項目</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR
	<BR>
	<銀行中的資金：$mbank Gold>
	<form action="./town.cgi" method="post">
	<INPUT type=text size=5 name=azuke>萬Gold
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=banka>
	
	<INPUT type=submit value=存入 CLASS=MFC></form>
	<form action="./town.cgi" method="post">
	<INPUT type=hidden name=azuke value=$mgold>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=bankall>
	<INPUT type=submit value=全部存入 CLASS=MFC></form>
	<form action="./town.cgi" method="post">
	<INPUT type=text size=5 name=hiki>萬Gold
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=bankh>
	<INPUT type=submit value=取出 CLASS=MFC></form>
	<form action="./town.cgi" method="post">
	<INPUT type=hidden name=azuke value=$mbank>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=bankhall>
	<INPUT type=submit value=全部取出 CLASS=MFC></form>
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF

	&footer;
	exit;
}
1;
