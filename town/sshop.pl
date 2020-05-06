sub sshop {
	&chara_open;
	&status_print;
	&town_open;
	&equip_open;
	$val_off=0;
	&time_data;

	$date = time();
	open(IN,"./data/sfree.cgi") or &error("檔案開啟錯誤[$idata](town/fshop.pl(10))。");
	@F_DATA = <IN>;
	close(IN);
        open(IN,"./data/ability.cgi");
        @ABILITY = <IN>;
        close(IN);
	$no=0;
	foreach(@F_DATA){
		($f_no,$f_ki,$f_name,$f_val,$f_dmg,$f_wei,$f_ele,$f_hit,$f_cl,$f_sta,$f_type,$f_flg,$f_id,$f_hname,$f_min,$f_max,$f_p,$f_last,$f_lname,$f_time,$f_pat)=split(/<>/);
                $it_type_name="";
                if($f_ki>=0 && $f_ki<3 || $f_ki eq"4" || $f_ki eq"7") {
		($f_stas[0],$f_stas[1])=split(/:/,$f_sta);
                        foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($f_stas[0] eq $abno){
                                                $it_type_name=$abname.$it_type_name;
                                        }elsif($f_stas[1] eq $abno){
                                                $it_type_name.="、$abname";
                                        }
                                }
                }else{
                        $it_type_name="";
                }		
		$f_time2=int(($f_time-$date)/3600);
		$f_timec="剩於$f_time2小時";
		if($f_time2 < 1){
			$f_time3=int(($f_time-$date)/60);
			if($f_time3 >0) {
				$f_timec="剩餘$f_time3分";
			}else{
				$f_timec="";
			}
		}
		if($f_timec ne""){
		$f_val2=$f_val/10000;
		$f_p2=$f_p/10000;
        if ($f_p2>9999) {
                $f_p2=int($f_p2/10000)."億".($f_p2%10000)."萬";
        }else{
                $f_p2.="萬";
        }
		$f_max2=$f_max/10000;
        if ($f_max2>9999) {
                $f_max2=int($f_max2/10000)."億".($f_max2%10000)."萬";
        }else{
                $f_max2.="萬";
        }
		$f_tb="<input type=radio name=no value=$no onclick=\"javascript:this.form.f_name.value='$f_name'\"";
		if ($f_ki eq 4) {
                        $fptable.="<TR><TD width=5% bgcolor=ffffcc><font size=1>$f_tb</font></TD><TD bgcolor=white><font size=1>$EQU[$f_ki]</font></TD><TD bgcolor=white><font size=1>$f_name</font></TD><TD bgcolor=white><font size=1>$f_hit</font></TD><TD bgcolor=white><font size=1>$f_val</font></TD><TD bgcolor=white><font size=1>$f_dmg</font></TD><TD bgcolor=white><font size=1>$f_wei</font></TD><TD bgcolor=white><font size=1>$ELE[$f_ele]</font></TD><TD bgcolor=white><font size=1>$f_hname</font></TD><TD bgcolor=white><font size=1>$f_max2</font></TD><TD bgcolor=white><font size=1>$f_timec</font></TD><TD bgcolor=white><font size=1>$it_type_name </font></TD></TR>";
		}else{
	                $ftable.="<TR><TD width=5% bgcolor=ffffcc><font size=1>$f_tb</font></TD><TD bgcolor=white><font size=1>$EQU[$f_ki]</font></TD><TD bgcolor=white><font size=1>$f_name$add</font></TD><TD bgcolor=white colspan=2><font size=1>$f_dmg</font></TD><TD bgcolor=white colspan=2><font size=1>$f_wei</font></TD><TD bgcolor=white><font size=1>$ELE[$f_ele]</font></TD><TD bgcolor=white><font size=1>$f_hname</font></TD><TD bgcolor=white><font size=1>$f_max2</font></TD><TD bgcolor=white><font size=1>$f_timec</font></TD><TD bgcolor=white><font size=1>$it_type_name</font></TD></TR>";
		}	
		}elsif($f_id eq $mid) {
			$getback.="<INPUT type=hidden name=no value=$no><INPUT type=submit CLASS=FC value=取回交易品「$f_name」>";
		}
		$no++;
	}

	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$no2=0;
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		$sel_val=int($it_val/2);
                $it_type_name="";
                if($it_ki>=0 && $it_ki<3 || $it_ki eq"7") {
			($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                        foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                $it_type_name=$abname.$it_type_name;
                                        }elsif($it_stas[1] eq $abno){
                                                $it_type_name.="、$abname";
                                        }
                                }
                }else{
                        $it_type_name="";
                }
		if ($it_ki eq 4) {
                        $pettable.="<TR><TD width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></TD><TD bgcolor=white><font size=1>$it_name</font></TD><TD bgcolor=white><font size=1>$it_hit</font></TD><TD bgcolor=white><font size=1>$it_val</font></TD><TD bgcolor=white><font size=1>$it_dmg</font></TD><TD bgcolor=white><font size=1>$it_wei</font></TD><TD bgcolor=white><font size=1>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=1>$EQU[$it_ki]</font></TD><TD bgcolor=white><font size=1>$it_type_name</font></TD></TR>";
		}else{
	                $ittable.="<TR><TD width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></TD><TD bgcolor=white><font size=1>$it_name</font></TD><TD colspan=2 bgcolor=white><font size=1>$sel_val</font></TD><TD bgcolor=white><font size=1>$it_dmg</font></TD><TD bgcolor=white><font size=1>$it_wei</font></TD><TD bgcolor=white><font size=1>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=1>$EQU[$it_ki]</font></TD><TD bgcolor=white><font size=1>$it_type_name</font></TD></TR>";
		}
		$no2++;
	}

	&header;
	
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="4" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">交易所</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc">[交易所店員]<BR>歡迎來到交易所。目前出售的物品如下。<BR>請選擇你要購買的物品或是販售的物品</FONT></TD>
    </TR>
    <TR>
      <TD align=center bgcolor="ffffff" colspan=4 width=100%>
	<font size=1>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<form action="./town.cgi" method="post">
	<tr><td colspan=14 align=center><font color=ffffcc>交易品一覽</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td>
	<td bgcolor=white><font size=1>種類</font></td>
	<td bgcolor=white><font size=1>名稱</font></td>
	<td bgcolor=white colspan=2><font size=1>威力</font></td>
	<td bgcolor=white colspan=2><font size=1>重量</font></td>
	<td bgcolor=white><font size=1>屬性</font></td>
	<td bgcolor=white><font size=1>出品者</font></td>
	<td bgcolor=white><font size=1>售價</font></td>
	<td bgcolor=white><font size=1>期限</font></td>
        <td bgcolor=white><font size=1>奧義</font></td>
	</tr>
	$ftable
        <tr><td colspan=14 align=center><font color=ffffcc>寵物交易品一覽</font></td></tr>
        <tr>
        <td bgcolor=ffffcc></td>
        <td bgcolor=white><font size=1>種類</font></td>
        <td bgcolor=white><font size=1>名稱</font></td>
        <td bgcolor=white><font size=1>等級</font></td>
        <td bgcolor=white><font size=1>威力</font></td>
        <td bgcolor=white><font size=1>防禦</font></td>
        <td bgcolor=white><font size=1>速度</font></td>
        <td bgcolor=white><font size=1>屬性</font></td>
        <td bgcolor=white><font size=1>出品者</font></td>
        <td bgcolor=white><font size=1>售價</font></td>
        <td bgcolor=white><font size=1>期限</font></td>
        <td bgcolor=white><font size=1>奧義</font></td>
        </tr>
        $fptable
	<TR><TD colspan=15 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$itype>
	<INPUT type=hidden name=mode value=sshop2>
	<INPUT type=hidden name=f_name>
	<INPUT type=submit CLASS=FC value=確定購買>
</form><form action=\"./town.cgi\" method=\"post\">
<INPUT type=hidden name=id value=$mid>
<INPUT type=hidden name=pass value=$mpass>
<input type=hidden name=rmode value=$in{'rmode'}>
<INPUT type=hidden name=mode value=sshop4>
$getback
</form>
</TD></TR>
	</FONT>
	</table>
	</TD></TR>
	<tr>
	<TD bgcolor="#ffffff" colspan="7" align=center>
	$STPR<BR>
	<form action="./town.cgi" method="POST">
	<table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
	<BR>
	<TR><td colspan=8 align=center bgcolor="$FCOLOR"><font color=ffffcc>目前持有物</font></td></tr>
	<TR>
	<TD bgcolor=ffffcc></TD><td bgcolor=white><font size=1>名稱</font></td><td colspan=2 bgcolor=white><font size=1>價值</font></td><td bgcolor=white><font size=1>威力</font></td><td bgcolor=white><font size=1>重量</font></td><td bgcolor=white><font size=1>屬性</font></td><td bgcolor=white><font size=1>種類</font></td><td bgcolor=white><font size=1>奧義</font></td>
	</TR>
	$ittable
        <TR><td colspan=8 align=center bgcolor="$FCOLOR"><font color=ffffcc>持有寵物</font></td></tr>
        <TR>
        <TD bgcolor=ffffcc></TD><td bgcolor=white><font size=1>名稱</font></td><td bgcolor=white><font size=1>等級</font></td><td bgcolor=white><font size=1>威力</font></td><td bgcolor=white><font size=1>防禦</font></td><td bgcolor=white><font size=1>速度</font></td><td bgcolor=white><font size=1>屬性</font></td><td bgcolor=white><font size=1>種類</font></td><td bgcolor=white><font size=1>奧義</font></td>
        </TR>
        $pettable
	<TR><TD colspan=9 align=center bgcolor=ffffff>
	<table border=0 width="50%" align=center bgcolor=$FCOLOR CLASS=TC>
	<tr>
	</tr>
	<TD bgcolor="#ffffff" colspan="3" align=center>
	售價：
	</TD>
	<TD bgcolor="#ffffff" colspan="3" align=center>
	<INPUT type=txt name=maxgold size=10>萬<br>
	</TD>
	</tr>
	<TD bgcolor="#ffffff" colspan="3" align=center>
	期限：
	</TD>
	<TD bgcolor="#ffffff" colspan="3" align=center>
	<INPUT type=txt name=hour size=10>小時<br>
	</TD>
	</tr>
	</table>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$itype>
	<INPUT type=hidden name=mode value=sshop3>
	<INPUT type=submit CLASS=FC value=確定出售></TD></form>
	</TR></font>
	</table>
	</TD>
    </TR>
    <TR>
    <TD colspan="7" align="center" bgcolor="ffffff">
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
