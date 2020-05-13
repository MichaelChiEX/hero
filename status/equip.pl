sub equip{
	&chara_open;
	&status_print;
	&equip_open;
	&ext_open;
	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$no2=0;
	
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);
	
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_flg)=split(/<>/);
		$sel_val=int($it_val/2);
		$it_type_name="";
		if($it_ki>=0 && $it_ki<3 || $it_ki eq"4") {
			($it_types[0],$it_types[1])=split(/:/,$it_type);
			foreach(@ABILITY){
                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                if($it_types[0] eq $abno){
                    $it_type_name=$abname.$it_type_name;
                }elsif($it_types[1] eq $abno){
                    $it_type_name.="、$abname";
                }
            }
		}
		if($it_ki>=0 && $it_ki<=3){$ittable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></td><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$sel_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td><td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td><td bgcolor=white><font size=2>$it_type_name</font></td></tr>";}elsif($it_ki eq 4){
			$pettable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></td><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$it_hit</font></td><td bgcolor=white><font size=2>$it_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td><td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td><td bgcolor=white><font size=2>$it_type_name</font></td></tr>";
		}
		$no2++;
	}
	
	$abname1="";
	$abname2="";
	$abname3="";
    ($marmstas[0],$marmstas[1])=split(/:/,$marmsta);
    ($mprostas[0],$mprostas[1])=split(/:/,$mprosta);
    ($maccstas[0],$maccstas[1])=split(/:/,$maccsta);
    ($mpetstas[0],$mpetstas[1])=split(/:/,$mpetsta);
	foreach(@ABILITY){
		($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
        if($marmstas[0] eq $abno){
            $abname1=$abname.$abname1;
        }elsif($marmstas[1] eq $abno){
            $abname1.="、$abname";
        }
        if($mprostas[0] eq $abno){
            $abname2=$abname.$abname2;
        }elsif($mprostas[1] eq $abno){
            $abname2.="、$abname";
        }
        if($maccstas[0] eq $abno){
            $abname3=$abname.$abname3;
        }elsif($maccstas[1] eq $abno){
            $abname3.="、$abname";
        }
        if($mpetstas[0] eq $abno){
            $abname4=$abname.$abname4;
        }elsif($mpetstas[1] eq $abno){
            $abname4.="、$abname";
        }
	}
	if ($mpetname ne"") {
		$petinput="<input type=submit value=收回寵物>";
	}
	&header;
	
	print <<"EOF";
    <table border="0" width="90%" align=center class=TC height="400">
        <tbody>
            <tr>
                <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="$FCOLOR2">使用/裝備/寵物</font></td>
            </tr>
            <tr>
                <td colspan=2 align="center" bgcolor="000000" height=50><font color="$FCOLOR2">請選擇你要使用的物品、裝備或要上場的寵物。</font></td>
            </tr>
            <tr>
                <td bgcolor="#ffffff" align=center>
                    $STPR
                    <table colspan=3 width=90% align=center class=MC>
                        <br>
                        <tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>奧義</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
                        <tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$abname1</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
                        <tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$abname2</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
                        <tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$abname3</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
                    </table>
                    <form action="./status.cgi" method="post">
                        <input type=hidden name=mode value=outpet>
                        <input type=hidden name=id value=$mid>
                        <input type=hidden name=pass value=$mpass>
                        <input type=hidden name=rmode value=$in{'rmode'}>
                        <table  width=90% align=center class=MC>
                            <tr><td bgcolor="$ELE_BG[$mele]"></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>屬性</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>等級</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>防禦</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>速度</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>奧義</font></td></tr>
                            <tr><td bgcolor="$ELE_C[$mele]">$petinput</td><td bgcolor="$ELE_C[$mele]">$ELE[$mpetele]</td><td bgcolor="$ELE_C[$mele]">$mpetname</td><td bgcolor="$ELE_C[$mele]">$mpetlv</td><td bgcolor="$ELE_C[$mele]">$mpetdmg</td><td bgcolor="$ELE_C[$mele]">$mpetdef</td><td bgcolor="$ELE_C[$mele]">$mpetspeed</td><td bgcolor="$ELE_C[$mele]">$abname4</td></tr>
                        </table>
                    </form>
                    <form action="./status.cgi" method="post" name="abuse">
                        <input type=hidden name=id value=$mid>
                        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                        <input type=hidden name=mode value=equip3>
                        <input type=hidden name=num value=1>
                        <input type=hidden name=abno value=>
                    </form>
                    <table border="0" align=center width="100%" height="1" class=MC>
                        <tbody>
                            <tr>
                                <td colspan="6" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>能力果</font></td>
                            </tr>
                            <tr>
                                <td bgcolor="$ELE_C[$mele]" align="center">能力果</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">持有數量</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">使用數量</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">使用</td>
                            </tr>
                            <tr>
                                <td bgcolor="$ELE_C[$mele]" align="center">力量之果</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[0]</td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=text value=1 size=3 id=num0></td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=button value=使用力量之果 onclick="javascript:subab(0,'num0');"></td>
                            </tr>
                            <tr>
                                <td bgcolor="$ELE_C[$mele]" align="center">生命之果</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[1]</td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=text value=1 size=3 id=num1></td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=button value=使用生命之果 onclick="javascript:subab(1,'num1');"></td>
                            </tr>
                            <tr>
                                <td bgcolor="$ELE_C[$mele]" align="center">智慧之果</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[2]</td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=text value=1 size=3 id=num2></td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=button value=使用智慧之果 onclick="javascript:subab(2,'num2');"></td>
                            </tr>
                            <tr>
                                <td bgcolor="$ELE_C[$mele]" align="center">精神之果</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[3]</td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=text value=1 size=3 id=num3></td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=button value=使用精神之果 onclick="javascript:subab(3,'num3');"></td>
                            </tr>
                            <tr>
                                <td bgcolor="$ELE_C[$mele]" align="center">運氣之果</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[4]</td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=text value=1 size=3 id=num4></td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=button value=使用運氣之果 onclick="javascript:subab(4,'num4');"></td>
                            </tr>
                            <tr>
                                <td bgcolor="$ELE_C[$mele]" align="center">速度之果</td>
                                <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[5]</td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=text value=1 size=3 id=num5></td>
                                <td bgcolor="$ELE_C[$mele]" align="center"><input type=button value=使用速度之果 onclick="javascript:subab(5,'num5');"></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td bgcolor="#ffffff" align=center>
                    <table border=0 width="90%" align=center class=TC>
                        <tr>
                            <td colspan=7 align=center><font color=ffffcc>所持物一覽</font></td>
                        </tr>
                        <tr>
                            <td bgcolor=ffffcc></td><td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>賣價</font></td>
                            <td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td>
                            <td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font><td bgcolor=white>
                            <font size=2>奧義</font></td>
                        </tr>
                        <form action="./status.cgi" method="POST">
                        $ittable
                        <tr>
                            <td colspan=8 align=center bgcolor=ffffff>
                                <input type=hidden name=id value=$mid>
                                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                                <input type=hidden name=itype value=$itype>
                                <input type=hidden name=mode value=equip2>
                                <input type=submit class=FC value=使用／裝備>
                            </td>
                        </form>
                        </tr>
                    </table>
                    <table border=0 width="90%" align=center class=TC>
                        <tr>
                            <td colspan=8 align=center><font color=ffffcc>寵物一覽</font></td>
                        </tr>
                        <tr>
                            <td bgcolor=ffffcc></td><td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>等級</font></td>
                            <td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>防禦</font></td>
                            <td bgcolor=white><font size=2>速度</font></td><td bgcolor=white><font size=2>屬性</font></td>
                            <td bgcolor=white><font size=2>種類</font><td bgcolor=white><font size=2>奧義</font></td>
                        </tr>
                        <form action="./status.cgi" method="POST">
                        $pettable
                        <tr>
                            <td colspan=9 align=center bgcolor=ffffff>
                                <input type=hidden name=id value=$mid>
                                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                                <input type=hidden name=itype value=$itype>
                                <input type=hidden name=mode value=equip2>
                                <input type=submit class=FC value=上場>
                            </td>
                        </form>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" bgcolor="ffffff">
                    <input type="button" value="返回" class=FC onclick="javascript:parent.backtown();">
                </td>
            </tr>
        </tbody>
    </table>
    <script>
        function subab(abnos,numn){
            abuse.num.value=document.getElementById(numn).value;
            abuse.abno.value=abnos;
            abuse.submit();
        }
    </script>
EOF
&footer;
exit;
}
1;
