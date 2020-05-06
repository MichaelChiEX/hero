sub sk_set {
	&chara_open;
	&status_print;

	#アビリティ情報
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);

	#取得済みアビリティ情報
	open(IN,"./logfile/ability/$mid.cgi");
	@ABDATA = <IN>;
	close(IN);

	($msk[0],$msk[1]) = split(/,/,$msk);

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
                if($msk[0] eq $abno){
                        $abname1=$abname;
                        $abcom1=$abcom;
                }
                if($msk[1] eq $abno){
                        $abname2=$abname;
                        $abcom2=$abcom;
                }
                foreach(@ABDATA){
                        ($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
                        if($kabno eq $abno){
				if($ab1[$kabtype] eq"" || $ab1[$kabtype]<$kabdmg){
					$ab1[$kabtype]=$kabdmg;
				}
                        }
                        if($kabno eq $abno && $jobflg[$abclass] eq 1){
				if($ab2[$kabtype] eq"" || $ab2[$kabtype]<$kabdmg){
					$ab2[$kabtype]=$kabdmg;
				}
                        }
                }
                $j++;
        }
        foreach(@ABILITY){
                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);

				if($ab1[$abtype] ne"" && $ab1[$abtype] eq "$abdmg" && $abno ne"103"){
					if($abno eq"55" || $abno eq"83" || $abno eq"87" || $abtype eq "21"){
                                                $abtable.="<TR><TD width=5% bgcolor=ffffcc align=center>不需安裝</TD><TD bgcolor=$FCOLOR2>$abname</TD><TD bgcolor=$FCOLOR2>$abcom</TD></TR>";
					}else{
						$abtable.="<TR><TD width=5% bgcolor=ffffcc align=center><input type=radio name=skill value=$abno></TD><TD bgcolor=$FCOLOR2>$abname</TD><TD bgcolor=$FCOLOR2>$abcom</TD></TR>";
					}
				}
				if($ab2[$abtype] ne"" && $ab2[$abtype] eq "$abdmg"){
                                        if($abno eq"55" || $abno eq"83" || $abno eq"87" || $abtype eq "21"){
                                                $abtable2.="<TR><TD width=5% bgcolor=ffffcc align=center>不需安裝</TD><TD bgcolor=$FCOLOR2>$abname</TD><TD bgcolor=$FCOLOR2>$abcom</TD></TR>";
					}else{
						$abtable2.="<TR><TD width=5% bgcolor=ffffcc align=center><input type=radio name=skill2 value=$abno></TD><TD bgcolor=$FCOLOR2>$abname</TD><TD bgcolor=$FCOLOR2>$abcom</TD></TR>";
					}
				}
                                
                }
	&header;
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">奧義變更</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000">
	<FONT color="#ffffcc" size=2>
	你好<font color=blue>$mname</font>。在這裡能進行奧義的變更。請選擇要變更的奧義。
	<BR>主要奧義可選擇你所有曾經學過的奧義，職業奧義只能選擇你目前職業可用的奧義。
	<BR><FONT color="red">※請特別注意在同時設定兩種相同的奧義、或者是同一系列的奧義，會有無法執行的狀況！</FONT>
	</FONT>
　　　</TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR 
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>主要奧義</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=$FCOLOR2 align=center>名稱</td><td bgcolor=$FCOLOR2 align=center>效果</td>
	</tr>
	<tr><td width=5% bgcolor=ffcc99 align=center>目前裝備</td><td bgcolor=ee9999>$abname1</td><td bgcolor=ee9999>$abcom1</td></tr>
	<form action="./status.cgi" method="post">
	$abtable
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=sk_set2>
	<INPUT type=hidden name=type value=1>
	<INPUT type=submit CLASS=FC value=變更主要奧義></TD></TR></form>
	</table>

	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>職業奧義</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=$FCOLOR2 align=center>名稱</td><td bgcolor=$FCOLOR2 align=center>效果</td>
	</tr>
	<tr><td width=5% bgcolor=ffcc99 align=center>目前裝備</td><td bgcolor=ee9999>$abname2</td><td bgcolor=ee9999>$abcom2</td></tr>
	<form action="./status.cgi" method="post">
	$abtable2
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=sk_set2>
	<INPUT type=hidden name=type value=2>
	<INPUT type=submit CLASS=FC value=變更職業奧義></TD></TR></form>
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
