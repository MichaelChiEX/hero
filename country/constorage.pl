sub constorage {
        &chara_open;
        &equip_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無國庫");}
        open(IN,"./data/ability.cgi");
        @ABILITY = <IN>;
        close(IN);

        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);

        open(IN,"./logfile/constorage/$mcon"."_max.cgi");
        $CONITEM_MAX = <IN>;
        close(IN);

	if ($CONITEM_MAX eq ""){
		$CONITEM_MAX=10;
	}
	$canget=1;
	if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){
		$canget=0;
		#&error("非官員以上人員無法提取裝備。");
	}
        $no1=0;
        foreach(@ITEM){
                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		$it_type_name="";
                if($it_ki>=0 && $it_ki<3 || $it_ki eq"7") {
			($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                        foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                $it_type_name=$abname;
                                        }elsif($it_stas[1] eq $abno){
                                                $it_type_name.="、$abname";
                                        }
                                }
			$ittable.="<TR><TD width=5% bgcolor=ffffcc><input type=button value=存入 onclick=javascript:this.form.no.value=$no1;this.form.submit();></TD><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD><TD bgcolor=white><font size=2>$it_type_name</font></TD></TR>";
		}
                $no1++;
        }

        open(IN,"./logfile/constorage/$mcon.cgi");
        @STORAGE = <IN>;
        close(IN);
        $no2=0;
        foreach(@STORAGE){
                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
                $it_type_name="";
                if($it_ki>=0 && $it_ki<3 || $it_ki eq"7") {
			($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                        foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                $it_type_name=$abname;
                                        }elsif($it_stas[1] eq $abno){
                                                $it_type_name.="、$abname";
                                        }
                                }
			if ($canget) {
				$sttable.="<TR><TD width=5% bgcolor=ffffcc><input type=button value=取出 onclick=javascript:this.form.no.value=$no2;this.form.submit();></TD><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD><TD bgcolor=white><font size=2>$it_type_name</font></TD></TR>";
			}else{
				$sttable.="<TR><TD width=5% bgcolor=ffffcc></TD><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD><TD bgcolor=white><font size=2>$it_type_name</font></TD></TR>";
			}
		}
                $no2++;
        }
        &header;

        print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">國庫</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc"><font color=#AAAAFF>$con_name國</font>的國庫<BR>您可以將身上的裝備捐入國家的國庫中。<BR>但只有國王及官職人員可以提取裝備<BR><font color=yellow>注意：寵物、道具及合成材料無法存放到國庫</FONT></TD>
    </TR>
    <TR>
      <TD align=center bgcolor="ffffff" colspan=2 width=55% valign=top>
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>$con_name國倉庫物品一覽($no2/$CONITEM_MAX)</font></td></tr>
        <tr>
        <td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td><td bgcolor=white>種類</td><td bgcolor=white>奧義</td>
        </tr>
        <form action="./country.cgi" method="post">
        $sttable
        <TR><TD colspan=8 align=center bgcolor="ffffff">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=no>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=itype value=$itype>
        <INPUT type=hidden name=mode value=constorage_out>
        </TD></TR></form>
        </table>

        <TD bgcolor="#ffffff" align=center valign=top>
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>手持物品一覽($no1/$ITM_MAX)</font></td></tr>
        <tr>
        <td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td><td bgcolor=white>種類</td><td bgcolor=white>奧義</td>
        </tr>
        <form action="./country.cgi" method="post">
        $ittable
        <TR><TD colspan=8 align=center bgcolor="ffffff">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=no>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=itype value=$itype>
        <INPUT type=hidden name=mode value=constorage_in>
        </TD></TR></form>
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
