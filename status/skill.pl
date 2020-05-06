sub skill {
	&chara_open;
	&header;
	&status_print;

	#アビリティ情報
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);

	#取得済みアビリティ情報
	open(IN,"./logfile/ability/$mid.cgi");
	@ABDATA = <IN>;
	close(IN);

	#能力上昇に必要な熟練度
	$point=int(($mmaxstr+$mmaxvit+$mmaxint+$mmaxmen+$mmaxdex+$mmaxagi-1000)/20);
	$uppoint=$point*$point;
	if($uppoint>10000){$uppoint=10000;}

	require './data/abini.cgi';
	@jlist = split(/,/,$AJOB[$mclass]);

	$i=0;
	foreach(@jlist){
		$jobflg[$jlist[$i]] = 1;
		$i++;
	}
	$j=0;
	foreach(@ABILITY){
		($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
		if($jobflg[$abclass] eq 1){
			$sumi="<input type=radio name=skill value=$abno>";
			$hit=0;
			foreach(@ABDATA){
				($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
				if($kabno eq $abno){
					$sumi="<font color=red>已修行</font>";
				}
				if($kabno eq $abrate){
					$hit=1;
				}
			}
			if($hit eq 1 || $abrate eq 0){
				$abtable.="<TR><TD width=5% bgcolor=ffffcc align=center><font color=red>$sumi</font></TD><TD bgcolor=$FCOLOR2>$abname</TD><TD bgcolor=$FCOLOR2>$abcom</TD><TD bgcolor=$FCOLOR2 align=right>$abpoint</TD></TR>";
			}
		}
		$j++;
	}
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">奧義取得/修行</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=#AAFFFF>$mname</font> 你好。<BR>在此你可以消費熟練度來取得你目前職業可練成的奧義。<BR>或者消費你的熟練度來修行 ，獲得能力的提昇，下表為能力提昇跟職業系的關系表。<BR>
<font color=yellow>注意：修行上限為４００</FONT><br>


      </TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
<table border="0" width="100%" id="table1" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center">
<table borderColor="#000000" cellSpacing="1" border="1" id="table1">
	<tr bgColor="#fff27b">
		<th><span style="font-weight: 400"><font size="2">職業</font></span></th>
		<th><span style="font-weight: 400"><font size="2">力量</font></span></th>
		<th><span style="font-weight: 400"><font size="2">生命</font></span></th>
		<th><font size="2"><span style="font-weight: 400">智</span></font><span style="font-weight: 400"><font size="2">力</font></span></th>
		<th><span style="font-weight: 400"><font size="2">精神</font></span></th>
		<th><span style="font-weight: 400"><font size="2">運氣</font></span></th>
		<th><font size="2"><span style="font-weight: 400">速度</span></font></th>
	</tr>
	<tr bgColor="#ffffff">
		<th><font size="2" color="#E170A4"><span style="font-weight: 400">劍術</span></font></th>
		<th><font size="2" color="#EE0026"><span style="font-weight: 400">◎</span></font></th>
		<th><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
	</tr>
	<tr bgColor="#ffffff">
		<th><font size="2" color="#FF0088"><span style="font-weight: 400">魔術</span></font></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">◎</span></font></b></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
	</tr>
	<tr bgColor="#ffffff">
		<th><font size="2" color="#679FCA"><span style="font-weight: 400">神術</span></font></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">◎</span></font></b></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
	</tr>
	<tr bgColor="#ffffff">
		<th><font size="2" color="#A45AAA"><span style="font-weight: 400">弓術</span></font></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">◎</span></font></b></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
	</tr>
	<tr bgColor="#ffffff">
		<th><font size="2" color="#FF9914"><span style="font-weight: 400">體術</span></font></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">◎</span></font></b></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
	</tr>
	<tr bgColor="#ffffff">
		<th><font size="2" color="#33A23D"><span style="font-weight: 400">忍術</span></font></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><span style="font-weight: 400"><font color="#ee0026" size="2">　</font></span></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">Ｏ</span></font></b></th>
		<th><b><font size="2" color="#EE0026"><span style="font-weight: 400">◎</span></font></b></th>
	</tr>
</table>
		</td>
		<td align="center">$STPR </td>
	</tr>
</table>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>可取得奧義一覽表</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=$FCOLOR2 align=center>奧義名稱</td><td bgcolor=$FCOLOR2 align=center>效果</td><td bgcolor=$FCOLOR2 align=center>必要熟練度</td>
	</tr>
	<form action="./status.cgi" method="post">
	$abtable
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=skill2>
	<INPUT type=submit CLASS=FC value=奧義修行></TD></TR></form>
	</table>

	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>能力修行</font></td></tr>
	<tr>
	<td bgcolor=$FCOLOR2 align=center>效果</td><td bgcolor=$FCOLOR2 align=center>必要熟練度</td>
	</tr>
	<form action="./status.cgi" method="post">
	<TR><TD bgcolor=$FCOLOR2>提昇界限值</TD>
	<TD bgcolor=$FCOLOR2 align=right>$uppoint</TD></TR>
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=skill3>
	<INPUT type=submit CLASS=FC value=開始提昇能力></TD></TR></form>
	</table>
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
