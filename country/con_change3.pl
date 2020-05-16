sub con_change3{
	&chara_open;
	&con_open;
	&town_open;
	if($con_id eq 0){&error("無所屬國者無法進行下野。");}

	&header;
	
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">下野</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">你身上需要有５００萬才可以下野成為無所屬。<br>而你的名聲及能力將回到原點。<br>確定要下野？</font></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<form action="./country.cgi" method="post">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
						
						<input type=hidden name=mode value=con_change4>
						<input type=submit value=下野 CLASS=FC>
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
