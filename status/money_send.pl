sub money_send {
	&chara_open;
	&status_print;
	&con_open;

	#$dir="./logfile/chara";
	#opendir(dirlist,"$dir");
	#$i=0;
	#while($file = readdir(dirlist)){
	#	if($file =~ /\.cgi/i){
	#	$datames = "查詢：$dir/$file<br>\n";
	#		if(!open(cha,"$dir/$file")){
	#			&error("找不到檔案：$dir/$file。<br>\n");
	#		}
	#		@cha = <cha>;
	#		close(cha);
	#		$list[$i]="$file";
	#		($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
	#		$clist[$rcon].="<option value=$rid>$rname";
	#	}
	#	$mn++;
	#}
	#closedir(dirlist);
		
	#foreach(@CON_DATA){
	#	($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
	#	$plist.="<option value=\"\">★★★$con2_name國★★★";
	#	$plist.="$clist[$con2_id]";
	#}
	#$plist.="<option value=\"\">★★★無所屬★★★";
	#$plist.="$clist[0]";

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">傳送金錢</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">將銀行內的存款傳送給其他玩家。<BR>請輸入傳送對象及傳送的金額。<BR>（你必須１００戰以上才能傳送，對方需要５００戰以上才可接收）</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR 
	<form action="./status.cgi" method="post">
	接收者名稱：<input type=text name=player>
	<!--<select name=player>
	$plist
	</select>-->
	<BR>
	金額：<INPUT type=text size=10 name=gold>萬<BR>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=money_send2>
	<INPUT type=submit value=傳送金錢 CLASS=FC></form>
$BACKTOWNBUTTON
       </TD>	
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF

	&footer;
	exit;
}
1;
