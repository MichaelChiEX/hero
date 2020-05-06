sub rpetup {
	&chara_open;
	
	#if($mpet eq""){&error("你必須帶著你的寵物才可進行訓練");}

	&status_print;
	&town_open;
	&equip_open;

        ($msk[0],$msk[1]) = split(/,/,$msk);
        ($esk[0],$esk[1]) = split(/,/,$esk);
        open(IN,"./data/ability.cgi");
        @ABILITY = <IN>;
        close(IN);
	$abname1="";
	$showpetname="";
        $ej=0;
        $tranbutton="";
	$tmppoint=0;
	if ($mpet ne"") {
		$showpetname="$mpetname($ELE[$mpetele])";
        	foreach(@PETDATA){
	                if ($PETDATA[$ej][0] eq $mpetname){
				$tmppoint=$PETDATA[$ej][5]/10000;
                	        $tranbutton="<input CLASS=FC type=submit value=花費$tmppoint萬訓練>";
				last;
        	        }
			$ej++;
	        }

	}
	if ($tmppoint eq 0) {
		$tranbutton="<font color=red>你的寵物無法訓練</font>";
	}elsif ($ej>=49 && $mpetlv>=10){
		$tranbutton="<font color=darkgreen>你的寵物已經達到最強狀態，不需要再進行訓練</font>"
	}
#取得84傳說馴獸師奧義
        foreach(@ABILITY){
                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                if($msk[0] eq $abno || $msk[1] eq $abno || $marmsta eq $abno || $mprosta eq $abno || $maccsta eq $abno || $mpetsta eq $abno){
                        $mab[$abno]=1;
                }
                if($mpetsta eq $abno){
                        $abname1=$abname;
                }
        }
        if ($mab[84] ne 1){
                &error("你必須有傳說馴獸師的奧義，才可以接進傳說中的馴獸師");
        }
	&header;
	
	print <<"EOF";

<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">傳說中的馴獸師</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/1.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc">[傳說中的馴獸師]<BR>你好,讓我幫你訓練寵物需要一定的酬勞。<BR>請將你要訓練的寵物帶在身上，支付酬勞後我們就開始訓練。</FONT></TD>
    </TR>
    <TR>
      <TD align=center bgcolor="ffffff" colspan=2 width=55%>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>你身上的寵物</font></td></tr>
	<form action="./town.cgi" method="post">
	<tr>
        <td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>等級</td><td bgcolor=white>威力</td><td bgcolor=white>防禦</td><td bgcolor=white>速度</td><td bgcolor=white>奧義</td>
	</tr>
	<tr>
        <td bgcolor=ffffcc></td><td bgcolor=white>$showpetname</td><td bgcolor=white>$mpetlv</td><td bgcolor=white>$mpetdmg</td><td bgcolor=white>$mpetdef</td><td bgcolor=white>$mpetspeed</td><td bgcolor=white>$abname1</td>
	</tr>
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=rpetup2>
	$tranbutton</TD></TR></form>
	</table>
	
	<TD bgcolor="#ffffff" align=center>
	$STPR<BR>
	<table colspan=3 width=90% align=center CLASS=MC>
	<tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
	</table>
	</TD>
    </TR>
    <TR>
    <TD colspan="3" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF

	&footer;
	exit;
}
1;
