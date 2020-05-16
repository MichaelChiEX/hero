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
        $show_para_add.="<br>目前「力量」加量：$ext_para_adds[0]";
        $show_para_add.="<br>目前「生命力」加量：$ext_para_adds[4]";
        $show_para_add.="<br>目前「智力」加量：$ext_para_adds[1]";
        $show_para_add.="<br>目前「精神」加量：$ext_para_adds[2]";
        $show_para_add.="<br>目前「運氣」加量：$ext_para_adds[3]";
        $show_para_add.="<br>目前「速度」加量：$ext_para_adds[5]";
        if($marmno eq"mix" && $mele eq $marmele){$mmaxhp-=1000;}
        if($mprono eq"mix" && $mele eq $mproele){$mmaxhp-=1000;}
        if($maccno eq"mix" && $mele eq $maccele){$mmaxmp-=1000;}	
	$hinn_gold=int($mmaxhp+$mmaxmp+$mstr+$mvit+$mint+$mdex+$mfai+$magi)*5000;
	if($hinn_gold<1000000){$hinn_gold=1000000;}
	$sleep_gold=$hinn_gold/10000;
	print <<"EOF";
<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">高級旅館</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">歡迎光臨<font color=#AAAAFF>$mname</font>。這裏是高級旅館。<br>在這你可以花費金錢來增加你的ＨＰ及ＭＰ最大值。<br>住一晚需花費<font size=5 color=yellow>$sleep_gold</font>萬。<br>或花４００萬（轉職後第一次需１千萬）增加你的能力０～５０<br>（不限次數，洗到沒錢為止，轉職後此數值全歸０，原力量１００，加２０點為１２０，第二次洗加１０點，力量改為１１０）。</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	$STPR
	<form action="./town.cgi" method="POST">
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=hinn2>
	<input type=submit CLASS=FC value=確定住一晚></form>
$show_para_add
        <form action="./town.cgi" method="POST">
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=hinn3>
        <input type=submit CLASS=FC value=洗能力點數></form>
$BACKTOWNBUTTON
     </td>	
    </tr>
  </tbody>
</table>
EOF
	&footer;
	exit;
}
1;
