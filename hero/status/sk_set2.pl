sub sk_set2{
	&chara_open;
	if($in{'skill'} eq ""){&error("請選擇要變更的奧義項目。");}
	if($in{'type'} ne "1"  && $in{'type'} ne "2"){&error("請選擇要變更的奧義位置。");}
	($msk[0],$msk[1]) = split(/,/,$msk);

	open(IN,"./logfile/ability/$mid.cgi");
	@ABDATA = <IN>;
	close(IN);

	$hit=0;
	foreach(@ABDATA){
		($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
		if($kabno eq $in{'skill'}){
			$hit=1;
			last
		}
	}
	if(!$hit){&error("尚未習得此奧義");}
	
	if($in{'type'} eq "1"){
		if($in{'skill'} eq"103"){&error("十字封印無法裝在主奧義！");}
		$msk="$in{'skill'},$msk[1]";
	}elsif($in{'type'} eq "2"){
		$msk="$msk[0],$in{'skill'}";
	}
	&chara_input;
	
	&header;
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">奧義變更</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">已成功變更了奧義。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<form action="./status.cgi" method="POST">
				<input type=hidden name=id value=$mid>
				<input type=hidden name=pass value=$mpass>
				<input type=hidden name=rmode value=$in{'rmode'}>
				<input type=hidden name=mode value=sk_set>
				<input type=submit CLASS=FC value=回奧義變更畫面></form>
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
