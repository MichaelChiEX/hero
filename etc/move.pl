sub move{
	&chara_open;
	&town_open;
	&con_open;

	open(IN,"./logfile/ability/$mid.cgi");
	@ABDATA = <IN>;
	close(IN);

	foreach(@ABDATA){
		($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
		if($kabno eq"55"){
			$moveall=1;
			last;
		}
	}

	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		$CONELE[$con2_id]=$con2_ele;
		$CONNAME[$con2_id]=$con2_name;
	}

	$tpr="<table bgcolor=663300><td width=15 height=5 bgcolor=ffffcc CLASS=GC>　</td>";
	for($i=0;$i<6;$i++){
		$tpr.= "<td width=15 height=5 bgcolor=ffffcc><font size=1>$i</font></td>";
	}
	for($i=0;$i<6;$i++){
		$tpr.= "<tr><td bgcolor=ffffcc><font size=1>$i</font></td>";
		for($j=0;$j<6;$j++){
			$m_hit=0;
			foreach(@TOWN_DATA){
				($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y)=split(/<>/);
				if("$town2_x" eq "$j" && "$town2_y" eq "$i"){$m_hit=1;last;}
			}
			if($m_hit){
				if($town2_id eq $mpos){
					$col = $ELE_C[$CONELE[$town2_con]];
				}else{
					$col = $ELE_BG[$CONELE[$town2_con]];
				}
			
				if($town2_id eq 0){
					$tpr.= "<th bgcolor=$col><img src=\"$IMG/town/m_2.gif\" title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></th>";
				}else{
					$tpr.= "<th bgcolor=$col><img src=\"$IMG/town/m_4.gif\" title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></th>";
				}
			}else{
				$tpr.= "<th>　</th>";
			}
		}
		$tpr.= "</tr>";
	}
	$tpr.="</table>";

	foreach(@TOWN_DATA){
		($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y)=split(/<>/);
		next if($town_name eq $town2_name);

		$xx=abs($town2_x-$town_x);
		$yy=abs($town2_y-$town_y);
		if($xx <= "1" && $yy <= "1"){
			$towntable.="<tr><td bgcolor=yellow>($town2_x,$town2_y)</td><td bgcolor=yellow>$town2_name</td><td bgcolor=yellow>$ELE[$town2_ele]</td><td bgcolor=yellow>免費</td><td bgcolor=yellow><input type=button class=FC value=移動 onclick='javascript:moves($town2_id);'></td></tr>";
		}elsif($moveall){
			$towntable.="<tr><td bgcolor=#EEEEFF>($town2_x,$town2_y)</td><td bgcolor=#EEEEFF>$town2_name</td><td bgcolor=#EEEEFF>$ELE[$town2_ele]</td><td bgcolor=#EEEEFF>飛行術</td><td bgcolor=#EEEEFF><input type=button class=FC value=移動 onclick='javascript:moves($town2_id);'></td></tr>";
		}else{
			$coins=($xx+$yy)*5;
			if($mbank+$mgold>100000000){
				$coins*=4;
			}elsif($mbank+$mgold>30000000){
				$coins*=2;
			}
			$towntable.="<tr><td bgcolor=white>($town2_x,$town2_y)</td><td bgcolor=white>$town2_name</td><td bgcolor=white>$ELE[$town2_ele]</td><td bgcolor=white>$coins萬</td><td bgcolor=white><input type=button class=FC value=移動 onclick='javascript:moves($town2_id);'></td></tr>";
		}
	}
	&header;
	
	print <<"EOF";
<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">移動</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center>$tpr</td>
      <td bgcolor="#330000"><font color="#ffffcc">移動到其他城鎮，請選擇將要移動到的地點，學會飛行術後可以免費所有城鎮移動。<br>你目前的所在地：$town_x - $town_y</font></td>
    </tr>
    <tr>
      <td colspan="2" align="right">
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>移動城鎮一覽</font></td></tr>
        <tr>
        <td bgcolor=white>座標</td><td bgcolor=white>城鎮名稱</td><td bgcolor=white>屬性</td><td bgcolor=white>移動費用</td><td bgcolor=white>移動</td>
        </tr>
        <form action="./etc.cgi" method="post" id=movef name=movef>
        $towntable
        <tr><td colspan=7 align=center bgcolor="ffffff">
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=tid id=tid>
        <input type=hidden name=mode value=move2>
        </td></tr></form>
        </table>
	<form action="./top.cgi" method="POST">
	<input type=hidden name=id value=$mid>
	
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=submit CLASS=FC value=回到城鎮>
	</td>
	
    </tr>
  </tbody>
</table>
<script language=javascript>
function moves(tid){
	document.getElementById('tid').value=tid;
	movef.submit();
}
</script>
EOF
	&mainfooter;
	exit;
}
1;
