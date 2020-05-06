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
		<INPUT type=hidden name=id value=$mid>
		<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		<INPUT type=hidden name=mode value=battle2>
		<INPUT type=submit value=挑戰(需花費$arena_gold\Gold) CLASS=FC></form>
EOF
	}
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">鬥技場</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$mname來到了鬥技場。<BR>如果你對自己的能力有信心，可以花費$arena_gold進行挑戰。<BR>挑戰勝者可以獲得獎金 $egold Gold？$mes</FONT></TD>
    </TR>
    <TR>
      <td colspan=2>
	<TABLE border="0" align=center width="70%" height="143" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="5" align="center" bgcolor="$FCOLOR"><font color=$FCOLOR2 size=4>目前鬥技場冠軍</font></TD>
    </TR>
    <TR>
      <TD colspan="5" class=FC align="center" ><font color=$FCOLOR2><font color=$FCOLOR>現在$eren連勝中　獎金：$egold Gold</font></TD>
    </TR>
    <TR>
      <TD rowspan="5" bgcolor="$ELE_C[$eele]" align=center><img src="$IMG/chara/$echara.gif"></TD>
      <TD bgcolor="$ELE_C[$eele]" align="left">等級</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$elv</TD>
      <TD bgcolor="$ELE_C[$eele]">職業</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$TYPE[$etype]</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">ＨＰ</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$ehp/$emaxhp</TD>
      <TD bgcolor="$ELE_C[$eele]">ＭＰ</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$emp/$emaxmp</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">力量</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$estr</TD>
      <TD bgcolor="$ELE_C[$eele]">生命力</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$evit</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">智力</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$eint</TD>
      <TD bgcolor="$ELE_C[$eele]">精神</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$efai</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">運氣</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$edex</TD>
      <TD bgcolor="$ELE_C[$eele]">速度</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$eagi</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]" align="center">$ename</TD>
      <TD bgcolor="$ELE_C[$eele]">職業</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$JOB[$eclass]</TD>
      <TD bgcolor="$ELE_C[$eele]">屬性</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$ELE[$eele]</TD>
    </TR>
   
    <TR>
      <TD colspan="5" align="center" bgcolor="$FCOLOR"><font color=$FCOLOR2>裝備</font></TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]"></TD>
      <TD colspan="2" bgcolor="$ELE_C[$eele]" align="center">名稱</TD>
      <TD bgcolor="$ELE_C[$eele]" align="center">威力</TD>
      <TD bgcolor="$ELE_C[$eele]" align="center">重量</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">武器</TD>
      <TD colspan="2" bgcolor="$ELE_C[$eele]" align="right">$earmname($ELE[$earmele])</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$earmdmg</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$earmwei</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">防具</TD>
      <TD colspan="2" bgcolor="$ELE_C[$eele]" align="right">$eproname($ELE[$eproele])</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$eprodmg</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$eprowei</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">飾品</TD>
      <TD colspan="2" bgcolor="$ELE_C[$eele]" align="right">$eaccname($ELE[$eaccele])</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$eaccdmg</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right">$eaccwei</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$eele]">寵物</TD>
      <TD colspan="2" bgcolor="$ELE_C[$eele]" align="right">$epetname.lv$epetval($ELE[$epetele])</TD>
      <TD bgcolor="$ELE_C[$eele]" align="right" colspan="2">威力：$epetdmg、防禦：$epetdef、速度：$epetspeed</TD>
    </TR>
    <TR>
      <TD colspan=5 align=center bgcolor="$FCOLOR"><font color=$FCOLOR2>戰鬥宣言</font></TD>
    </TR>
　　<TR>
      <TD colspan=5 bgcolor="$ELE_C[$eele]">$emes</TD>
    </TR>
	</table>
      </td>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$form
$BACKTOWNBUTTON
	</TD>	
    </TR>
  </TBODY>
</TABLE>
<center>$STPR</center>
EOF

	&footer;
	exit;
}
1;
