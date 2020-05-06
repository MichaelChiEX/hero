sub unit_edit {
	&chara_open;
	&con_open;
	&town_open;
	&status_print;
	open(IN,"./data/unit.cgi");
	@UNIT_DATA = <IN>;
	close(IN);

	if($in{'unit'} eq ""){&error("請輸入隊伍的名稱。");}
	if($in{'com'} eq ""){&error("請輸入隊伍介紹詞。");}
	if($mcex<100){&error("需要名聲１００以上。");}
	if(length($in{'unit'}) < 4||length($in{'unit'}) > 20){&error("隊伍名稱需要２～１０個字之間");}
	if(length($in{'com'}) > 40){&error("隊伍介紹不可大於２０個字。");}
	foreach(@UNIT_DATA){
		($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bflg)=split(/<>/);
		if($bid eq $mid){&error("你目前已在其他的隊伍之中，無法再自己建立新的隊伍，請先離開或解散原有的隊伍再進行操入。");}
	}
	if($in{'unit'} eq $uname){&error("隊伍的名稱與其他隊伍重複，請更改。");}

	$munit = $mid;
	unshift(@UNIT_DATA,"$mid<>$mchara<>$mname<>$in{'unit'}<>$mid<>$mname<>$in{'com'}<>$mcon<>\n");
	open(OUT,">./data/unit.cgi") or &error('檔案開啟錯誤counrty/unit_edit.pl(23)。');
	print OUT @UNIT_DATA;
	close(OUT);

	&chara_input;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">新規作成</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">隊伍：$in{'unit'}已成功編成。<BR></FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center" bgcolor="#ffffcc">
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
