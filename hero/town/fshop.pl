sub fshop {
	&chara_open;
	&status_print;
	&town_open;
	&equip_open;
	$val_off=0;
	&time_data;

	$date = time();
	open(IN,"./data/free.cgi") or &error("檔案開啟錯誤[$idata](town/fshop.pl(10))。");
	@F_DATA = <IN>;
	close(IN);
	$no=0;
        open(IN,"./data/ability.cgi");
        @ABILITY = <IN>;
        close(IN);
	foreach(@F_DATA){
		($f_no,$f_ki,$f_name,$f_val,$f_dmg,$f_wei,$f_ele,$f_hit,$f_cl,$f_sta,$f_type,$f_flg,$f_id,$f_hname,$f_min,$f_max,$f_p,$f_last,$f_lname,$f_time,$f_pat)=split(/<>/);
		
		#Zeeman 奧義物品
		#if($f_ki ne 3 && $f_sta){$add="(※)";}
		#else{$add="";}
                $it_type_name="";
                if($f_ki>=0 && $f_ki<3 || $f_ki eq"7" || $f_ki eq"4") {
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
		$rakusatu="？？？";
		$rakuval="？？？";
		if($f_time2 < 1){
			$f_time3=int(($f_time-$date)/60);
			$f_timec="剩餘$f_time3分";
		}
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
		$f_min2=$f_min/10000;
        if ($f_min2>9999) {
                $f_min2=int($f_min2/10000)."億".($f_min2%10000)."萬";
        }else{
                $f_min2.="萬";
        }
	$fover=0;
		$f_tb="<input type=radio name=no value=$no>";
		if($f_time<$date || $f_max<=$f_p){
			$fover=1;
			$f_timec="<font color=red>終了</font>";
			$f_tb="<font color=red>終了</font>";
			$rakusatu="$f_lname";
			$rakuval="$f_p";
			if($f_last eq $mid || $f_id eq $mid){
				$f_tb="<font color=blue>得標</font>";
				if ($f_ki eq 4) {
                                	$rptable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=no value=$no></td><td bgcolor=white><font size=1>$EQU[$f_ki]</font></td><td bgcolor=white>$f_name</td><td bgcolor=white>$f_val</td><td bgcolor=white align=right>$f_hit</td><td bgcolor=white>$f_dmg</td><td bgcolor=white>$f_wei</td><td bgcolor=white>$ELE[$f_ele]</td><td bgcolor=white>$f_hname</td><td bgcolor=white>$f_min2</td><td bgcolor=white>$f_max2</td><td bgcolor=white>$f_p2</td><td bgcolor=white>$f_lname</td><td bgcolor=white>$f_timec</td><td bgcolor=white>$it_type_name</td></tr>";
				}else{
                                	$rtable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=no value=$no></td><td bgcolor=white><font size=1>$EQU[$f_ki]</font></td><td bgcolor=white>$f_name$add</td><td colspan=2 bgcolor=white align=right>$f_val2 萬</td><td bgcolor=white>$f_dmg</td><td bgcolor=white>$f_wei</td><td bgcolor=white>$ELE[$f_ele]</td><td bgcolor=white>$f_hname</td><td bgcolor=white>$f_min2</td><td bgcolor=white>$f_max2</td><td bgcolor=white>$f_p2</td><td bgcolor=white>$f_lname</td><td bgcolor=white>$f_timec</td><td bgcolor=white>$it_type_name</td></tr>";
				}
			}
		}
		if ($rakuval ne"？？？") {
			$rakuval2=$rakuval/10000;
        if ($f_rakuval2>9999) {
                $f_rakuval2=int($f_rakuval2/10000)."億".($f_rakuval2%10000)."萬";
        }else{
                $f_rakuval2.="萬";
        }
		}else{
			$rakuval2=$rakuval;
		}
		if ($f_ki eq 4 && !$fover) {
                        $fptable.="<tr><td width=5% bgcolor=ffffcc><font size=1>$f_tb</font></td><td bgcolor=white><font size=1>$EQU[$f_ki]</font></td><td bgcolor=white><font size=1>$f_name</font></td><td bgcolor=white><font size=1>$f_hit</font></td><td bgcolor=white><font size=1>$f_val</font></td><td bgcolor=white><font size=1>$f_dmg</font></td><td bgcolor=white><font size=1>$f_wei</font></td><td bgcolor=white><font size=1>$ELE[$f_ele]</font></td><td bgcolor=white><font size=1>$f_hname</font></td><td bgcolor=white><font size=1>$f_min2</font></td><td bgcolor=white><font size=1>$f_max2</font></td><td bgcolor=white><font size=1>$rakuval2</font></td><td bgcolor=white><font size=1>$rakusatu</font></td><td bgcolor=white><font size=1>$f_timec</font></td><td bgcolor=white>$it_type_name</td></tr>";
		}else{
        $f_val2=int($f_val/10000);
        if ($f_val2>9999) {
                $f_val2=int($f_val2/10000)."億".($f_val2%10000)."萬";
        }else{
                $f_val2.="萬";
        }
	if(!$fover){

	                $ftable.="<tr><td width=5% bgcolor=ffffcc><font size=1>$f_tb</font></td><td bgcolor=white><font size=1>$EQU[$f_ki]</font></td><td bgcolor=white><font size=1>$f_name$add</font></td><td colspan=2 bgcolor=white align=right><font size=1>$f_val2</font></td><td bgcolor=white><font size=1>$f_dmg</font></td><td bgcolor=white><font size=1>$f_wei</font></td><td bgcolor=white><font size=1>$ELE[$f_ele]</font></td><td bgcolor=white><font size=1>$f_hname</font></td><td bgcolor=white><font size=1>$f_min2</font></td><td bgcolor=white><font size=1>$f_max2</font></td><td bgcolor=white><font size=1>$rakuval2</font></td><td bgcolor=white><font size=1>$rakusatu</font></td><td bgcolor=white><font size=1>$f_timec</font></td><td bgcolor=white>$it_type_name</td></tr>";
	}
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
                if($it_ki>=0 && $it_ki<3 || $it_ki eq"7" || $it_ki eq"4") {
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
                        $pettable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></td><td bgcolor=white><font size=1>$it_name</font></td><td bgcolor=white><font size=1>$it_hit</font></td><td bgcolor=white><font size=1>$it_val</font></td><td bgcolor=white><font size=1>$it_dmg</font></td><td bgcolor=white><font size=1>$it_wei</font></td><td bgcolor=white><font size=1>$ELE[$it_ele]</font></td><td bgcolor=white><font size=1>$EQU[$it_ki]</font></td><td bgcolor=white><font size=1>$it_type_name</font></td></tr>";
		}else{
	                $ittable.="<tr><td width=5% bgcolor=ffffcc><input type=radio name=itno value=$no2></td><td bgcolor=white><font size=1>$it_name</font></td><td colspan=2 bgcolor=white><font size=1>$sel_val</font></td><td bgcolor=white><font size=1>$it_dmg</font></td><td bgcolor=white><font size=1>$it_wei</font></td><td bgcolor=white><font size=1>$ELE[$it_ele]</font></td><td bgcolor=white><font size=1>$EQU[$it_ki]</font></td><td bgcolor=white><font size=1>$it_type_name</font></td></tr>";
		}
		$no2++;
	}

	&header;
	
	print <<"EOF";
<table border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <tbody>
    <tr>
      <td colspan="4" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">拍賣所</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></td>
      <td bgcolor="#330000" colspan="3"><font color="#ffffcc">[拍賣場店員]<br>歡迎來到拍賣場。目前拍賣場有以下的物品正在進行拍賣。<br>請選擇你要拍賣或購買的物品？</font></td>
    </tr>
    <tr>
      <td align=center bgcolor="ffffff" colspan=4 width=100%>
	<font size=1>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<form action="./town.cgi" method="post">
	<tr><td colspan=14 align=center><font color=ffffcc>拍賣品一覽</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td>
	<td bgcolor=white><font size=1>種類</font></td>
	<td bgcolor=white><font size=1>名稱</font></td>
	<td bgcolor=white colspan=2><font size=1>價格</font></td>
	<td bgcolor=white><font size=1>威力</font></td>
	<td bgcolor=white><font size=1>重量</font></td>
	<td bgcolor=white><font size=1>屬性</font></td>
	<td bgcolor=white><font size=1>出品者</font></td>
	<td bgcolor=white><font size=1>起標價</font></td>
	<td bgcolor=white><font size=1>直接購買價</font></td>
	<td bgcolor=white><font size=1>目前出價者</font></td>
	<td bgcolor=white><font size=1>得標者</font></td>
	<td bgcolor=white><font size=1>期限</font></td>
	<td bgcolor=white><font size=1>奧義</font></td>
	</tr>
	$ftable
        <tr><td colspan=14 align=center><font color=ffffcc>寵物拍賣品一覽</font></td></tr>
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
        <td bgcolor=white><font size=1>起標價</font></td>
        <td bgcolor=white><font size=1>直接購買價</font></td>
        <td bgcolor=white><font size=1>目前出價者</font></td>
        <td bgcolor=white><font size=1>得標者</font></td>
        <td bgcolor=white><font size=1>期限</font></td>
	<td bgcolor=white><font size=1>奧義</font></td>
        </tr>
        $fptable
	<tr><td colspan=15 align=center bgcolor="ffffff">
	拍賣出價：<input type=txt name=gold size=10>萬<br>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=itype value=$itype>
	<input type=hidden name=mode value=fbid>
	<input type=submit CLASS=FC value=確定出價></td></tr></form>
	</font>
	<form action="./town.cgi" method="post">
	<tr><td colspan=15 align=center><font color=ffffcc>已得標物品一覽</font></td></tr>
        <tr>
        <td bgcolor=ffffcc></td>
        <td bgcolor=white><font size=1>種類</font></td>
        <td bgcolor=white><font size=1>名稱</font></td>
        <td bgcolor=white colspan=2><font size=1>價格</font></td>
        <td bgcolor=white><font size=1>威力</font></td>
        <td bgcolor=white><font size=1>重量</font></td>
        <td bgcolor=white><font size=1>屬性</font></td>
        <td bgcolor=white><font size=1>出品者</font></td>
        <td bgcolor=white><font size=1>起標價</font></td>
        <td bgcolor=white><font size=1>直接購買價</font></td>
        <td bgcolor=white><font size=1>目前出價者</font></td>
        <td bgcolor=white><font size=1>得標者</font></td>
        <td bgcolor=white><font size=1>期限</font></td>
	<td bgcolor=white><font size=1>奧義</font></td>
        </tr>
	$rtable
	<tr><td colspan=15 align=center><font color=ffffcc>已得標寵物一覽</font></td></tr>
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
        <td bgcolor=white><font size=1>起標價</font></td>
        <td bgcolor=white><font size=1>直接購買價</font></td>
        <td bgcolor=white><font size=1>目前出價者</font></td>
        <td bgcolor=white><font size=1>得標者</font></td>
        <td bgcolor=white><font size=1>期限</font></td>
	<td bgcolor=white><font size=1>奧義</font></td>
        </tr>
	$rptable
	<tr><td colspan=15 align=center bgcolor="ffffff">
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=fget>
	<input type=submit CLASS=FC value=收取得標物></td></tr></form>
	</table>
	</td></tr>
	<tr>
	<td bgcolor="#ffffff" colspan="6" align=center>
	$STPR<br>
	<form action="./town.cgi" method="POST">
	<table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
	<br>
	<tr><td colspan=10 align=center bgcolor="$FCOLOR"><font color=ffffcc>目前持有物</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=white><font size=1>名稱</font></td><td colspan=2 bgcolor=white><font size=1>價值</font></td><td bgcolor=white><font size=1>威力</font></td><td bgcolor=white><font size=1>重量</font></td><td bgcolor=white><font size=1>屬性</font></td><td bgcolor=white><font size=1>種類</font></td><td bgcolor=white><font size=1>奧義</font></td>
	</tr>
	$ittable
        <tr><td colspan=10 align=center bgcolor="$FCOLOR"><font color=ffffcc>持有寵物</font></td></tr>
        <tr>
        <td bgcolor=ffffcc></td><td bgcolor=white><font size=1>名稱</font></td><td bgcolor=white><font size=1>等級</font></td><td bgcolor=white><font size=1>威力</font></td><td bgcolor=white><font size=1>防禦</font></td><td bgcolor=white><font size=1>速度</font></td><td bgcolor=white><font size=1>屬性</font></td><td bgcolor=white><font size=1>種類</font></td><td bgcolor=white><font size=1>奧義</font></td>
        </tr>
        $pettable
	<tr><td colspan=9 align=center bgcolor=ffffff>
	<table border=0 width="50%" align=center bgcolor=$FCOLOR CLASS=TC>
	<tr>
	<td bgcolor="#ffffff" colspan="3" align=center>
	起標價：
	</td>
	<td bgcolor="#ffffff" colspan="3" align=center>
	<input type=txt name=mingold size=10>萬<br>
	</td>
	</tr>
	<td bgcolor="#ffffff" colspan="3" align=center>
	直接購買價：
	</td>
	<td bgcolor="#ffffff" colspan="3" align=center>
	<input type=txt name=maxgold size=10>萬<br>
	</td>
	</tr>
	<td bgcolor="#ffffff" colspan="3" align=center>
	期限：
	</td>
	<td bgcolor="#ffffff" colspan="3" align=center>
	<input type=txt name=hour size=10>小時<br>
	</td>
	</tr>
	</table>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=itype value=$itype>
	<input type=hidden name=mode value=fex>
	<input type=submit CLASS=FC value=確定拍賣></td></form>
	</tr></font>
	</table>
	</td>
    </tr>
    <tr>
    <td colspan="7" align="center" bgcolor="ffffff">
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
