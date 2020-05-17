sub skill2{
	&chara_open;
	if($in{'skill'} eq ""){&error("請選擇要修練的奧義。");}
	
	require './data/abini.cgi';
	@jlist = split(/,/,$AJOB[$mclass]);

	foreach $job(@jlist){
		$jobflg[$job] = 1;
	}

	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);
	foreach(@ABILITY){
		($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
		if($abno eq $in{'skill'}){
			if($jobflg[$abclass] ne 1){&error("無法修煉此奧義");}
			$hit=1;
			$mabp-=$abpoint;
			if($mabp < 0){&error("你的熟練度不足。");}
			
			open(IN,"./logfile/ability/$mid.cgi");
			@ABDATA = <IN>;
			close(IN);
			foreach(@ABDATA){
				($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
				if($kabno eq $abno){&error("你已經學習過此奧義。");}
			}
			push(@ABDATA,"$abno<>$abname<>$abcom<>$abdmg<>$abrate<>$abpoint<>$abclass<>$abtype<>l<>e<>\n");
			open(OUT,">./logfile/ability/$mid.cgi");
			print OUT @ABDATA;
			close(OUT);
			last;
		}
	}
	if(!$hit){&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}

	&chara_input;

	&header;
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">奧義修行</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></td>
				<td bgcolor="#330000"><font color=#AAAAFF>$mname</font> <font color="#ffffcc">已學得</font> <font color=red>$abname</font>。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<form action="./status.cgi" method="POST">
				<input type=hidden name=id value=$mid>
				<input type=hidden name=pass value=$mpass>
				<input type=hidden name=rmode value=$in{'rmode'}>
				<input type=hidden name=mode value=skill>
				<input type=submit class=FC value=回到奧義取得/修行畫面></form></td>
			</tr>
		</tbody>
	</table>
EOF

	&footer;
	exit;
}
1;
