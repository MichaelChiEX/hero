sub con_conv {
	&chara_open;
	&con_open;
	&town_open;
	&header;
	&status_print;
	if($con_id eq "0"){&error("無所屬國無法進行留言。");}

	open(IN,"./blog/conv/$con_id.cgi");
	@CONV_DATA = <IN>;
	close(IN);

	$no=0;
	foreach(@CONV_DATA){
		($lid,$lname,$lchara,$lcon,$ltitle,$lmes,$letc,$lhost,$ldaytime)=split(/<>/);
		if($ltitle ne""){
			if($no>0){
				$conv.="<tr><td colspan=3 width=100% bgcolor=$ELE_C[$mcon] align=right><form action=\"./country.cgi\" method=\"post\">訊息：<textarea name=\"message\" cols=\"40\" rows=\"2\"></TEXTAREA>";
				$conv.="<input type=submit CLASS=MFC value=回覆><input type=hidden name=bbs value=con><input type=hidden name=resno value=$resno><input type=hidden name=id value=$mid><input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}><input type=hidden name=mode value=conv_write></td></tr></form>";
				$conv.="</table><br>";
			}
			$resno=$no;
			$bbsno=$resno+1;
			$conv.="<table border=0 bgcolor=000000 width=90%>";
			$conv.="<tr><td colspan=3 width=100% bgcolor=$ELE_BG[$lcon]><font color=$ELE_C[$lcon]>●$ltitle</font></td></tr>";
			$conv.="<tr><td width=10% bgcolor=$ELE_BG[$lcon]><img src=\"$IMG/chara/$lchara.gif\"></td><td colspan=2 align=left bgcolor=$ELE_C[$lcon] width=85% height=50><font color=000000>$lmes<br>($ldaytime $letc $lname)</b></font></td></tr>";
		}
		else{
			$conv.="<tr><td colspan=2 align=left bgcolor=$ELE_C[$lcon] width=85% height=50><font color=000000>$lmes<br>($ldaytime $letc $lname)</b></font></td><td width=10% bgcolor=$ELE_BG[$lcon]><img src=\"$IMG/chara/$lchara.gif\"></td></tr>";
		}
		$no++;
	}
	if($no>0){
		$conv.="<tr><td colspan=3 width=100% bgcolor=$ELE_C[$mcon] align=right><form action=\"./country.cgi\" method=\"post\">メッセージ：<textarea name=\"message\" cols=\"40\" rows=\"2\"></TEXTAREA>";
		$conv.="<input type=submit CLASS=MFC value=回覆><input type=hidden name=bbs value=con><input type=hidden name=resno value=$resno><input type=hidden name=id value=$mid><input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}><input type=hidden name=mode value=conv_write></td></tr></form>";
		$conv.="</table><br>";
	}
	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">$con_name國廣場</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">$con_name國留言板。<br>$con_name國的廣場人來人往。<br>這裏是大家歇腳的地方，在水池的旁邊就是國家的留言板。<br>有什麼話要跟國人說的，可以在此留話。</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
$BACKTOWNBUTTON
	<br><form action="./country.cgi" method="post">
	標題：<input type=text name=title><br>
	<img src="$IMG/chara/$mchara.gif">
	<textarea name="message" cols="40" rows="4"></TEXTAREA><br>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=conv_write>
	<input type=hidden name=type value=1>
	<input type=hidden name=bbs value=con>
	<input type=submit value=留言 CLASS=MFC></form>

	<form action="./country.cgi" method="POST">
	$conv
	</form>
$BACKTOWNBUTTON
     </td>
    </tr>
  </tbody>
</table>
<center></center>
EOF
	&footer;
	exit;
}
1;
