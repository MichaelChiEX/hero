sub conv_write {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	&time_data;
	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error("距離下次可以留言的時間剩 $btime 秒。");}
	if($in{'type'} && $in{'title'} eq""){&error("請輸入要留言的標題。");}
	if($in{'message'} eq ""){&error("請輸入要留言的內容。");}
	if(length($in{'title'}) > 30){&error("標題不可大於１５個字。");}
	if(length($in{'message'}) > 400){&error("內容不可大於２００個字。");}
	if($in{'bbs'} eq "con" && $con_id eq "0"){&error("無所屬國無法在此留言。");}

	if($in{'bbs'} eq "all"){
		$BFILE="./blog/conv/0.cgi";
		$conv="all_conv";
	}elsif($in{'bbs'} eq "con"){
		$BFILE="./blog/conv/$con_id.cgi";
		$conv="con_conv";
	}else{&error("資料傳輸錯誤，<a href='./login.cgi'>請重新登入</a>。");}

	open(IN,"$BFILE");
	@BBS_DATA = <IN>;
	close(IN);
	
	$no=0;
	@BBS_DATA2=();
	@N_BBS=();
	@N_BBS2=();
	foreach(@BBS_DATA){
		($lid,$lname,$lchara,$lcon,$ltitle,$lmes,$letc,$lhost,$ldaytime)=split(/<>/);
		if($ltitle ne""){
			$no2=$no;
		}
		if($no2 eq"$in{'resno'}" && $in{'resno'} ne""){
			$hit=1;
			push(@BBS_DATA2,"$_");
		}else{push(@N_BBS,"$_");}
		$no++;
	}
	
	if($con_king eq $mid){$etc="$con_name國王";}
	else{$etc="$con_name兵士";}
	push(@BBS_DATA2,"$mid<>$mname<>$mchara<>$con_ele<>$in{'title'}<>$in{'message'}<>$etc<>$mhost<>$daytime<>\n");

	@N_BBS2=(@BBS_DATA2,@N_BBS);
	splice(@N_BBS2,30);
	
	open(OUT,">$BFILE");
	print OUT @N_BBS2;
	close(OUT);

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="120" CLASS=FC>
  <TBODY>
    <TR>
      <TD align="center" bgcolor="#993300"><FONT color="#ffffcc">留言</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#330000" height=100><FONT color="#ffffcc">留言完成。</FONT></TD>
    </TR>
    <TR>
      <TD align="center">
	<form action="./country.cgi" method="POST">
	<INPUT type=hidden name=mode value=$conv>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=submit CLASS=FC value=OK></form></TD>
	
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF

	&footer;
	exit;
}
1;
