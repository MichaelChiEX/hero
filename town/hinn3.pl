sub hinn3{
	&chara_open;
	&town_open;
        &ext_open;
        ($ext_para_adds[0],$ext_para_adds[1],$ext_para_adds[2],$ext_para_adds[3],$ext_para_adds[4],$ext_para_adds[5])=split(/,/,$ext_para_add);
        for($i=0;$i<6;$i++){
                $all_para_add+=$ext_para_adds[$i];
        }
        $show_para_add.="<BR>原「力量」加量：$ext_para_adds[0]";
        $show_para_add.="<BR>原「生命力」加量：$ext_para_adds[4]";
        $show_para_add.="<BR>原「智力」加量：$ext_para_adds[1]";
        $show_para_add.="<BR>原「精神」加量：$ext_para_adds[2]";
        $show_para_add.="<BR>原「運氣」加量：$ext_para_adds[3]";
        $show_para_add.="<BR>原「速度」加量：$ext_para_adds[5]";
	&equip_open;
	if($all_para_add eq 0){$hinn_gold=10000000;}
	else{$hinn_gold=4000000;}
	if($mgold<$hinn_gold){&error("所持金不足$hinn_gold。")};
	$mgold-=$hinn_gold;
        $mstr-=$ext_para_adds[0];
        $mvit-=$ext_para_adds[4];
        $mint-=$ext_para_adds[1];
        $mfai-=$ext_para_adds[2];
        $mdex-=$ext_para_adds[3];
        $magi-=$ext_para_adds[5];
	for($i=0;$i<6;$i++){
		$ext_para_adds[$i]=int(rand(51));
	}
        $mstr+=$ext_para_adds[0];
        $mvit+=$ext_para_adds[4];
        $mint+=$ext_para_adds[1];
        $mfai+=$ext_para_adds[2];
        $mdex+=$ext_para_adds[3];
        $magi+=$ext_para_adds[5];
        $show_para_add.="<BR>花費:$hinn_gold Gold";
        $show_para_add.="<BR>增加「力量」加量：$ext_para_adds[0]";
        $show_para_add.="<BR>增加「生命力」加量：$ext_para_adds[4]";
        $show_para_add.="<BR>增加「智力」加量：$ext_para_adds[1]";
        $show_para_add.="<BR>增加「精神」加量：$ext_para_adds[2]";
        $show_para_add.="<BR>增加「運氣」加量：$ext_para_adds[3]";
        $show_para_add.="<BR>增加「速度」加量：$ext_para_adds[5]";	
	$town_gold+=int($hinn_gold/((1500-$town_ind)/250));

	&town_input;
	
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">高級旅館</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=lightblue>$mname</font>於高級旅館住了一晚。$show_para_add</font>。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=hinn3>
        <INPUT type=submit CLASS=FC value=繼續洗點></form>

        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=hinn>
        <INPUT type=submit CLASS=FC value=回高級旅館></form>

$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF
	$ext_para_add="$ext_para_adds[0],$ext_para_adds[1],$ext_para_adds[2],$ext_para_adds[3],$ext_para_adds[4],$ext_para_adds[5]";
	&ext_input;
	&chara_input;
	&footer;
	exit;
}
1;
