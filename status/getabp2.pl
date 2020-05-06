sub getabp2{
	&chara_open;
	if($in{'job'} eq ""){&error("請選擇職業。");}
	
	require './data/abini.cgi';
	@jlist = split(/,/,$AJOB[$mclass]);

	$i=0;
	foreach(@jlist){
		$jobflg[$jlist[$i]] = 1;
		$i++;
	}
	if($jobflg[$in{'job'}] ne 1){
		&maplog("<font color=red>[警告]</font>$mname嘗試取得非同系上階職業的熟練值。");
		&error("請不要進行作弊的行為。");
	}
	open(IN,"./logfile/job/$mid.cgi");
	@JOB_DATA = <IN>;
	close(IN);
	@job = split(/<>/,$JOB_DATA[0]);

	$getabp = int($job[$in{'job'}]*0.7);
		
	if($getabp > 1){
		$mabp += $getabp;
		$job[$in{'job'}] = 0;
	}else{
		&error("無法取得該職業的熟練度。");
	}

	@N_JOB_DATA=();
	unshift(@N_JOB_DATA,"$job[0]<>$job[1]<>$job[2]<>$job[3]<>$job[4]<>$job[5]<>$job[6]<>$job[7]<>$job[8]<>$job[9]<>$job[10]<>$job[11]<>$job[12]<>$job[13]<>$job[14]<>$job[15]<>$job[16]<>$job[17]<>$job[18]<>$job[19]<>$job[20]<>$job[21]<>$job[22]<>$job[23]<>$job[24]<>$job[25]<>$job[26]<>$job[27]<>$job[28]<>$job[29]<>$job[30]<>$job[31]<>$job[32]<>$job[33]<>$job[34]<>$job[35]<>$job[36]<>$job[37]<>$job[38]<>\n");
	open(OUT,">./logfile/job/$mid.cgi") or &error('檔案開啟錯誤status/getabp2.pl(33)。');
	print OUT @N_JOB_DATA;
	close(OUT);

	&chara_input;
	
	&header;
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">取得完成</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">已成功取得<font color=red>$getabp</font>熟練度。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	<form action="./status.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=getabp>
	<INPUT type=submit CLASS=FC value=回到取得熟練值畫面></form>
$BACKTOWNBUTTON
    </TD>
    </TR>
  </TBODY>
</TABLE>
EOF
	&footer;
	exit;
}
1;
