sub money_send {
	&chara_open;
	&status_print;
	&con_open;

	&header;
	
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">傳送金錢</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></td>
				<td bgcolor="#330000">
					<font color="#ffffcc">將銀行內的存款傳送給其他玩家。<br>
					請輸入傳送對象及傳送的金額。<br>（你必須１００戰以上才能傳送，對方需要５００戰以上才可接收）</font>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				$STPR 
				<form action="./status.cgi" method="post">
				接收者名稱：<input type=text name=player>
				<!--<select name=player>
				$plist
				</select>-->
				<br>
				金額：<input type=text size=10 name=gold>萬<br>
				<input type=hidden name=id value=$mid>
				<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
				<input type=hidden name=mode value=money_send2>
				<input type=submit value=傳送金錢 CLASS=FC></form>
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
