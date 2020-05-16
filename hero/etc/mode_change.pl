sub mode_change{
	&chara_open;
	&ext_open;
	
	$selmode = ($ext_show_mode_maplog eq "N") ? "" : "checked" ;
	$selmode2 = ($ext_show_mode_guest eq "N") ? "" : "checked" ;

	&header;
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">顯示型態變更</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/town/machi.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">請選擇要變更的畫面型態。<br><br>預設畫面：原有的顯示畫面，不顯示世界地圖<br>世界地圖顯示：原有的顯示畫面，多了世界地圖的顯示<br>簡易畫面：原有的顯示晝面，少了城鎮情報顯示</font></td>
			</tr>
	　　 	<tr>
				<td colspan="2" align="right">
					<form action="./etc.cgi" method="POST">
						<input type="checkbox" name="modes2" value="Y" $selmode2>顯示目前參加者清單<br>
						<input type="checkbox" name="modes" value="Y" $selmode>顯示最近事件及戰鬥清單<br>
						選擇模式：
						<select name=pmode>
							<option value=1>預設畫面</option>
							<option value=0>世界地圖顯示</option>
							<option value=2>簡易畫面</option>
						</select>
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=mode_change2>
						<input type=submit class=FC value=開始變更>
					</form>
					<form action="./top.cgi" method="POST">
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=submit class=FC value=回到城鎮>
					</form>
				</td>
			</tr>
		</tbody>
	</ta>
EOF
	&mainfooter;
	exit;
}
1;
