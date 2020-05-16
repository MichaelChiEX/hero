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
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">國家公告變更</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">國家公告已變更為。<br>$in{'in'}</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
$BACKTOWNBUTTON
      </td>	
    </tr>
  </tbody>
</table>
<center></center>
EOF

	&footer;
	exit;
}
1;

