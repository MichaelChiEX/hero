sub bat{
	&chara_open;
	&town_open;
	&equip_open;
	&ext_open;
	&quest_open;
        $date = time();
#                $ext_tmpx2=$ext_lock-$date;
#                $ext_tmpx=int(($ext_tmpx2)/60/60);
#                if($ext_tmpx2>0){
#			&verchklog("封鎖後戰鬥($ext_robot)");
#                        &error3("你的帳號已被封鎖,需要$ext_tmpx小時($ext_tmpx2秒)才會解除");
#                }
	if($ext_quest_total<$mtotal && $mtotal ne""){
		if ($ext_quest_total eq"-1" || $ext_quest_total eq""){
			if($mpos ne $quest_town_no){
			$i=0;
		        foreach(@TOWN_DATA){
		                ($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y)=split(/<>/);
				if($town2_id>21){last;}
		                if(abs($town2_x-$town_x) <= "1" && abs($town2_y-$town_y) <= "1" && $town_name ne $town2_name || $moveall){
		                        $towns[$i]=$town2_id;
                        		$townn[$i]=$town2_name."($town2_x，$town2_y)";
                		        $i++
		                }
		        }
			$ext_quest_total="-1";
		        $gtown=int(rand($i));
		        $quest_town_no=$towns[$gtown];
		        $quest_town_name=$townn[$gtown];
			if($quest_town_no eq""){
				$quest_town_no=0;
				$quest_town_name="冒險者中心";
			}
			&quest_input;
			&ext_input;
			}
			&quest_form;
		}elsif($ext_quest_total eq"-2"){
			&quest_form2;
		}else{
			$quest_time[0]=$date+600;
			$ext_quest_total="-2";
			&quest_input;
			&ext_input;
			&quest_form2;
		}
	}
	if($mtotal eq""){
		$ext_quest_total="-1";
	}
#	if($ext_check_robot ne"" && $in{'verchk'} eq""){
#		$u_date=$date-$vertime;
#		if($u_date>120){
#			&verchklog("上次$ext_check_robot驗證顯示時間:$u_date秒前");
#		}
#                &verchklog("重進驗證:$ext_check_robot");
#		&createver;
#		&vercheck_form;
#	}elsif (int(rand(60)) eq 15){
#		&createver;
#		if($SP_LOG){
#			&verchklog("驗證碼產生:$ext_check_robot");
#		}
#                &vercheck_form;
#        }else{
#                $ext_check_robot="";
#        }
	($ext_kinghit,$ext_kingtophit,$ext_kingcount)=split(/,/,$ext_kingetc);
	if($in{'mode'} eq "" || $SEN[$in{'mode'}] eq ""){&error("資料傳輸錯誤，<a href='./login.cgi'>請重新登入</a>。");}
#	if ($in{'verchk'} ne $ext_check_robot && $ext_check_robot ne""){
#		$e_addrobot=($ext_robot % 3) + 1;
#                $ext_robot++;
#                &verchklog("驗證錯誤($ext_robot)");
#                $ext_lock=$date+600*$e_addrobot;
#		$ext_check_robot="";
#		&ext_input;
#		&error3("驗證失敗,封鎖$e_addrobot 0分鐘");
#	}else{
		#特別ID LOG
#		if($SP_LOG){
#		}
#		$ext_check_robot="";
#	}
        open(IN,"./data/guest_list.cgi");
        @newguest = <IN>;
        close(IN);
	$player=@newguest;
	$mixsp=0;
if($in{'rnd2'} eq "" && $mtotal ne"0"){&error2("系統已進行更新，請重新登入");}
	if($member_point eq""){
	foreach(@newguest) {
                ($gname,$gtime,$gcon,$ghost,$gid)=split(/<>/);
                if($gid ne $mid && $ghost eq $mhost){
                        &maplog3("[變更IP後重複]$mname與$gname 登入後IP相同。");
			&error2("你的ＩＰ與 $gname 相同,重複IP無法同時登入");
#                }elsif($gid eq $mid && $ghost ne $mhost && $mid ne $GMID){
#			&maplog3("[變更IP]$mname登入後IP變更，需要重新登入。");
#                        &error2("你的主機ＩＰ登入後變更，請重新登入$ghost->$mhost");
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

	$rand=int(rand(1000));
	
	if(int(rand(50)) eq 7 && $in{'mode'}<30){$monfile="monster2.cgi";$reamon=1;}
	else{$monfile="monster.cgi";}
	open(IN,"./data/$monfile") or &error("檔案無法開啟battle/battle.pl(16)。");
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
		#Zeeman 修塔100%出現
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
        if($SP_LOG){
                &verchklog("戰:".$SEN[$in{'mode'}]);
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
	        if(@N_MON_DATA ==()){&error("資料出現異常");}
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
		#禁區怪越來越強
	#	if($in{'mode'} eq"31"){
			#$nowmapup=$nowmap;
			#if($nowmapup eq""){
			#	$nowmapup=1;
			#}
                        #$nowmapup2=1+$nowmapup/50;
			#$nowmapup=1+$nowmapup/10;
			#$ehp=int($ehp*$nowmapup);
			#$str=int($str*$nowmapup);
			#$vit=int($vit*$nowmapup);
			#$eint=int($eint*$nowmapup2);
			#$efai=int($efai*$nowmapup2);
			#$edex=int($edex*$nowmapup2);
			#$eagi=int($eagi*$nowmapup2);
	#	}
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
<TABLE border="0" width="100%" align=center height="144" CLASS=TOC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]" style="font-size:12pt"><FONT color="#ffffcc">$town_name $sen<font color=#AAAAFF>$SEN[$in{'mode'}]</font></FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#cccccc" width="30%">
      <TABLE border="0" width="100%" height="100%" bgcolor=$ELE_BG[$mele] align=right>
        <TBODY>
          <TR>
            <TD rowspan="2"><FONT size="-1"><img src="$IMG/chara/$mchara.gif"></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">HP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mhp/$mmaxhp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">攻擊力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mstr $chi1(+$marmdmg+<font color=red>$mpetdmg)</font></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$marmname<BR>
            【$marmdmg/$marmwei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mmp/$mmaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mvit $chi1(+$mprodmg+$maccdmg+<font color=red>$mpetdef</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mproname<BR>
            【$mprodmg/$mprowei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mname$petname2</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2>$JOB[$mclass]</TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$magi+<font color=red>$mpetspeed</font></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">飾品</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$maccname<BR>
            【$maccdmg/$maccwei】</FONT></TD>
          </TR>
        </TBODY>
      </TABLE>
      </TD>
      <TD align="center" bgcolor="$FCOLOR2" width="20%"><a href="#lower"><IMG src="$IMG/etc/$mode2.jpg" width="150" height="113" border="0"></a></TD>
      <TD bgcolor="#cccccc" width=30%>
      <TABLE border="0" width="100%" height="100%" bgcolor=$ELE_BG[$eele]>
        <TBODY>
          <TR>
            <TD rowspan="2"><FONT size="-1"><img src="$IMG/$echara.gif"></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">HP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ehp/$emaxhp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">攻擊力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$estr $chi2</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$emp/$emaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$evit $chi2</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ename</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$eagi</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">飾品</FONT></TD>
          </TR>
        </TBODY>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD bgcolor=#000000><font color="white" size="-1">「$mcom」</font></TD>
      <TD align=center bgcolor="666600"><font color="white" size="-1">戰鬥宣言</font></TD>
      <TD bgcolor=#000000><font color="white" size="-1">「・・・」</font></TD>
    </TR>
  </TBODY>
</TABLE>
<BR><BR>
EOF


##戰鬥處理
	$turn=0;
	$maxturn=30;
        if($killking){$maxturn=20;}
        while($turn<=$maxturn){
		$turn++;
		if($turn>100){&error("回合錯誤");}
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
#$ext_kinghit,$ext_kingtophit,$ext_kingcount
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
				$com.="<font color=blueviolet><b>發現隱藏的財寶！</b></font><BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";
			}
			elsif($in{'mode'} eq 7){
				$mode=10;
				$get_ex = 100;
				$z_gold = int(rand(500000));
				$com.="<font color=blueviolet><b>發現隱藏的財寶</b></font><BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";
			}elsif($in{'mode'} eq 8){
				$mode=10;
				$get_ex = 100;
				$z_gold = int(rand(2000000));
				$com.="<font color=blueviolet><b>發現隱藏的財寶</b></font><BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";
				
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
                                                $com.="<font color=orange>力的界限值上昇了１點！！</font><BR>";
                                        }elsif($muprnd eq "1"){
                                                $mmaxvit += 1;
                                                $com.="<font color=orange>生命的界限值上昇了１點！！</font><BR>";
                                        }elsif($muprnd eq "2"){
                                                $mmaxint += 1;
                                                $com.="<font color=orange>智力的界限值上昇了１點！！</font><BR>";
                                        }elsif($muprnd eq "3"){
                                                $mmaxmen += 1;
                                                $com.="<font color=orange>精神的界限值上昇了１點！！</font><BR>";
                                        }elsif($muprnd eq "4"){
                                                $mmaxdex += 1;
                                                $com.="<font color=orange>運的界限值上昇了１點！！</font><BR>";
                                        }elsif($muprnd eq "5"){
                                                $mmaxagi += 1;
                                                $com.="<font color=orange>速的界限值上昇了１點！！</font><BR>";
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
					$com.="<font color=orange>力的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "1"){
					$mmaxvit += 1;
					$com.="<font color=orange>生命的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "2"){
					$mmaxint += 1;
					$com.="<font color=orange>智力的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "3"){
					$mmaxmen += 1;
					$com.="<font color=orange>精神的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "4"){
					$mmaxdex += 1;
					$com.="<font color=orange>運的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "5"){
					$mmaxagi += 1;
					$com.="<font color=orange>速的界限值上昇了１點！！</font><BR>";
				}
				$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";
				$com.="$mname<font color=blueviolet><b>發現隱藏的財寶</b></font>獲得<BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";
			}
			if($in{'mode'} eq 6){
				$mode=6;
				#Zeeman	$get_ex = 100;
				$get_ex = 100;
				$getabp=int(rand(50));
				if(int(rand(20)) eq 7){$getabp=300;}
				$z_gold = int(rand(100000));
				$com.="$mname<font color=blueviolet><b>發現隱藏的財寶</b></font>獲得<BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";
			}
			if($in{'mode'} eq 13){
				$getabp = 1000;
			}
			if($in{'mode'} eq 20){
				$getabp = 100;
				$get_ex = 100;
				$z_gold = int(rand(250000))+250000;
				$com.="$mname<font color=blueviolet><b>得到試練獎勵</b></font>獲得<BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";				
			}elsif($in{'mode'} eq 21){
				$getabp = 500;
				$get_ex = 100;
				$z_gold = int(rand(500000))+500000;
				$com.="$mname<font color=blueviolet><b>得到試練獎勵</b></font>獲得<BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";				
			}elsif($in{'mode'} eq 22){
				$getabp = 1000;
				$get_ex = 100;
				$z_gold = int(rand(1000000))+1000000;
				$com.="$mname<font color=blueviolet><b>得到試練獎勵</b></font>獲得<BR><font color=blue size=4><b>$z_gold</b></font>Gold。<BR>";				
			}
			if($in{'mode'} eq 23 || $in{'mode'} eq 22){
				if($in{'mode'} eq 23){
					$getabp = 100;
					$get_ex = 50;
				}
				$muprnd=int(rand(6));

				if($muprnd eq "0"){
					$mmaxstr += 1;
					$com.="<font color=orange>力的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "1"){
					$mmaxvit += 1;
					$com.="<font color=orange>生命的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "2"){
					$mmaxint += 1;
					$com.="<font color=orange>智力的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "3"){
					$mmaxmen += 1;
					$com.="<font color=orange>精神的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "4"){
					$mmaxdex += 1;
					$com.="<font color=orange>運的界限值上昇了１點！！</font><BR>";
				}elsif($muprnd eq "5"){
					$mmaxagi += 1;
					$com.="<font color=orange>速的界限值上昇了１點！！</font><BR>";
				}
				$mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";

			}
			if($mab[22]){
				$get_ex = int($get_ex*1.2);
				$getabp += 1;
			}
			
			if($reamon eq 1){$getabp=$mode*20;}

#Zeeman
#$get_ex=1000;
#$getabp=1000;
#			if ($in{'verchk'} ne"") {
#				$get_ex+=$VERADDEX;
#				$getabp+=$VERADDABP;
#				$get_gold+=$VERADDGOLD;
#			}
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
			#Zeeman + 99999999
			if($mode eq"7"){
				$get_gold=($epoint + int(rand($epoint/5))); #+int(rand(99999999));
			}else{
				$get_gold=($epoint + int(rand($epoint/5)))*4;
			}
			#金錢任務加成
			if($quest_time[1]>=$date){
				$quest_get_gold=$get_gold;
				$com.="<font color=green size=3>$QUEST_NAME[1]任務效果，增加$quest_get_gold Gold</font>。<BR>";
			}
                        #金錢加成
			$get_gold=int($get_gold*$ADDGOLD);
			#熟練任務加成
			if($quest_time[2]>=$date){
				if($quest_abp>200){
					$quest_abp=200;
				}
				$com.="<font color=green size=3>$QUEST_NAME[2]任務效果，增加$quest_abp熟練</font>。<BR>";
			}else{
				$quest_abp=0;
			}
			if($member_level>0){
				$com.="<font color=green size=3>等級$member_level贊助效果，增加$member_level熟練</font>。<BR>";
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
				$com.="額外獲得<font color=orange size=4>$add_gold</font>Gold。<BR>";
			}
			$get_gold2=$get_gold+$add_gold + $z_gold+$quest_get_gold;

			$mgold+=$get_gold2;

			##レベルアップ


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
#Zeeman
#&MAXUP;

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
					$com.="<BR><B>發現<font color=#ff0066>$ELE[$ino]原料</font></B>!!<BR>";
					if($STORITM_MAX<$ext_mix[$ino]){
						$com.="<font color=#ff0000>但因此原料數量達倉庫上限,所以被丟棄</font>";
						$ext_mix[$ino]--;
					#原料任務效果
					}elsif($quest_time[5]>=$date){
						$ext_mix[$ino]++;
	                                        $com.="<BR><font color=green><B>$QUEST_NAME[5]任務效果追加１個<font color=#ff0066>$ELE[$ino]原料</font></B>!!</font><BR>";	
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
#
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
				$com.="<BR><B>發獲得<font color=#ff0066>$ACTITEM[$ACTOPEN]</font></B>!!<BR>";
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
                                        $com.="<BR><B>發現<font color=#ff0066>建國之石</font></B>!!<BR>";
                                        $iflg=1;
                                        $reano=5;
#&maplog("<font color=#ff0066>[打寶]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得<font color=red>建國之石</font>!!");
#                                        &maplog7("<font color=#ff0066>[打寶]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得$led<font color=red>建國之石</font>!!");

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
					$com.="<BR><B>發現<font color=#ff0066>$it_name $it_desc</font></B>!!<BR>";
					&maplog("<font color=#ff0066>[打寶]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得<font color=red>$it_name</font><font color=green>$it_desc</font>!!");
					&maplog7("<font color=#ff0066>[打寶]</font><font color=blue>$mname</font>於<font color=green><font color=blue>$SEN[$in{'mode'}]</font></font>獲得$led<font color=red>$it_name</font><font color=green>$it_desc</font>!!");
				}
			}

			print <<"EOF";
			<center><a name=lower></a>
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">勝利！</FONT></TD>
    			</TR>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">
			獲得<FONT color="#cc0000">$get_ex</FONT>經驗<BR>
      			獲得<FONT color="#000099">$get_gold</FONT> Gold！<BR>
			獲得<FONT color="#cc0000">$getabp</FONT>熟練度<BR>
			$com<BR>$showmsg<BR>
      			<TABLE border="0" bgcolor="#990000">
        		<TBODY><TR>
            		<TD bgcolor="#ffffcc">經驗值</TD>
            		<TD bgcolor="#ffffcc">$mex(+$get_ex)point</TD>
          		</TR>
          		<TR><TD bgcolor="#ffffcc">Gold</TD>
            		<TD bgcolor="#ffffcc">$mgold(+$get_gold2)Gold</TD>
          		</TR></TBODY></TABLE>
      			</TD></TR>
  			</TBODY></TABLE>
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
						$losecom.="<font color=red>你被魔王推回到入口$nowmap!</font><BR>";
					}else{
						$losecom.="<font color=red>你被魔王推回$mabdmg[39]層!</font><BR>";
					}
				}
			}
			#$bmess.="$mname的所持金減半。";
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
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">
			<FONT color="#ff0000">$mname的所持金減半！！</FONT><BR>
      			<BR>

      			<TABLE border="0" bgcolor="#990000">
        		<TBODY><TR>$losecom
            		<TD bgcolor="#ffffcc">失去了<FONT color="#000099">$lose_gold</FONT> Gold！</TD>
          		</TR></TBODY></TABLE>
      			</TD></TR>
  			</TBODY></TABLE>
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
                                                $mmess.="<font color=red>你被魔王推回到入口!</font><BR>";
                                        }else{
                                                $mmess.="<font color=red>你被魔王推回$mabdmg[39]層!</font><BR>";
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
        <INPUT type=hidden name=mode value=inn>
        <input type=hidden name=rmode value=$rmode>
        <input type="submit" value="住宿" CLASS=FC style="HEIGHT: 48px" ></td>
        </form>
EOF
$buttonl[2]=<<"EOF";
        <form action="./town.cgi" method="post">
        <INPUT type=hidden name=azuke value=$mgold>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass>
	<input type=hidden name=rmode value=$rmode>
        <INPUT type=hidden name=mode value=bankall>
        <INPUT type=submit value=全部存入銀行 CLASS=FC style="HEIGHT: 48px"></td></form>
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
			$bmess.= "<BR>使用〔$k_name〕剩餘<font color=red>$pnum</font>)<BR>";
			if($k_val <0){
				$bmess.= "<font color=red>〔$k_name〕消失了。。</font><BR>";
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
