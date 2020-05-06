sub skill3{
	&chara_open;

	#能力上昇に必要な熟練度
	$point=int(($mmaxstr+$mmaxvit+$mmaxint+$mmaxmen+$mmaxdex+$mmaxagi-1000)/20);
	$uppoint=$point*$point;
	if($uppoint>10000){$uppoint=10000;}

	$mabp-=$uppoint;
	if($mabp < 0){&error("熟練度不足。");}

	if(int(rand($MAXLVP)) eq 1){
		$coment="$mname界限值上限急速成長！！";
		&maplog("<font color=orange>[急成長]</font><font color=blue>$mname</font>的界限值於修行後快速成長！");
		$rate=5;
	}
	elsif(int(rand($SMAXLV)) eq 1){
		$coment="$mname界限值獲得覺醒！！！";
		&maplog("<font color=red>[覺醒]</font><font color=blue>$mname</font>的界限值於修行後大幅成長！！");
		$rate=15;
	}
	else{
		$coment="$mname的界限值上昇！。";
		$rate=1;
	}
	$com.="$coment<BR>";
	if ($mmaxstr <400) {$mmaxstr += $JMAX[$mtype][0]*$rate;}
	if ($mmaxvit <400) {$mmaxvit += $JMAX[$mtype][1]*$rate;}
	if ($mmaxint <400) {$mmaxint += $JMAX[$mtype][2]*$rate;}
	if ($mmaxmen <400) {$mmaxmen += $JMAX[$mtype][3]*$rate;}
	if ($mmaxdex <400) {$mmaxdex += $JMAX[$mtype][4]*$rate;}
	if ($mmaxagi <400) {$mmaxagi += $JMAX[$mtype][5]*$rate;}

	#if($mmaxstr>=400){$mmaxstr = 400;}
	#if($mmaxvit>=400){$mmaxvit = 400;}
	#if($mmaxint>=400){$mmaxint = 400;}
	#if($mmaxmen>=400){$mmaxmen = 400;}
	#if($mmaxdex>=400){$mmaxdex = 400;}
	#if($mmaxagi>=400){$mmaxagi = 400;}
	$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";

	&chara_input;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">修行</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$mname<font color=red>進行了修行。<BR>$coment</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	<form action="./status.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=skill>
	<INPUT type=submit CLASS=FC value=回到奧義取得/修行畫面></form></TD>
	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
