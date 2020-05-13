sub status{
	&chara_open;
	&equip_open;
	&status_print;

	open(IN,"./data/tec.cgi") or &error('檔案開啟失敗status\status.pl(6)。');
	@TEC = <IN>;
	close(IN);
	($mtec1,$mtec2,$mtec3,$mmprate,$mhprate)=split(/,/,$mtec);

	$mmaxmaxhp = $mmaxstr*5 + $mmaxvit*10 + $mmaxmen*3 - 2000;
	$mmaxmaxmp = $mmaxint*5 + $mmaxmen*3 - 800;
	&ext_open;
	if($mtec1 eq ""){$mtec1=0;}
	if($mtec2 eq ""){$mtec2=0;}
	if($mtec3 eq ""){$mtec3=0;}
	($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
	for($i=1;$i<9;$i++){
		$actlist1.="<td bgcolor=\"$ELE_C[$mele]\" align=\"center\">$ACTITEM[$i]</td>";
		$actlist2.="<td bgcolor=\"$ELE_C[$mele]\" align=\"center\">$act[$i]</td>";
	}
	($mtec_name[0],$mtec_str[0],$mtec_hit[0],$mtec_mp[0],$mtec_ab[0],$mtec_sta[0],$mtec_class[0]) = split(/<>/,$TEC[$mtec1]);
	($mtec_name[1],$mtec_str[1],$mtec_hit[1],$mtec_mp[1],$mtec_ab[1],$mtec_sta[1],$mtec_class[1]) = split(/<>/,$TEC[$mtec2]);
	($mtec_name[2],$mtec_str[2],$mtec_hit[2],$mtec_mp[2],$mtec_ab[2],$mtec_sta[2],$mtec_class[2]) = split(/<>/,$TEC[$mtec3]);
			
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);
        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);
        $no1=0;

        foreach(@ITEM){
                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
                $sel_val=int($it_val/2);
                if($it_no eq "rea" && $it_name =~ /★/){$sel_val=40000000;}
                elsif($it_no eq "rea" && $it_ki eq 3){$sel_val=3000000;}
                elsif($it_no eq "rea" && $it_ki eq 5){$sel_val=100000;}
                elsif($it_no eq "rea"){$sel_val=10000000;}
                $it_type_name="";
		($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                if($it_ki>=0 && $it_ki<3 || $it_ki eq"4" || $it_ki eq"7") {
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
                $ittable.="<tr><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$sel_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td><td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td><td bgcolor=white><font size=2>$it_type_name</font></td></tr>";
                $no1++;
        }
	($msk[0],$msk[1]) = split(/,/,$msk);
        ($marmstas[0],$marmstas[1])=split(/:/,$marmsta);
        ($mprostas[0],$mprostas[1])=split(/:/,$mprosta);
        ($maccstas[0],$maccstas[1])=split(/:/,$maccsta);
        ($mpetstas[0],$mpetstas[1])=split(/:/,$mpetsta);
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
                if($marmstas[0] eq $abno){
                        $abname3=$abname.$abname3;
                }elsif($marmstas[1] eq $abno){
                        $abname3.="、$abname";
                }
                if($mprostas[0] eq $abno){
                        $abname4=$abname.$abname4;
                }elsif($mprostas[1] eq $abno){
                        $abname4.="、$abname";
                }
                if($maccstas[0] eq $abno){
                        $abname5=$abname.$abname5;
                }elsif($maccstas[1] eq $abno){
                        $abname5.="、$abname";
                }
                if($mpetstas[0] eq $abno){
                        $abname6=$abname.$abname6;
                }elsif($mpetstas[1] eq $abno){
                        $abname6.="、$abname";
                }
		$j++;
	}
	
	&header;
	
	print <<"EOF";
<table border="0" align=center width="70%" height="143" CLASS=MC>
  <tbody>
    <tr>
      <td colspan="5" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>個人狀態</font></td>
    </tr>
    <tr>
      <td rowspan="5" bgcolor="$ELE_C[$mele]" align=center><img src="$IMG/chara/$mchara.gif"></td>
      <td bgcolor="$ELE_C[$mele]" align="left">等級</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mlv</td>
      <td bgcolor="$ELE_C[$mele]">屬性</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$ELE[$mele]</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">ＨＰ</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mhp/$mmaxhp($mmaxmaxhp)</td>
      <td bgcolor="$ELE_C[$mele]">ＭＰ</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mmp/$mmaxmp($mmaxmaxmp)</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">力量</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mstr($mmaxstr)</td>
      <td bgcolor="$ELE_C[$mele]">生命力</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mvit($mmaxvit)</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">智力</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mint($mmaxint)</td>
      <td bgcolor="$ELE_C[$mele]">精神</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mfai($mmaxmen)</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">運氣</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mdex($mmaxdex)</td>
      <td bgcolor="$ELE_C[$mele]">速度</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$magi($mmaxagi)</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">$mname</td>
      <td bgcolor="$ELE_C[$mele]">職業</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$JOB[$mclass]</td>
      <td bgcolor="$ELE_C[$mele]">名聲</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mcex</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">$mtotal戰$mkati勝</td>
      <td bgcolor="$ELE_C[$mele]">經驗值</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mex</td>
      <td bgcolor="$ELE_C[$mele]">熟練度</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mabp</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">總經驗值：$mtotalex</td>
      <td bgcolor="$ELE_C[$mele]">健康度</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mken%</td>
      <td bgcolor="$ELE_C[$mele]">資金</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mgold</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center"></td>
      <td bgcolor="$ELE_C[$mele]">劍術</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mjp[0]</td>
      <td bgcolor="$ELE_C[$mele]">魔術</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mjp[1]</td>
    </tr>
　　<tr>
      <td bgcolor="$ELE_C[$mele]" align="center"></td>
      <td bgcolor="$ELE_C[$mele]">神術</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mjp[2]</td>
      <td bgcolor="$ELE_C[$mele]">弓術</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mjp[3]</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center"></td>
      <td bgcolor="$ELE_C[$mele]">體術</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mjp[4]</td>
      <td bgcolor="$ELE_C[$mele]">忍術</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mjp[5]</td>
    </tr>
    <tr>
      <td colspan="5" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>奧義</font></td>
    </tr>
　　<tr>
      <td colspan="1" align="center" bgcolor="blueviolet"><font color=$ELE_C[$mele]>主要</font></td>
      <td colspan="1" align="center" bgcolor="$ELE_C[$mele]"><font color=$ELE_BG[$mele]>$abname1</font></td>
      <td colspan="3" align="center" bgcolor="$ELE_C[$mele]"><font color=$ELE_BG[$mele]>$abcom1</font></td>
    </tr>
　　<tr>
      <td colspan="1" align="center" bgcolor="blueviolet"><font color=$ELE_C[$mele]>職業</font></td>
      <td colspan="1" align="center" bgcolor="$ELE_C[$mele]"><font color=$ELE_BG[$mele]>$abname2</font></td>
      <td colspan="3" align="center" bgcolor="$ELE_C[$mele]"><font color=$ELE_BG[$mele]>$abcom2</font></td>
    </tr>
    <tr>
      <td colspan="5" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>目前裝配技能</font></td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]"></td>
      <td bgcolor="$ELE_C[$mele]" align="center" colspan="2">名稱</td>
      <td bgcolor="$ELE_C[$mele]" align="center">威力</td>
      <td bgcolor="$ELE_C[$mele]" align="center">發動率</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">通常</td>
      <td bgcolor="$ELE_C[$mele]" colspan="2">$mtec_name[0]</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mtec_str[0]</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mtec_hit[0]</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">MP於$mmprate%以下</td>
      <td bgcolor="$ELE_C[$mele]" colspan="2">$mtec_name[1]</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mtec_str[1]</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mtec_hit[1]</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">HP於$mhprate%以下</td>
      <td bgcolor="$ELE_C[$mele]" colspan="2">$mtec_name[2]</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mtec_str[2]</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mtec_hit[2]</td>
    </tr>
    <tr>
      <td colspan="5" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>裝備</font></td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]"></td>
      <td colspan="2" bgcolor="$ELE_C[$mele]" align="center">名稱</td>
      <td bgcolor="$ELE_C[$mele]" align="center">奧義</td>
      <td bgcolor="$ELE_C[$mele]" align="center">威力/重量</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">武器</td>
      <td colspan="2" bgcolor="$ELE_C[$mele]" align="right">$marmname($ELE[$marmele])</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$abname3</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$marmdmg/$marmwei</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">防具</td>
      <td colspan="2" bgcolor="$ELE_C[$mele]" align="right">$mproname($ELE[$mproele])</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$abname4</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$mprodmg/$mprowei</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]">飾品</td>
      <td colspan="2" bgcolor="$ELE_C[$mele]" align="right">$maccname($ELE[$maccele])</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$abname5</td>
      <td bgcolor="$ELE_C[$mele]" align="right">$maccdmg/$maccwei</td>
    </tr>
<tr>
   <td colspan="5" align="center" bgcolor="$ELE_BG[$mele]">
<table border="0" align=center width="100%" height="1" CLASS=MC>
  <tbody>
    <tr>
      <td colspan="8" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>寵物</font></td>
    </tr>
    <tr>
	<td bgcolor="$ELE_C[$mele]" align="center">等級</td>
      <td bgcolor="$ELE_C[$mele]" align="center">名稱</td>
      <td bgcolor="$ELE_C[$mele]" align="center">屬性</td>
      <td bgcolor="$ELE_C[$mele]" align="center">威力</td>
      <td bgcolor="$ELE_C[$mele]" align="center">防禦</td>
      <td bgcolor="$ELE_C[$mele]" align="center">速度</td>
      <td bgcolor="$ELE_C[$mele]" align="center">奧義</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">$mpetlv</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$mpetname</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ELE[$mpetele]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$mpetdmg</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$mpetdef</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$mpetspeed</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$abname6</td>
    </tr>
  </tbody>
</table>
<table border="0" align=center width="100%" height="1" CLASS=MC>
  <tbody>
    <tr>
      <td colspan="9" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>原料</font></td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">建國之石</td>
      <td bgcolor="$ELE_C[$mele]" align="center">火</td>
      <td bgcolor="$ELE_C[$mele]" align="center">水</td>
      <td bgcolor="$ELE_C[$mele]" align="center">風</td>
      <td bgcolor="$ELE_C[$mele]" align="center">星</td>
      <td bgcolor="$ELE_C[$mele]" align="center">雷</td>
      <td bgcolor="$ELE_C[$mele]" align="center">光</td>
      <td bgcolor="$ELE_C[$mele]" align="center">闇</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[0]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[1]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[2]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[3]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[4]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[5]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[6]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_mix[7]</td>
    </tr>
  </tbody>
</table>
<table border="0" align=center width="100%" height="1" CLASS=MC>
  <tbody>
    <tr>
      <td colspan="6" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>能力果</font></td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">力量之果</td>
      <td bgcolor="$ELE_C[$mele]" align="center">生命之果</td>
      <td bgcolor="$ELE_C[$mele]" align="center">智慧之果</td>
      <td bgcolor="$ELE_C[$mele]" align="center">精神之果</td>
      <td bgcolor="$ELE_C[$mele]" align="center">幸運之果</td>
      <td bgcolor="$ELE_C[$mele]" align="center">速度之果</td>
    </tr>
    <tr>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[0]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[1]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[2]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[3]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[4]</td>
      <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[5]</td>
    </tr>
  </tbody>
</table>
<table border=\"0\" align=center width=\"100%\" height=\"1\" CLASS=MC>
  <tbody>
    <tr>
      <td colspan=\"9\" align=\"center\" bgcolor=\"$ELE_BG[$mele]\"><font color=$ELE_C[$mele]>活動物品</font></td>
    </tr>
    <tr>
      $actlist1
    </tr>
    <tr>
      $actlist2
    </tr>
  </tbody>
</table>
	</td>
</tr>
    <tr>
      <td colspan=5 align=center bgcolor=$ELE_C[$mele]>
$BACKTOWNBUTTON
	</td>
    </tr>
<table border="0" align=center width="70%" height="1" CLASS=MC>
  <tbody>
    <tr>
      <td colspan="7" align="center" bgcolor="$ELE_BG[$mele]" style="color:white">手持物品清單($no1/$ITM_MAX)</td>
    </tr>
$ittable
  </tbody>
</table>
  </tbody>
</table>
EOF
&footer;
exit;
}
1;
