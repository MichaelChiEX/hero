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

	if ($mmaxstr <400) {$mmaxstr += $JMAX[$mtype][0]*$rate;}
	if ($mmaxvit <400) {$mmaxvit += $JMAX[$mtype][1]*$rate;}
	if ($mmaxint <400) {$mmaxint += $JMAX[$mtype][2]*$rate;}
	if ($mmaxmen <400) {$mmaxmen += $JMAX[$mtype][3]*$rate;}
	if ($mmaxdex <400) {$mmaxdex += $JMAX[$mtype][4]*$rate;}
	if ($mmaxagi <400) {$mmaxagi += $JMAX[$mtype][5]*$rate;}

	$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";

	&chara_input;

	&header;	
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">修行</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">$mname<font color=red>進行了修行。<br>$coment</font></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<form action="./status.cgi" method="POST">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=skill>
						<input type=submit CLASS=FC value=回到奧義取得/修行畫面>
					</form>
				</td>
			</tr>
		</tbody>
	</table>
EOF
	&footer;
	exit;
}
1;
