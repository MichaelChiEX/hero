sub change {
	&chara_open;
	&status_print;
	&ext_open;

	open(IN,"./data/class.cgi");
	@CLASS_DATA = <IN>;
	close(IN);
	($ext_tl_chara,$ext_tl_name,$ext_tl_month,$ext_tl_type[0],$ext_tl_type[1],$ext_tl_type[2],$ext_tl_type[3],$ext_tl_type[4],$ext_tl_type[5],$ext_tl_king,$ext_tl_lose,$ext_tl_lvup,$ext_tl_gift,$ext_tl_mix,$ext_tl_rshop,$ext_tl_goditem)=split(/,/,$ext_total);	
	
	open(IN,"./logfile/job/$mid.cgi");
	@JOB_DATA = <IN>;
	close(IN);
	@job = split(/<>/,$JOB_DATA[0]);

	for($j=0; $j<=$#CLASS_DATA; $j++){
		($cname,$cjp,$cnou,$cup,$cflg,$ctype)=split(/<>/, @CLASS_DATA[$j]);
		($cjp[0],$cjp[1],$cjp[2],$cjp[3],$cjp[4],$cjp[5]) = split(/,/,$cjp);
		($cp[0],$cp[1],$cp[2],$cp[3],$cp[4],$cp[5]) = split(/,/,$cnou);
		if($mjp[0] >= $cjp[0] && $mjp[1] >= $cjp[1] && $mjp[2] >= $cjp[2] && $mjp[3] >= $cjp[3] && $mjp[4] >= $cjp[4] && $mjp[5] >= $cjp[5]
		&& $mstr >= $cp[0] && $mvit >= $cp[1] && $mint >= $cp[2] && $mfai >= $cp[3] && $mdex >= $cp[4] && $magi >= $cp[5] ){
			$jobtable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=job value=$j></td><td bgcolor=$FCOLOR2>$cname</td><td bgcolor=$FCOLOR2>$TYPE[$ctype]</td><td bgcolor=$FCOLOR2 align=right>$job[$j]</td></tr>";
		}
	}

	&header;
	
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">轉職神殿</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc"><font color=#AAAAFF>$mname</font> 現在位於神聖的轉職神殿。<br>請選擇你要轉職的職業？</font></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					$STPR 
					<br>
					本月總升級次數:<font color=red><b>$ext_tl_lvup</b></font>、
					$TYPE[0]戰數:<font color=red><b>$ext_tl_type[0]</b></font>、
					$TYPE[4]戰數:<font color=red><b>$ext_tl_type[4]</b></font>、
					$TYPE[1]戰數:<font color=red><b>$ext_tl_type[1]</b></font>、
					$TYPE[2]戰數:<font color=red><b>$ext_tl_type[2]</b></font>、
					$TYPE[3]戰數:<font color=red><b>$ext_tl_type[3]</b></font>、
					$TYPE[5]戰數:<font color=red><b>$ext_tl_type[5]</b></font>
					<br>
					<table border=0 width="100%" bgcolor=$FCOLOR class=TC>
						<tr>
							<td colspan=6 align=center><font color=ffffcc>目前可轉職業一覽</font></td>
						</tr>
						<tr>
							<td bgcolor=ffffcc></td><td bgcolor=$FCOLOR2 align=center>職業</td>
							<td bgcolor=$FCOLOR2 align=center>類型</td>
							<td bgcolor=$FCOLOR2 align=center>熟練度</td>
						</tr>
						<form action="./status.cgi" method="post">
						$jobtable
						<tr>
							<td colspan=7 align=center bgcolor="ffffff">
								<input type=hidden name=id value=$mid>
								<input type=hidden name=pass value=$mpass>
								<input type=hidden name=rmode value=$in{'rmode'}>
								<input type=hidden name=mode value=change2>
								<input type=submit class=FC value=轉職>
							</td>
						</tr>
						</form>
					</table>
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
