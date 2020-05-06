sub mode_change{
	&header;
	&chara_open;
	&ext_open;
	$selmode="";$selmode2="";
	if($ext_show_mode_maplog eq"" || $ext_show_mode_maplog eq"Y"){$selmode="checked";}
        if($ext_show_mode_guest eq"" || $ext_show_mode_guest eq"Y"){$selmode2="checked";}
	$list.="<option value=1>預設畫面";
	$list.="<option value=0>世界地圖顯示";
	$list.="<option value=2>簡易畫面";
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">顯示型態變更</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/town/machi.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">請選擇要變更的畫面型態。<BR><br>預設畫面：原有的顯示畫面，不顯示世界地圖<BR>世界地圖顯示：原有的顯示畫面，多了世界地圖的顯示<BR>簡易畫面：原有的顯示晝面，少了城鎮情報顯示</FONT></TD>
    </TR>
　　<TR>
      <TD colspan="2" align="right">
	<form action="./etc.cgi" method="POST">
<input type="checkbox" name="modes2" value="Y" $selmode2>顯示目前參加者清單<BR>
<input type="checkbox" name="modes" value="Y" $selmode>顯示最近事件及戰鬥清單<BR>
	選擇模式：<select name=pmode>
	$list
	</select>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=mode_change2>
	<INPUT type=submit CLASS=FC value=開始變更></form>
　　　
	<form action="./top.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=submit CLASS=FC value=回到城鎮></form>
　　　</TD>
    </TR>
  </TBODY>
</TABLE>
EOF
	&mainfooter;
	exit;
}
1;
