sub action2 {
	&chara_open;
	&ext_open;
#	if($ACTOPEN eq 0){&error("目前沒有活動!");}
        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);
	$no=$in{'no'};
	if($no eq""){
		&error("請選擇要兌換的物品!");
	}
	if(@ITEM>=$ITM_MAX){&error("你的持有物品數已達上限。(最大$ITM_MAX個)");}
	#兌換物品
        open(IN,"./data/actchangeitem.cgi");
        @CHITEM = <IN>;
        close(IN);
	($it_actno,$it_actnum,$it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$CHITEM[$no]);
	$getitem="$it_no<>$it_ki<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_sta<>$it_type<>$it_flg<>";
	$cit_name=$it_name;
	$ait_name=$ACTITEM[$it_actno];
	if($it_name eq""){&error("找不到你要兌換的物品!");}
	($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
	if($act[$it_actno]>=$it_actnum){
		$act[$it_actno]-=$it_actnum;
		$ext_action="$act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9]";
		push(@ITEM,"$getitem\n");
	        &chara_input;
		&ext_input;
	        open(OUT,">./logfile/item/$in{'id'}.cgi");
	        print OUT @ITEM;
	        close(OUT);
		$com="你花費$it_actnum個「<font color=yellow>$ait_name</font>」兌換了「<font color=#AAAAFF>$cit_name</font>」";
		&maplog("<font color=green>[活動物品兌換]</font><font color=blue>$mname</font>兌換了$cit_name活動物品");
	}else{
		$com="你要兌換的「<font color=#AAAAFF>$cit_name</font>」需要「<font color=yellow>$ait_name</font>」$it_actnum個";
	}
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">$ACTNAME[$ACTOPEN]活動兌換所</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=#AAAAFF>$mname</font>$com</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=action>
        <INPUT type=submit CLASS=FC value=回到$ACTNAME[$ACTOPEN]兌換所></form></TD>

    </TR>
  </TBODY>
</TABLE>

EOF

	&footer;
	exit;
}
1;
