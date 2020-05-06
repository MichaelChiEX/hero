sub sirei2 {
	&chara_open;
	&status_print;
	&town_open;
	&con_open;
	
	$conkazu="@CON_DATA";

	if($mcex<500){&error("名聲必需大於５００才可變更公告。");}
	if($con_id eq 0){&error("無所屬國無法執行。");}
	if($in{'mes'} eq ""){&error("請輸入公告內容。");}
	if(length($in{'mes'}) < 4||length($in{'mes'}) > 300){&error("請輸入２～１００字內的公告內容。");}
	if ($in{'mes'} =~ /<>/){&error("不可使用\"<>\"字樣。");}
	$con_mes="$in{'mes'}($mname)";
	&con_input;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">國家公告變更</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">國家公告已變更為。<br>$in{'in'}</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
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

