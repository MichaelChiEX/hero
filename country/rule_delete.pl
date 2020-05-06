sub rule_delete {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	&time_data;

	if($in{'no'} eq ""){&error("請選擇要刪除的法規。");}
	if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){&error("無官職者無法刪除法規。");}
	
	if($in{'type'} eq 1){
		$BFILE="./blog/rule/$con_id.cgi";
		$rule="rule";
	}elsif($in{'type'} eq 2){
		if($con_king ne $mid && $mid ne $GMID){&error("國王以外的人無法刪除。");}
		$BFILE="./blog/rule/0.cgi";
		$rule="all_rule";
	}else{&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}

	open(IN,"$BFILE");
	@BBS_DATA = <IN>;
	close(IN);
	
	splice(@BBS_DATA,$in{'no'},1);

	open(OUT,">$BFILE");
	print OUT @BBS_DATA;
	close(OUT);

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="120" CLASS=FC>
  <TBODY>
    <TR>
      <TD align="center" bgcolor="#993300"><FONT color="#ffffcc">法規刪除完成</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#330000" height=100><FONT color="#ffffcc">你選擇的法規已刪除完成。</FONT></TD>
    </TR>
    <TR>
      <TD align="center">
	<form action="./country.cgi" method="POST">
	<INPUT type=hidden name=mode value=rule>
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
