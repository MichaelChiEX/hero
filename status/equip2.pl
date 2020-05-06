sub equip2 {
	&chara_open;
	&ext_open;
	if($in{'itno'} eq ""){&error("請正確選擇你要使用/裝備的物品。");}
	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'itno'}]);
	if($it_no ne "bug"){
	if($it_ki eq"0"){
		$idata="arm";
		($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$marm);
                if($it_no eq"mix" && $mele eq $it_ele){$mmaxhp+=1000;}
                if($it_no2 eq"mix" && $mele eq $it_ele2){$mmaxhp-=1000;}
		push(@ITEM,"$it_no2<>0<>$it_name2<>$it_val2<>$it_dmg2<>$it_wei2<>$it_ele2<>$it_hit2<>$it_cl2<>$it_sta2<>$it_type2<>$it_flg2<>\n");
		$marm="$it_no,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg";
		$mess="<font color=red>$it_name</font>裝備完成。";
	}elsif($it_ki eq"1"){
		$idata="pro";
		($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpro);
                if($it_no eq"mix" && $mele eq $it_ele){$mmaxhp+=1000;}
                if($it_no2 eq"mix" && $mele eq $it_ele2){$mmaxhp-=1000;}
		push(@ITEM,"$it_no2<>1<>$it_name2<>$it_val2<>$it_dmg2<>$it_wei2<>$it_ele2<>$it_hit2<>$it_cl2<>$it_sta2<>$it_type2<>$it_flg2<>\n");
		$mpro="$it_no,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg";
		$mess="<font color=red>$it_name</font>裝備完成。";
	}elsif($it_ki eq"2"){
		$idata="acc";
		($it_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$it_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$macc);
                if($it_no eq"mix" && $mele eq $it_ele){$mmaxmp+=1000;}
                if($it_no2 eq"mix" && $mele eq $it_ele2){$mmaxmp-=1000;}
		push(@ITEM,"$it_no2<>2<>$it_name2<>$it_val2<>$it_dmg2<>$it_wei2<>$it_ele2<>$it_hit2<>$it_cl2<>$it_sta2<>$it_type2<>$it_flg2<>\n");
		$macc="$it_no,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg";
		$mess="<font color=red>$it_name</font>裝備完成。";
	}elsif($it_ki eq"4"){
                $idata="pet";
                ($it_no2,$it_name2,$it_dmg2,$it_def2,$it_speed2,$it_ele2,$it_lv2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpet);
		if ($it_name2 ne""){
                	push(@ITEM,"$it_no2<>4<>$it_name2<>$it_dmg2<>$it_def2<>$it_speed2<>$it_ele2<>$it_lv2<>$it_cl2<>$it_sta2<>$it_type2<>0<>\n");
		}
                $mpet="$it_no,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg";
		$mess="你選擇了<font color=red>$it_name</font>當作你的戰鬥伙伴。";
	}elsif($it_ki eq"3"){
		$mess="使用了<font color=red>$it_name</font>。";
		if($it_type eq"0"){
			$mhp += $it_dmg;
			if($mhp>$mmaxhp){$mhp = $mmaxhp;}
			$mess.="<BR>HP回復<font color=red>$it_dmg</font>。";
		}elsif($it_type eq"3"){
			if($mele <= 0){
($arm_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$arm_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$marm);
($pro_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$pro_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpro);
($acc_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$acc_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$macc);
	                        if($arm_no2 eq"mix" && $arm_ele2 eq $mele){$mmaxhp-=1000;}
	                        if($pro_no2 eq"mix" && $pro_ele2 eq $mele){$mmaxhp-=1000;}
	                        if($acc_no2 eq"mix" && $acc_ele2 eq $mele){$mmaxmp-=1000;}
				$mele = $it_ele;
                                if($arm_no2 eq"mix" && $arm_ele2 eq $mele){$mmaxhp+=1000;}
                                if($pro_no2 eq"mix" && $pro_ele2 eq $mele){$mmaxhp+=1000;}
                                if($acc_no2 eq"mix" && $acc_ele2 eq $mele){$mmaxmp+=1000;}
                                if ($mhp>$mmaxhp){$mhp=$mmaxhp;}
                                if ($mmp>$mmaxmp){$mmp=$mmaxmp;}
				$mess.="<BR>屬性變更為<font color=red>$ELE[$it_ele]</font>\。";
			}else{
				$mess.="<BR>什麼事都沒發生・・・。";
			}
                }elsif($it_type eq"4"){
                        $upval = $it_dmg;
			if($upval =~ m/[^0-9]/){$upval=2;}
			if($it_ele eq"0"){
				$rndmax=int(rand(6));
			}else{
				$rndmax=$it_ele-1;
			}
			if($randmax>5){$rndmax=int(rand(6));}
			$eathit=0;
                        if($rndmax eq "0"){
				$eathit=1;
                                $mmaxstr += $upval;
                                $mess.="<font color=orange>力量 界限值上昇了$upval點！！</font><BR>";
                        }elsif($rndmax eq "1"){
				$eathit=1;
                                $mmaxvit += $upval;
                                $mess.="<font color=orange>生命 界限值上昇了$upval點！！</font><BR>";
                        }elsif($rndmax eq "2"){
				$eathit=1;
                                $mmaxint += $upval;
                                $mess.="<font color=orange>智力 界限值上昇了$upval點！！</font><BR>";
                        }elsif($rndmax eq "3"){
				$eathit=1;
                                $mmaxmen += $upval;
                                $mess.="<font color=orange>精神 界限值上昇了$upval點！！</font><BR>";
                        }elsif($rndmax eq "4"){
				$eathit=1;
                                $mmaxdex += $upval;
                                $mess.="<font color=orange>運氣 界限值上昇了$upval點！！</font><BR>";
                        }elsif($rndmax eq "5"){
				$eathit=1;
                                $mmaxagi += $upval;
                                $mess.="<font color=orange>速度 界限值上昇了$upval點！！</font><BR>";
			}
                        $mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";
			
                }elsif($it_type eq"5"){
                        if($mele > 0){
($arm_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$arm_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$marm);
($pro_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$pro_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpro);
($acc_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$acc_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$macc);
                                if($arm_no2 eq"mix" && $arm_ele2 eq $mele){$mmaxhp-=1000;}
                                if($pro_no2 eq"mix" && $pro_ele2 eq $mele){$mmaxhp-=1000;}
                                if($acc_no2 eq"mix" && $acc_ele2 eq $mele){$mmaxmp-=1000;}
                                $mele = 0;
                                if ($mhp>$mmaxhp){$mhp=$mmaxhp;}
                                if ($mmp>$mmaxmp){$mmp=$mmaxmp;}
                                $mess.="<BR>屬性變更為無屬性。";
                        }else{
                                $mess.="<BR>什麼事都沒發生・・・。";
                        }
		}elsif($it_type eq"9"){
			open(IN,"./logfile/battle/$in{'id'}.cgi");
			@BC_DATA = <IN>;
			close(IN);
			($mhpr,$mmpr,$mtim)=split(/<>/,$BC_DATA[0]);

			$date = time();
			$rec = 1;
			$mhpr+=$rec;
			$mmpr+=$rec;
			if($mhpr>1){$mhpr=1;}
			if($mmpr>1){$mmpr=1;}
			if($mmpr<0.2){$mmpr=0.2;}
	
			@N_BC=();
			unshift(@N_BC,"$mhpr<>$mmpr<>$date<>\n");
			open(OUT,">./logfile/battle/$in{'id'}.cgi");
			print OUT @N_BC;
			close(OUT);

			$mess.="<BR>傷口治癒了。";
		}elsif($it_type eq"10"){
			if(int(rand(4)) eq 1 || $it_dmg eq"999"){
				$moya = 777;
				$mess.="<BR><font color=red>你看到了夜空出現閃爍的星星・・・</font>";
			}else{
				$mess.="<BR>什麼事都沒有發生。。。";
			}
		}elsif($it_type eq"11"){
			$mabp += $it_dmg;
			$mess.="<BR>熟練度增加了<font color=red>$it_dmg</font>。";
		}elsif($it_type eq"12"){
			$mjp[$it_ele] += $it_dmg;
			if($mjp[$it_ele]>$MAXJOB){$mjp[$it_ele] = $MAXJOB;}
			$mess.="<BR>$TYPE[$it_ele]熟練度增加了<font color=red>$it_dmg</font>。";
		}elsif($it_type eq"13"){
($arm_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$arm_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$marm);
($pro_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$pro_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpro);
($acc_no2,$it_name2,$it_val2,$it_dmg2,$it_wei2,$acc_ele2,$it_hit2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$macc);
                                if($arm_no2 eq"mix" && $arm_ele2 eq $mele){$mmaxhp-=1000;}
                                if($pro_no2 eq"mix" && $pro_ele2 eq $mele){$mmaxhp-=1000;}
                                if($acc_no2 eq"mix" && $acc_ele2 eq $mele){$mmaxmp-=1000;}
			$mele = $it_ele;
                                if($arm_no2 eq"mix" && $arm_ele2 eq $mele){$mmaxhp+=1000;}
                                if($pro_no2 eq"mix" && $pro_ele2 eq $mele){$mmaxhp+=1000;}
                                if($acc_no2 eq"mix" && $acc_ele2 eq $mele){$mmaxmp+=1000;}
				if ($mhp>$mmaxhp){$mhp=$mmaxhp;}
				if ($mmp>$mmaxmp){$mmp=$mmaxmp;}
			$mess.="<BR>屬性變為<font color=red>$ELE[$it_ele]</font>。";
		}elsif($it_type eq"14" || $it_type eq"20" || $it_type eq"21" || $it_type eq"22"){
			if ($it_type eq"14"){
				$rit_sta=$weapon_stone[int(rand(100))];
				$rit_dmg=0;
			}elsif($it_type eq"20"){
				$rit_sta=$pro_stone[int(rand(117))];
				$rit_dmg=1;
                        }elsif($it_type eq"21"){
				$rit_dmg=2;
                        }elsif($it_type eq"22"){
				$rit_dmg=4;
			}
		        open(IN,"./data/ability.cgi");
		        @ABILITY = <IN>;
		        close(IN);
		        foreach(@ABILITY){
	                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
	                        if($rit_sta eq $abno){
	                                $rit_name=$abname."奧義之石(".$EQU[$rit_dmg].")";
					last;
	                        }
	                }
			$rit_val=30000;$rit_wei=0;$rit_ele=0;$reano=7;
                                push(@ITEM,"rea<>$reano<>$rit_name<>$rit_val<>$rit_dmg<>$rit_wei<>$rit_ele<>$rit_hit<>$rit_cl<>$rit_sta<>$rit_type<>0<>\n");
                                $mess.="<BR>$it_name寶箱後出現了<font color=red>$rit_name</font>！！！";
                                &maplog("<font color=orange>[寶箱]</font><font color=blue>$mname</font>打開了<font color=green>$it_name</font>獲得<font color=red>$rit_name</font><font color=green>$rit_desc</font>。");
                                &maplog7("<font color=orange>[寶箱]</font><font color=blue>$mname</font>打開了<font color=green>$it_name</font>獲得<font color=red>$rit_name</font><font color=green>$rit_desc</font>。");

#神秘寶箱
		}elsif($it_type eq"23"){
			$trlv = $it_type - 19;
			$rate = $trlv * 25;

			$brand=int(rand(5));
			if($it_type eq 22){$brand= 1 + int(rand(3));}
			if($it_type eq 23){$brand= 1 + int(rand(3));$rate = 100;}

			if($brand eq 1){
				$REA="arm";
				$reano=0;
				$b_no2 = int(rand(91));
				$ino=0;
				if(int(rand(100)) < $rate){
					$rflg=1;
					$REA="rarearm";
					$b_no2 = int(rand(26));
					if(($it_type eq 22 && int(rand(10)) eq 1) || $it_type eq 23){
						$b_no2 = 26 + int(rand(36));
					}
					$ino=0;
				}
			}
			elsif($brand eq 2){
				$REA="pro";
				$reano=1;
				$b_no2 = int(rand(59));
				$ino=0;
				if(int(rand(100)) < $rate){
					$rflg=1;
					$REA="rarepro";
					$b_no2 = int(rand(23));
					if(($it_type eq 22 && int(rand(10)) eq 1) || $it_type eq 23){
						$b_no2 = 23 + int(rand(23));
					}
					$ino=0;
				}
			}
			elsif($brand eq 3){
				$REA="acc";
				$reano=2;
				$b_no2 = int(rand(67));
				$ino=0;
				if(int(rand(100)) < $rate){
					$rflg=1;
					$REA="rareacc";
					$b_no2 = int(rand(25));
					if(($it_type eq 22 && int(rand(10)) eq 1) || $it_type eq 23){
						$b_no2 = 25 + int(rand(25));
					}
					$ino=0;
				}
			}
			else{
				$rflg=1;
				$REA="item";
				$reano=3;
				$b_no2 = int(rand(21));
				$ino=19;
			}
			open(IN,"./data/$REA.cgi");
			@A2_DATA = <IN>;
			close(IN);

			$kit_no=$ino+$b_no2;
			($rit_name,$rit_val,$rit_dmg,$rit_wei,$rit_ele,$rit_hit,$rit_cl,$rit_sta,$rit_type,$rit_pos) = split(/<>/,$A2_DATA[$kit_no]);
			if($rflg eq ""){
				#$rit_dmg += int(rand($rit_dmg*0.2));
				#$rit_wei -= int(rand(5));
				#$rit_name.= "+";
			}
			if($rit_val ne ""){
				$rand_val=17-int($mtotal/10000);
				if ($rand_val<8) {
					$rand_val=8;
				}
				if (int(rand($rand_val)) eq 1 || $mid eq $GMID) {
					$rnd_srar=int(rand($SRARCOUNT));
					if($rnd_srar eq 14){
						$rnd_srar=int(rand($SRARCOUNT));
					}
					$rit_ele=int(rand(8));
					$rit_sta=$SRAR[$rnd_srar][0];
					if ($REA eq "rarearm") {
						$rit_name=$SRAR[$rnd_srar][1] . "之" . $ARM[$rit_ele] . "★";
					}elsif ($REA eq "rarepro") {
						$rit_name=$SRAR[$rnd_srar][1] . $TPRO[$rit_ele] . "★";
					}elsif ($REA eq "rareacc") {
						$rit_name=$SRAR[$rnd_srar][1] . $TACC[$rit_ele] . "★";
					}
					$rnd_srar=int(rand(21));
				}
					if(int(rand($rand_val*2)) eq 5){
						$up_var=0.4;
						$rit_name="稀有的".$rit_name;
					}elsif(int(rand(int($rand_val))) eq 7){
						$up_var=0.2;
						$rit_name="優良的".$rit_name;
					}
					$rit_dmg+=int($rit_dmg*$up_var);
					if ($rit_wei>0){
						$rit_wei-=int($rit_wei*$up_var);
					}elsif($rit_wei<0){
						$rit_wei+=int($rit_wei*$up_var);
					}else{
						$rit_wei-=int($up_var*50);
					}
				$rit_desc="(".$rit_dmg."/".$rit_wei.")(".$ELE[$rit_ele].")";

			
				push(@ITEM,"rea<>$reano<>$rit_name<>$rit_val<>$rit_dmg<>$rit_wei<>$rit_ele<>$rit_hit<>$rit_cl<>$rit_sta<>$rit_type<>0<>\n");
				$mess.="<BR>打開寶箱後出現了<font color=red>$rit_name</font>$rit_desc！！！";
				&maplog("<font color=orange>[寶箱]</font><font color=blue>$mname</font>打開了<font color=green>寶箱</font>獲得<font color=red>$rit_name</font><font color=green>$rit_desc</font>。");
                                &maplog7("<font color=orange>[寶箱]</font><font color=blue>$mname</font>打開了<font color=green>寶箱</font>獲得<font color=red>$rit_name</font><font color=green>$rit_desc</font>。");

			}
			else{
				$mess.="<BR>寶箱中什麼都沒有・・・。";
				&maplog("<font color=orange>[寶箱]</font><font color=blue>$mname</font>打開了<font color=green>寶箱</font>結果確是空的・・・。");
			}
			
		}elsif($it_type eq"24"){
			if($it_name eq "滿月之鑰" && $moya%2500 ne "17"){
				&error("請在藍天之下使用此物。");
			}else{
				$moya = $it_dmg;
			}
		}elsif($it_type eq"25"){
			if(int(rand(5)) eq 1 && $it_no eq"rea"){
				$moya = 77777;
				$mess.="<BR><font color=red>你從秘寶地圖中看出了寶藏的置位！</font>";
			}else{
				$mess.="<BR>這張地圖破損得太嚴重，你看不出寶藏的藏身之處。。。";
			}
		}elsif($it_type eq"26"){
			$moya = int(rand(15));
			$mess.="<BR>好像發生了什麼不錯的事・・・？";
#地獄草
		}elsif($it_type eq"27"){
			if($down_lv_limit eq""){$down_lv_limit=50;}
			if($down_lv_limit>50){$down_lv_limit=50}
			$mlv-=$it_dmg;
			$mex-=$it_dmg*100;
			$down_lv_limit2=$down_lv_limit;
			$down_lv_limit-=$it_dmg;
			if($mlv<1){&error("你的等級需要大於$it_dmg才可使用");}
			if($down_lv_limit<0){&error("你本轉可降等剩餘$down_lv_limit2");}
                        $mess.="<BR>你的等級下降了<b>$it_dmg</b>級,你本轉可降等剩餘$down_lv_limit";
#超級地獄草
                }elsif($it_type eq"31"){
                        $mlv-=$it_dmg;
                        $mex-=$it_dmg*100;
                        if($mlv<1){&error("你的等級需要大於$it_dmg才可使用");}
                        $mess.="<BR>你的等級下降了<b>$it_dmg</b>級,你本轉可降等剩餘$down_lv_limit(本次使用未扣剩餘數)";
#新春褔袋
                }elsif($it_type eq"32"){
                                $rnditem[0]="rea<>3<>防奧石之箱<>10000<>0<>0<>0<>80<>10<>寶物<>20<><>";
                                $rnditem[1]="rea<>3<>武奧石之箱<>10000<>0<>0<>0<>80<>10<>寶物<>14<><>";
                                $rnditem[2]="rea<>3<>火寵成長劑<>1000000<>1<>0<>1<>80<>10<>寶物<>30<><>";
                                $rnditem[3]="rea<>3<>水寵成長劑<>1000000<>1<>0<>2<>80<>10<>寶物<>30<><>";
                                $rnditem[4]="rea<>3<>風寵成長劑<>1000000<>1<>0<>3<>80<>10<>寶物<>30<><>";
                                $rnditem[5]="rea<>3<>星寵成長劑<>1000000<>1<>0<>4<>80<>10<>寶物<>30<><>";
                                $rnditem[6]="rea<>3<>雷寵成長劑<>1000000<>1<>0<>5<>80<>10<>寶物<>30<><>";
                                $rnditem[7]="rea<>3<>光寵成長劑<>1000000<>1<>0<>6<>80<>10<>寶物<>30<><>";
                                $rnditem[8]="rea<>3<>闇寵成長劑<>1000000<>1<>0<>7<>80<>10<>寶物<>30<><>";
                                $rnditem[9]="rea<>3<>賢者之石<>1000000<>5<>0<>0<>80<>10<>寶物<>4<>1000<>";
                                $rnditem[10]="rea<>3<>神秘的寶箱<>10000000<>0<>0<>0<>80<>10<>寶物<>23<>1000<>";
                                $rnditem[11]="rea<>3<>熟練之書<>1000000<>2000<>0<>0<>80<>10<>寶物<>11<>1000<>";
                                $rnditem[12]="rea<>3<>力量之石<>1000000<>5<>0<>1<>80<>10<>寶物<>4<>1000<>";
                                $rnditem[13]="rea<>3<>體力之石<>1000000<>5<>0<>2<>80<>10<>寶物<>4<>1000<>";
                                $rnditem[14]="rea<>3<>智力之石<>1000000<>5<>0<>3<>80<>10<>寶物<>4<>1000<>";
                                $rnditem[15]="rea<>3<>精神之石<>1000000<>5<>0<>4<>80<>10<>寶物<>4<>1000<>";
                                $rnditem[16]="rea<>3<>運氣之石<>1000000<>5<>0<>5<>80<>10<>寶物<>4<>1000<>";
                                $rnditem[17]="rea<>3<>速度之石<>1000000<>5<>0<>6<>80<>10<>寶物<>4<>1000<>";
                                $rnditem[18]="rea<>3<>地獄草<>0<>3<>0<>0<>80<>10<>寶物<>27<>1000<>";
                                $rnditem[19]="rea<>3<>超級地獄草<>0<>1<>0<>0<>80<>10<>寶物<>31<>1000<>";
                                $giftitem=$rnditem[int(rand(20))];
                                push(@ITEM,"$giftitem\n");
                                ($git1,$git2,$git3,$git4,$git5,$git6,$git7)=split(/<>/,$giftitem);
                                $mess.="<BR>打開新春褔袋後出現了<font color=red>$git3</font>($git5)！！！";
                                &maplog("<font color=orange>[寶箱]</font><font color=blue>$mname</font>打開了<font color=green>新春褔袋</font>獲得<font color=red>$git3</font><font color=green>($git5)</font>。");
                                &maplog7("<font color=orange>[寶箱]</font><font color=blue>$mname</font>打開了<font color=green>新春褔袋</font>獲得<font color=red>$git3</font><font color=green>($git5)</font>。");

		}elsif($it_type eq"30"){
#寵物成長劑
			require './conf_pet.cgi';
			($mpetcno,$mpetname,$mpetdmg,$mpetdef,$mpetspeed,$mpetele,$mpetlv,$mpetcl,$mpetsta,$mpettype,$mpetflg) = split(/,/,$mpet);
			if($mpetele ne $it_ele){&error("成長劑屬性與寵物不同,無法使用!");}
		        if ($mpet ne"") {
		                $showpetname="$mpetname($ELE[$mpetele])";
		                foreach(@PETDATA){
		                        if ($PETDATA[$ej][0] eq $mpetname){
		                                $tranpoints=$PETDATA[$ej][5]/10000;
		                                last;
		                        }
		                        $ej++;
		                }

		        }
		        if ($tmppoints eq 0) {
		                &error("您的寵物無法訓練！！");
		        }elsif ($ej>=49 && $mpetlv>=10){
		                &error("您的寵物已經達到最強狀態，不需要再訓練了！！");
		        }

		        if ($mpetlv eq 10){
		                $rndpet=6+int(rand(4));
		                $petupID=$PETDATA[$ej][$rndpet];
		                if ($PETDATA[$petupID][5] eq"100000000"){
		                        $rndpet=6+int(rand(4));
		                        $petupID=$PETDATA[$ej][$rndpet];
		                }
		                if ($petupID>0) {
		                        $mpetlv=0;
		                        &maplog("<font color=darkgreen>[寵物]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>轉生成為<font color=red>$PETDATA[$petupID][0]</font>");
		                        &maplog10("<font color=darkgreen>[寵物]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>轉生成為<font color=red>$PETDATA[$petupID][0]</font>");
		                        $mpetname=$PETDATA[$petupID][0];
		                        $mess="恭喜你，你的寵物已轉生成為<font color=#AAAAFF>$mpetname</font>";
		
		                }else{
		                        &error("你的寵物無法再轉生！");
		                }
		        }else{
		                $mpetlv+=1;
		                $mpetdmg+=$PETDATA[$ej][1];
		                $mpetdef+=$PETDATA[$ej][2];
		                $mpetspeed+=$PETDATA[$ej][3];
		                $mess="你的寵物升級了，<font color=yellow>威力+$PETDATA[$ej][1]、防禦+$PETDATA[$ej][2]、速度+$PETDATA[$ej][3]";
		        }
			$mpet="$mpetcno,$mpetname,$mpetdmg,$mpetdef,$mpetspeed,$mpetele,$mpetlv,$mpetcl,$mpetsta,$mpettype,$mpetflg";
		}elsif($it_type eq "100"){
			$upval = 1;
			if($it_dmg eq "0" && $mmaxstr<500){
				$mmaxstr += $upval;
				$mess.="<font color=orange>力量 界限值上昇了$upval點！！</font><BR>";
			}elsif($it_dmg eq "1" && $mmaxvit<500){
				$mmaxvit += $upval;
				$mess.="<font color=orange>生命 界限值上昇了$upval點！！</font><BR>";
			}elsif($it_dmg eq "2" && $mmaxint<500){
				$mmaxint += $upval;
				$mess.="<font color=orange>智力 界限值上昇了$upval點！！</font><BR>";
			}elsif($it_dmg eq "3" && $mmaxmen<500){
				$mmaxmen += $upval;
				$mess.="<font color=orange>精神 界限值上昇了$upval點！！</font><BR>";
			}elsif($it_dmg eq "4" && $mmaxdex<500){
				$mmaxdex += $upval;
				$mess.="<font color=orange>運氣 界限值上昇了$upval點！！</font><BR>";
			}elsif($it_dmg eq "5" && $mmaxagi<500){
				$mmaxagi += $upval;
				$mess.="<font color=orange>速度 界限值上昇了$upval點！！</font><BR>";
			}
			$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";
		}elsif($it_type eq "101"){
			$upval = 2;
                        if($it_dmg eq "0" && $mmaxstr<500){
       	                        $mmaxstr += $upval;
                                $mess.="<font color=orange>力 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "1" && $mmaxvit<500){
                                $mmaxvit += $upval;
       	                        $mess.="<font color=orange>生命 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "2" && $mmaxint<500){
                                $mmaxint += $upval;
                                $mess.="<font color=orange>智力 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "3" && $mmaxmen<500){
                                $mmaxmen += $upval;
                                $mess.="<font color=orange>精神 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "4" && $mmaxdex<500){
                                $mmaxdex += $upval;
                                $mess.="<font color=orange>運氣 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "5" && $mmaxagi<500){
                                $mmaxagi += $upval;
                                $mess.="<font color=orange>速度 界限值上昇了$upval點！！</font><BR>";
                        }

			if($it_wei eq "0"){
				$mmaxstr -= $upval;
				$mess.="<font color=blue>力量 界限值下降了$upval點。。</font><BR>";
			}elsif($it_wei eq "1"){
				$mmaxvit -= $upval;
				$mess.="<font color=blue>生命 界限值下降了$upval點。。</font><BR>";
			}elsif($it_wei eq "2"){
				$mmaxint -= $upval;
				$mess.="<font color=blue>智力 界限值下降了$upval點。。</font><BR>";
			}elsif($it_wei eq "3"){
				$mmaxmen -= $upval;
				$mess.="<font color=blue>精神 界限值下降了$upval點。。</font><BR>";
			}elsif($it_wei eq "4"){
				$mmaxdex -= $upval;
				$mess.="<font color=blue>運氣 界限值下降了$upval點。。</font><BR>";
			}elsif($it_wei eq "5"){
				$mmaxagi -= $upval;
				$mess.="<font color=blue>速度 界限值下降了$upval點。。</font><BR>";
			}

			if($mmaxstr<100){$mmaxstr=100;}
			if($mmaxvit<100){$mmaxvit=100;}
			if($mmaxint<100){$mmaxint=100;}
			if($mmaxmen<100){$mmaxmen=100;}
			if($mmaxdex<100){$mmaxdex=100;}
			if($mmaxagi<100){$mmaxagi=100;}
			
			$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";
		}else{
			&error("此物品無法使用。");
		}
		&maplog4("[使用]$mname 使用了<font color=red>$it_name</font>。");
		
	}else{&error("此物品無法裝備。");}
	}else{
##bug
		&verchklog("$it_name,非法使用");	
	}
	splice(@ITEM,$in{'itno'},1);
	
	if($it_name){
		open(OUT,">./logfile/item/$in{'id'}.cgi");
		print OUT @ITEM;
		close(OUT);
		&chara_input;
		&ext_input;
	}else{&error("資料出現異常。");}

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">物品裝備/使用</FONT></TD>
    </TR>
    <TR>
      <TD colspan=2 height=100 bgcolor="#330000"><FONT color="$FCOLOR2">$mess</FONT>
　　</TD></TR>
	<TR><TD align=center height=5%>
	<form action="./status.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=equip>
	<INPUT type=submit CLASS=FC value=回到裝備/使用畫面></form>
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF
	&footer;
	exit;
	
}
1;
