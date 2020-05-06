sub king_com {
	&chara_open;
	&status_print;
	&con_open;

	if($con_id eq 0){&error("無所屬國無法進行");}
	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	$i=0;
	
	for($i=0;$i<6;$i++){
		$list[$i].="受任者：<select name=cand>";
		if($y_name[$i]){
			open(IN,"./logfile/chara/$y_chara[$i].cgi");
			@E_DATA = <IN>;
			close(IN);
			($eid,$epass,$ename,$eurl,$echara,$esex,$ehp,$emaxhp,$emp,$emaxmp,$eele,$estr,$evit,$eint,$efai,$edex,$eagi,$emax,$ecom,$egold,$ebank,$eex,$ecex,$eunit,$econ,$earm,$epro,$eacc,$etec,$esta,$epos,$emes,$ehost,$edate,$esyo,$eclass,$etotal,$ekati,$etype,$eoya,$esk,$eflg,$eflg2,$eflg3,$eflg4,$eflg5,$epet) = split(/<>/,$E_DATA[0]);
			if($y_chara[$i] eq "$eid"){
				$list[$i].="<option value=$eid selected>$ename";
			}
		}
	}
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			$datames = "查詢：$dir/$file<br>\n";
			if(!open(cha,"$dir/$file")){
				&error("找不到檔案：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
			if($con_id eq $rcon && $rcex>500 && $mid ne"$rid"){
				$ylist.="<option value=$rid>$rname";
			}
		}
		$mn++;
	}
	closedir(dirlist);

	for($i=0;$i<6;$i++){
		$ylist[$i].="</select><BR>";
		$ylist[$i].="官職名稱<input type=text size=10 name=yname value=$y_name[$i]><BR>";

		$list[$i].="$ylist $ylist[$i]<input type=hidden name=no value=$i>";
	}
	&header;
	
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">官職任命</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">本國官職人員最多可任命６人。<BR>任命者的名聲需要５００以上、官職名稱由國王命名。<BR>請選擇要任職的人員。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	<table class=TC width=80%>
	<tr><td colspan=6 align=center><font color=$FCOLOR2>任命</font></td></tr>
	<tr>
	<td bgcolor=$FCOLOR2 align=center><font color=$FCOLOR>官職１</font></td>
	<td bgcolor=$FCOLOR2 align=center><font color=$FCOLOR>官職２</font></td>
	<td bgcolor=$FCOLOR2 align=center><font color=$FCOLOR>官職３</font></td>
        <td bgcolor=$FCOLOR2 align=center><font color=$FCOLOR>官職４</font></td>
        <td bgcolor=$FCOLOR2 align=center><font color=$FCOLOR>官職５</font></td>
        <td bgcolor=$FCOLOR2 align=center><font color=$FCOLOR>官職６</font></td>
	</tr>
	<tr><td bgcolor=$FCOLOR2 align=center>
	<form action="./country.cgi" method="post">
	$list[0]
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=king_com2>
	<INPUT type=submit value=決定 CLASS=FC>
        <INPUT type=button value=取消官職 CLASS=FC onclick="javascript:clcom(0);">
	</td></form>
	<td bgcolor=$FCOLOR2 align=center>
	<form action="./country.cgi" method="post">
	$list[1]
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=king_com2>
	<INPUT type=submit value=決定 CLASS=FC>
        <INPUT type=button value=取消官職 CLASS=FC onclick="javascript:clcom(1);">
	</td></form>
	<td bgcolor=$FCOLOR2 align=center>
	<form action="./country.cgi" method="post">
	$list[2]
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=king_com2>
	<INPUT type=submit value=決定 CLASS=FC>
        <INPUT type=button value=取消官職 CLASS=FC onclick="javascript:clcom(2);">
	</td></form>
	<td bgcolor=$FCOLOR2 align=center>
        <form action="./country.cgi" method="post">
        $list[3]
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=king_com2>
        <INPUT type=submit value=決定 CLASS=FC>
	<INPUT type=button value=取消官職 CLASS=FC onclick="javascript:clcom(3);">
        </td></form>
        <td bgcolor=$FCOLOR2 align=center>
        <form action="./country.cgi" method="post">
        $list[4]
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=king_com2>
        <INPUT type=submit value=決定 CLASS=FC>
	<INPUT type=button value=取消官職 CLASS=FC onclick="javascript:clcom(4);">
        </td></form>
        <td bgcolor=$FCOLOR2 align=center>
        <form action="./country.cgi" method="post">
        $list[5]
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=king_com2>
        <INPUT type=submit value=決定 CLASS=FC>
	<INPUT type=button value=取消官職 CLASS=FC onclick="javascript:clcom(5);">
        </td></form>
        <form action="./country.cgi" method="post" id="clf">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=king_com2>
	<input type=hidden name=no>
	</form>
</tr>
	</table>
$BACKTOWNBUTTON
      </TD>
    </TR>
  </TBODY>
</TABLE>
<script language="javascript">
function clcom(ino){
	document.getElementById('clf').no.value=ino;
	document.getElementById('clf').submit();
}
</script>
<center>$STPR</center>
EOF

	&footer;
	exit;
}
1;
