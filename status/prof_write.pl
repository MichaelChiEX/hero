#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/#
#_/       会議室書き込み     _/#
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/#

sub prof_write{

	&chara_open;
	&con_open;
    	
	if($in{'message'} eq"") { &error("請輸入自傳內容。"); }
	if(length($in{'message'}) > 1000) { &error("自傳內容太長，請少於５００個字"); }


	if($lockkey) { &F_LOCK; }
	open(IN,"./logfile/prof/$mid.cgi");
	@PROF_DATA = <IN>;
	close(IN);
	$in{'message'}.="<BR>";
	@t = split(/<br>/,$in{'message'});
	$gyou=@t;
	if($gyou>20){&error("行數請少於或等於２０行。");}

	@N_PROF_DATA=();
	push(@N_PROF_DATA,"$in{'message'}");

	open(OUT,">./logfile/prof/$mid.cgi");
	print OUT @N_PROF_DATA;
	close(OUT);

	&header;
	
print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">更新自傳</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/house.jpg"></TD>
      <TD bgcolor="#000000"><FONT color="#ffffcc">你的自傳已更新完成。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
<form action="./status.cgi" method="post">
<input type=hidden name=id value=$mid>
<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
<input type=hidden name=mode value=prof_edit>
<input type=submit CLASS=FC value="回到自傳"></form></TD>
	
    </TR>
  </TBODY>
</TABLE>
EOF
	&footer;
	exit;
	
}
1;
