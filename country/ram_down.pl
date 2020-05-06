sub ram_down {
	&chara_open;
&error("系統更新中....");
	&status_print;
	&con_open;
	&town_open;
	if($con_id eq 0){&error("無所屬國無法進行計略。");}
	
	if($town_con ne $mcon){&error("請在自己的國家城鎮上施行計略。");}
	if($town_build_data[12] eq"" || $town_build_data[12] eq "0"){&error("本城鎮沒有建設$town_build_name[12]");}
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if("$con2_id" eq "$town_con"){$hit=1;}
		$CONELE[$con2_id]=$con2_ele;
		$CONNAME[$con2_id]=$con2_name;
		$c_no++;
	}
	if(!$hit){$con2_ele=0;$con2_name="無所屬";$con2_id=0;}

	$i=0;
	$tpr="<table bgcolor=663300><TD width=15 height=5 bgcolor=ffffcc CLASS=GC>　</TD>";
	for($i=0;$i<6;$i++){
		$tpr.= "<TD width=15 height=5 bgcolor=ffffcc><font size=1>$i</font></TD>";
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
					$tpr.= "<TH bgcolor=$col><img src=\"$IMG/town/m_2.gif\" title=\"$town2_name【$CONNAME[$town2_con]】\" width=15 height=10></TH>";
				}else{
					$tpr.= "<TH bgcolor=$col><img src=\"$IMG/town/m_4.gif\" title=\"$town2_name【$CONNAME[$town2_con]】\" width=15 height=10></TH>";
				}
			}else{
				$tpr.= "<TH>　</TH>";
			}
		}
		$tpr.= "</TR>";
	}
	$tpr.="</table>";

	$movelist="<select name=tid>";
	$movelist.="<option value=\"\">請選擇城鎮";
	foreach(@TOWN_DATA){
		($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y)=split(/<>/);
		if(abs($town2_x-$town_x) <= "1" && abs($town2_y-$town_y) <= "1" && $town_name ne $town2_name){$movelist.="<option value=$town2_id>$town2_name";}
		$tx++;
	}
	$movelist.="</select>";


	$list="<select name=pow>";
	$list.="<option value=t_str>下毒(有機會減少士兵攻/防)";
	$list.="<option value=t_hp>流言(有機會讓城中的士兵逃離)";
        $list.="<option value=t_def>調虎離山(有機會讓守城的玩家離守)";
	$list.="</select>";

	&header;
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">計略</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center>$tpr</TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">對他國的城鎮進行計略。<BR>實行者的名聲需要大於５００，每次施計扣除１００名聲及３００萬<BR>請選擇要實施的對象及施計的內容。<BR>本鎮$town_build_name[12]等級$town_build_data[12]，國家資金：$scon_gold</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
以下公式還需計算對方城鎮$town_build_name[12]等級所減的效果，才是實際效果<BR>
下毒：（（運氣＋精神）／２０）ｘ（１＋$town_build_name[12]等級／１０）<BR>
流言：（（智力＋精神）／２）ｘ（１＋$town_build_name[12]等級／１０）<BR>
調處離山：機率〔（智力－對方智力）ｘ（１＋$town_build_name[12]等級／１０）〕％
	<form action="./country.cgi" method="post">
	$movelist
	$list
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=ram_down2>
	<INPUT type=submit value=計略 CLASS=FC></form>
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
