sub prof_write{
	&chara_open;
    	
	if(length($in{'message'}) > 1000) { &error("自傳內容太長，請少於５００個字"); }

	open(OUT,">./logfile/prof/$mid.cgi");
	print OUT $in{'message'};
	close(OUT);

	&header;
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">更新自傳</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/house.jpg"></td>
				<td bgcolor="#000000"><font color="#ffffcc">你的自傳已更新完成。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<form action="./status.cgi" method="post">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=prof_edit>
						<input type=submit CLASS=FC value="回到自傳">
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
