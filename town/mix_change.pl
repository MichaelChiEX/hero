sub mix_change {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	&ext_open;
	if($con_id eq 0){&error("無所國無法進行黑商原料交易。");}
        if($ext_mix[1] eq ""){$ext_mix[1]=0;}
        if($ext_mix[2] eq ""){$ext_mix[2]=0;}
        if($ext_mix[3] eq ""){$ext_mix[3]=0;}
        if($ext_mix[4] eq ""){$ext_mix[4]=0;}
        if($ext_mix[5] eq ""){$ext_mix[5]=0;}
        if($ext_mix[6] eq ""){$ext_mix[6]=0;}
        if($ext_mix[7] eq ""){$ext_mix[7]=0;}

	$elei=0;
	foreach(@ELE){
		if($elei>0 && $elei ne $town_ele){
			if ($town_mix_lv[$elei] eq ""){$town_mix_lv[$elei]="0";}
			$plus_up=1;
			if ($ANELE[$elei] eq $town_ele){
				$plus_up=1.5;
			}
			$need_cex=100*$plus_up;
			if($town_mix[$elei] eq""){$town_mix[$elei]="0";}
			$mix_list.="<tr style=\"font-size: 12px\"><td bgColor=\"white\">$ELE[$elei]原料</td><td bgColor=\"white\">LV.$town_mix_lv[$elei]</td><td bgColor=\"white\">$need_cex</td><td bgColor=\"white\">$town_mix[$elei]</td>";
			if($ext_mix[$elei] eq "0"){
                                $mix_list.="<td bgColor=\"white\">你身上沒有$ELE[$elei]原料</td></tr>";
			}elsif($need_cex>$mcex){
                                $mix_list.="<td bgColor=\"white\">你的名聲不足</td></tr>";
			}elsif($town_mix[$elei] eq"0"){
                                $mix_list.="<td bgColor=\"white\">已無存量</td></tr>";
			}else{
                                $mix_list.="<td bgColor=\"white\"><input CLASS=FC type=\"button\" onclick=\"javascript:mix_ups($elei);\" value=\"交換$ELE[$town_ele]原料\" name=\"B1\"></td></tr>";
			}
		}
		$elei++;
	}
	&header;
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">$ELE[$town_ele]原料黑商</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">你來到$town_name原料黑市交易商，在這你可以用身上的原料跟黑商交換$ELE[$town_ele]原料。<BR>在黑市交易將會扣除你的名聲<BR>目前名聲：<font color="yellow">$mcex</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>目前原料數</font></td></tr>
        <tr>
        <td bgcolor=ffffcc>火</td><td bgcolor=ffffcc>水</td><td bgcolor=ffffcc>風</td><td bgcolor=ffffcc>星</td><td bgcolor=ffffcc>雷</td><td bgcolor=ffffcc>光</td><td bgcolor=ffffcc>闇</td>
        </tr>
        <tr>
        <td bgcolor=white>$ext_mix[1]</td><td bgcolor=white>$ext_mix[2]</td><td bgcolor=white>$ext_mix[3]</td><td bgcolor=white>$ext_mix[4]</td><td bgcolor=white>$ext_mix[5]</td><td bgcolor=white>$ext_mix[6]</td><td bgcolor=white>$ext_mix[7]</td>
        </tr>
        </table>

<table class="TC" border="0" width="100%" bgColor="#883300" id="table1">
	<tr>
		<td colSpan="5" align="middle"><font color="#FFFFCC">本鎮($ELE[$town_ele])原料黑商</font></td>
	</tr>
	<tr>
		<td bgColor="white">你身上要交換的原料</td>
		<td bgColor="white">關係</td>
		<td bgColor="white">扣除名聲</td>
                <td bgColor="white">庫存量</td>
		<td bgColor="white">交換原料</td>
	</tr>
$mix_list
	
</table>
$BACKTOWNBUTTON
</TD>
		<form method="post" action="./town.cgi" name="mix_up">
			<INPUT type=hidden name=gold value=10000>
		        <INPUT type=hidden name=id value=$mid>
		        <INPUT type=hidden name=pow>
		        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		        <INPUT type=hidden name=mode value=mix_change2>
		   </form>	
    </TR>
  </TBODY>
</TABLE>
<script language="javascript">
function mix_ups(ele){
	mix_up.pow.value=ele;
	mix_up.submit();
}
</script>
<center></center>
EOF
	&footer;
	exit;
}
1;
