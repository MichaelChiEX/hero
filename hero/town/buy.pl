sub buy {
	&chara_open;
	&town_open;
	$val_off=0;
	if($mcon eq $town_con && $town_con ne 0){
		$val_off=int($mcex/100)+1;
		if($val_off>15){$val_off=15;}
	}
	if($in{'itype'} eq"0"){$idata="arm";}
	elsif($in{'itype'} eq"1"){$idata="pro";}
	elsif($in{'itype'} eq"2"){$idata="acc";}
	elsif($in{'itype'} eq"3"){$idata="item";}
	else{&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	if($in{'no'} eq ""){&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}

	open(IN,"./data/$idata.cgi") or &error("檔案開啟錯誤town/buy.pl(16)。");
	@it_data = <IN>;
	close(IN);
	$it_num=@it_data;
	$num=$in{'no'};
	if($it_num>$num){
		($it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos)=split(/<>/,$it_data[$in{'no'}]);
	}else{
		open(IN,"./data/carm.cgi") or &error("檔案開啟錯誤town/buy.pl(24)。");
		@it2_data = <IN>;
		close(IN);
		$no2=$num-$it_num;
		($it_t,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos)=split(/<>/,$it2_data[$no2]);
		if("$in{'itype'}" ne"$it_t"||$it_name eq""){&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	}
	$it_val=int($it_val*(1-$val_off/100));
	
	if(($it_pos ne $town_id && $it_pos ne "all") || $it_pos eq "1000"){
		&verchklog("$it_name,非法取得");
		#&error("金額不足。");
	}
	if($mgold<$it_val){&error("金額不足。");}
	$mgold-=$it_val;

	$townget=$town_ind/300;
	$town_gold+=int($it_val/((1500-$town_ind)/250));
        $up_var=0;
        if(int(rand($rand_val)) eq 5){
	        $up_var=0.4;
                $it_name="稀有的".$it_name;
		$ames="<br><font color=red>＋很幸運的。這次你買到了品質稀有的物品＋</font>";
        }elsif(int(rand(int($rand_val/2))) eq 7){
                $up_var=0.2;
                $it_name="優良的".$it_name;
                $ames="<br><font color=red>＋很幸運的。這次你買到了品質優良的物品＋</font>";
        }
        $it_dmg+=int($it_dmg*$up_var);
        if ($it_wei>0){
                $it_wei-=int($it_wei*$up_var);
        }elsif($it_wei<0){
                $it_wei-=int($it_wei*$up_var);
        }else{
                $it_wei-=($up_var*5);
        }

	open(IN,"./logfile/item/$in{'id'}.cgi");
	@ITEM = <IN>;
	close(IN);
	if(@ITEM>=$ITM_MAX){&error("你的持有物品數已達上限。(最大$ITM_MAX個)");}
	if(($it_pos eq $town_id || $it_pos eq "all") && $it_pos ne "1000"){
		push(@ITEM,"$in{'no'}<>$in{'itype'}<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
	}else{
                push(@ITEM,"bug<>$in{'itype'}<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
	}
		open(OUT,">./logfile/item/$in{'id'}.cgi");
		print OUT @ITEM;
		close(OUT);
	&chara_input;
	&town_input;

	&header;
	
	print <<"EOF";
<table border="0" width="80%" align=center height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="$FCOLOR2">$EQU[$in{'itype'}]屋</font></td>
    </tr>
    <tr>
      <td bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/buki.jpg"></td>
      <td bgcolor="#330000"><font color="$FCOLOR2">[$EQU[$in{'itype'}]屋]<br>購買$it_name。$ames<br>花費 $it_val Gold。</font></td>
    </tr>
    <tr>
    <td colspan="2" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
	</td>
    </tr>
  </tbody>
</table>
<center></center>
EOF
	&footer;
	exit;
	
}
1;
