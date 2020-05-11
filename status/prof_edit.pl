sub prof_edit {
	&chara_open;
    	
	open(IN,"./logfile/prof/$mid.cgi");
	@PROF_DATA = <IN>;
	close(IN);

	&header;
	print <<"EOM";
	<table class=TC width="100%" height=100%>
		<tbody>
			<tr>
				<td bgcolor=$FCOLOR width=100% height=5 align=center><font color=$FCOLOR2 size=4>＜＜<B> * 更新自傳 *</B>＞＞</font></td>
			</tr>
			<tr>
				<td height="5">
					<table border="0" width=100%>
						<tr><td>
							<img src=\"$IMG/etc/machi.jpg\"></td><td width="100%" bgcolor=000000>
							<font color=ffffff>在此可以隨時更新自傳。<BR>可以輸入你要大家點閱你時可以看到的內容，請不要輸入不雅的字眼。</font>
						</td></tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width=100% align=center bgcolor=$FCOLOR2>
					$BACKTOWNBUTTON
				</td>
			</tr>
			<tr>
				<td colspan=2 bgcolor=$FCOLOR2 align=center>
					<table class=TC width=80%>
						<tr>
							<td align=center><font color=$FCOLOR2>$mname的自傳</font></td>
						</tr>
						<tr>
							<td bgcolor=000000><font color=$FCOLOR2>@PROF_DATA</font></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align=center bgcolor=$FCOLOR2>
					<br>
					<form action="./status.cgi" method="post">
						請輸入自傳內容：<BR>
						<textarea name=message cols=50 rows=10></textarea>
						<img src="$IMG/chara/$mchara.gif">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=prof_write>
						<input type=submit class=MFC value="更新自傳">
					</form>
				</td>
			</tr>
		</tbody>
	</table>
EOM

	&footer;
	exit;
}
1;
