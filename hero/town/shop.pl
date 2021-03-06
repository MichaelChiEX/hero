sub shop {
	&chara_open;
	&status_print;
	&town_open;
	&equip_open;

	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);
	&ext_open;
	&quest_open;
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
	if($abname1 eq""){$abname1="－";}
	if($abname2 eq""){$abname2="－";}
	if($abname3 eq""){$abname3="－";}
	if($abname4 eq""){$abname4="－";}

	$val_off=0;
	if($mcon eq $town_con && $town_con ne 0){
		$val_off=int($mcex/100)+1;
		if($val_off>15){$val_off=15;}
		$mes="<br><font color=#AAAAFF>$mname</font>你好。你在此地購物將獲得<font color=yellow size=5>$val_off%</font>的優惠。";
	}

	if($in{'mode'} eq"arm"){$idata="arm";$itype=0;$dev=$town_arm;}
	elsif($in{'mode'} eq"pro"){$idata="pro";$itype=1;$dev=$town_pro;}
	elsif($in{'mode'} eq"acc"){$idata="acc";$itype=2;$dev=$town_acc;}
	elsif($in{'mode'} eq"item"){$idata="item";$itype=3;$dev=$town_ind;}
	else{&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	open(IN,"./data/$idata.cgi");
	@ARM_DATA = <IN>;
	close(IN);

	$no=0;
	foreach(@ARM_DATA){
		($arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos)=split(/<>/);
		$arm_val2=$arm_val;
		$arm_val=int($arm_val*(1-$val_off/100));
		if(($town_id eq $arm_pos || $arm_pos eq"all") && $arm_val2>0 && ($arm_val2<=($dev*$dev*10+100)||$dev>=999)){
			if($arm_sta && $in{'mode'} ne "item"){$arm_name="$arm_name";}
			$armtable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=no value=$no></td><td bgcolor=white><font size=2>$arm_name</font></td><td bgcolor=white align=right><font size=2>$arm_val Gold</font></td><td bgcolor=white><font size=2>$arm_dmg</font></td><td bgcolor=white><font size=2>$arm_wei</font></td><td bgcolor=white><font size=2>$ELE[$arm_ele]</font></td><td bgcolor=white><font size=2>$arm_type</font></td></tr>";
		}elsif($quest1_town_no eq $town_id && $arm_name eq $quest1_item){
			$armtable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=no value=$no></td><td bgcolor=white><font size=2>$arm_name</font></td><td bgcolor=white align=right><font size=2>$arm_val Gold</font></td><td bgcolor=white><font size=2>$arm_dmg</font></td><td bgcolor=white><font size=2>$arm_wei</font></td><td bgcolor=white><font size=2>$ELE[$arm_ele]</font></td><td bgcolor=white><font size=2>$arm_type</font></td></tr>";
		}
		$no++;
	}
	if($town_con>=0){
		open(IN,"./data/carm.cgi");
		@CARM = <IN>;
		close(IN);
		foreach(@CARM){
			($arm_t,$arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos)=split(/<>/);
			$arm_val=int($arm_val*(1-$val_off/100));
			if(($town_id eq $arm_pos && $arm_t eq $itype) && $arm_val>0 && ($arm_val<=($dev*$dev*10+100) || $dev>=999)){
				if($arm_sta){$arm_name="$arm_name";}
				$armtable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=no value=$no></td><td bgcolor=white><font size=2>$arm_name</font></td><td bgcolor=white align=right><font size=2>$arm_val Gold</font></td><td bgcolor=white><font size=2>$arm_dmg</font></td><td bgcolor=white><font size=2>$arm_wei</font></td><td bgcolor=white><font size=2>$ELE[$arm_ele]</font></td><td bgcolor=white><font size=2>$arm_type</font></td></tr>";
			}
			$no++;
		}
	}

	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$no2=0;
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		if($it_ki ne 4){
        	        $sel_val=int($it_val/2);
			if($it_ki >4){}
			elsif($it_no eq "rea" && $it_name =~ /★/){$sel_val=40000000;}
	                elsif($it_no eq "rea" && $it_ki eq 3){$sel_val=3000000;}
                	elsif($it_no eq "rea"){$sel_val=10000000;}
		
			$ittable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></td><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$sel_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td><td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td></tr>";
		}else{
		        $pettable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></td><td bgcolor=white><font size=2>$it_hit</font></td><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$it_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td><td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td></tr>";
		}
		$no2++;
	}

	&header;
	
	print <<"EOF";
<table border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <tbody>
    <tr>
      <td colspan="3" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">$EQU[$itype]店</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></td>
      <td bgcolor="#330000" colspan="3"><font color="#ffffcc">[$EQU[$itype]店]<br>歡迎光臨。$mes<br>請選擇要購買的物品。</font></td>
    </tr>
    <tr>
      <td align=center bgcolor="ffffff" colspan=2 width=55%>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=7 align=center><font color=ffffcc>商品一覽</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white>名稱</td><td bgcolor=white>價格</td><td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td><td bgcolor=white>種類</td>
	</tr>
	<form action="./town.cgi" method="post">
	$armtable
	<tr><td colspan=7 align=center bgcolor="ffffff">
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=itype value=$itype>
	<input type=hidden name=mode value=buy>
	<input type=submit CLASS=FC value=購入></td></tr></form>
	</table>
	
	<td bgcolor="#ffffff" align=center>
	$STPR<br>
	<table colspan=3 width=90% align=center CLASS=MC>
	<tr><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>種類</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>名稱</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>奧義</font></td><td bgcolor="$ELE_BG[$mele]"><font color=ffffcc>威力/重量</font></td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">武器</td><td bgcolor="$ELE_C[$mele]">$marmname</td><td bgcolor="$ELE_C[$mele]">$abname1</td><td bgcolor="$ELE_C[$mele]">$marmdmg/$marmwei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">防具</td><td bgcolor="$ELE_C[$mele]">$mproname</td><td bgcolor="$ELE_C[$mele]">$abname2</td><td bgcolor="$ELE_C[$mele]">$mprodmg/$mprowei</td></tr>
	<tr><td bgcolor="$ELE_C[$mele]">飾品</td><td bgcolor="$ELE_C[$mele]">$maccname</td><td bgcolor="$ELE_C[$mele]">$abname3</td><td bgcolor="$ELE_C[$mele]">$maccdmg/$maccwei</td></tr>
	</table>
	<table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
	<br>
	<tr><td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>目前所持物品</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font></td><td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td><td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
	</tr>
	<form action="./town.cgi" method="POST">
	$ittable
	<tr><td colspan=7 align=center bgcolor=ffffff>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=itype value=$itype>
	<input type=hidden name=mode value=sell>
	<input type=submit CLASS=FC value=賣出物品></td></form>
	</tr></font>
	</table>

 <table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
        <br>
        <tr><td colspan=8 align=center bgcolor="$FCOLOR"><font color=ffffcc>寵物一覽</font></td></tr>
        <tr>
        <td bgcolor=ffffcc></td><td bgcolor=white><font size=2>等級</font></td><td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>防禦</font></td><td bgcolor=white><font size=2>速度</font></td><td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
        </tr>
        <form action="./town.cgi" method="POST">
        $pettable
        <tr><td colspan=8 align=center bgcolor=ffffff>
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=itype value=$itype>
        <input type=hidden name=mode value=sell>
        <input type=submit CLASS=FC value=丟棄寵物></td></form>
        </tr></font>
        </table>

	</td>
    </tr>
    <tr>
    <td colspan="3" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
	</td>
    </tr>
  </tbody>
</table>
EOF

	&footer;
	exit;
}
1;
