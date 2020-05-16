sub mode_change2{
	&chara_open;
	&ext_open;
	$mflg="$in{'pmode'}";
	
	$ext_show_mode_maplog = ($in{'modes'} eq "Y") ? "Y" : "N";
	$ext_show_mode_guest = ($in{'modes2'} eq "Y") ? "Y" : "N";
	
	&chara_input;
	&ext_input;
	
	&header;
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">顯示型態變更</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/town/machi.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">畫面顯示型態變更完成。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<form action="./top.cgi" method="POST">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=submit class=FC value=回到城鎮>
					</form>
				</td>
			</tr>
		</tbody>
	</table>
EOF
	&mainfooter;
	exit;
}
1;
