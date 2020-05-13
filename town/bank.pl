sub bank {
	&chara_open;
	&header;
	&status_print;
	$inn_gold=int(($mmaxhp-20)/3+$mmaxmp/3+($mstr+$mvit+$mint+$mdex+$mfai+$magi)/5);
	if($inn_gold<5){$inn_gold=5;}
	#if($mgold<$inn_gold && $mbank<$inn_gold){$mes="お金をお持ちで無いようですね。今回は特別サービスにしますよ。";}
	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">銀行</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">歡迎光臨 $mname 你目前在銀行共有$mbank Gold。<br>請選擇服務項目</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	$STPR
	<br>
	<銀行中的資金：$mbank Gold>
	<form action="./town.cgi" method="post">
	<input type=text size=5 name=azuke>萬Gold
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=banka>
	
	<input type=submit value=存入 CLASS=MFC></form>
	<form action="./town.cgi" method="post">
	<input type=hidden name=azuke value=$mgold>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<input type=hidden name=mode value=bankall>
	<input type=submit value=全部存入 CLASS=MFC></form>
	<form action="./town.cgi" method="post">
	<input type=text size=5 name=hiki>萬Gold
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<input type=hidden name=mode value=bankh>
	<input type=submit value=取出 CLASS=MFC></form>
	<form action="./town.cgi" method="post">
	<input type=hidden name=azuke value=$mbank>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<input type=hidden name=mode value=bankhall>
	<input type=submit value=全部取出 CLASS=MFC></form>
$BACKTOWNBUTTON
	</td>
    </tr>
  </tbody>
</table>
EOF

	&footer;
	exit;
}
1;
