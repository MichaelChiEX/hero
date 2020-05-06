sub backup{
	&chara_open;
	&town_open;
	&con_open;
	
	&host_name;
	$date = time();
	@N_DATA=();
	$mjp = "$mjp[0],$mjp[1],$mjp[2],$mjp[3],$mjp[4],$mjp[5]";
	$mmax = "$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";
	unshift(@N_DATA,"$mid<>$mpass<>$mname<>$murl<>$mchara<>$msex<>$mhp<>$mmaxhp<>$mmp<>$mmaxmp<>$mele<>$mstr<>$mvit<>$mint<>$mfai<>$mdex<>$magi<>$mmax<>$mcom<>$mgold<>$mbank<>$mex<>$mtotalex<>$mjp<>$mabp<>$mcex<>$munit<>$mcon<>$marm<>$mpro<>$macc<>$mtec<>$msta<>$mpos<>$mmes<>$host<>$date<>$mdate2<>$mclass<>$mtotal<>$mkati<>$mtype<>$moya<>$msk<>$mflg<>$mflg2<>$mflg3<>$mflg4<>$mflg5<>$mpet<>\n");
	open(OUT,">./logfile/backup/$in{'id'}.cgi") or &error('開啟檔案失敗status\backup.pl(12)。');
	print OUT @N_DATA;
	close(OUT);
	
	open(IN,"./logfile/item/$in{'id'}.cgi");
	@ITEM = <IN>;
	close(IN);

	open(OUT,">./logfile/backup/item/$in{'id'}.cgi");
	print OUT @ITEM;
	close(OUT);

	open(IN,"./logfile/storage/$in{'id'}.cgi");
	@STORAGE = <IN>;
	close(IN);

	open(OUT,">./logfile/backup/storage/$in{'id'}.cgi");
	print OUT @STORAGE;
	close(OUT);
	
        open(IN,"./logfile/ext/$in{'id'}.cgi");
        @EXTB = <IN>;
        close(IN);

        open(OUT,">./logfile/backup/ext/$in{'id'}.cgi");
        print OUT @EXTB;
        close(OUT);
	&header;
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">備份</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">已成功將你的角色資料備份。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
$BACKTOWNBUTTON
	</TD>	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
