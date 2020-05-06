sub mix {
	&chara_open;
	&status_print;
	&town_open;
	&equip_open;
	&ext_open;
	$val_off=0;
	#アビリティ情報
	($msk[0],$msk[1]) = split(/,/,$msk);
        open(IN,"./logfile/ability/$mid.cgi");
        @ABDATA = <IN>;
        close(IN);

	foreach(@ABDATA){
		($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
		if($kabno eq"87"){
			$cans=1;
			last;
		}
	}

	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);

	foreach(@ABILITY){
		($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
		if($msk[0] eq $abno || $msk[1] eq $abno){
			$mab[$abtype]=1;
			$mabdmg[$abtype]=$abdmg/10;
		}
	}
	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
$itemtotal=@ITEM;
	close(IN);
	$no2=0;
	$mixno=0;
	if($member_mix){$addpoint="(+50%合成卷效果,成功上限提升到100%)";}
	if($ext_mix[1] eq ""){$ext_mix[1]=0;}
        if($ext_mix[2] eq ""){$ext_mix[2]=0;}
        if($ext_mix[3] eq ""){$ext_mix[3]=0;}
        if($ext_mix[4] eq ""){$ext_mix[4]=0;}
        if($ext_mix[5] eq ""){$ext_mix[5]=0;}
        if($ext_mix[6] eq ""){$ext_mix[6]=0;}
        if($ext_mix[7] eq ""){$ext_mix[7]=0;}

	$mixno2=0;
	$eleno=0;
	foreach(@ELE){
		if ($eleno>0){
			$elelist.="<Option value=$eleno>$ELE[$eleno]原料</option>";
		}
		$eleno++;
	}
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
		$sel_val=int($it_val/2);
		$ittable.="<TR><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$sel_val</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD></TR>";
		if($it_ki eq"5"){
			$mixno++;
		}elsif($it_ki eq"0" && $it_stas[0]>0 && $it_no eq"rea"){
		        foreach(@ABILITY){
		                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
				if($it_stas[0] eq $abno){
					last;
	                	}
		        }
			$spoint=int(($it_dmg-($it_wei*3))/10);
			if($it_ele eq $marmele) {
				$spoint+=10;
				if($it_ele eq $mele){$spoint+=10;}
			}
			if($spoint>50){$spoint=50;}
			$armsta.="<option value=$no2>$it_name($abname)基礎成功率，$spoint％$addpoint</option>";
		}elsif($it_ki eq"1" && $it_stas[0]>0 && $it_no eq"rea"){
                        foreach(@ABILITY){
                                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                if($it_stas[0] eq $abno){
                                        last;
                                }
                        }
                        $spoint=int(($it_dmg-($it_wei*3))/10);
			if($spoint>50){$spoint=50;}
			if($it_ele eq $mproele) {
				$spoint+=10;
				if($it_ele eq $mele){$spoint+=10;}
			}
                        $prosta.="<option value=$no2>$it_name($abname)基礎成功率，$spoint％$addpoint</option>";
		}elsif($it_ki eq"2" && $it_stas[0]>0 && $it_no eq"rea"){
                        foreach(@ABILITY){
                                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                if($it_stas[0] eq $abno){
                                        last;
                                }
                        }
                        $spoint=int(($it_dmg-($it_wei*3))/10);
			$spoint2=$spoint;
			if($spoint>50){$spoint=50;}
                        if($it_ele eq $mpetele) {
				$spoint+=10;
				if($it_ele eq $mele){$spoint+=10;}
			}
                        $petsta.="<option value=$no2>$it_name($abname)基礎成功率，$spoint％$addpoint</option>";
                        if($it_ele eq $maccele) {
                                $spoint2+=10;
                                if($it_ele eq $mele){$spoint2+=10;}
                        }

                        $accsta.="<option value=$no2>$it_name($abname)基礎成功率，$spoint2％$addpoint</option>";
                }elsif($it_ki eq"7"){
                        foreach(@ABILITY){
                                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                if($it_stas[0] eq $abno){
                                        last;
                                }
                        }
                        $spoint=int(($it_dmg-($it_wei*3))/10);
                        if($spoint>50){$spoint=50;}
			if($it_dmg eq"0"){
	                        $armsta2.="<option value=$no2>$it_name($abname)基礎成功率，$spoint％$addpoint</option>";
			}elsif($it_dmg eq"1"){
                                $prosta2.="<option value=$no2>$it_name($abname)基礎成功率，$spoint％$addpoint</option>";
			}elsif($it_dmg eq"2"){
                                $accsta2.="<option value=$no2>$it_name($abname)基礎成功率，$spoint％$addpoint</option>";
                        }elsif($it_dmg eq"4"){
                                $petsta2.="<option value=$no2>$it_name($abname)基礎成功率，$spoint％$addpoint</option>";
			}
		}

		$no2++;
	}

        #合成
	$mixno=1;
        if($mab[37] || $cans){
		foreach(@ext_mix){
			if ($ext_mix[$mixno] >2){
				$mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();wname(true);\"></td><td bgcolor=white><font color=blue>$ELE[$mixno]武、防、飾製成</font></td><td bgcolor=white>每100點1%成功率</td><td bgcolor=white>每100萬1%成功率</td><td bgcolor=white>$ELE[$mixno]原料x3</td></td></TR>";
				$mixno2++;
			}
			if ($ext_mix[$mixno]>1){
                                $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();wsel(true);\"></td><td bgcolor=white><font color=blue>原料合成</font></td><td bgcolor=white>每100點20%成功率</td><td bgcolor=white>每100萬20%成功率</td><td bgcolor=white>$ELE[$mixno]原料x2</td></td></TR>";
                                $mixno2++;
			}
			$mixno++;
		}
#武強化
		if ($marmno eq"mix" && $ext_mix[$marmele]>0) {
			$mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden2();\"></td><td bgcolor=white><font color=blue>$marmname強化</font></td><td bgcolor=white>每100點10%成功率</td><td bgcolor=white>每100萬10%成功率</td><td bgcolor=white>$ELE[$marmele]原料x1</td></td></TR>";
                                $mixno2++;
		}
#防強化
                if ($mprono eq"mix" && $ext_mix[$mproele]>0) {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden2();\"></td><td bgcolor=white><font color=blue>$mproname強化</font></td><td bgcolor=white>每100點10%成功率</td><td bgcolor=white>每100萬10%成功率</td><td bgcolor=white>$ELE[$mproele]原料x1</td></td></TR>";
                                $mixno2++;
                }
#武注奧
                if ($marmno eq"mix" && $armsta ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();armsta(true);\"></td><td bgcolor=white><font color=blue>「$marmname」注入奧義</font></td><td bgcolor=white>每500點1%成功率</td><td bgcolor=white>每500萬1%成功率</td><td bgcolor=white>奧義武器</td></td></TR>";
			 $mixno2++;
		}
                
#武注奧
                if ($mprono eq"mix" && $prosta ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();prosta(true);\"></td><td bgcolor=white><font color=blue>「$mproname」注入奧義</font></td><td bgcolor=white>每500點1%成功率</td><td bgcolor=white>每500萬1%成功率</td><td bgcolor=white>奧義防具</td></td></TR>";
                         $mixno2++;
                }
#寵注奧
                if ($mpetname ne"" && $petsta ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();petsta(true);\"></td><td bgcolor=white><font color=blue>「$mpetname」注入奧義</font></td><td bgcolor=white>每500點1%成功率</td><td bgcolor=white>每500萬1%成功率</td><td bgcolor=white>奧義飾品</td></td></TR>";
                         $mixno2++;
                }
#寵轉熟
                if ($mpetname ne"" && $ext_mix[$mpetele]>2) {
			$getabp=($mpetdmg+$mpetdef+$mpetspeed*2)*10;
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();\"></td><td bgcolor=white><font color=blue>「$mpetname」轉$getabp熟練書</font></td><td colspan=2 align=center bgcolor=white>100熟或100萬=100%成功</td><td bgcolor=white>$ELE[$mpetele]原料x3</td></td></TR>";
                         $mixno2++;
                }
#飾品強化
                if ($maccno eq"mix" && $ext_mix[$maccele]>2) {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden2();\"></td><td bgcolor=white><font color=blue>$maccname強化</font></td><td bgcolor=white>每100點10%成功率</td><td bgcolor=white>每100萬10%成功率</td><td bgcolor=white>$ELE[$maccele]原料x3</td></td></TR>";
                         $mixno2++;
                }
#飾注奧
                if ($maccno eq"mix" && $accsta ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();accsta(true);\"></td><td bgcolor=white><font color=blue>「$maccname」注入奧義</font></td><td bgcolor=white>每1000點1%成功率</td><td bgcolor=white>每1000萬1%成功率</td><td bgcolor=white>奧義飾品</td></td></TR>";
                         $mixno2++;
                }
#奧義石(武)
                if ($marmno eq"mix" && $armsta2 ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();armsta2(true);\"></td><td bgcolor=white><font color=blue>「$marmname」注入奧義之石</font></td><td bgcolor=white>每2000點1%成功率</td><td bgcolor=white>每2000萬1%成功率</td><td bgcolor=white>奧義之石</td></td></TR>";
                         $mixno2++;
                }
#奧義石(防)
                if ($mprono eq"mix" && $prosta2 ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();prosta2(true);\"></td><td bgcolor=white><font color=blue>「$mproname」注入奧義之石</font></td><td bgcolor=white>每2000點1%成功率</td><td bgcolor=white>每2000萬1%成功率</td><td bgcolor=white>奧義之石</td></td></TR>";
                         $mixno2++;
                }
#奧義石(飾)
                if ($maccno eq"mix" && $accsta2 ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();accsta2(true);\"></td><td bgcolor=white><font color=blue>「$maccname」注入奧義之石</font></td><td bgcolor=white>每2000點1%成功率</td><td bgcolor=white>每2000萬1%成功率</td><td bgcolor=white>奧義之石</td></td></TR>";
                         $mixno2++;
                }
#奧義石(寵)
                if ($mpetname ne"" && $petsta2 ne"") {
                        $mixtable.="<TR><td bgcolor=ffffcc><input type=radio name=no value=$mixno2 onclick=\"javascript:allhidden();petsta2(true);\"></td><td bgcolor=white><font color=blue>「$mpetname」注入奧義之石</font></td><td bgcolor=white>每2000點1%成功率</td><td bgcolor=white>每2000萬1%成功率</td><td bgcolor=white>奧義之石</td></td></TR>";
                         $mixno2++;
                }

	}

	&header;
	
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">工房</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc">在此可以利用你的熟練度或金錢製作以下的物品但你必須先從鐵匠職業學會合成的相關技能。<BR>請選擇你要製作的物品(如果你要強化或注入奧義你的自製裝備,請先將它們裝備在身上,寵物如要注入奧義也請先讓牠上場)<BR><font color=yellow>※奧義注入成功率最高50%</font>。「<a href="/hero_data/html/mix.html" target="_blank"><font color=#AAAAFF>鐵匠說明</font></a>」</FONT></TD>
    </TR>
    <TR>
      <TD align=center bgcolor="ffffff" colspan=2 width=55%>
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>目前原料數</font></td></tr>
        <tr>
        <td bgcolor=ffffcc>火</td><td bgcolor=ffffcc>水</td><td bgcolor=ffffcc>風</td><td bgcolor=ffffcc>星</td><td bgcolor=ffffcc>雷</td><td bgcolor=ffffcc>光</td><td bgcolor=ffffcc>闇</td>
        </tr>
        <tr>
        <td bgcolor=white>$ext_mix[1]</td><td bgcolor=white>$ext_mix[2]</td><td bgcolor=white>$ext_mix[3]</td><td bgcolor=white>$ext_mix[4]</td><td bgcolor=white>$ext_mix[5]</td><td bgcolor=white>$ext_mix[6]</td><td bgcolor=white>$ext_mix[7]</td>
        </tr>
	</table>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=5 align=center><font color=ffffcc>可製作品一覽</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>花費熟練</td><td bgcolor=white>花費金錢</td><td bgcolor=white>所需物品</td>
	</tr>
	<form action="./town.cgi" method="post">
	$mixtable
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=itemtotal value=$itemtotal>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<div id="darmsta" style="display:none;">選擇要注入的奧義<select size="1" name="iarmsta">$armsta</select></div>
	<div id="dprosta" style="display:none;">選擇要注入的奧義<select size="1" name="iprosta">$prosta</select></div>
	<div id="dpetsta" style="display:none;">選擇要注入的奧義<select size="1" name="ipetsta">$petsta</select></div>
        <div id="daccsta" style="display:none;">選擇要注入的奧義<select size="1" name="iaccsta">$accsta</select></div>
        <div id="darmsta2" style="display:none;">選擇要注入的奧義之石<select size="1" name="iarmsta2">$armsta2</select></div>
        <div id="dprosta2" style="display:none;">選擇要注入的奧義之石<select size="1" name="iprosta2">$prosta2</select></div>
        <div id="dpetsta2" style="display:none;">選擇要注入的奧義之石<select size="1" name="ipetsta2">$petsta2</select></div>
        <div id="daccsta2" style="display:none;">選擇要注入的奧義之石<select size="1" name="iaccsta2">$accsta2</select></div>
	<div id="dname" style="display:none;"><select size="1" name="itype"><option value="0" selected>武器</option><option value="1">防具</option><option value="2">飾品</option><font color=blue>命名:</font><INPUT type=text name=it_name size=12>(請為自己的裝備命名4~8個全形或16個英文字)</div>
	<div id="dname2" style="display:none;"><font color=blue>製作原料:</font><select szie="1" name="iele">$elelist</select></div>
	<div id="encnum" style="display:none;"><font color=blue>強化數量:</font><input type=text size=3 value=1 name="enc_num">(以下的使用熟練輸入每次強化的熟練<BR>如強化數量2,熟練輸入100,就等於花200熟強化兩次)</div>
	使用熟練<INPUT type=text name=useabp value=0 size=4>、
	使用金錢<INPUT type=text name=usegold value=0 size=6>萬
	<INPUT type=hidden name=mode value=mix2>
	<INPUT type=submit CLASS=FC value=製作></TD></TR></form>
	</table>
	
	<TD bgcolor="#ffffff" align=center>
	$STPR<BR>
	<table colspan=3 width=90% align=center CLASS=MC>
	<tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
	</table>
	<table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
	<BR>
	<TR><td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>所持物一覽($no2/$ITM_MAX)</font></td></tr>
	<TR>
	<td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font></td><td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td><td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
	</TR>
	<form action="./town.cgi" method="POST">
	$ittable
	<TR><TD colspan=7 align=center bgcolor=ffffff>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$itype>
	</TD></form>
	</TR></font>
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
<script language="javascript">
function allhidden(){
	wname(false);wsel(false);armsta(false);prosta(false);petsta(false);accsta(false);encnum(false);
	armsta2(false);prosta2(false);petsta2(false);accsta2(false);
}
function allhidden2(){
        wname(false);wsel(false);armsta(false);prosta(false);petsta(false);accsta(false);encnum(true);
        armsta2(false);prosta2(false);petsta2(false);accsta2(false);
}

function wname(v){
	if (v){
		document.getElementById("dname").style.display='';
	}else{
                document.getElementById("dname").style.display='none';
	}
	
}
function wsel(v){
        if (v){
                document.getElementById("dname2").style.display='';
        }else{
                document.getElementById("dname2").style.display='none';
        }
}
function armsta(v){
        if (v){
                document.getElementById("darmsta").style.display='';
        }else{
                document.getElementById("darmsta").style.display='none';
        }
}
function prosta(v){
        if (v){
                document.getElementById("dprosta").style.display='';
        }else{
                document.getElementById("dprosta").style.display='none';
        }
}
function petsta(v){
        if (v){
                document.getElementById("dpetsta").style.display='';
        }else{
                document.getElementById("dpetsta").style.display='none';
        }
}
function accsta(v){
        if (v){
                document.getElementById("daccsta").style.display='';
        }else{
                document.getElementById("daccsta").style.display='none';
        }
}
function armsta2(v){
        if (v){
                document.getElementById("darmsta2").style.display='';
        }else{
                document.getElementById("darmsta2").style.display='none';
        }
}
function prosta2(v){
        if (v){
                document.getElementById("dprosta2").style.display='';
        }else{
                document.getElementById("dprosta2").style.display='none';
        }
}
function petsta2(v){
        if (v){
                document.getElementById("dpetsta2").style.display='';
        }else{
                document.getElementById("dpetsta2").style.display='none';
        }
}
function accsta2(v){
        if (v){
                document.getElementById("daccsta2").style.display='';
        }else{
                document.getElementById("daccsta2").style.display='none';
        }
}
function encnum(v){
        if (v){
                document.getElementById("encnum").style.display='';
        }else{
                document.getElementById("encnum").style.display='none';
        }
}

</script>
EOF

	&footer;
	exit;
}
1;
