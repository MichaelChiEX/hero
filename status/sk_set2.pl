sub sk_set2{
	&chara_open;
	if($in{'type'} eq "1" && $in{'skill'} eq "" ){&error("請選擇要變更的主奧義項目。");}
	if($in{'type'} eq "2" && $in{'skill2'} eq "" ){&error("請選擇要變更的職業奧義項目。");}
	($msk[0],$msk[1]) = split(/,/,$msk);
	
	if($in{'type'} eq "1"){
		if($in{'skill'} eq"103"){&error("十字封印無法裝在主奧義！");}
		$msk="$in{'skill'},$msk[1]";
	}elsif($in{'type'} eq "2"){
		$msk="$msk[0],$in{'skill2'}";
	}
	&chara_input;

	
	&header;
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">奧義變更</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">已成功變更了奧義。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	<form action="./status.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=sk_set>
	<INPUT type=submit CLASS=FC value=回奧義變更畫面></form>
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
