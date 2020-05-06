sub name_change2{
	require './conf_pet.cgi';
	&chara_open;
	&con_open;
	#&equip_open;
	if($in{'rname'} eq ""){&error("請輸入名稱。");}
	if ($in{'rname'} =~ /,/ || $in{'rname'} =~ / / || $in{'rname'} =~ /GM/ || $in{'rname'} =~ /ＧＭ/ || $in{'name'} =~ /,/) {&error("名字中請不要出現空格豆號或ＧＭ等字樣。"); }

	if($moya%5000 ne "37"){&error2("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	if(length($in{'rname'}) > 32 || length($in{'rname'}) < 4){&error("請輸入２～８個文字。");}
	$rename_gold=50000000;
	if($mgold<$rename_gold){&error("手持金不足５０００萬。");}
	if($in{'changeitem'} eq"2"){
		if($in{'rname'} =~ /,/ || $in{'rname'} =~ /※/ || $in{'rname'} =~ /★/ || $in{'rname'} =~ /稀有/ || $in{'rname'} =~ /優良/) {&error("請不要使用特殊字眼及符號(※、★、稀有、優良)。"); }
		($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$marm);
		if($it_no2 ne"mix"){&error("你身上的武器非自製武器");}
	        &maplog("<font color=green>[改名]</font><font color=blue>$mname</font>的自製武器<font color=red>$it_name2</font>改名為<font color=red>★$in{'rname'}</font>！");
		&maplog6("<font color=green>[改名]</font><font color=blue>$mname</font>的自製武器<font color=red>$it_name2</font>改名為<font color=red>★$in{'rname'}</font>！");
		$it_name2="★$in{'rname'}";
                $marm="$it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2";
 	}elsif($in{'changeitem'} eq"3"){
		if($in{'rname'} =~ /,/ || $in{'rname'} =~ /※/ || $in{'rname'} =~ /★/ || $in{'rname'} =~ /稀有/ || $in{'rname'} =~ /優良/) {&error("請不要使用特殊字眼及符號(※、★、稀有、優良)。"); }
		($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpro);
		if($it_no2 ne"mix"){&error("你身上的防具非自製防具");}
		&maplog("<font color=green>[改名]</font><font color=blue>$mname</font>的自製防具<font color=red>$it_name2</font>改名為<font color=red>★$in{'rname'}</font>！");
                &maplog6("<font color=green>[改名]</font><font color=blue>$mname</font>的自製防具<font color=red>$it_name2</font>改名為<font color=red>★$in{'rname'}</font>！");
		$it_name2="★$in{'rname'}";
		$mpro="$it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2";
        }elsif($in{'changeitem'} eq"4"){
                if($in{'rname'} =~ /,/ || $in{'rname'} =~ /※/ || $in{'rname'} =~ /★/ || $in{'rname'} =~ /稀有/ || $in{'rname'} =~ /優良/) {&error("請
不要使用特殊字眼及符號(※、★、稀有、優良)。"); }
                ($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$macc);
                if($it_no2 ne"mix"){&error("你身上的防具非自製飾品");}
                &maplog("<font color=green>[改名]</font><font color=blue>$mname</font>的自製飾品<font color=red>$it_name2</font>改名為<font color=red>★$in{'rname'}</font>！");
                &maplog6("<font color=green>[改名]</font><font color=blue>$mname</font>的自製飾品<font color=red>$it_name2</font>改名為<font color=red>★$in{'rname'}</font>！");
                $it_name2="★$in{'rname'}";
                $macc="$it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2";
        }elsif($in{'changeitem'} eq"5"){
		if($in{'rname'} =~ /,/ || $in{'rname'} =~ /※/ || $in{'rname'} =~ /★/ || $in{'rname'} =~ /稀有/ || $in{'rname'} =~ /優良/) {&error("請不要使用特殊字眼及符號(※、★、稀有、優良)。"); }
		($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpet);
		if($it_name2 eq""){&error("請讓要改名的寵物上場");}
                $peti=0;
		$pethit=0;
		#for($peti=0;$peti<77;$peti++){
		foreach(@PETDATA){
			if($PETDATA[$peti][0] eq"$in{'rname'}"){
				$pethit=1;
				last;
			}
			$peti++;
                }
		if($pethit eq 1){&error("請不要使用已存在的寵物名稱「$PETDATA[$peti][0]」");}
		&maplog("<font color=green>[改名]</font><font color=blue>$mname</font>的寵物<font color=red>$it_name2</font>改名為<font color=red>$in{'rname'}</font>！");
                &maplog6("<font color=green>[改名]</font><font color=blue>$mname</font>的寵物<font color=red>$it_name2</font>改名為<font color=red>$in{'rname'}</font>！");
                $it_name2="$in{'rname'}";
                $mpet="$it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2";
         }else{
	        $dir="./logfile/chara";
	        opendir(dirlist,"$dir");
	        while($file = readdir(dirlist)){
	                if($file =~ /\.cgi/i){
	                        $datames = "查詢：$dir/$file<br>\n";
	                        if(open(cha,"$dir/$file")){
	
	                        @cha = <cha>;
	                        close(cha);
	                        $list[$i]="$file";
	                        ($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
							if($rname eq $in{'rname'}){closedir(dirlist);&error("「$rname」已被其他玩家使用");}
	                        }
	                }
	                if($mn>10000){&error("ループ");}
	                $mn++;
	        }
	        closedir(dirlist);
		&kh_log("$mname 改名為 $in{'rname'}。",$con_name);
	        &maplog("<font color=green>[改名]</font><font color=blue>$mname</font>改名為<font color=red>$in{'rname'}</font>！");
        	&maplog6("<font color=green>[改名]</font><font color=blue>$mname</font>改名為<font color=red>$in{'rname'}</font>！");
		$mname="$in{'rname'}";
	}
			
	$moya = int(rand(20000));
	$mgold-=$rename_gold;
	&chara_input;

	&header;
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">改名神殿</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">已成功改名為：<font color=red>$in{'rname'}</font>！</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
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
