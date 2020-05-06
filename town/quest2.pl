sub quest2 {
	&chara_open;
	&header;
	&town_open;
	&ext_open;
	&quest_open;
	$quest_hit=0;
	$date=time();
	if($in{'qno'} eq "0"){
		if($quest_town_no ne $mpos){&error("任務地點有誤")}
		if($ext_quest_total ne "-1" && $ext_quest_total ne ""){&error("你的作務未完成，無法再接受此任務");}
		$ext_quest_total=$mtotal+int(rand(50))+50;
                $lifetotal=$ext_quest_total-$mtotal;
                $com="你已接受村民的請求，請到各地打怪，幫村民消除$lifetotal隻怪物吧<BR>※不限時間";
	}elsif($in{'qno'} eq "ok0"){
		if($ext_quest_total ne "-2"){&error("你的<font color=blue>[$QUEST_NAME[0]]</font>任務未完成，無法交還此任務");}
                        $ext_quest_total="-1";
                        $ext_quest_town="";
		if($quest_time[0]-$date>=0){
	                $getgold=int($quest_count[0]/5)+100;
	                $getabp=int($quest_count[0]/5)+100;
        	        if($getgold>500){$getgold=500;}
	                if($getabp>500){$getabp=500;}
			$quest_count[0]++;
			$ext_quest_town="";
			$mabp+=$getabp;
			$mgold+=$getgold*10000;
			$ext_quest_total="-1";
	                $com="你已完成<font color=blue>[$QUEST_NAME[0]]</font>任務，得到獎利：$getabp熟，$getgold萬";
			&get_quest_gift;
		}else{
			if($date-$quest_time[0]>3600){
				$d_mabp=100;
			}elsif($date-$quest_time[0]>1800){
	                        $d_mabp=50;
			}
			if($d_mabp>0){
				$mabp-=$d_mabp;
	                        $com="你已完成<font color=blue>[$QUEST_NAME[0]]</font>任務，但因超時交任務，扣$d_mabp熟練";
			}else{
	                        $com="你已完成<font color=blue>[$QUEST_NAME[0]]</font>任務，但因超時交任務，所以沒得到任何獎勵";
			}
		}
        }elsif($in{'qno'} eq "1"){
                if($date<$quest_time[1]){
                        $tmp_time=$quest_time[1]-$date;
                        &error("<font color=blue>[$QUEST_NAME[1]]</font>任務效果剩餘<b>$tmp_time</b>秒，此時間內無法重接任務");
                }elsif($quest1_item eq ""){
                        $quest1_limit_time=$date+600;
                        &get_quest1();
                        $com="<font color=blue>[$QUEST_NAME[1]]</font>任務(請到<B>$quest1_town_name</B>購買<B>$quest1_item</B>送到<B>$quest1_town_name</B>的任務屋)※限時１０分鐘";
                }elsif($quest1_limit_time<=$date){
                        $com="<font color=blue>[".$QUEST_NAME[1]."]</font><font color=red>將".$ELE[$quest1_mix]."原料１０分鐘內送到$quest1_town_name任務失敗</font>";
                        $quest1_limit_time="";
                        $quest1_town_no="";
                        $quest1_town_name="";
                        $quest1_item="";
                }elsif($quest1_town_no eq $mpos){
                        $tmp_time=$quest1_limit_time-$date;
                        &finish_quest1;
                        if($finish[1]){
                                $com="<font color=blue>[$QUEST_NAME[1]]</font>你交出了$quest1_item完成任務!!<BR>獲得打怪金錢２倍效果：３０分鐘！";
                                $quest1_limit_time="";
                                $quest1_town_no="";
                                $quest1_town_name="";
                                $quest1_item="";
                                $quest_time[1]=$date+60*30;
                                $quest_count[1]+=1;
                        }else{
                                &error("<font color=blue>[".$QUEST_NAME[1]."]</font><font color=red>你身上沒有".$quest1_item."，無法完成任務</font>※任務限時剩餘<b>$tmp_time</b>秒");
                        }
                }else{
                        &error("任務完成地點錯誤");
                }
        }elsif($in{'qno'} eq "2"){
                if($date<$quest_time[2]){
                        $tmp_time=$quest_time[2]-$date;
                        &error("<font color=blue>[$QUEST_NAME[2]]</font>任務效果剩餘<b>$tmp_time</b>秒，此時間內無法重接任務");
                }elsif($quest2_map eq ""){
                        $quest2_limit_time=$date+600;
			($maxstr,$maxvit,$maxint,$maxmen,$maxdex,$maxagi,$maxlv) = split(/,/,$mmax);
			$maxtotal=$maxstr+$maxstr+$maxvit+$maxint+$maxmen+$maxdex+$maxagi;
			if ($maxtotal >6000){
				$quest2_map="31";
			}elsif ($maxtotal >5000){
				$quest2_map="30";
			}elsif ($maxtotal >4000){
				$quest2_map="4";
			}elsif ($maxtotal >4000){
				$quest2_map="3";
			}elsif($maxtotal>2000){
				$quest2_map="2";
			}else{
				$quest2_map="1";
			}
			$quest2_town_no=int(rand(22));
                        ($townx_id,$townx_name,$townx_con,$townx_ele,$townx_gold,$townx_arm,$townx_pro,$townx_acc,$townx_ind,$townx_tr,$townx_s,$townx_x,$townx_y,$townx_build,$townx_etc)=split(/<>/,$TOWN_DATA[$quest2_town_no]);
                        $quest2_town_no=$townx_id;
                        $quest2_town_name=$townx_name."($townx_x，$townx_y)";
                        $quest2_count="0";
                        $com="<font color=blue>[$QUEST_NAME[2]]</font>任務(請到<B>$quest2_town_name的$SEN[$quest2_map]</B>不住宿不存錢打贏１０隻<B>$SEN[$quest2_map]</B>怪※限時１０分鐘";
                }elsif($quest2_limit_time<=$date){
                        $com="<font color=blue>[".$QUEST_NAME[2]."]</font><font color=red>到<B>$quest2_town_name</B>不住宿不存錢打贏１０隻<B>$SEN[$quest2_map]</B>怪失敗</font>";
                        $quest2_limit_time="";
                        $quest2_town_no="";
                        $quest2_town_name="";
                        $quest2_map="";
                        $quest2_count="";
                }else{
                        if($quest2_count>9){
                                $com="<font color=blue>[$QUEST_NAME[2]]</font>你挑戰自我成功，完成任務!!<BR>獲得打怪熟練２倍效果：３０分鐘！";
                                $quest2_limit_time="";
                                $quest2_town_no="";
                                $quest2_town_name="";
                                $quest2_map="";
                                $quest2_count="";
                                $quest_time[2]=$date+60*30;
                                $quest_count[2]+=1;
                        }else{
                                &error("<font color=blue>[".$QUEST_NAME[2]."]</font><font color=red>你身上沒有".$quest2_map."，無法完成任務</font>※任務限時剩餘<b>$tmp_time</b>秒");
                        }
                }
        }elsif($in{'qno'} eq "5"){
	        if($date<$quest_time[5]){
	                $tmp_time=$quest_time[5]-$date;
	                &error("<font color=blue>[$QUEST_NAME[5]]</font>任務效果剩餘<b>$tmp_time</b>秒，此時間內無法重接任務");
	        }elsif($quest5_mix eq ""){
	                $quest5_limit_time=$date+600;
	                $quest5_town_no=int(rand(22));
			($townx_id,$townx_name,$townx_con,$townx_ele,$townx_gold,$townx_arm,$townx_pro,$townx_acc,$townx_ind,$townx_tr,$townx_s,$townx_x,$townx_y,$townx_build,$townx_etc)=split(/<>/,$TOWN_DATA[$quest5_town_no]);
			$quest5_town_no=$townx_id;
	                $quest5_town_name=$townx_name."($townx_x，$townx_y)";
	                $quest5_mix=int(rand(7))+1;
	                $com="<font color=blue>[$QUEST_NAME[5]]</font>任務(請將１個<B>$ELE[$quest5_mix]原料</B>送到<B>$quest5_town_name</B>的任務屋)※限時１０分鐘";
	        }elsif($quest5_limit_time<=$date){
	                $com="<font color=blue>[".$QUEST_NAME[5]."]</font><font color=red>將".$ELE[$quest5_mix]."原料１０分鐘內送到$quest5_town_name任務失敗</font>";
                        $quest5_limit_time="";
                        $quest5_town_no="";
                        $quest5_town_name="";
                        $quest5_mix="";
	        }elsif($quest5_town_no eq $mpos){
	                $tmp_time=$quest5_limit_time-$date;
	                if($ext_mix[$quest5_mix]>=0){
                                $ext_mix[$quest5_mix]-=1;
	        		$com="<font color=blue>[$QUEST_NAME[5]]</font>你交出了１個$ELE[$quest5_mix]原料完成任務!!<BR>獲得打到原料數量加２倍效果：１小時！";
                                $quest5_limit_time="";
                                $quest5_town_no="";
                                $quest5_town_name="";
                                $quest5_mix="";
                                $quest_time[5]=$date+60*60;
                                $quest_count[5]+=1;
	                }else{
				&error("<font color=blue>[".$QUEST_NAME[5]."]</font><font color=red>你身上沒有".$ELE[$quest5_mix]."原料，無法完成任務</font>※任務限時剩餘<b>$tmp_time</b>秒");
	                }
	        }else{
	                &error("任務完成地點錯誤");
	        }
	}else{
		&error("請選擇正確的任務");
	}
	&quest_input;
	&chara_input;
	&ext_input;
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">任事屋</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">這裏是村民的委託所，在這可以接到各種任務</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center" style="color:blue">
$com
<BR>
	</font>
        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=quest>
        <INPUT type=submit CLASS=FC value=回到任務屋></form>
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF

	&footer;
	exit;
}
sub get_quest1(){
	open(IN,"./data/towndata.cgi");
	@T_LIST = <IN>;
	close(IN);
	$idata[0]="arm";
	$idata[1]="pro";
	$idata[2]="acc";
	$idata_name[0]="武器";
	$idata_name[1]="防具";
	$idata_name[2]="飾品";
	$item_count=0;
	for($i=0;$i<3;$i++){
                open(IN,"./data/$idata[$i].cgi") or exit;
                @ARM_DATA = <IN>;
                close(IN);
                foreach(@ARM_DATA){
                        ($arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos)=split(/<>/);
                        if ($arm_val<=100000 && $arm_val>0) {
                        	if ($arm_pos ne "all" || ($mgold+$mbank)<10000000){
		                        foreach(@T_LIST){
			                        ($zcid,$zname,$zcon,$zele,$zmoney,$zarm,$zpro,$zacc,$zind,$zs,$ztr,$zx,$zy,$zbuild,$zetc)=split(/<>/);
			                        if($zcid>21){last;}
			                        if($arm_pos eq $zcid || $arm_pos eq "all"){
		                                  $buy_area=$zname."(".$zx."，".$zy.")";
				                        $items_town_name[$item_count]="$buy_area";
				                        $items_name[$item_count]="$arm_name";
				                        $items_town_no[$item_count]=$zcid;
				                        $item_count++;
	                                 }
		                        }
	                        }
                        }
                }
	}
	$rnditem=int(rand($item_count));
	$quest1_town_no=$items_town_no[$rnditem];
	$quest1_town_name=$items_town_name[$rnditem];
	$quest1_item=$items_name[$rnditem];
}
sub finish_quest1(){
	$finish[1]=0;
    open(IN,"./logfile/item/$mid.cgi");
    @ITEM = <IN>;
    close(IN);
    $remove_no=0;
    foreach(@ITEM){
		($tmp_it_no,$tmp_it_ki,$tmp_it_name,$tmp_it_val,$tmp_it_dmg,$tmp_it_wei,$tmp_it_ele,$tmp_it_hit,$tmp_it_cl,$tmp_it_sta,$tmp_it_type,$tmp_it_flg)=split(/<>/);
		if($tmp_it_name eq $quest1_item && $tmp_it_no ne"rea" && $tmp_it_no ne"mix"){
			$finish[1]=1;
			last;
		}
		$remove_no+=1;
    }
    if($finish[1]){
		splice(@ITEM,$remove_no,1);
		open(OUT,">./logfile/item/$mid.cgi");
		print OUT @ITEM;
		close(OUT);
    }
}
sub get_quest_gift{
	if($quest_count[0]>19 && $quest_count[0] % 10 eq 0){
	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$rndi=int(($quest_count[0]-20)/10);
	$rndi=$rndi % 22;
	$tmp_itm[0]="rea<>3<>力量之石<>1000000<>2<>0<>1<>80<>10<>寶物<>4<>1000<>";
	$tmp_itm[1]="rea<>3<>體力之石<>1000000<>2<>0<>2<>80<>10<>寶物<>4<>1000<>";
	$tmp_itm[2]="rea<>3<>智力之石<>1000000<>2<>0<>3<>80<>10<>寶物<>4<>1000<>";
	$tmp_itm[3]="priv<>3<>星空入場券<>10000000<>999<>0<>0<>80<>10<>寶物<>10<><>";
	$tmp_itm[4]="rea<>3<>精神之石<>1000000<>2<>0<>4<>80<>10<>寶物<>4<>1000<>";
	$tmp_itm[5]="rea<>3<>運氣之石<>1000000<>2<>0<>5<>80<>10<>寶物<>4<>1000<>";
	$tmp_itm[6]="rea<>3<>速度之石<>1000000<>2<>0<>6<>80<>10<>寶物<>4<>1000<>";
	$tmp_itm[7]="priv<>3<>GM婆的熟練之書<>10000000<>5000<>0<>0<>80<>10<>寶物<>11<><>";
	$tmp_itm[8]="rea<>3<>火寵成長劑<>1000000<>1<>0<>1<>80<>10<>寶物<>30<><>";
	$tmp_itm[9]="priv<>3<>星空入場券<>10000000<>999<>0<>0<>80<>10<>寶物<>10<><>";
	$tmp_itm[10]="rea<>3<>水寵成長劑<>1000000<>1<>0<>2<>80<>10<>寶物<>30<><>";
	$tmp_itm[11]="priv<>3<>+5賢者之石<>10000000<>5<>0<>0<>80<>10<>寶物<>4<><>";
	$tmp_itm[12]="rea<>3<>風寵成長劑<>1000000<>1<>0<>3<>80<>10<>寶物<>30<><>";
	$tmp_itm[13]="rea<>3<>星寵成長劑<>1000000<>1<>0<>4<>80<>10<>寶物<>30<><>";
	$tmp_itm[14]="rea<>3<>雷寵成長劑<>1000000<>1<>0<>5<>80<>10<>寶物<>30<><>";
	$tmp_itm[15]="priv<>3<>GM婆的熟練之書<>10000000<>5000<>0<>0<>80<>10<>寶物<>11<><>";
	$tmp_itm[16]="priv<>3<>星空入場券<>10000000<>999<>0<>0<>80<>10<>寶物<>10<><>";
	$tmp_itm[17]="priv<>3<>+5賢者之石<>10000000<>5<>0<>0<>80<>10<>寶物<>4<><>";
	$tmp_itm[18]="rea<>3<>光寵成長劑<>1000000<>1<>0<>6<>80<>10<>寶物<>30<><>";
	$tmp_itm[19]="rea<>3<>闇寵成長劑<>1000000<>1<>0<>7<>80<>10<>寶物<>30<><>";
	$tmp_itm[20]="priv<>3<>武奧石之箱<>10000000<>0<>0<>0<>80<>10<>寶物<>14<><>";
	$tmp_itm[21]="priv<>3<>神秘的寶箱<>10000000<>0<>0<>0<>80<>10<>寶物<>23<><>";
	($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$tmp_itm[$rndi]);
	$getitem=$tmp_itm[$rndi];
	$cit_name=$it_name;
	push(@ITEM,"$getitem\n");
	&questlog("<font color=green>[任務]</font>$quest_town_name的村民感謝<font color=blue>$mname</font>幫忙解決多次任務,贈送了$cit_name");
        &maplog("<font color=green>[任務]</font>$quest_town_name的村民感謝<font color=blue>$mname</font>幫忙解決多次任務,贈送了$cit_name");
	open(OUT,">./logfile/item/$mid.cgi");
	print OUT @ITEM;
	close(OUT);
	$com.="<BR>§因為多次的解決村民的問題，特別贈送了$cit_name";
	}
}
1;
