sub toubatsu {
	&chara_open;
	&status_print;
	&con_open;
#	if($con_id eq 0){&error("無所屬國無法參加。");}
	
	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	$i=0;
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			$datames = "查詢：$dir/$file<br>\n";
			if(!open(cha,"$dir/$file")){
				&error("$dir/$file開啟錯誤。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
			if($rcon eq 0){$klist.="<option value=$rid>$rname";}
		}
		$mn++;
	}
	closedir(dirlist);
		
	$plist.="<option value=\"\">★★★選擇討伐對象★★★";
	$plist.="$klist";
	
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">討伐</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/town/machi.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">對無所屬國的角色進行討伐。<BR>請選擇要討伐的對手。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR 
	<select name=player>
	$plist
	</select>
	<BR>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=toubatsu2>
	
	<INPUT type=submit value=討伐 CLASS=FC></form>
	</form>
$BACKTOWNBUTTON
       </TD>	
	</TR></font>
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF

	&footer;
	exit;
}
1;
