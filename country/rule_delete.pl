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
		if($con_king ne $mid){&error("國王以外的人無法刪除。");}
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
<table border="0" width="80%" align=center bgcolor="#ffffff" height="120" CLASS=FC>
  <tbody>
    <tr>
      <td align="center" bgcolor="#993300"><font color="#ffffcc">法規刪除完成</font></td>
    </tr>
    <tr>
      <td bgcolor="#330000" height=100><font color="#ffffcc">你選擇的法規已刪除完成。</font></td>
    </tr>
    <tr>
      <td align="center">
	<form action="./country.cgi" method="POST">
	<input type=hidden name=mode value=rule>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=submit CLASS=FC value=回到法規></form></td>
	
    </tr>
  </tbody>
</table>
<center></center>
EOF

	&footer;
	exit;
}
1;
