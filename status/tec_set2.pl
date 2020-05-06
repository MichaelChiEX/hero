sub tec_set2{
	&chara_open;
	if($in{'tec1'} eq ""||$in{'tec2'} eq ""||$in{'tec3'} eq ""){&error("請選擇三個條件的發動技能。");}
	if ($in{'mprate'} =~ m/[^0-9]/ || $in{'hprate'} =~ m/[^0-9]/){&error("請正確輸入發動條件，請輸入數字。"); }
	if ($in{'mprate'} >100 || $in{'mprate'} <0 || $in{'hprate'} > 100 || $in{'hprate'} < 0){&error("發動條件請輸入　0~100 %的數字。"); }
	if(length($in{'bcom'}) > 40){&error("戰鬥宣告請少於２０個文字。");}
	
	$mcom="$in{'bcom'}";
	$mtec="$in{'tec1'},$in{'tec2'},$in{'tec3'},$in{'mprate'},$in{'hprate'}";
	&chara_input;

	&header;
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">變更完成</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/house.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">你的技能已變更完成。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
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
