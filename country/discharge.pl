sub discharge {
	&chara_open;
	&status_print;
	&con_open;

	if($con_id eq 0){&error("無所屬者無法進行解雇。");}
	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	$i=0;
	
	$list.="請選擇要解雇的人員：<select name=cand>";
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			$datames = "查詢：$dir/$file<br>\n";
			if(!open(cha,"$dir/$file")){
				&error("找不到檔案：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
			if($con_id eq $rcon && $rid ne"$con_king" && $mid ne"$rid"){
				$list.="<option value=$rid>$rname";
			}
		}
		$mn++;
	}
	closedir(dirlist);

	
	$list.="</select><BR>";
	$list.="<input type=hidden name=no value=$i>";

	&header;
	
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">解雇</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">在此進行解雇。<BR>只有國王或官員可以進行解雇(需要消費１００點名聲)。<BR>被解雇的人將無法再次加入$con_name國、並且名聲歸０。<BR>請選擇要解雇的對象。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	<table class=TC width=80%>
	<tr><td align=center><font color=$FCOLOR2>解雇</font></td></tr>
	<tr>
	<td bgcolor=$FCOLOR2 align=center><font color=$FCOLOR>名單</font></td>
	</tr>
	<tr><td bgcolor=$FCOLOR2 align=center>
	<form action="./country.cgi" method="post">
	$list
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=discharge2>
	<INPUT type=submit value=決定 CLASS=FC>
	</td></form>
	</tr>
	</table>
$BACKTOWNBUTTON
      </TD>
    </TR>
  </TBODY>
</TABLE>
<center>$STPR</center>
EOF

	&footer;
	exit;
}
1;
