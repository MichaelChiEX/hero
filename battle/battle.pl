sub bat{
	&chara_open;
	&town_open;
	&equip_open;
	&ext_open;
	&quest_open;
	$date = time();

	($ext_kinghit,$ext_kingtophit,$ext_kingcount)=split(/,/,$ext_kingetc);
	if($in{'mode'} eq "" || $SEN[$in{'mode'}] eq ""){&error("資料傳輸錯誤，<a href='./login.cgi'>請重新登入</a>。");}
	open(IN,"./data/guest_list.cgi");
	@newguest = <IN>;
	close(IN);
	$player=@newguest;
	$mixsp=0;
	if($member_point eq""){
		foreach(@newguest) {
			($gname,$gtime,$gcon,$ghost,$gid)=split(/<>/);
			if($gid ne $mid && $ghost eq $mhost){
				&maplog3("[變更IP後重複]$mname與$gname 登入後IP相同。");
				&error2("你的ＩＰ與 $gname 相同,重複IP無法同時登入");
			}
        }
	}
	if($player>$ADDTIMEMAX){
		$BTIME+=($player-$ADDTIMEMAX);
		if($BTIME>35){$BTIME=35;}
		if($BTIME>=30){
			if($ADDEX eq 1){
				$ADDEX=2;
			}
			if($ADDABP eq 1){
				$ADDABP=2;
			}
			if($ADDGOLD eq 1){
				$ADDGOLD=2;
			}
		}
	}
	if($member_fix_time){
		$BTIME=15;
	}
	if ($mid eq $GMID){
		$BTIME=5;
	}
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error("離下次可戰鬥時間剩$btime 秒。");}

	if(int(rand(50)) eq 7 && $in{'mode'}<30){$monfile="monster2.cgi";$reamon=1;}
	else{$monfile="monster.cgi";}
	open(IN,"./data/$monfile");
	@MON_DATA = <IN>;
	close(IN);

	$mode=$in{'mode'};
	$mode2=$in{'mode'};
	if ($mid eq $GMID) {
		$CHECK_MAP=0;
	}
	if ($moya ne $in{'rnd'}) {
		&error("戰鬥後請勿按重新整理");
	}elsif($in{'mode'} eq 30){
		$mode=5;
		$mixsp=1;
	}elsif($in{'mode'} eq 31){
		$mixsp=1;
		if($nowmap eq""){
			$SEN[$in{'mode'}].="入口";
		}elsif($nowmap eq"25"){
			$SEN[$in{'mode'}].="王座";
			$killking=1;
		}elsif($nowmap<25){
			$SEN[$in{'mode'}].=$nowmap."層";
		}else{
			$SEN[$in{'mode'}].="1層";
		}
		$mode=6;
	}elsif($in{'mode'} eq 5){
		$mode=1;
		if($mex%11 ne 0 && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 6){
		$mode=2;
		if($moya%40 ne "0" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}elsif($in{'mode'} eq 7){
		$mode=2;
		if(int(rand(15)) eq 7){
			$xmode=1;
			$mode2=18;
		}
		if($moya%80 ne "7" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}elsif($in{'mode'} eq 8){
		$mode=3;
		if($moya%300 ne "8" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 9){
		$mode=4;
		if($moya%1000 ne "9" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 10){
		$mode=1;
		if($moya ne "777" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 11){
		$mode=2;
		if($moya%2500 ne "17" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 12){
		$mode=3;
		if($moya ne "55555" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 13){
		$mode=3;
		if($moya%5000 ne "773" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 14){
		$mode=1;
		if($moya ne "77777" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 15){
		$mode=1;
		if($moya ne "775" && $moya ne "776" && $CHECK_MAP eq 1){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 20){
		$mode=1;
		if ($mtotal%100 ne "1"){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 21){
		$mode=2;
		if ($mtotal%300 ne "2"){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 22){
		$mode=3;
		if ($mtotal%600 ne "3"){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 23){
		$mode=3;
		if ($mtotal%3000 ne "4"){
			&lockaccout();
		}
	}
	elsif($in{'mode'} eq 24){
		$mode=4;
		if ($mtotal%10000 ne "5"){
			&lockaccout();
		}
	}elsif($in{'mode'} eq 40){
		$mode=7;
	}
 
	$mtotal++;
	#排名統計
	($ext_tl_chara,$ext_tl_name,$ext_tl_month,$ext_tl_type[0],$ext_tl_type[1],$ext_tl_type[2],$ext_tl_type[3],$ext_tl_type[4],$ext_tl_type[5],$ext_tl_king,$ext_tl_lose,$ext_tl_lvup,$ext_tl_gift,$ext_tl_mix,$ext_tl_rshop,$ext_tl_goditem)=split(/,/,$ext_total);
	$ext_tl_chara=$mchara;
	$ext_tl_name=$mname;
	&time_data;
	if($ext_tl_month ne "$mon"){
		$ext_tl_month=$mon;
		$ext_tl_type[0]=0;
		$ext_tl_type[1]=0;
		$ext_tl_type[2]=0;
		$ext_tl_type[3]=0;
		$ext_tl_type[4]=0;
		$ext_tl_type[5]=0;
		$ext_tl_king=0;
		$ext_tl_lose=0;
		$ext_tl_lvup=0;
		$ext_tl_gift=0;
		$ext_tl_mix=0;
		$ext_tl_rshop=0;
		$ext_tl_goditem=0;
	}
	#當天戰數統計
	($ext_today_date,$ext_today_total)=split(/,/,$ext_today_count);
	if($ext_today_date ne "$mday"){
		$ext_today_date=$mday;
		$ext_today_total=0;
	}
	$ext_today_total+=1;
	$ext_today_count="$ext_today_date,$ext_today_total";
	$ext_tl_type[$mtype]+=1;
	#神獸
	if (int(rand(200)) eq 1 && $monfile eq "monster.cgi" && ($in{'mode'}<6 || $in{'mode'} eq 30 || $in{'mode'} eq 31)) {
		if($town_con eq "$mcon" || $mcon eq"0"){
	        open(IN,"./data/townmonster.cgi");
	        @tmdata = <IN>;
	        close(IN);
			foreach(@tmdata){
				($ename,$eab,$etec,$esk,$e_ex,$e_gold,$etype,$elv)=split(/<>/);
				($ehp,$emp,$str,$vit,$eint,$efai,$edex,$eagi,$eele)=split(/,/,$eab);
				if("$etype" eq"$town_id" && $ehp>0 && $ename ne""){
					if ($ehp<10000){
						$ehp=10000;
					}
					$godmonsterhit++;
					last;
				}
			}
		}
	}
	if(!$godmonsterhit){
		@N_MON_DATA=();
		foreach(@MON_DATA){
			($ename,$eab,$etec,$esk,$e_ex,$e_gold,$etype,$elv)=split(/<>/);
			if($elv eq $mode){
				push(@N_MON_DATA,"$_");
			}
		}
		if($in{'mode'} eq"31"){
			if($nowmap eq""){
				$rand=0;
			}else{
				$rand=$nowmap;
				if ($rand>25){$rand=1;$nowmap=1;}
			}
		}else{
			$rand=int(rand(@N_MON_DATA));
		}
		($ename,$eab,$etec,$esk,$e_ex,$e_gold,$etype,$elv)=split(/<>/,$N_MON_DATA[$rand]);
		($ehp,$emp,$str,$vit,$eint,$efai,$edex,$eagi,$eele)=split(/,/,$eab);
#禁區魔王血量
		if($killking){
			$ext_kinghit++;
			if($ext_kinghp >0){
				$ehp=$ext_kinghp;
			}
		}
	}
	if($in{'mode'} ne"31" || $rand ne 25){
		$emaxhp=int(($ehp+$mmaxhp/2)/1.5);
	}else{
		$emaxhp=$ehp;
	}
	$emaxmp=$emp + int(rand($emp/2));
	if($reamon){
		$emaxhp=$ehp;
		$emaxmp=$emp;
	}
	$estr=int(($str+($mstr+$mvit)/2)/1.7);
	$evit=int(($vit+($mstr+$mvit)/2)/1.7);
	
	$epoint=int(($ehp+$emp)/3)+$str+$vit+$eint+$efai+$edex+$eagi;

	if($mode eq 1){$echara="chara/enemy";}
	elsif($mode eq 2){$echara="chara/enemy2";}
	elsif($mode eq 3){$echara="chara/enemy3";}
	elsif($mode eq 5){
		$echara="monster/".($mode*100 +1+$rand);}
	elsif($mode eq 6){
		$echara="monster/".($mode*100 +$rand);}
        elsif($mode eq 7){
                $echara="monster/k".(1 +$rand);}
	else{$echara="chara/enemy4";}
	$ehp2=$ehp;
	$emp2=$emp;
	&PARA;
	&TEC_OPEN;
	&header;
	
	print <<"EOF";
<table border="0" width="100%" align=center height="144" CLASS=TOC>
  <tbody>
    <tr>
      <td colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]" style="font-size:12pt"><font color="#ffffcc">$town_name $sen<font color=#AAAAFF>$SEN[$in{'mode'}]</font></font></td>
    </tr>
    <tr>
      <td bgcolor="#cccccc" width="30%">
      <table border="0" width="100%" height="100%" bgcolor=$ELE_BG[$mele] align=right>
        <tbody>
          <tr>
            <td rowspan="2"><font size="-1"><img src="$IMG/chara/$mchara.gif"></font></td>
            <td bgcolor=$FCOLOR2><font size="-1">HP</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$mhp/$mmaxhp</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">攻擊力</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$mstr $chi1(+$marmdmg+<font color=red>$mpetdmg)</font></font></td>
            <td bgcolor=$FCOLOR2><font size="-1">武器</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$marmname<br>
            【$marmdmg/$marmwei】</font></td>
          </tr>
          <tr>
            <td bgcolor=$FCOLOR2><font size="-1">MP</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$mmp/$mmaxmp</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">防御力</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$mvit $chi1(+$mprodmg+$maccdmg+<font color=red>$mpetdef</font>)</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">防具</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$mproname<br>
            【$mprodmg/$mprowei】</font></td>
          </tr>
          <tr>
            <td bgcolor=$FCOLOR2><font size="-1">$mname$petname2</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">職業</font></td>
            <td bgcolor=$FCOLOR2>$JOB[$mclass]</td>
            <td bgcolor=$FCOLOR2><font size="-1">速度</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$magi+<font color=red>$mpetspeed</font></font></td>
            <td bgcolor=$FCOLOR2><font size="-1">飾品</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$maccname<br>
            【$maccdmg/$maccwei】</font></td>
          </tr>
        </tbody>
      </table>
      </td>
      <td align="center" bgcolor="$FCOLOR2" width="20%"><a href="#lower"><img src="$IMG/etc/$mode2.jpg" width="150" height="113" border="0"></a></td>
      <td bgcolor="#cccccc" width=30%>
      <table border="0" width="100%" height="100%" bgcolor=$ELE_BG[$eele]>
        <tbody>
          <tr>
            <td rowspan="2"><font size="-1"><img src="$IMG/$echara.gif"></font></td>
            <td bgcolor=$FCOLOR2><font size="-1">HP</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$ehp/$emaxhp</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">攻擊力</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$estr $chi2</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">武器</font></td>
          </tr>
          <tr>
            <td bgcolor=$FCOLOR2><font size="-1">MP</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$emp/$emaxmp</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">防御力</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$evit $chi2</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">防具</font></td>
         </tr>
          <tr>
            <td bgcolor=$FCOLOR2><font size="-1">$ename</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">職業</font></td>
            <td bgcolor=$FCOLOR2></td>
            <td bgcolor=$FCOLOR2><font size="-1">速度</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">$eagi</font></td>
            <td bgcolor=$FCOLOR2><font size="-1">飾品</font></td>
          </tr>
        </tbody>
      </table>
      </td>
    </tr>
    <tr>
      <td bgcolor=#000000><font color="white" size="-1">「$mcom」</font></td>
      <td align=center bgcolor="666600"><font color="white" size="-1">戰鬥宣言</font></td>
      <td bgcolor=#000000><font color="white" size="-1">「・・・」</font></td>
    </tr>
  </tbody>
</table>
<br><br>
EOF


##戰鬥處理
	$turn=0;
	$maxturn=30;
	if($killking){$maxturn=20;}
	while($turn<=$maxturn){
		$turn++;
		$bmess="";
		$mmess="";
		if($mab[15] && $mabdmg[15]>$eabdmg[15] && int(rand(3-$mabdmg[15])) eq 0){$sensei = 1;}
		elsif($eab[15] && $eabdmg[15]>$mabdmg[15] && int(rand(3-$eabdmg[15])) eq 0){$sensei = 0;}
		elsif(int(rand($mdex)) > int(rand($edex))){$sensei = 1;}
		else{$sensei = 0;}
		if($sensei){
			if($mhp>0){
				&MATT;
			}else{
				$bmess.="<font size=3 color=#FF0000><b>(你已經沒有體力，躺在地上無法行動．．．)</b></font>";
			}
			if($ehp>0){
				$runb=int($mtotal/500);
				if($runb<5){$runb=5;}
				if($reamon && int(rand($runb)) eq 4){$mmess.="$ename逃跑了。";last;}
				&EATT;
			}
		}else{
			if($ehp>0){
				$runb=int($mtotal/500);
				if($runb<5){$runb=5;}
				if($reamon && int(rand($runb)) eq 4){$mmess.="$ename逃跑了。";last;}
				&EATT;
			}
			if($mhp>0){&MATT;}
		}
		if($win){
			#自我挑戰任務
			if ($quest2_town_no eq $mpos && $quest2_limit_time>$date && $quest2_map eq $in{'mode'}){
				$quest2_count++;
			}
			#禁區升層
			$kingover=0;
			if($in{'mode'} eq"31"){
				if($nowmap eq""){
					$nowmap="1";
				}elsif($killking){
					$nowmap="1";
					$ext_kinghp="0";
					$kingover=1;
					if($ext_kingtophit eq""){$ext_kingtophit=99;}
					if($ext_kingtophit>$ext_kinghit){$ext_kingtophit=$ext_kinghit;}
					$ext_kinghit=0;
					if($ext_kingcount eq""){$ext_kingcount=0;}
					$ext_kingcount++;
					$ext_tl_king++;
				}else{
					$nowmap++;
				}
			}
			$mkati++;
			&atp;
			if($sensei){
				&BPRINT;
			} else {
				&MPRINT;
			}
			$mlv=int($mex/100)+1;
			
			$get_ex=(int($epoint/15) + 10 + int(rand(10)));
			if($get_ex>50){$get_ex = 50 + int(rand(10));}
			if($get_ex<10){$get_ex = 10 + int(rand(10));}

#寵物生成技能,越高等地圖怪,越難成長,怪等級跟轉數越高,越難成長
			&PETLVUP;
			if($in{'mode'} eq 5 && $mex < 9900){
				$mode=5;
				$get_ex = 100;
				$z_gold = int(rand($mex*20));
				$com.="<font color=blueviolet><b>發現隱藏的財寶！</b></font><br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";
			}
			elsif($in{'mode'} eq 7){
				$mode=10;
				$get_ex = 100;
				$z_gold = int(rand(500000));
				$com.="<font color=blueviolet><b>發現隱藏的財寶</b></font><br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";
			}elsif($in{'mode'} eq 8){
				$mode=10;
				$get_ex = 100;
				$z_gold = int(rand(2000000));
				$com.="<font color=blueviolet><b>發現隱藏的財寶</b></font><br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";
				
			}
			$getabp=$mode;
			if($mode eq"5"){
				$getabp=5;
				$getabp+=int(rand($getabp));
				if (int(rand(100))>=98){
					$getabp=$getabp*10;
				}
                        }elsif($mode eq"7"){
				$getabp=int(rand(25))+25;
			}elsif($mode eq"6"){
				if($nowmap eq""){$nowmap=0;}
				$getabp=5+$nowmap;
				if (int(rand(100))>=98){
						$getabp=$getabp*10;
				}
				if($kingover){
					$getabp=1000;
					$z_gold = int(rand(5000000));
					if(int(rand(10)) < 13){
						$muprnd=int(rand(6));

						if($muprnd eq "0"){
							$mmaxstr += 1;
							$com.="<font color=orange>力的界限值上昇了１點！！</font><br>";
						}elsif($muprnd eq "1"){
							$mmaxvit += 1;
							$com.="<font color=orange>生命的界限值上昇了１點！！</font><br>";
						}elsif($muprnd eq "2"){
							$mmaxint += 1;
							$com.="<font color=orange>智力的界限值上昇了１點！！</font><br>";
						}elsif($muprnd eq "3"){
							$mmaxmen += 1;
							$com.="<font color=orange>精神的界限值上昇了１點！！</font><br>";
						}elsif($muprnd eq "4"){
							$mmaxdex += 1;
							$com.="<font color=orange>運的界限值上昇了１點！！</font><br>";
						}elsif($muprnd eq "5"){
							$mmaxagi += 1;
							$com.="<font color=orange>速的界限值上昇了１點！！</font><br>";
						}
						$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";
					}
				}
			}
			if($in{'mode'} eq 9){
				$mode=9;
				$get_ex = 100;
				$getabp=100 + int(rand(200));
				if(int(rand(20)) eq 7){$getabp=1000;}
				$muprnd=int(rand(6));
				$z_gold = int(rand(2000000));
				if($muprnd eq "0"){
					$mmaxstr += 1;
					$com.="<font color=orange>力的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "1"){
					$mmaxvit += 1;
					$com.="<font color=orange>生命的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "2"){
					$mmaxint += 1;
					$com.="<font color=orange>智力的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "3"){
					$mmaxmen += 1;
					$com.="<font color=orange>精神的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "4"){
					$mmaxdex += 1;
					$com.="<font color=orange>運的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "5"){
					$mmaxagi += 1;
					$com.="<font color=orange>速的界限值上昇了１點！！</font><br>";
				}
				$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";
				$com.="$mname<font color=blueviolet><b>發現隱藏的財寶</b></font>獲得<br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";
			}
			if($in{'mode'} eq 6){
				$mode=6;
				$get_ex = 100;
				$getabp=int(rand(50));
				if(int(rand(20)) eq 7){$getabp=300;}
				$z_gold = int(rand(100000));
				$com.="$mname<font color=blueviolet><b>發現隱藏的財寶</b></font>獲得<br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";
			}
			if($in{'mode'} eq 13){
				$getabp = 1000;
			}
			if($in{'mode'} eq 20){
				$getabp = 100;
				$get_ex = 100;
				$z_gold = int(rand(250000))+250000;
				$com.="$mname<font color=blueviolet><b>得到試練獎勵</b></font>獲得<br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";				
			}elsif($in{'mode'} eq 21){
				$getabp = 500;
				$get_ex = 100;
				$z_gold = int(rand(500000))+500000;
				$com.="$mname<font color=blueviolet><b>得到試練獎勵</b></font>獲得<br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";				
			}elsif($in{'mode'} eq 22){
				$getabp = 1000;
				$get_ex = 100;
				$z_gold = int(rand(1000000))+1000000;
				$com.="$mname<font color=blueviolet><b>得到試練獎勵</b></font>獲得<br><font color=blue size=4><b>$z_gold</b></font>Gold。<br>";				
			}
			if($in{'mode'} eq 23 || $in{'mode'} eq 22){
				if($in{'mode'} eq 23){
					$getabp = 100;
					$get_ex = 50;
				}
				$muprnd=int(rand(6));

				if($muprnd eq "0"){
					$mmaxstr += 1;
					$com.="<font color=orange>力的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "1"){
					$mmaxvit += 1;
					$com.="<font color=orange>生命的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "2"){
					$mmaxint += 1;
					$com.="<font color=orange>智力的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "3"){
					$mmaxmen += 1;
					$com.="<font color=orange>精神的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "4"){
					$mmaxdex += 1;
					$com.="<font color=orange>運的界限值上昇了１點！！</font><br>";
				}elsif($muprnd eq "5"){
					$mmaxagi += 1;
					$com.="<font color=orange>速的界限值上昇了１點！！</font><br>";
				}
				$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";

			}
			if($mab[22]){
				$get_ex = int($get_ex*1.2);
				$getabp += 1;
			}
			
			if($reamon eq 1){$getabp=$mode*20;}

			#經驗加成
			$get_ex=int($get_ex*$ADDEX);
			#熟練加成
			$quest_abp=$getabp;
			if($getabp<=101){
				$getabp=int($getabp*$ADDABP);
			}

			$mbex=$mex;
			if($mex<9900){
				$mex+=$get_ex;
			}
			$mtotalex+=$get_ex;

			if($mode eq"7"){
				$get_gold=($epoint + int(rand($epoint/5)));
			}else{
				$get_gold=($epoint + int(rand($epoint/5)))*4;
			}
			#金錢任務加成
			if($quest_time[1]>=$date){
				$quest_get_gold=$get_gold;
				$com.="<font color=green size=3>$QUEST_NAME[1]任務效果，增加$quest_get_gold Gold</font>。<br>";
			}
			#金錢加成
			$get_gold=int($get_gold*$ADDGOLD);
			#熟練任務加成
			if($quest_time[2]>=$date){
				if($quest_abp>200){
					$quest_abp=200;
				}
				$com.="<font color=green size=3>$QUEST_NAME[2]任務效果，增加$quest_abp熟練</font>。<br>";
			}else{
				$quest_abp=0;
			}
			if($member_level>0){
				$com.="<font color=green size=3>等級$member_level贊助效果，增加$member_level熟練</font>。<br>";
			}
			
			$mabp+=$getabp+$quest_abp+$member_level;
			$bmjp[$mtype]=$mjp[$mtype];
			$mjp[$mtype]+=$getabp;
			if($mjp[$mtype]>$MAXJOB){$mjp[$mtype] = $MAXJOB;}
			
			if($mab[13]){
				$find = int($mabdmg[13]/750);
			}
			if(int(rand(10-$find)) eq 1){
				$add_gold=int(rand($get_gold*5+1000));
				$com.="額外獲得<font color=orange size=4>$add_gold</font>Gold。<br>";
			}
			$get_gold2=$get_gold+$add_gold + $z_gold+$quest_get_gold;

			$mgold+=$get_gold2;

			&LVUP;

			##界限アップ
			$maxtotal = $mmaxstr + $mmaxvit + $mmaxint + $mmaxmen + $mmaxdex + $mmaxagi;
			$maxrand = int(($maxtotal - 1000)/20);
			if($maxrand<0){&error("界限值出現異常。");}
			$maxrand2 = $maxrand * $maxrand;
			if($mab[22]){
				$maxrand2=int($maxrand2/1.5);
			}
			if(int(rand($maxrand2)) eq "1" || $in{'mode'} eq "13"){
				&MAXUP;
			}

			##宝箱ゲット
			$reaup = 0;
			if($mab[13]){
				$reaup += $mabdmg[13];
			}
			#地圖打寶率
			if($in{'mode'} eq 4){$reaup += 2000;}
			elsif($in{'mode'} eq "30") {$reaup += 3000;}
			elsif($kingover){$reaup = 9900;}
			elsif($in{'mode'} eq "31") {$reaup += 4000;}
			
			$han2=int(rand(10000-$reaup));
			if(($in{'mode'} eq "30" || $in{'mode'} eq "31" || $in{'mode'} eq "40")) {
				$sr_rnd=400-$member_level*30;
				$sr_rnd2=50-$member_level*3;
				if($sr_rnd <100){$sr_rnd=100;}
				if($sr_rnd2 <25){$sr_rnd2=25;}
				if (int(rand($sr_rnd)) eq "8"){
					$reahit=1;
				}elsif ($mab[38] && int(rand($sr_rnd2)) eq "10") {
					$reahit=1;
				}
				if($mid eq $GMID){$reahit=1;}
				if ($reahit eq 1){
					#原料
					if ($ext_tl_mix eq""){$ext_tl_mix=0;}
					$ext_tl_mix++;
					$rflg=1;
					$REA="mixitem";
					$ino=$eele;
					if($in{'mode'} eq"31" || $in{'mode'} eq "40"){$ino=int(rand(7)+1);}
					if($ext_mix[$ino] eq ""){
						$ext_mix[$ino]=1;
					}else{
						$ext_mix[$ino]++;
					}
					$com.="<br><b>發現<font color=#ff0066>$ELE[$ino]原料</font></b>!!<br>";
					if($STORITM_MAX<$ext_mix[$ino]){
						$com.="<font color=#ff0000>但因此原料數量達倉庫上限,所以被丟棄</font>";
						$ext_mix[$ino]--;
					#原料任務效果
					}elsif($quest_time[5]>=$date){
						$ext_mix[$ino]++;
						$com.="<br><font color=green><b>$QUEST_NAME[5]任務效果追加１個<font color=#ff0066>$ELE[$ino]原料</font></b>!!</font><br>";	
						if($STORITM_MAX<$ext_mix[$ino]){
							$com.="<font color=#ff0000>但因此原料數量達倉庫上限,所以被丟棄</font>";
							$ext_mix[$ino]--;
						}
					}
					$iflg=1;
					$reano=5;
				}elsif(($mid eq $GMID || int(rand(2500)) eq 1) && $in{'mode'} eq "31" && $nowmap>5){
					#地獄草
					$rflg=1;
					$reahit=1;
					$REA="item";
					$ino=51;
					$iflg=1;
					$reano=3;
				}
			}
			if($in{'mode'} eq "12" && int(rand(5)) eq "3"){
				$rflg=1;
				$REA="item";
				$reano=3;
				$b_no2 = int(rand(5));
				$ino=45+$b_no2;
				$reahit=1;
				$iflg=1;
			}elsif($in{'mode'} eq "14"){
				$rflg=1;
				$REA="item";
				$reano=3;
				$b_no2 = int(rand(4));
				$ino=44;
				$reahit=1;
			}elsif($in{'mode'} eq "9" && int(rand(15)) eq 7){
				$rflg=1;
				$REA="item";
				$reano=3;
				$b_no2 = 0;
				$ino=50;
				$reahit=1;
			}elsif($in{'mode'} >= 3 && $han2 eq "7" || $in{'mode'} eq "10" || $elv >=99){
				$brand=int(rand(6));
				if($in{'mode'} eq 3 || $in{'mode'} eq 4){
					$brand=int(rand(3)) + 2;
					$rrand=7;
				}else{
					$rrand=15;
				}
				#降低物品出現率
                if ($brand >4){$brand=int(rand(7));}
				if ($brand >4){$brand=5;}
				if ($brand eq 4 && !$mab[36]) {
					$brand=int(rand(6));
				}

				if($brand eq 1){
					$REA="rarearm";
					$reano=0;
					$b_no2 = int(rand(26));
					if(int(rand($rrand)) eq 1){
						$b_no2 = 26 + int(rand(36));
					}
					$ino=$b_no2;
					if($ino eq 4){$ino = 5;}
				}
				elsif($brand eq 2){
					$rflg=1;
					$REA="rarepro";
					$reano=1;
					$b_no2 = int(rand(23));
					if(int(rand($rrand)) eq 1){
						$b_no2 = 23 + int(rand(23));
					}
					$ino=$b_no2;
				}
				elsif($brand eq 3){
					$rflg=1;
					$REA="rareacc";
					$reano=2;
					$b_no2 = int(rand(25));
					if(int(rand($rrand)) eq 1){
						$b_no2 = 25 + int(rand(25));
					}
					$ino=$b_no2;
				}
				elsif($brand eq 4){
					$REA="pet";
					$reano=4;
					$b_no2=int(rand(7));
					if ($b_no2 eq 7){$b_no2=5;}
					$ino=$b_no2;
				}else{
					$rflg=1;
					$REA="item";
					$reano=3;
					$b_no2 = int(rand(23));
					$ino=17+$b_no2;
				}
				$reahit=1;
			} else {
				$rrand=15;
			}
			$act_rnd=500;
			$act_rnd-=$member_level*40;
			if($act_rnd<100){$act_rnd=100;}
			#KO魔王掉奧義石
			if($kingover &&!$reahit && int(rand($act_rnd/2)) eq 33){
				$tmp_get[0]=92;
				$tmp_get[1]=93;
				$tmp_get[2]=94;
				$tmp_get[3]=95;
				$tmp_get[4]=96;
				$tmp_get[5]=97;
				$tmp_get[6]=98;
				$tmp_get[7]=108;

				$REA="";
				$reano="7";
				$ino=0;
				$reahit=1;
				$rndsta=$tmp_get[int(rand(8))];
				if($rndsta eq 96 || $randsta eq 108){$rndsta=$tmp_get[int(rand(8))];}
			        open(IN,"./data/ability.cgi");
			        @ABILITY = <IN>;
			        close(IN);
			        foreach(@ABILITY){
						($abno,$abname,$abcom)=split(/<>/);
					if($abno eq $rndsta){
						last;
					}
				}
				$REA[0]="$abname-奧義之石(飾)<>300000<>2<>0<>0<>80<>10<>$rndsta<><><>";
			}elsif(!$reahit && $in{'mode'} eq"40" && (int(rand($act_rnd)) eq 3 || $mid eq $GMID)){
			#魔王城掉奧義石
				$REA="";
				$reano="7";
				$ino=0;
				$reahit=1;
				$rndsta=int(rand(54));
				if($rndsta eq 53){
					$rndsta=int(rand(22));
					if($rndsta eq 21){
						$rndsta=int(rand(6));
						$rndsta=$ext_stone[$rndsta];
					}else{
						$rndsta=$adv_stone[$rndsta];
					}
				}else{
					$rndsta=$normal_stone[$rndsta];
				}
				if($rndsta eq""){$rndsta="1";}
				open(IN,"./data/ability.cgi");
				@ABILITY = <IN>;
				close(IN);
				foreach(@ABILITY){
					($abno,$abname,$abcom)=split(/<>/);
					if($abno eq $rndsta){
						last;
					}
				}
				$reqx=int(rand(3));
				if($reqx eq 0){
					$req_namex="武";
				}elsif($reqx eq 1){
					$req_namex="防";
				}elsif($reqx eq 2){
					$req_namex="飾";
				}
				$REA[0]="$abname-奧義之石($req_namex)<>300000<>$reqx<>0<>0<>80<>10<>$rndsta<><><>";
			}

			#活動區
			#加倍
			$act_rnd=int($act_rnd/2);
			if(!$reahit && $ACTOPEN>0 && int(rand($act_rnd)) eq 35 && $ext_today_total<1501){
#1/10的機會得到無限冒險抽獎券
				if (int(rand(10)) eq 7) {$ACTOPEN=8;}
				($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
				$act[$ACTOPEN]+=1;
				$ext_action="$act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9]";
				$REA="actionitem";
				$reano=6;
				$ino=$ACTOPEN-1;
				$reahit=1;
				$com.="<br><b>發獲得<font color=#ff0066>$ACTITEM[$ACTOPEN]</font></b>!!<br>";
				&maplog("<font color=#ff0066>[活動]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得<font color=red>$ACTITEM[$ACTOPEN]</font>!!");
				&maplog7("<font color=#ff0066>[活動]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得<font color=red>$ACTITEM[$ACTOPEN]</font>!!");
			}
#活動區結束
			if ($con_id eq "0"){$rndtmp=500;}else{$rndtmp=2000;}
				if(!$reahit && int(rand($rndtmp)) eq 50){
					#建國之石
					$rflg=1;
					$REA="mixitem";
					$ino=$eele;
					$ino=0;
					if($ext_mix[$ino] eq ""){
						$ext_mix[$ino]=1;
					}else{
						$ext_mix[$ino]++;
					}
					$com.="<br><b>發現<font color=#ff0066>建國之石</font></b>!!<br>";
					$iflg=1;
					$reano=5;
			}
			if($reahit){
				if ($ext_tl_gift eq ""){$ext_tl_gift=0;}
				$ext_tl_gift++;
			}

			if($reahit && "$reano" ne "5" && "$reano" ne "6"){
				if($REA ne ""){
					open(IN,"./data/$REA.cgi");
					@REA = <IN>;
					close(IN);
				}
				($it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos) = split(/<>/,$REA[$ino]);

				open(IN,"./logfile/item/$in{'id'}.cgi");
				@ITEM = <IN>;
				close(IN);
				if(@ITEM<$ITM_MAX && $it_name ne ""){
					if ($REA eq "rarearm" || $REA eq "rarepro" || $REA eq "rareacc"){
						$rand_val=17-int($mtotal/10000);
						if ($rand_val<8) {
							$rand_val=8;
						}
						$rand_val-=$member_level;
						if($rand_val<3){$rand_val=3;}
						if ($mid eq $GMID) {$rand_val=2;}
						if (int(rand($rand_val)) eq 1) {
							$rnd_srar=int(rand($SRARCOUNT));
							if ($rnd_srar eq 14) {
								$rnd_srar=int(rand($SRARCOUNT));
							}
							$it_ele=int(rand(8));
							$it_type=$SRAR[$rnd_srar][0];
							if ($REA eq "rarearm") {
								$it_name=$SRAR[$rnd_srar][1] . "之" . $ARM[$it_ele] . "★";
							}elsif ($REA eq "rarepro") {
								$it_name=$SRAR[$rnd_srar][1] . $TPRO[$it_ele] . "★";
							}elsif ($REA eq "rareacc") {
								$it_name=$SRAR[$rnd_srar][1] . $TACC[$it_ele] . "★";
							}
							$rnd_srar=int(rand(21));
						}
						$up_var=0;
						if(int(rand($rand_val*2)) eq 5){
							$up_var=0.4;
							$it_name="稀有的".$it_name;
						}elsif(int(rand(int($rand_val))) eq 7){
							$up_var=0.2;
							$it_name="優良的".$it_name;
						}
						$it_dmg+=int($it_dmg*$up_var);
						if ($it_wei>0){
							$it_wei-=int($it_wei*$up_var);
						}elsif($it_wei<0){
							$it_wei+=int($it_wei*$up_var);
						}else{
							$it_wei-=int($up_var*50);
						}
						
						$it_desc="(".$it_dmg."/".$it_wei.")(".$ELE[$it_ele].")";
						if ($ext_tl_goditem eq""){$ext_tl_goditem=0;}
						$ext_tl_goditem++;
					}
					push(@ITEM,"rea<>$reano<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>0<>\n");
					open(OUT,">./logfile/item/$in{'id'}.cgi");
					print OUT @ITEM;
					close(OUT);
					$com.="<br><b>發現<font color=#ff0066>$it_name $it_desc</font></b>!!<br>";
					&maplog("<font color=#ff0066>[打寶]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得<font color=red>$it_name</font><font color=green>$it_desc</font>!!");
					&maplog7("<font color=#ff0066>[打寶]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得$led<font color=red>$it_name</font><font color=green>$it_desc</font>!!");
				}
			}

			print <<"EOF";
			<center><a name=lower></a>
			<table border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<tbody><tr>
      			<td colspan="2" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">勝利！</font></td>
    			</tr>
    			<tr><td colspan="2" align="center" bgcolor="$FCOLOR2">
			獲得<font color="#cc0000">$get_ex</font>經驗<br>
      			獲得<font color="#000099">$get_gold</font> Gold！<br>
			獲得<font color="#cc0000">$getabp</font>熟練度<br>
			$com<br>$showmsg<br>
      			<table border="0" bgcolor="#990000">
        		<tbody><tr>
            		<td bgcolor="#ffffcc">經驗值</td>
            		<td bgcolor="#ffffcc">$mex(+$get_ex)point</td>
          		</tr>
          		<tr><td bgcolor="#ffffcc">Gold</td>
            		<td bgcolor="#ffffcc">$mgold(+$get_gold2)Gold</td>
          		</tr></tbody></table>
      			</td></tr>
  			</tbody></table>
			</center>
EOF
			last;
		}if($lose){
			if ($quest2_town_no eq $mpos && $quest2_limit_time>$date && $quest2_map eq $in{'mode'} && $quest2_count<10){
				$quest2_count=0;
			}
			$ext_tl_lose++;
			#禁地回入口
			if($in{'mode'} eq"31" && !$killking){
				if($mab[39] && $nowmap ne""){
					if($mabdmg[39]<$nowmap){
						$nowmap-=$mabdmg[39];
					}else{
						$nowmap="";
					}
				}else{
					$nowmap="";
				}
			}elsif($killking){
				$ext_kinghp=$ehp+1000;
				if($ext_kinghp>200000){$ext_kinghp=200000;}
				if(int(rand(10)) >6 ){
					if($mab[39] && $mabdmg[39]<$nowmap){
							$nowmap-=$mabdmg[39];
					}else{
							$nowmap="";
					}
					if($nowmap eq""){
						$losecom.="<font color=red>你被魔王推回到入口$nowmap!</font><br>";
					}else{
						$losecom.="<font color=red>你被魔王推回$mabdmg[39]層!</font><br>";
					}
				}
			}
			$lose_gold=$mgold-int($mgold/2);
			$mgold-=$lose_gold;
			&atp;
			if($sensei){
				&BPRINT;
			} else {
				&MPRINT;
			}
			print <<"EOF";
			<center><a name=lower></a>
			<table border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<tbody>
    			<tr><td colspan="2" align="center" bgcolor="$FCOLOR2">
			<font color="#ff0000">$mname的所持金減半！！</font><br>
      			<br>

      			<table border="0" bgcolor="#990000">
        		<tbody><tr>$losecom
            		<td bgcolor="#ffffcc">失去了<font color="#000099">$lose_gold</font> Gold！</td>
          		</tr></tbody></table>
      			</td></tr>
  			</tbody></table>
			</center>
EOF
			last;
		}
		if($sensei){
			&BPRINT;
		} else {
			&MPRINT;
		}
	}
	if(!$win && !$lose){
		&atp;
		if($killking){
			$ext_kinghp=$ehp+1000;
			if($ext_kinghp>200000){$ext_kinghp=200000;}
			if(int(rand(10)) >3 ){
				if($mab[39] && $mabdmg[39]<$nowmap){
					$nowmap-=$mabdmg[39];
				}else{
					$nowmap="";
				}
				if($nowmap eq""){
					$mmess.="<font color=red>你被魔王推回到入口!</font><br>";
				}else{
					$mmess.="<font color=red>你被魔王推回$mabdmg[39]層!</font><br>";
				}
			}
		}
		if($sensei){
			$mmess.="<center><a name=lower></a>此戰未分出勝負。";
			&BPRINT;
		} else {
			$bmess.="<center><a name=lower></a>此戰未分出勝負。";
			&MPRINT;
		}

	}

	if($mab[30]){
		$un = 8000;
		$un2 = 5;
	}
	if($moya eq "55555"){
		if($iflg || int(rand(5)) eq "1" || $lose){
			$moya=int(rand(30000));
		}
	}else{
		if ($mab[34]){
			if (int(rand(40)) eq 11) {
				$moya=6666;
			}
		}
		if ($moya ne 6666) {
			$moya=int(rand(20000-$un));
		}
		if ($moya eq 6666 && $mab[34] ne 1) {
			$moya=6783;
		}
	}

	if($in{'mode'} eq 11){$moya = 775 + int(rand(12-$un2));}
	elsif($in{'mode'} eq 15){
		if(int(rand(30)) eq 7){$moya=77777;}
		else{$moya = 777 + int(rand(4));}
	}
	elsif($mode2 eq 18){$moya = 770 + int(rand(15-$un2));}
	elsif($in{'mode'} eq 7 && $moya ne 777 && $moya ne 775 && $moya ne 776){$moya = int(rand(20-$un2));}
	elsif($in{'mode'} eq 8 && int(rand(10)) eq 1 && !$lose){
		$moya = 55555;
	}
	if($moya eq 777 && $mtotal<3000 && int(rand(4)) < 3){
		$moya=int(rand(20000-$un));
	}

	if(int(rand(100000)) eq 777){
		$moya=77777;
	}
	
	if($in{'mode'} eq"23" && $win){
		$moya=777;
	}
	if($in{'mode'} eq"24" && $win){
                $moya=77777;
        }
	if($member_auto_sleep){$mhp=$mmaxhp;$mmp=$mmaxmp;}
	if($member_auto_savegold){$mbank+=$mgold;$mgold=0;}
	if($killking){
		$exp_kinghp=$ehp;
		$mtotal--;
	}
	&chara_input;
	if ($in{'mode'} ne"1" && $in{'mode'} ne"2" && $in{'mode'} ne"3" && $in{'mode'} ne"4" && $in{'mode'} ne"30" && $in{'mode'} ne"31" && $in{'mode'} ne"40"){
		$rmode=$in{'rmode'};
	}else{
		$rmode=$in{'mode'};
	}
	$ext_kingetc="$ext_kinghit,$ext_kingtophit,$ext_kingcount";
	#戰數統計
	if($moya%1000 eq "1"){
		if($ext_tl_rshop eq""){$ext_tl_rshop=0;}
		$ext_tl_rshop++;
	}
	$ext_total="$ext_tl_chara,$ext_tl_name,$ext_tl_month,$ext_tl_type[0],$ext_tl_type[1],$ext_tl_type[2],$ext_tl_type[3],$ext_tl_type[4],$ext_tl_type[5],$ext_tl_king,$ext_tl_lose,$ext_tl_lvup,$ext_tl_gift,$ext_tl_mix,$ext_tl_rshop,$ext_tl_goditem";
	&quest_input;
	&ext_input;
$buttonl[1]=<<"EOF";
        <center>
	<input type="button" value="[F4]回到城鎮" CLASS=FC onclick="javascript:parent.backtown();" style="HEIGHT: 48px">
EOF
$buttonl[0]=<<"EOF";
        <form action="./town.cgi" method="POST">
        <input type=hidden name=id value="$mid">
        <input type=hidden name=pass value="$mpass">
        <input type=hidden name=mode value=inn>
        <input type=hidden name=rmode value=$rmode>
        <input type="submit" value="住宿" CLASS=FC style="HEIGHT: 48px" ></td>
        </form>
EOF
$buttonl[2]=<<"EOF";
        <form action="./town.cgi" method="post">
        <input type=hidden name=azuke value=$mgold>
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass>
	<input type=hidden name=rmode value=$rmode>
        <input type=hidden name=mode value=bankall>
        <input type=submit value=全部存入銀行 CLASS=FC style="HEIGHT: 48px"></td></form>
EOF
	print <<"EOF";
<center>
<table border="0" width="35%" id="table1" cellspacing="4" cellpadding="0">
	<tr>
		<td>$buttonl[0]
		<td>$buttonl[1]</td>
		<td>$buttonl[2]
	</tr>
</table>
$verscript
	</center>
EOF
&footer;
}
sub atp{
	open(IN,"./logfile/item/$in{'id'}.cgi");
	@K_ITEM = <IN>;
	close(IN);
	$ihit=0;
	@NEW_C_ITEM=();
	foreach(@K_ITEM){
		($k_no,$k_mark,$k_name,$k_val,$k_dmg,$k_wei,$k_ele,$k_hit,$k_cl,$k_type,$k_sta,$k_flg) = split(/<>/);
		if($k_sta eq "1" && $ihit eq "0" && $k_mark eq 3){
			$mhp = $mmaxhp;
			$k_val-=$mmaxhp*2;
			$ihit=1;
			$pnum = int($k_val/2);
			$bmess.= "<br>使用〔$k_name〕剩餘<font color=red>$pnum</font>)<br>";
			if($k_val <0){
				$bmess.= "<font color=red>〔$k_name〕消失了。。</font><br>";
			}else{
				push(@NEW_C_ITEM,"$k_no<>$k_mark<>$k_name<>$k_val<>$k_dmg<>$k_wei<>$k_ele<>$k_hit<>$k_cl<>$k_type<>$k_sta<>$k_flg<>\n");
			}
		}else{
			push(@NEW_C_ITEM,"$_");
		}
	}
	open(OUT,">./logfile/item/$in{'id'}.cgi");
	print OUT @NEW_C_ITEM;
	close(OUT);
}
sub lockaccout{
	$e_addrobot=($ext_robot % 3) + 1;
	$ext_robot++;
	&verchklog("不當進入($ext_robot)");
	$ext_lock=$date+600*$e_addrobot;
	&ext_input;
	&error3("封鎖 $e_addrobot 分鐘");
}
1;
