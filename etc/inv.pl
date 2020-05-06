sub inv{
	&header;
	&chara_open;
	&town_open;
	&con_open;
#&error("國戰停止中,假期後重開,詳細時間會提前公告");
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if("$con2_id" eq "$town_con"){$hit=1;}
		$CONELE[$con2_id]=$con2_ele;
		$CONNAME[$con2_id]=$con2_name;
		$c_no++;
	}
	if(!$hit){$con2_ele=0;$con2_name="無所屬";$con2_id=0;}
	$i=0;
	$tpr="<table bgcolor=663300><TD width=15 height=10 bgcolor=ffffcc CLASS=GC>　</TD>";
	for($i=0;$i<6;$i++){
		$tpr.= "<TD width=15 height=10 bgcolor=ffffcc><font size=1>$i</font></TD>";
	}
	for($i=0;$i<6;$i++){
		$n = $i;
		$tpr.= "<TR><TD bgcolor=ffffcc><font size=1>$n</font></td>";
		for($j=0;$j<6;$j++){
			$m_hit=0;$tx=0;
			foreach(@TOWN_DATA){
				($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y)=split(/<>/);
				if("$town2_x" eq "$j" && "$town2_y" eq "$i"){$m_hit=1;last;}
				$tx++;
			}
			$col="";
			if($m_hit){
				if($town2_id eq $mpos){
					$col = $ELE_C[$CONELE[$town2_con]];
				}else{
					$col = $ELE_BG[$CONELE[$town2_con]];
				}
				if($town2_id eq 0){
					$tpr.= "<TH bgcolor=$col><img src=\"$IMG/town/m_2.gif\" title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></TH>";
				}else{
					$tpr.= "<TH bgcolor=$col><img src=\"$IMG/town/m_4.gif\" title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></TH>";
				}
			}else{
				$tpr.= "<TH>　</TH>";
			}
		}
		$tpr.= "</TR>";
	}
	$tpr.="</table>";

	$movelist="<select name=tid>";
	$movelist.="<option>所屬國家選擇";
	foreach(@TOWN_DATA){
		($town3_id,$town3_name,$town3_con,$town3_ele,$town3_gold,$town3_arm,$town3_pro,$town3_acc,$town3_ind,$town3_tr,$town3_s,$town3_x,$town3_y)=split(/<>/);
		if(abs($town3_x-$town_x) <= "1" && abs($town3_y-$town_y) <= "1" && $town_name ne $town3_name){$movelist.="<option value=$town3_id>$town3_name($town3_x - $town3_y)";}
		$tx++;
	}
	$movelist.="</select>";
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">侵略</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center>$tpr</TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">請選擇要侵略的城鎮，每攻擊一次將花費國家資金１００萬。<BR>目前所在地：$town_x - $town_y</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	<form action="./etc.cgi" method="POST">
	<INPUT type=hidden name=mode value=inv2>
	<INPUT type=hidden name=id value=$mid>
	
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	$movelist
	<INPUT type=submit CLASS=FC value=侵略></form>
	<form action="./top.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=submit CLASS=FC value=回到城鎮>
	</TD>
</Form>	
    </TR>
  </TBODY>
</TABLE>
EOF
	&mainfooter;
	exit;
}
1;
