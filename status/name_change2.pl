sub name_change2{
	require './conf_pet.cgi';
	&chara_open;
	&con_open;
	if($in{'rname'} eq ""){&error("請輸入名稱。");}
	if ($in{'rname'} =~ /,/ || $in{'rname'} =~ / / || $in{'rname'} =~ /GM/ || $in{'rname'} =~ /ＧＭ/ || $in{'name'} =~ /,/) {&error("名字中請不要出現空格逗號或ＧＭ等字樣。"); }
	if($moya%5000 ne "37"){&error2("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	if(length($in{'rname'}) > 32 || length($in{'rname'}) < 4){&error("請輸入２～８個文字。");}
	$rename_gold=50000000;
	if($mgold<$rename_gold){&error("手持金不足５０００萬。");}

	if ($in{'changeitem'} ne "1" && ($in{'rname'} =~ /※/ || $in{'rname'} =~ /★/ || $in{'rname'} =~ /稀有/ || $in{'rname'} =~ /優良/)) {&error("請不要使用特殊字眼及符號(※、★、稀有、優良)。"); }
	if($in{'changeitem'} eq"2"){
		$marm=rename_equip($marm, "武器");
 	}elsif($in{'changeitem'} eq"3"){
		$mpro=rename_equip($mpro, "防具");
	}elsif($in{'changeitem'} eq"4"){
		$macc=rename_equip($macc, "飾品");
	}elsif($in{'changeitem'} eq"5"){
		($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpet);
		if($it_name2 eq""){&error("請讓要改名的寵物上場");}

		foreach $pet(@PETDATA){
			if($pet[0] eq"$in{'rname'}"){
				&error("請不要使用已存在的寵物名稱「$pet[0]」");
			}
		}

		&rename_log($mname, "的寵物", $it_name2, $in{'rname'});
		$it_name2="$in{'rname'}";
		$mpet="$it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2";
	}else{
		$dir="./logfile/chara";
		opendir(dirlist,"$dir");
		while($file = readdir(dirlist)){
			if($file =~ /\.cgi/i){
				if(open(cha,"$dir/$file")){
					@cha = <cha>;
					close(cha);
					($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
					if($rname eq $in{'rname'}){closedir(dirlist);&error("「$rname」已被其他玩家使用");}
				}
			}
		}
		closedir(dirlist);
		&rename_log($mname, "", "", $in{'rname'});
		&kh_log("$mname 改名為 $in{'rname'}。",$con_name);
		$mname="$in{'rname'}";
	}
	
	$moya = int(rand(20000));
	$mgold-=$rename_gold;
	&chara_input;

	&header;
	print <<"EOF";
	<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
		<tbody>
			<tr>
				<td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">改名神殿</font></td>
			</tr>
			<tr>
				<td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></td>
				<td bgcolor="#330000"><font color="#ffffcc">已成功改名為：<font color=red>$in{'rname'}</font>！</font></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					$BACKTOWNBUTTON
				</td>	
			</tr>
		</tbody>
	</table>
EOF
	&footer;
	exit;
}

sub rename_equip{
	my($data, $type) = @_;
	($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/, $data);
	if($it_no2 ne "mix"){&error("你身上的$type非自製$type");}
	&rename_log($mname, "的自製$type", $it_name2, "★$in{'rname'}");
	$it_name2="★$in{'rname'}";
	return "$it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2";
}

sub rename_log{
	my($mname, $type, $orig_name, $new_name) = @_;
	&maplog("<font color=green>[改名]</font><font color=blue>$mname</font>$type<font color=red>$orig_name</font>改名為<font color=red>$new_name</font>！");
	&maplog6("<font color=green>[改名]</font><font color=blue>$mname</font>$type<font color=red>$orig_name</font>改名為<font color=red>$new_name</font>！");
}

1;
