sub rule_write {
	&chara_open;
	&header;
	&status_print;
	&con_open;
	&town_open;
	&time_data;

	if($in{'message'} eq ""){&error("請輸入要法規的訊息。");}
	if(length($in{'message'}) > 400){&error("法規訊息請不要超過１００個字。");}
	if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){&error("無官職者無法實行。");}
	
	if($in{'type'} eq 1){
		$BFILE="./blog/rule/$con_id.cgi";
		$rule="rule";
	}elsif($in{'type'} eq 2){
		if($con_king ne $mid && $mid ne $GMID){&error("國王以外的人無法進行此操作。");}
		$BFILE="./blog/rule/0.cgi";
		$rule="all_rule";
	}else{&error("xxxxxxxxxx。");}
	open(IN,"$BFILE");
	@BBS_DATA = <IN>;
	close(IN);
	
	if($con_king eq $mid){$etc="$con_name 國王";}
	$bcount=@BBS_DATA;
	if($bcount>=20){&error("法規數已達上限２０篇，無法再新增。");}
	unshift(@BBS_DATA,"$mid<>$mname<>$mchara<>$con_ele<>$in{'message'}<>$etc<>$mhost<>$daytime<>\n");
	
	open(OUT,">$BFILE");
	print OUT @BBS_DATA;
	close(OUT);

	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="120" CLASS=FC>
  <TBODY>
    <TR>
      <TD align="center" bgcolor="#993300"><FONT color="#ffffcc">法規發佈完成</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#330000" height=100><FONT color="#ffffcc">已成功發佈法規。</FONT></TD>
    </TR>
    <TR>
      <TD align="center">
	<form action="./country.cgi" method="POST">
	<INPUT type=hidden name=mode value=$rule>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=submit CLASS=FC value=回到法規></form></TD>
	
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF

	&footer;
	exit;
}
1;
