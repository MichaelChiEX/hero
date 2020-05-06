sub top_print{
	if(!$mflg){
	##地圖表示
	#取得目前城鎮所屬國
	foreach(@CON_DATA){
	        ($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
	        $CONELE[$con2_id]=$con2_ele;
	        $CONNAME[$con2_id]=$con2_name;
	        $c_no++;
	}
	$hit=0;
	foreach(@CON_DATA){
	        ($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
	        if("$con2_id" eq "$town_con"){$hit=1;last;}
	}
	if(!$hit){$con2_ele=0;$con2_name="無所屬";$con2_id=0;}

	open(IN,"./data/towndata.cgi");
	@TOWN_DATA = <IN>;
	close(IN);

	$tpr="<table bgcolor=663300><TD width=15 height=10 bgcolor=ffffcc CLASS=GC>　</TD>";
	for($i=0;$i<6;$i++){
		$tpr.= "<TD width=15 height=10 bgcolor=ffffcc><font size=1>$i</TD>";
	}
	for($i=0;$i<6;$i++){
		$n = $i;
		$tpr.= "<TR><TD bgcolor=ffffcc><font size=1>$n</td>";
		for($j=0;$j<6;$j++){
			$m_hit=0;$tx=0;
			foreach(@TOWN_DATA){
				($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y,$town2_build,$town2_etc)=split(/<>/);
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
					$tpr.= "<TH bgcolor=$col><img src=\"$IMG/town/m_2.gif\" border=0 title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></TH>";
				}else{
					$tpr.= "<TH bgcolor=$col><img src=\"$IMG/town/m_4.gif\" border=0 title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></TH>";
				}
			}else{
				$tpr.= "<TH>　</TH>";
			}
		}
		$tpr.= "</TR>";
	}
	$tpr.="</table>";
	$tpr2="<TD colspan=2 align=center bgcolor=\"$ELE_C[$con2_ele]\">$tpr</TD>";
                
	}
	if ($town_sta ne""){
		$town_sta2="";
	}
	$top_print=<<"_TPR_";
	<TR>
      	<TD align="center">
      	<TABLE border="0" width="100%" id="town_datas">
	<TBODY>
 
          <TR>
            <TD height="38">
            <TABLE  border="0" bgcolor="$ELE_BG[$town_ele]" width=100% CLASS=CC2>
              <TBODY>
		<TR>
            	<TD colspan="11" bgcolor="$ELE_BG[$con2_ele]" id="town_name1" style="color:white"></TD>
          	</TR>
		<TR><TD colspan="11">
		<TR>
                  <TD align="center" bgcolor="$ELE_C[$con2_ele]" colspan="2"><a href="#downl"><img src="$timg" border=0></a></TD>
		  $tpr2
                  <TD colspan="7" bgcolor="#000000" style="color:FFFFCC">
                  在這裡居住的居民主要是由其他種族的人們移居到這裡，而且常有來來往往的商人，使得城鎮日益繁榮<div id="shot_mesg"></div>。
		  </TD>
                </TR>
		<TR>
                  <TD colspan="11" style="color:#ffffcc" id="town_name2">資料載入中....</TD>
                </TR><TR>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5%>收益</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5% id="town_gold" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5%>所屬國</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5% id="con2_name" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5%>所在</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5% id="town_xy" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5%>屬性</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" width=12.5% id="town_ele" style="color:3333CC"></TD>
                </TR>
                <TR>
                  <TD bgcolor="$ELE_C[$con2_ele]">武器開發值</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_arm" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]">防具開發值</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_pro" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]">飾品開發值</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_acc" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]">產業值</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_ind" style="color:3333CC"></TD>
                </TR>
                <TR>
                  <TD bgcolor="$ELE_C[$con2_ele]">兵力</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_hp" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]">士兵攻擊力</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_str" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]">士兵防禦力</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_def" style="color:3333CC"></TD>
                  <TD bgcolor="$ELE_C[$con2_ele]">崗哨數量</TD>
                  <TD bgcolor="$ELE_C[$con2_ele]" id="town_def_max" style="color:3333CC"></TD>
                </TR></TBODY>
		</TD>
		</TR>
		<TR>
		<TD colspan=11>
		<font color=$ELE_C[$con2_ele]>都市守備
		</TD>
		</TR>
		<TR>
		<TD colspan=11 bgcolor=$ELE_C[$con2_ele] style="color:$ELE_BG[$con2_ele]" id="def_list">
		</TD>
		</TR><TR>
	    <TD>
	    <TR>
	    <table CLASS=CC width=100%>
	    <TR>
	    <TD width=15% style="color:$ELE_C[$con_ele]" id="con_gold_name">
	    </TD><TD bgcolor=$ELE_C[$con_ele] width=50% colspan=5 align=right id="con_gold"></TD>
	    </TR>
	    </table>
	    </TR>
	    </TD>
	    
	  </TR>
              </TBODY>
            </TABLE>
            </TD>
          </TR>
_TPR_
}
1;
