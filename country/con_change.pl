sub con_change{
	&chara_open;
	&con_open;
	&town_open;
	if($con_id ne 0){&error("為無所屬身份才可入國。");}
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if("$con2_id" eq "$town_con"){$hit=1;last;}
	}
	if(!$hit){&error("請先移動到將要入國國家的領土上。");}

	&header;
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">入國</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">是否要加入$con2_name國？</font></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					$STPR 
					<form action="./country.cgi" method="post">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
						
						<input type=hidden name=mode value=con_change2>
						<input type=submit value=加入 CLASS=FC>
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
