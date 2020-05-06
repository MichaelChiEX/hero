sub suport_money2 {
	&chara_open;
	&con_open;

	if($con_id eq 0){&error("無所屬國無法貢獻。");}
	if(!$hit){&error("國家資料異常。");}
	if($in{'gold'} eq ""){&error("請輸入要貢獻的金額。");}
	if($in{'gold'} =~ m/[^0-9]/){&error("請輸入正確的貢獻金。");}
	if($in{'gold'} <0){&error("請輸入正確的貢獻金。");}
	
	$date = time();
	$btime = $BTIME - $date + $mdate;
	
	$gold=$in{'gold'}*10000;
	$con_gold+=$gold;
	$mgold-=$gold;
	if($mgold<0){&error("所持金不足。");}
	$mcex+=$in{'gold'};
	if ($in{'gold'}>=100) {
		&maplog("<font color=orange>[貢獻]</font><font color=blue>$mname</font>貢獻$con_name國<font color=red>$in{'gold'}</font>萬。");
	}
	&con_input;
	&chara_input;

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">貢獻資金</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">貢獻<font color=#AAAAFF>$con_name國</font><font color=yellow>$in{'gold'}</font>萬。</FONT></TD>
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
