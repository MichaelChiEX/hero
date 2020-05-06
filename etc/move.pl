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

        foreach(@TOWN_DATA){
                ($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y)=split(/<>/);
                if($town_name ne $town2_name){
                    $xx=abs($town2_x-$town_x);
                    $yy=abs($town2_y-$town_y);
	            if($xx <= "1" && $yy <= "1"){
                        $towntable.="<TR><TD bgcolor=yellow>($town2_x,$town2_y)</TD><TD bgcolor=yellow>$town2_name</TD><TD bgcolor=yellow>$ELE[$town2_ele]</TD><TD bgcolor=yellow>免費</TD><TD bgcolor=yellow><input type=button class=FC value=移動 onclick='javascript:moves($town2_id);'></TD></TR>";
		    }elsif($moveall){
                        $towntable.="<TR><TD bgcolor=#EEEEFF>($town2_x,$town2_y)</TD><TD bgcolor=#EEEEFF>$town2_name</TD><TD bgcolor=#EEEEFF>$ELE[$town2_ele]</TD><TD bgcolor=#EEEEFF>飛行術</TD><TD bgcolor=#EEEEFF><input type=button class=FC value=移動 onclick='javascript:moves($town2_id);'></TD></TR>";
                    }else{
                    	$coins=($xx+$yy)*5;
			if($mbank+$mgold>100000000){
				$coins*=4;
			}elsif($mbank+$mgold>30000000){
				$coins*=2;
			}
                    	$towntable.="<TR><TD bgcolor=white>($town2_x,$town2_y)</TD><TD bgcolor=white>$town2_name</TD><TD bgcolor=white>$ELE[$town2_ele]</TD><TD bgcolor=white>$coins萬</TD><TD bgcolor=white><input type=button class=FC value=移動 onclick='javascript:moves($town2_id);'></TD></TR>";
                    }
                }
                if($town_name ne $town2_name){
			$towntable.="<TR><TD bgcolor=yellow>($town2_x,$town2_y)</TD><TD bgcolor=yellow>$town2_name</TD><TD bgcolor=yellow>$ELE[$town2_ele]</TD><TD bgcolor=yellow>免費</TD><TD bgcolor=yellow><input type=button class=FC value=移動 onclick='javascript:moves($town2_id);'></TD></TR>";
                }

                $tx++;
        }
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">移動</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center>$tpr</TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">移動到其他城鎮，請選擇將要移動到的地點，學會飛行術後可以免費所有城鎮移動。<BR>你目前的所在地：$town_x - $town_y</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>移動城鎮一覽</font></td></tr>
        <tr>
        <td bgcolor=white>座標</td><td bgcolor=white>城鎮名稱</td><td bgcolor=white>屬性</td><td bgcolor=white>移動費用</td><td bgcolor=white>移動</td>
        </tr>
        <form action="./etc.cgi" method="post" id=movef name=movef>
        $towntable
        <TR><TD colspan=7 align=center bgcolor="ffffff">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=tid id=tid>
        <INPUT type=hidden name=mode value=move2>
        </TD></TR></form>
        </table>
	<form action="./top.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=submit CLASS=FC value=回到城鎮>
	</TD>
	
    </TR>
  </TBODY>
</TABLE>
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
