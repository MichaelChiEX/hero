sub sk_set {
	&chara_open;
	&status_print;

	#アビリティ情報
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);

	#取得済みアビリティ情報
	open(IN,"./logfile/ability/$mid.cgi");
	@ABDATA = <IN>;
	close(IN);

	($msk[0],$msk[1]) = split(/,/,$msk);

	require './data/abini.cgi';
	@jlist = split(/,/,$AJOB[$mclass]);
	foreach $job(@jlist){
		$jobflg[$job] = 1;
	}

	foreach(@ABILITY){
		($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
		if($msk[0] eq $abno){
			$abname1=$abname;
			$abcom1=$abcom;
		}
		if($msk[1] eq $abno){
			$abname2=$abname;
			$abcom2=$abcom;
		}
		foreach(@ABDATA){
			($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
			if($kabno eq $abno){
				if($ab1[$kabtype] eq"" || $ab1[$kabtype]<$kabdmg){
					$ab1[$kabtype]=$kabdmg;
				}
			}
			if($kabno eq $abno && $jobflg[$abclass] eq 1){
				if($ab2[$kabtype] eq"" || $ab2[$kabtype]<$kabdmg){
					$ab2[$kabtype]=$kabdmg;
				}
			}
		}
	}
	foreach(@ABILITY){
		($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
		if($ab1[$abtype] ne"" && $ab1[$abtype] eq "$abdmg" && $abno ne"103"){
			if($abno eq"55" || $abno eq"83" || $abno eq"87" || $abtype eq "21"){
				$input = "不需安裝";
			}else{
				$input = "<input type=radio name=skill value=$abno>";
			}
			$abtable.="<tr><td width=5% bgcolor=ffffcc align=center>$input</td><td bgcolor=$FCOLOR2>$abname</td><td bgcolor=$FCOLOR2>$abcom</td></tr>";
		}
		if($ab2[$abtype] ne"" && $ab2[$abtype] eq "$abdmg"){
			if($abno eq"55" || $abno eq"83" || $abno eq"87" || $abtype eq "21"){
				$input = "不需安裝";
			}else{
				$input = "<input type=radio name=skill value=$abno>";
			}
			$abtable2.="<tr><td width=5% bgcolor=ffffcc align=center>$input</td><td bgcolor=$FCOLOR2>$abname</td><td bgcolor=$FCOLOR2>$abcom</td></tr>";
		}
						
	}
	&header;
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">奧義變更</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></td>
				<td bgcolor="#330000">
					<font color="#ffffcc" size=2>
					你好<font color=blue>$mname</font>。在這裡能進行奧義的變更。請選擇要變更的奧義。
					<br>主要奧義可選擇你所有曾經學過的奧義，職業奧義只能選擇你目前職業可用的奧義。
					<br><font color="red">※請特別注意在同時設定兩種相同的奧義、或者是同一系列的奧義，會有無法執行的狀況！</font>
					</font>
		　　　	 </td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					$STPR 
					<table border=0 width="100%" bgcolor=$FCOLOR class=TC>
						<tr>
							<td colspan=6 align=center><font color=ffffcc>主要奧義</font></td>
						</tr>
						<tr>
							<td bgcolor=ffffcc></td><td bgcolor=$FCOLOR2 align=center>名稱</td><td bgcolor=$FCOLOR2 align=center>效果</td>
						</tr>
						<tr>
							<td width=5% bgcolor=ffcc99 align=center>目前裝備</td><td bgcolor=ee9999>$abname1</td><td bgcolor=ee9999>$abcom1</td>
						</tr>
						<form action="./status.cgi" method="post">
						$abtable
						<tr>
							<td colspan=7 align=center bgcolor="ffffff">
								<input type=hidden name=id value=$mid>
								<input type=hidden name=pass value=$mpass>
								<input type=hidden name=rmode value=$in{'rmode'}>
								<input type=hidden name=mode value=sk_set2>
								<input type=hidden name=type value=1>
								<input type=submit class=FC value=變更主要奧義>
							</td>
						</tr>
						</form>
					</table>
					<table border=0 width="100%" bgcolor=$FCOLOR class=TC>
						<tr>
							<td colspan=6 align=center><font color=ffffcc>職業奧義</font></td>
						</tr>
						<tr>
							<td bgcolor=ffffcc></td><td bgcolor=$FCOLOR2 align=center>名稱</td><td bgcolor=$FCOLOR2 align=center>效果</td>
						</tr>
						<tr>
							<td width=5% bgcolor=ffcc99 align=center>目前裝備</td><td bgcolor=ee9999>$abname2</td><td bgcolor=ee9999>$abcom2</td>
						</tr>
						<form action="./status.cgi" method="post">
						$abtable2
						<tr>
							<td colspan=7 align=center bgcolor="ffffff">
								<input type=hidden name=id value=$mid>
								<input type=hidden name=pass value=$mpass>
								<input type=hidden name=rmode value=$in{'rmode'}>
								<input type=hidden name=mode value=sk_set2>
								<input type=hidden name=type value=2>
								<input type=submit class=FC value=變更職業奧義>
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
