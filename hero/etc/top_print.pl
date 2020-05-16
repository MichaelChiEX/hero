sub top_print{
	if(!$mflg){
		##地圖表示
		#取得目前城鎮所屬國
		foreach(@CON_DATA){
			($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
			$CONELE[$con2_id]=$con2_ele;
			$CONNAME[$con2_id]=$con2_name;
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

		$tpr="<table bgcolor=663300><td width=15 height=10 bgcolor=ffffcc CLASS=GC>　</td>";
		for($i=0;$i<6;$i++){
			$tpr.= "<td width=15 height=10 bgcolor=ffffcc><font size=1>$i</td>";
		}
		for($i=0;$i<6;$i++){
			$n = $i;
			$tpr.= "<tr><td bgcolor=ffffcc><font size=1>$n</td>";
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
						$tpr.= "<th bgcolor=$col><img src=\"$IMG/town/m_2.gif\" border=0 title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></th>";
					}else{
						$tpr.= "<th bgcolor=$col><img src=\"$IMG/town/m_4.gif\" border=0 title=\"$town2_name($ELE[$town2_ele])【$CONNAME[$town2_con]國】\" width=15 height=10></th>";
					}
				}else{
					$tpr.= "<th>　</th>";
				}
			}
			$tpr.= "</tr>";
		}
		$tpr.="</table>";
		$tpr2="<td colspan=2 align=center bgcolor=\"$ELE_C[$con2_ele]\">$tpr</td>";        
	}

	$top_print=<<"_TPR_";
	<tr>
      	<td align="center">
      	<table border="0" width="100%" id="town_datas">
	<tbody>
 
          <tr>
            <td height="38">
            <table  border="0" bgcolor="$ELE_BG[$town_ele]" width=100% CLASS=CC2>
              <tbody>
		<tr>
            	<td colspan="11" bgcolor="$ELE_BG[$con2_ele]" id="town_name1" style="color:white"></td>
          	</tr>
		<tr><td colspan="11">
		<tr>
                  <td align="center" bgcolor="$ELE_C[$con2_ele]" colspan="2"><a href="#downl"><img src="$timg" border=0></a></td>
		  $tpr2
                  <td colspan="7" bgcolor="#000000" style="color:FFFFCC">
                  在這裡居住的居民主要是由其他種族的人們移居到這裡，而且常有來來往往的商人，使得城鎮日益繁榮<div id="shot_mesg"></div>。
		  </td>
                </tr>
		<tr>
                  <td colspan="11" style="color:#ffffcc" id="town_name2">資料載入中....</td>
                </tr><tr>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5%>收益</td>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5% id="town_gold" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5%>所屬國</td>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5% id="con2_name" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5%>所在</td>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5% id="town_xy" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5%>屬性</td>
                  <td bgcolor="$ELE_C[$con2_ele]" width=12.5% id="town_ele" style="color:3333CC"></td>
                </tr>
                <tr>
                  <td bgcolor="$ELE_C[$con2_ele]">武器開發值</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_arm" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]">防具開發值</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_pro" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]">飾品開發值</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_acc" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]">產業值</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_ind" style="color:3333CC"></td>
                </tr>
                <tr>
                  <td bgcolor="$ELE_C[$con2_ele]">兵力</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_hp" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]">士兵攻擊力</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_str" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]">士兵防禦力</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_def" style="color:3333CC"></td>
                  <td bgcolor="$ELE_C[$con2_ele]">崗哨數量</td>
                  <td bgcolor="$ELE_C[$con2_ele]" id="town_def_max" style="color:3333CC"></td>
                </tr></tbody>
		</td>
		</tr>
		<tr>
		<td colspan=11>
		<font color=$ELE_C[$con2_ele]>都市守備
		</td>
		</tr>
		<tr>
		<td colspan=11 bgcolor=$ELE_C[$con2_ele] style="color:$ELE_BG[$con2_ele]" id="def_list">
		</td>
		</tr><tr>
	    <td>
	    <tr>
	    <table CLASS=CC width=100%>
	    <tr>
	    <td width=15% style="color:$ELE_C[$con_ele]" id="con_gold_name">
	    </td><td bgcolor=$ELE_C[$con_ele] width=50% colspan=5 align=right id="con_gold"></td>
	    </tr>
	    </table>
	    </tr>
	    </td>
	    
	  </tr>
              </tbody>
            </table>
            </td>
          </tr>
_TPR_
}
1;
