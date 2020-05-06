#_/_/_/_/_/_/_/_/_/#
#_/    プロフィール    _/#
#_/_/_/_/_/_/_/_/_/#

sub prof_edit {

	&chara_open;
	&con_open;
    	
	open(IN,"./logfile/prof/$mid.cgi");
	@PROF_DATA = <IN>;
	close(IN);

	if(@PROF_DATA == ()){
		$com1="";
		$com2="";
	}
	else{
		$com2="@PROF_DATA";
	}
	&header;
	print <<"EOM";
<TABLE CLASS=TC WIDTH="100%" height=100%>
<TBODY><TR>
<TD BGCOLOR=$FCOLOR WIDTH=100% height=5 align=center><font color=$FCOLOR2 size=4>＜＜<B> * 更新自傳 *</B>＞＞</font></TD>
</TR><TR>
<TD height="5">
<TABLE border="0" width=100%><TBODY>
<TR><TD><img src=\"$IMG/etc/machi.jpg\"></TD><TD width="100%" bgcolor=000000><font color=ffffff>在此可以隨時更新自傳。<BR>可以輸入你要大家點閱你時可以看到的內容，請不要輸入不雅的字眼。</font></TD>
</TR>
</TBODY></TABLE>
</TD>
</TR><TR>
<TD WIDTH=100% align=center bgcolor=$FCOLOR2>
$BACKTOWNBUTTON
</TD>
</TR>
<TR>
<td colspan=2 bgcolor=$FCOLOR2 align=center>
<table CLASS=TC width=80%>
<tr>
<TD align=center><font color=$FCOLOR2>$mname的自傳</font></TD>
</tr>
<tr>
<TD bgcolor=000000><font color=$FCOLOR2>$com2</font></TD>
</tr>
</table>
</td>
</TR>
<TR>
<TD align=center bgcolor=$FCOLOR2>

<br><form action="./status.cgi" method="post">
請輸入自傳內容：<BR>
<textarea name=message cols=50 rows=10>$com1
</TEXTAREA> <img src="$IMG/chara/$mchara.gif"><p>
<input type=hidden name=id value=$mid>
<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
<input type=hidden name=mode value=prof_write>
<input type=submit CLASS=MFC value="更新自傳">
</form>
</font>

</CENTER>
</TD>
</TR>
</TBODY></TABLE>
EOM

	&footer;
	exit;
}
1;
