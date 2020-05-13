sub kunren {
	&chara_open;
	&status_print;
	&con_open;
	if($con_id eq 0){&error("無所屬者無法參加。");}

	&header;
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">訓練</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/town/machi.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">與本國角色進行訓練。<br>請選擇要與自己訓練的對象。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					$STPR
					<form action="./battle.cgi" method="post">
						輸入訓練對象名稱：<input type=text name=player>
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=kunren2>
						<input type=submit value=訓練 CLASS=FC></form>
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
