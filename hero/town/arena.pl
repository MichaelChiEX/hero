sub arena {
	&chara_open;
	&header;
	&status_print;
	$arena_gold=10000;
	if($mgold<$arena_gold){
		$mes="你目前手上的金額不足$arena_gold Gold 無法進行挑戰。";
	}
	open(IN,"./data/chanp.cgi") or &error("案檔開啟錯誤：town/arena.pl(9)。");
	@CHANP = <IN>;
	close(IN);
	($eid,$ename,$echara,$eele,$ehp,$emaxhp,$emp,$emaxmp,$estr,$evit,$eint,$efai,$edex,$eagi,$earm,$epro,$eacc,$etec,$esk,$etype,$eclass,$emes,$eex,$egold,$eren,$epet)=split(/<>/,$CHANP[0]);
	$elv = int($eex/100)+1;
	&equip_open;
	if($eid ne $mid && $mgold>=$arena_gold){
		$form= <<"EOF";
		<form action="./battle.cgi" method="post">
		<input type=hidden name=id value=$mid>
		<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		<input type=hidden name=mode value=battle2>
		<input type=submit value=挑戰(需花費$arena_gold\Gold) CLASS=FC></form>
EOF
	}
	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">鬥技場</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">$mname來到了鬥技場。<br>如果你對自己的能力有信心，可以花費$arena_gold進行挑戰。<br>挑戰勝者可以獲得獎金 $egold Gold？$mes</font></td>
    </tr>
    <tr>
      <td colspan=2>
	<table border="0" align=center width="70%" height="143" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="5" align="center" bgcolor="$FCOLOR"><font color=$FCOLOR2 size=4>目前鬥技場冠軍</font></td>
    </tr>
    <tr>
      <td colspan="5" class=FC align="center" ><font color=$FCOLOR2><font color=$FCOLOR>現在$eren連勝中　獎金：$egold Gold</font></td>
    </tr>
    <tr>
      <td rowspan="5" bgcolor="$ELE_C[$eele]" align=center><img src="$IMG/chara/$echara.gif"></td>
      <td bgcolor="$ELE_C[$eele]" align="left">等級</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$elv</td>
      <td bgcolor="$ELE_C[$eele]">職業</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$TYPE[$etype]</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">ＨＰ</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$ehp/$emaxhp</td>
      <td bgcolor="$ELE_C[$eele]">ＭＰ</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$emp/$emaxmp</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">力量</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$estr</td>
      <td bgcolor="$ELE_C[$eele]">生命力</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$evit</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">智力</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$eint</td>
      <td bgcolor="$ELE_C[$eele]">精神</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$efai</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">運氣</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$edex</td>
      <td bgcolor="$ELE_C[$eele]">速度</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$eagi</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]" align="center">$ename</td>
      <td bgcolor="$ELE_C[$eele]">職業</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$JOB[$eclass]</td>
      <td bgcolor="$ELE_C[$eele]">屬性</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$ELE[$eele]</td>
    </tr>
   
    <tr>
      <td colspan="5" align="center" bgcolor="$FCOLOR"><font color=$FCOLOR2>裝備</font></td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]"></td>
      <td colspan="2" bgcolor="$ELE_C[$eele]" align="center">名稱</td>
      <td bgcolor="$ELE_C[$eele]" align="center">威力</td>
      <td bgcolor="$ELE_C[$eele]" align="center">重量</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">武器</td>
      <td colspan="2" bgcolor="$ELE_C[$eele]" align="right">$earmname($ELE[$earmele])</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$earmdmg</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$earmwei</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">防具</td>
      <td colspan="2" bgcolor="$ELE_C[$eele]" align="right">$eproname($ELE[$eproele])</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$eprodmg</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$eprowei</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">飾品</td>
      <td colspan="2" bgcolor="$ELE_C[$eele]" align="right">$eaccname($ELE[$eaccele])</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$eaccdmg</td>
      <td bgcolor="$ELE_C[$eele]" align="right">$eaccwei</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$eele]">寵物</td>
      <td colspan="2" bgcolor="$ELE_C[$eele]" align="right">$epetname.lv$epetval($ELE[$epetele])</td>
      <td bgcolor="$ELE_C[$eele]" align="right" colspan="2">威力：$epetdmg、防禦：$epetdef、速度：$epetspeed</td>
    </tr>
    <tr>
      <td colspan=5 align=center bgcolor="$FCOLOR"><font color=$FCOLOR2>戰鬥宣言</font></td>
    </tr>
　　<tr>
      <td colspan=5 bgcolor="$ELE_C[$eele]">$emes</td>
    </tr>
	</table>
      </td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	$form
$BACKTOWNBUTTON
	</td>	
    </tr>
  </tbody>
</table>
<center>$STPR</center>
EOF

	&footer;
	exit;
}
1;
