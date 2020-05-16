sub con_change2{
	&chara_open;
	&con_open;
	&town_open;

	if($con_id ne 0){&error("非無所屬國者不能入國。");}
	if($munit ne ""){&error("請先脫離隊伍。");}
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if("$con2_id" eq "$town_con"){$hit=1;last;}
	}
	if(!$hit){&error("請先移動到將要入國國家的領土上。");}

	open(IN,"./logfile/out/$mid.cgi");
	@DATA = <IN>;
	close(IN);

	foreach(@DATA){
		($dcon_id,$dtime)=split(/<>/);
		if("$dcon_id" eq "$town_con"){&error("曾被此國家解顧，無法再加入此國家。");}
	}

	$mcon=$town_con;
	&chara_input;
	
	&maplog("<font color=green>[入國]</font>恭喜<font color=blue>$mname</font>加入了<font color=$ELE_BG[$con2_ele]>$con2_name國($ELE[$con2_ele])</font>。");
	&kh_log("成為$con2_name國的國民。",$con2_name);

	&header;

	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">入國</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">已成功成為$con2_name國的國民。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
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
