sub hinn{
	&header;
	&chara_open;
	&town_open;
	&status_print;
	&equip_open;
	&ext_open;
	($ext_para_adds[0],$ext_para_adds[1],$ext_para_adds[2],$ext_para_adds[3],$ext_para_adds[4],$ext_para_adds[5])=split(/,/,$ext_para_add);
	for($i=0;$i<6;$i++){
		$all_para_add+=$ext_para_adds[$i];
	}
        $show_para_add.="<BR>目前「力量」加量：$ext_para_adds[0]";
        $show_para_add.="<BR>目前「生命力」加量：$ext_para_adds[4]";
        $show_para_add.="<BR>目前「智力」加量：$ext_para_adds[1]";
        $show_para_add.="<BR>目前「精神」加量：$ext_para_adds[2]";
        $show_para_add.="<BR>目前「運氣」加量：$ext_para_adds[3]";
        $show_para_add.="<BR>目前「速度」加量：$ext_para_adds[5]";
        if($marmno eq"mix" && $mele eq $marmele){$mmaxhp-=1000;}
        if($mprono eq"mix" && $mele eq $mproele){$mmaxhp-=1000;}
        if($maccno eq"mix" && $mele eq $maccele){$mmaxmp-=1000;}	
	$hinn_gold=int($mmaxhp+$mmaxmp+$mstr+$mvit+$mint+$mdex+$mfai+$magi)*5000;
	if($hinn_gold<1000000){$hinn_gold=1000000;}
	$sleep_gold=$hinn_gold/10000;
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">高級旅館</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">歡迎光臨<font color=#AAAAFF>$mname</font>。這裏是高級旅館。<BR>在這你可以花費金錢來增加你的ＨＰ及ＭＰ最大值。<BR>住一晚需花費<font size=5 color=yellow>$sleep_gold</font>萬。<BR>或花４００萬（轉職後第一次需１千萬）增加你的能力０～５０<BR>（不限次數，洗到沒錢為止，轉職後此數值全歸０，原力量１００，加２０點為１２０，第二次洗加１０點，力量改為１１０）。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR
	<form action="./town.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=hinn2>
	<INPUT type=submit CLASS=FC value=確定住一晚></form>
$show_para_add
        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=hinn3>
        <INPUT type=submit CLASS=FC value=洗能力點數></form>
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
