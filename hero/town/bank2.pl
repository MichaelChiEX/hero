sub bank2{
	&chara_open;
	
	if($in{'azuke'} eq "" && $in{'hiki'} eq ""){&error("請輸入金額。");}
	if($in{'azuke'} =~ m/[^0-9]/ || $in{'hiki'} =~ m/[^0-9]/){&error("請輸入正確的金額。");}
	if($in{'azuke'} <0 || $in{'hiki'} < 0){&error("請輸入正確的金額。");}

	if($in{'mode'} eq"banka"){
		$com="存入";
		$gold=$in{'azuke'}*10000;
		$mgold-=$gold;
		if($mgold<0){&error("所持金不足。");}
		$mbank+=$gold;
		&ext_open;
		&quest_open;
		if($quest2_town_no eq $mpos && $quest2_limit_time>$date && $quest2_count<10){
			$quest2_count=0;
		}
		&quest_input;
		&ext_input;
	}elsif($in{'mode'} eq"bankh"){
		$com="取出";
		$gold=$in{'hiki'}*10000;
		$mgold+=$gold;
		$mbank-=$gold;
		if($mbank<0){&error("銀行的資金不足。");}
	}elsif($in{'mode'} eq"bankall"){
		$com="存入";
		if($mgold<0){&error("所持金不足。");}
		$gold=$mgold;
		$mbank+=$gold;
		$mgold=0;
		&ext_open;
		&quest_open;
		if($quest2_town_no eq $mpos && $quest2_limit_time>$date && $quest2_count<10){
			$quest2_count=0;
		}
		&quest_input;
		&ext_input;
	}elsif($in{'mode'} eq"bankhall"){
		$com="取出";
		$gold=$in{'azuke'};
		if($mbank<$gold){&error("銀行的資金不足。");}
		$mbank=0;
		$mgold+=$gold;	
	}else{&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	
	&header;
	
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">銀行</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">$gold Gold$com。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					$BACKTOWNBUTTON
				</td>
			</tr>
		</tbody>
	</table>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
