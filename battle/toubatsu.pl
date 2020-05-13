sub toubatsu {
	&chara_open;
	&status_print;
	&con_open;
	
	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			if(!open(cha,"$dir/$file")){
				&error("$dir/$file開啟錯誤。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
			if($rcon eq 0){$klist.="<option value=$rid>$rname</option>";}
		}
	}
	closedir(dirlist);
	
	$plist.="<option value=\"\">★★★選擇討伐對象★★★</option>";
	$plist.="$klist";
	
	&header;
	print <<"EOF";
	<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" class=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">討伐</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/town/machi.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">對無所屬國的角色進行討伐。<br>請選擇要討伐的對手。</font></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					$STPR 
					<form action="./battle.cgi" method="post">
						<select name=player>
							$plist
						</select>
						<br>
						<input type=hidden name=id value=$mid>
						<input type=hidden name=pass value=$mpass>
						<input type=hidden name=rmode value=$in{'rmode'}>
						<input type=hidden name=mode value=toubatsu2>
						<input type=submit value=討伐 class=FC></form>
					</form>
					$BACKTOWNBUTTON
				</td>	
			</tr>
		</tr>
	</table>
EOF

	&footer;
	exit;
}
1;
