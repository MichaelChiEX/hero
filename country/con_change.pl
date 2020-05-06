sub con_change{
	&chara_open;
	&con_open;
	&town_open;
	if($con_id ne 0){&error("為無所屬身份才可任官。");}
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if("$con2_id" eq "$town_con"){$hit=1;last;}
	}
	$ccount=@CON_DATA;
	$ccount--;
	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	$i=0;	
	$mn++;
	while($file = readdir(dirlist)){
	        if($file =~ /\.cgi/i){
	                $datames = "查詢：$dir/$file<br>\n";
	                if(!open(cha,"$dir/$file")){
	                        &error("$dir/$fileがみつかりません。<br>\n");
	                }
	                @cha = <cha>;
	                close(cha);
	                $list[$i]="$file";
	                ($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon) = split(/<>/,$cha[0]);

	                $KOKUMIN[$rcon]++;
	        }
	        $mn++;
	        if($mn>10000){&error("ループ");}
	}
	$ccount=int($mn/$ccount);
	if($KOKUMIN[$con2_id]>=$ccount){
		&error("本國家目前人數$KOKUMIN[$con2_id],已超過目前國家人數上限$ccount人");
	}
	if(!$hit){&error("需要移動到將任官的國家才可進行任官。");}
	if($town_con eq 0){&error("無法對此國家任官。");}

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">入國</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">是否要加入$con2_name國？</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR 
	<form action="./country.cgi" method="post">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=con_change2>
	<INPUT type=submit value=加入 CLASS=FC></form>
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
