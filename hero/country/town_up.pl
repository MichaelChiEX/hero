sub town_up {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	if($con_id eq 0){&error("無所國無法進行城鎮開發。");}
	if($town_con ne $mcon){&error("請在本國的城鎮開發。");}

	$list="<select name=pow>";
	$list.="<option value=t_arm>武器開發";
	$list.="<option value=t_pro>防具開發";
	$list.="<option value=t_acc>飾品開發";
	$list.="<option value=t_ind>產業";

	$list.="</select>";
	$elei=0;
	if($con_ele eq $town_ele){
		$plus_up=0.7;
	}elsif($ANELE[$town_ele] eq $con_ele){
		$plus_up=1.3;
	}else{
		$plus_up=1;
	}
	foreach(@ELE){
		if($elei>0 && $elei ne $town_ele){
			if ($town_mix_lv[$elei] eq ""){$town_mix_lv[$elei]="0";}
			$need_gold=($town_mix_lv[$elei]+1)*1000*$plus_up;
			$need_cex=($town_mix_lv[$elei]+1)*10*$plus_up;
			$mix_list.="<tr style=\"font-size: 12px\"><td bgColor=\"white\">$ELE[$elei]原料</td><td bgColor=\"white\">LV.$town_mix_lv[$elei]</td><td bgColor=\"white\">國庫$need_gold萬，個人名聲扣除$need_cex</td>";
			$mix_list.="<td bgColor=\"white\"><input CLASS=FC type=\"button\" onclick=\"javascript:mix_ups($elei);\" value=\"提昇黑商交換$ELE[$elei]原料的關係\" name=\"B1\"></td></tr>";
		}
		$elei++;
	}
	&header;
	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">城鎮開發</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">對$town_name進行開發，以及對黑商的行賄。<br>名聲需要大於５００，請選擇要開發的項目。<br>國家資金：<font color="yellow">$scon_gold</font><br><font color="#ffffcc">黑商每提升一等關係，每天可交換的原料多１個</td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	<form action="./country.cgi" method="post">
	$list
	<input type=text size=5 name=gold>萬
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=town_up2>
	<input type=submit value=開發 CLASS=FC></form>
<table class="TC" border="0" width="100%" bgColor="#883300" id="table1">
	<tr>
		<td colSpan="4" align="middle"><font color="#FFFFCC">本鎮($ELE[$town_ele])原料黑商關係</font></td>
	</tr>
	<tr>
		<td bgColor="white">名稱</td>
		<td bgColor="white">關係</td>
		<td bgColor="white">提升代價</td>
		<td bgColor="white">提升關係</td>
	</tr>
$mix_list
	
</table>
$BACKTOWNBUTTON
</td>
		<form method="post" action="./country.cgi" name="mix_up">
			<input type=hidden name=gold value=10000>
		        <input type=hidden name=id value=$mid>
		        <input type=hidden name=pow>
		        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		        <input type=hidden name=mode value=town_up2>
		   </form>	
    </tr>
  </tbody>
</table>
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
