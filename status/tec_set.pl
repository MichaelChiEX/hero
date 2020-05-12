sub tec_set {
	&chara_open;
	&header;
	&status_print;

	($mtec1,$mtec2,$mtec3,$mprate,$hprate)=split(/,/,$mtec);

	open(IN,"./data/tec.cgi");
	@TEC = <IN>;
	close(IN);

	require './data/abini.cgi';
	@jlist = split(/,/,$AJOB[$mclass]);

	foreach $job(@jlist){
		$jobflg[$job] = 1;
	}

	$teclist1="<select name=tec1>";
	$teclist2="<select name=tec2>";
	$teclist3="<select name=tec3>";

	($tecname,$tecdmg,$tecrate,$tecmp,$tecab,$tecsta,$tecclass)=split(/<>/,$TEC[$mtec1]);
	if($tecname){$teclist1.="<option value=$mtec1>$tecname（威力：$tecdmg 機率：$tecrate 消費：$tecmp）";}
	($tecname,$tecdmg,$tecrate,$tecmp,$tecab,$tecsta,$tecclass)=split(/<>/,$TEC[$mtec2]);
	if($tecname){$teclist2.="<option value=$mtec2>$tecname（威力：$tecdmg 機率：$tecrate 消費：$tecmp）";}
	($tecname,$tecdmg,$tecrate,$tecmp,$tecab,$tecsta,$tecclass)=split(/<>/,$TEC[$mtec3]);
	if($tecname){$teclist3.="<option value=$mtec3>$tecname（威力：$tecdmg 機率：$tecrate 消費：$tecmp）";}
	
	for($j=0; $j<=$#TEC; $j++){
		($tecname,$tecdmg,$tecrate,$tecmp,$tecab,$tecsta,$tecclass)=split(/<>/, @TEC[$j]);
		($str,$vit,$int,$fai,$dex,$agi)=split(/,/,$tecab);
		if(($jobflg[$tecclass] && $tecclass ||$tecclass eq"all") && $mstr>$str && $mvit>$vit && $mint>$int && $mfai>$fai && $mdex>$dex && $magi>$agi){
			$teclist.="<option value=$j>$tecname（威力：$tecdmg 機率：$tecrate 消費：$tecmp）</option>";
		}
	}
	$teclist.="</select><br>";

	$teclist1.="$teclist";
	$teclist2.="$teclist";
	$teclist3.="$teclist";

	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">技能變更</FONT></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/house.jpg"></td>
				<td bgcolor="#330000"><FONT color="#ffffcc">戰鬥時的技能變更。<br>請個別在以下三個發動條件選擇技能。<br>技能修件的發動優先權為：條件三＞條件二＞條件一。</FONT></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					$STPR 
					<form action="./status.cgi" method="post">
						<table border=0 class=FC>
							<tbody>
								<tr><td>條件一：</td><td>通常</td><td>$teclist1</td></tr>
								<tr><td>條件二：</td><td>ＭＰ於<input type=text size=5 name=mprate value=$mprate>％以下時</td><td>$teclist2</td></tr>
								<tr><td>條件三：</td><td>ＨＰ於<input type=text size=5 name=hprate value=$hprate>％以下時</td><td>$teclist3</td></tr>
							</tbody>
						</table>
						戰鬥宣言：<input type=text size=50 name=bcom value=$mcom><br>
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=tec_set2>
						<input type=submit value=變更確認 class=FC>
					</form>
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
