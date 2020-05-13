
sub name_change {
	require './conf_pet.cgi';
	&chara_open;
	&status_print;
	&equip_open;

	if ($marmno eq"mix"){
		$armradio="<input type=\"radio\" value=\"2\" name=\"changeitem\">更改「<font color=blue>$marmname</font>」名稱（２～８文字）<br>";
	}
	if ($mprono eq"mix"){
		$proradio="<input type=\"radio\" value=\"3\" name=\"changeitem\">更改「<font color=blue>$mproname</font>」名稱（２～８文字）<br>";
	}
	if ($maccno eq"mix"){
		$accradio="<input type=\"radio\" value=\"4\" name=\"changeitem\">更改「<font color=blue>$maccname</font>」名稱（２～８文字）<br>";
	}

	if ($mpetname ne""){
		# 最高階
		$peti=49;
		$pethit=0;
		for($peti=49;$peti<77;$peti++){
			if($PETDATA[$peti][0] eq $mpetname && $mpetlv eq"10"){
				$pethit=1;
				last;	
			}
		}
		# 名稱不在清單中
		$peti=0;
		$pethit2=0;
		if($pethit ne 1){
			foreach(@PETDATA){
				if($PETDATA[$peti][0] eq $mpetname){
					$pethit2=1;
					last;
				}
				$peti++;
			}
		}
		if($pethit eq 1 || $pethit2 eq 0){
			$petradio="<input type=\"radio\" value=\"5\" name=\"changeitem\">更改「<font color=blue>$mpetname</font>」名稱（２～８文字）<br>";
		}
	}

	&header;
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">改名神殿</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></td>
				<td bgcolor="#330000">
					<font color="#ffffcc">在這裏，你可以修改你的名字或寵物及特武的名字<br>
					(一次只能改一樣,請把要改名的寵物或自製武器拿著)。<br>寵物只可修改終階10級寵。<br>
					改名需要花費你手中的５０００萬。<br>請輸入你想要修改的名稱。</font>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					$STPR 
					<form action="./status.cgi" method="post">
					<input checked type="radio" value="1" name="changeitem">更改角色名稱（２～８文字）<br>
					$armradio
					$proradio
					$accradio
					$petradio
					<input type=text size=20 name=rname><br>
					<input type=hidden name=id value=$mid>
					<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
					<input type=hidden name=mode value=name_change2>
					<input type=submit value=確定改名 CLASS=FC></form>
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
