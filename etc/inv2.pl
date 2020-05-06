sub inv2{
	&chara_open;
	&town_open;
	&con_open;
	&time_data;
#&error("國戰停止中,假期後重開,詳細時間會提前公告");
	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error_old("距離下次行動的時間還剩 $btime 秒。");}
	if($con_gold<1000000 && $con_id>0){&error_old("國家資金不足１００萬，無法攻擊");}
	open(IN,"./logfile/battle/$in{'id'}.cgi");
	@BC_DATA = <IN>;
	close(IN);

	open(IN,"./data/battlecount.cgi");
	@COUNT_DATA = <IN>;
	close(IN);
	($battlecount)=split(/<>/,$COUNT_DATA[0]);

	($mhpr,$mmpr,$mtim)=split(/<>/,$BC_DATA[0]);
	if($mhpr eq""){$mhpr=1;}
	if($mmpr eq""){$mmpr=1;}
	#$mhpr=1;
	if($mhpr<0.25){&error_old("目前的健康程度無法進行戰鬥。");}
	$mhp=int($mmaxhp*$mhpr);
	$mmp=int($mmaxmp*$mmpr);

	$mtotal++;
	$date = time();
	if($town_build_data[10] eq""){$town_build_data[10]=0;}
	$KTIME-=$town_build_data[10]*20;
	$ktime = $KTIME - $date + $mdate2;
	#$ktime=0;
	if($ktime>0){&error_old("下次可進攻的剩餘時間為 $ktime 秒。");}
	if($con_id eq 0){
		$ktime = $MTIME - $date + $mdate2;
		#$ktime=0;
		if($ktime>0){&error_old("下次可進攻的剩餘時間為 $ktime 秒。");}
		if($mbank<$INVGOLD){&error_old("銀行裏的金額不足$INVGOLD Gold，無法進行攻擊。");}
		$mbank-=50000;
	}
	if($in{'tid'} eq ""){&error_old("請選擇正確的侵略地點。");}
	if($town_con ne $mcon && $con_id ne 0){&error_old("你未在自己的國土上，無法攻擊其他城鎮。");}

	foreach(@TOWN_DATA){
		($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y,$town2_build,$town2_etc)=split(/<>/);
		if($in{'tid'} eq $town2_id){$tohit=1;last;}
		$tx++;
	}
#$town2_con ne"7"
$times2=$hour*100+$min;
if($mcon ne"0"){
	$can_do=($wday>=2 && $wday<=4 && $times2<=2230 && $times2>=2130);
}else{
        $can_do=($wday>=2 && $wday<=4 && $times2<=2000 && $times2>=800);
}
	if(!$can_do){
		if ($mcon ne"0"){
			&error_old("國戰時間為週二至週四21:30~22:30");
		}else{
			&error_old("無所屬可攻城時間為週二至週四8:00~20:00");
		}
	}

	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	$i=0;
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			$datames = "查詢：$dir/$file<br>\n";
			if(!open(cha,"$dir/$file")){
				&error_old("找不到檔案：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			$list[$i]="$file";
			($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rabp,$rjp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
			if($rcon eq $town2_con){$zin++;}
			elsif($rcon eq $mcon){$zin2++;}
		}
		$mn++;
	}
	closedir(dirlist);

	foreach(@TOWN_DATA){
		($t2_id,$t2_name,$t2_con,$t2_ele,$t2_gold,$t2_arm,$t2_pro,$t2_acc,$t2_ind,$t2_tr,$t2_s,$t2_x,$t2_y,$t2_build,$t2_etc)=split(/<>/);
		if($t2_con eq $town2_con){$t2hit+=1;}
		if($t2_con eq 0){$musyo+=1;}
		$total++;
	}
	if ($town2_build_data[0] eq ""){$town2_build_data[0]=0;}
	$prodate=$town2_build_data[0]-$date;
	if($prodate>0){&error_old("此城鎮在保護期中,剩餘$prodate秒");}
	if($in{'tid'} eq "0"||$town2_con eq $con_id){&error_old("這個城鎮無法進行攻擊。");}
	if($t2hit<=1 && $con_id eq 0){&error_old("無所屬城鎮無法進行攻擊。");}
	if($t2hit eq $total-1){&error_old("因為被統一了，所以無法進行攻擊。");}
	if($con_id eq 0 && $musyo>=2){&error_old("無法進行攻擊。");}
	if(!$tohit){&error_old("請選擇正確的攻擊目標。");}
	#if($con_id ne 0 && $town2_con ne 0 && ($zin<5||$zin2<5)){&error_old("本國攻擊目前受限,無法再攻擊其他國家。");}

	$conhit=0;
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_con,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if($town2_con eq $con2_id){$conhit=1;last;}
		$tx++;
	}
	if(!$conhit){$con2_ele=0;$con2_name="無所屬";}
	if(abs($town2_x-$town_x) > 1 && abs($town2_y-$town_y) > 1){&error_old("錯誤的地點。");}
	#新國保護期
        open(IN,"./data/procountry.cgi");
        @PROCON_DATA = <IN>;
        close(IN);
        foreach(@PROCON_DATA){
                ($procon_id,$procon_date)=split(/<>/);
                if("$procon_id" eq "$town2_con"){$prohit=1;last;}
        }
	if($prohit && $date-$procon_date<14*24*60*60){
		$tmp_date=14*24*60*60+$procon_date-$date;
		if($tmp_date<60){$tmp_date.="秒鐘";}
		elsif($tmp_date<60*60){$tmp_date=int($tmp_date/60)."分鐘";}
                else{$tmp_date=int($tmp_date/(24*60*60))."天";}
		&error("此國家正於保護期中,可攻擊時間剩餘約$tmp_date");
	}
	require './battle_suport.cgi';

	$dhit=0;
	open(IN,"./data/def.cgi");
	@DEF = <IN>;
	close(IN);
	foreach(@DEF){
		($enemy_name,$enemy_id,$enemy_pos)=split(/<>/);
		if($enemy_pos eq "$in{'tid'}"){$dhit=1;last;}
	}
	$eadd_dmg=0;
	if($dhit){
		&enemy_open;
	}else{
($town2_hp,$town2_max,$town2_str,$town2_def,$town2_dex,$town2_flg,$town2_sta,$town2_mix_lv[1],$town2_mix_lv[2],$town2_mix_lv[3],$town2_mix_lv[4],$town2_mix_lv[5],$town2_mix_lv[6],$town2_mix_lv[7],$town2_mix[1],$town2_mix[2],$town2_mix[3],$town2_mix[4],$town2_mix[5],$town2_mix[6],$town2_mix[7])=split(/,/,$town2_etc);
($town2_build_data[0],$town2_build_data[1],$town2_build_data[2],$town2_build_data[3],$town2_build_data[4],$town2_build_data[5],$town2_build_data[6],$town2_build_data[7],$town2_build_data[8],$town2_build_data[9],$town2_build_data[10],$town2_build_data[11],$town2_build_data[12])=split(/,/,$town2_build);
		$ename="要塞";
		$echara="fort";
		$emaxhp=$town2_hp;$ehp=$emaxhp;$emaxmp=0;$estr=$town2_str;$evit=$town2_def;$eint=0;$efai=300;$edex=$town2_dex;$eagi=400;
		$earmdmg=estr*$town2_build_data[5]/20;
		$eprodmg=evit*$town2_build_data[6]/20;
		$eadd_dmg=$town2_build_data[1]*50;
	}
	&maplog5("<a href=\"/hero_data/inv/$battlecount.html\" TARGET=\"_blank\"><font color=red>【攻擊】</font></a><font color=red>$con_name國</font>的<font color=blue>$mname</font>對<font color=green>$con2_name國：$town2_name</font> 的 <font color=red>$ename</font> 進行攻擊。");
	
	&equip_open;
	$iflg = 1;
	#神之必殺效果減半
	$god_kill="2";
	&PARA;

	if($dhit){
		open(IN,"./logfile/battle/$enemy_id.cgi");
		@BE_DATA = <IN>;
		close(IN);
		($ehpr,$empr,$etim)=split(/<>/,$BE_DATA[0]);
		if($ehpr eq""){$ehpr=1;}
		if($empr eq""){$empr=1;}
		$ehp=int($emaxhp*$ehpr);
		$emp=int($emaxmp*$empr);
	}
	&TEC_OPEN;

	&header;
	$blog.= <<"EOF";
<TABLE border="0" width="100%" align=center height="144" CLASS=TOC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]"><FONT color="#ffffcc">$town_name </FONT></TD>
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
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mstr(+$marmdmg)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$marmname<BR>
            【$marmdmg/$marmwei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mmp/$mmaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mvit(+$mprodmg+$maccdmg)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mproname<BR>
            【$mprodmg/$mprowei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mname</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2>$JOB[$mclass]</TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$magi</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">飾品</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$maccname<BR>
            【$maccdmg/$maccwei】</FONT></TD>
          </TR>
        </TBODY>
      </TABLE>
      </TD>
      <TD align="center" bgcolor="$FCOLOR2" width="20%"><IMG src="$IMG/town/machi.jpg" width="150" height="113" border="0"></TD>
      <TD bgcolor="#cccccc" width=30%>
      <TABLE border="0" width="100%" height="100%" bgcolor=$ELE_BG[$eele]>
        <TBODY>
          <TR>
            <TD rowspan="2"><FONT size="-1"><img src="$IMG/chara/$echara.gif"></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">HP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ehp/$emaxhp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">攻擊力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$estr(+$earmdmg)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
          <TD bgcolor=$FCOLOR2><FONT size="-1">$earmname<BR>【$earmdmg/$earmwei】</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$emp/$emaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$evit(+$eprodmg+$eaccdmg)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
         <TD bgcolor=$FCOLOR2><FONT size="-1">$eproname<BR>【$eprodmg/$eprowei】</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ename</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2>$JOB[$eclass]</TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$eagi</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">飾品</FONT></TD>
          <TD bgcolor=$FCOLOR2><FONT size="-1">$eaccname<BR>【$eaccdmg/$eaccwei】</FONT></TD>
         </TR>
        </TBODY>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD bgcolor=#000000><font color="white" size="-1">「$mcom」</font></TD>
      <TD align=center bgcolor="666600"><font color="white" size="-1">戰鬥宣言</font></TD>
      <TD bgcolor=#000000><font color="white" size="-1">「$ecom」</font></TD>
    </TR>
  </TBODY>
</TABLE>
<BR><BR>
EOF
	&BATTLE;
	
	&log_print;

	@N_COUNT=();
	$battlecount+=1;
	if($battlecount>=10){$battlecount=1;}

	unshift(@N_COUNT,"$battlecount<>\n");
	open(OUT,">./data/battlecount.cgi");
	print OUT @N_COUNT;
	close(OUT);


	print <<"EOF";
	$blog
	<center>
	<form action="./top.cgi" method="POST">
	<input type=hidden name=id value="$mid">
	
	<input type=hidden name=pass value="$mpass">
	<CENTER>
	<input type="submit" value="回到城鎮" CLASS=FC>
	</CENTER>
	<BR><BR>
	</form>
	<P><hr size=0></center>
	</center>
EOF
	$con_gold-=1000000;
	if($con_gold<0){$con_gold=0;}
	&con_input;
	&chara_input;

#健康度
	$mhpr=int($mhp*100/$mmaxhp)/100-0.1;
	if($mhpr<0.05){$mhpr=0.05;}
	$mmpr=int($mmp*100/$mmaxmp)/100-0.1;
	if($mmpr<0.05){$mmpr=0.05;}
	@N_BC=();
	unshift(@N_BC,"$mhpr<>$mmpr<>$date<>\n");
	open(OUT,">./logfile/battle/$in{'id'}.cgi");
	print OUT @N_BC;
	close(OUT);
	
	if($dhit){
		$date = time();
		$ehpr=int($ehp*100/$emaxhp)/100-0.1;
		if($ehpr<0.05){$ehpr=0.05;}
		$empr=int($emp*100/$emaxmp)/100-0.1;
		if($empr<0.05){$empr=0.05;}
		@N_BE=();
		unshift(@N_BE,"$ehpr<>$empr<>$date<>\n");
		open(OUT,">./logfile/battle/$enemy_id.cgi");
		print OUT @N_BE;
		close(OUT);
	}
	&mainfooter;
	exit;
}


sub BATTLE{##戰鬥處理
	while($turn<=50){
		$turn++;
		$bmess="";
		$mmess="";
		if($mab[15] && $mabdmg[15]>$eabdmg[15] && int(rand(3-$mabdmg[15])) eq 0){$sensei = 1;}
		elsif($eab[15] && $eabdmg[15]>$mabdmg[15] && int(rand(3-$eabdmg[15])) eq 0){$sensei = 0;}
		elsif(int(rand($mdex)) > int(rand($edex))){$sensei = 1;}
		else{$sensei = 0;}
		if($sensei){
			if($mhp>0){&MATT;}
			if($ehp>0){&EATT;}
		}else{
			if($ehp>0){&EATT;}
			if($mhp>0){&MATT;}
		}

		if($win){
			$mkati++;
			if($sensei){
				&BINVPRINT;
			} else {
				&MINVPRINT;
			}
			$mlv=int($mex/100)+1;
			$get_ex=50 + int(rand(10));
			if($mex<9900){
				$mex+=$get_ex;
			}
			$mtotalex+=$get_ex;
			$get_gold=$e_gold + int(rand($e_gold/3));
			$mgold+=$get_gold;
			$getabp=2;
			if($mab[22]){$getabp += 1;}

			$mabp+=$getabp;
			$mjp[$mtype]+=$getabp;
			if($mjp[$mtype]>$MAXJOB){$mjp[$mtype] = $MAXJOB;}
			
			##レベルアップ
			&LVUP;
			
			if($dhit){
				@NEW_DEF=();
				foreach(@DEF){
					($def_name,$def_id,$def_pos)=split(/<>/);
					if($enemy_id eq "$def_id"){next;}
					else{push(@NEW_DEF,"$_");}
				}
				&maplog5("<font color=red>【勝利】</font><font color=blue>$mname</font> 討伐 <font color=green>$ename</font> 獲得勝利。");
				$mflg2++;
				if(($mflg2%50) eq 0){
					$mcex+=100;
					&kh_log("$mflg2人斬達成。",$con_name);
				}
				$mcex+=5;
				open (OUT, "> ./data/def.cgi");
				print OUT @NEW_DEF;
				close (OUT);
			}
			elsif($ename eq"要塞"){
				&maplog5("<b><font color=red>【壓制】</font> <font color=blue>$mname</font> 壓制了 <font color=green>$town2_name</font>。</b>");
				&kh_log("壓制$town2_name。",$con_name);
				$towntotal=0;
				foreach(@TOWN_DATA){
					($t_id,$t_name,$t_con,$t_ele,$t_gold,$t_arm,$t_pro,$t_acc,$t_ind,$t_tr,$t_s,$t_x,$t_y,$t_build,$t_etc)=split(/<>/);
					if($town2_con eq $t_con){$towntotal++;}
					if($mcon ne $t_con){$towntotal2++;}
				}
				if($towntotal<=1 && $con2_id ne 0 && $conhit){
					$mcex+=500;
					open(IN,"./data/country.cgi") or &error2("檔案開啟失敗。etc/inv2.pl(332)(要塞)");
					@CON = <IN>;
					close(IN);
					@NCON=();
					foreach(@CON){
						($con3_id,$con3_name,$con3_ele,$con3_gold,$con3_king,$con3_yaku,$con3_cou,$con3_mes,$con3_etc)=split(/<>/);
						if("$con3_id" eq "$town2_con"){next;}
						else{push(@NCON,"$_");}
						$c_no++;
					}
					open(OUT,">./data/country.cgi") or &error('檔案開啟失敗etc/inv2.pl(342)。');
					print OUT @NCON;
					close(OUT);
					&maplog("<font color=black><b>【滅亡】<font color=red>$con2_name國</font>減亡了.....</b></font>");
					&maplog2("<font color=green>$con_name國</font>的 <font color=blue>$mname</font> 滅了 <font color=red>$con2_name國</font>。");
					&kh_log("消滅$con2_name國。",$con_name);
				
				}
				if($towntotal2<=2 && $con_id ne 0){
					$mcex+=1000;
					&maplog("<font color=red><b>【統一】$con_name國統一了全世界！！</b></font>");
					&maplog2("$con_name國統一了全世界。");
				}
				$town2_con=$con_id;
$town2_mix_lv[1]="";
$town2_mix_lv[2]="";
$town2_mix_lv[3]="";
$town2_mix_lv[4]="";
$town2_mix_lv[5]="";
$town2_mix_lv[6]="";
$town2_mix_lv[7]="";
$town2_mix[1]="";
$town2_mix[2]="";
$town2_mix[3]="";
$town2_mix[4]="";
$town2_mix[5]="";
$town2_mix[6]="";
$town2_mix[7]="";
$town2_build_data[0]=$date+(7*24*60*60);
$town2_build_data[1]="0";
$town2_build_data[2]="0";
$town2_build_data[3]="0";
$town2_build_data[4]="0";
$town2_build_data[5]="0";
$town2_build_data[6]="0";
$town2_build_data[7]="0";
$town2_build_data[8]="0";
$town2_build_data[9]="0";
$town2_build_data[10]="0";
$town2_build_data[11]="0";
$town2_build_data[12]="0";

			}
			$blog.= <<"EOF";
			<center>
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">勝利！</FONT></TD>
    			</TR>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">獲得<FONT color="#cc0000">$get_ex</FONT>經験值<BR>
      			獲得<FONT color="#000099">$get_gold</FONT> Gold！<BR>$com<BR>
      			獲得<FONT color="#cc0000">$getabp</FONT>熟練<BR>
			<TABLE border="0" bgcolor="#990000">
        		<TBODY><TR>
            		<TD bgcolor="#ffffcc">經験值</TD>
            		<TD bgcolor="#ffffcc">$mex(+$get_ex)point</TD>
          		</TR>
          		<TR><TD bgcolor="#ffffcc">Gold</TD>
            		<TD bgcolor="#ffffcc">$mgold(+$get_gold)Gold</TD>
          		</TR></TBODY></TABLE>
      			</TD></TR>
  			</TBODY></TABLE>
			</center>
EOF
			last;
		}if($lose){
			&maplog5("<font color=blue>【敗北】</font><font color=red>$mname</font> 攻擊 <font color=green>$ename</font> 失敗了。。");
			$lose_gold=$mgold-int($mgold/2);
			$mgold-=$lose_gold;
			#$bmess.="$mname的所持金減半。";
			if($sensei){
				&BINVPRINT;
			} else {
				&MINVPRINT;
			}
			$blog.= <<"EOF";
			<center>
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">失敗！</FONT></TD>
    			</TR>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">
			<FONT color="#ff0000">$mname的所持金減半！！</FONT><BR>
      			<BR>

      			<TABLE border="0" bgcolor="#990000">
        		<TBODY><TR>
            		<TD bgcolor="#ffffcc">失去了<FONT color="#000099">$lose_gold</FONT> Gold！</TD>
          		</TR></TBODY></TABLE>
      			</TD></TR>
  			</TBODY></TABLE>
			</center>
EOF
			last;
		}
		if($sensei){
			&BINVPRINT;
		} else {
			&MINVPRINT;
		}
		
	}
	if(!$win && !$lose){
		$bmess.="此戰未分出勝負。";
		if($sensei){
			&BINVPRINT;
		} else {
			&MINVPRINT;
		}
	}
	if($ename eq"要塞"){
		open(IN,"./data/towndata.cgi") or &error("檔案開啟錯誤etc/inv2.pl(394)。");
		@TOWN_DATA = <IN>;
		close(IN);
		#軍醫院效果每升一級,可增加2%的傷兵恢復效果
		if($ehp>0){
			$ehp+=int(($town2_hp-$ehp)*$town2_build_data[9]*2/100);
		}	
		$town2_hp=$ehp;
		$town2_str-=15;
		$town2_def-=15;
		if($town2_str<300){
			$town2_str=300;
		}
		if($town2_def<300){
			$town2_def=300;
		}
		#攻城研究所效果
		if ($town_build_data[11] ne"" && $town_build_data[1] >0){
			if($town_build_data[1]>int(rand(100))){
				$buildi=0;
				foreach(@town_build_name){
					if($buildi>0){
						if ($town2_build_data[$buildi] ne "" && $town2_build_data[$buildi]>0 && $town_build_data[11]>$town2_build_data[$buildi]){
						&maplog("[破壞]<font color=red>$mname攻擊$town2_name時,將$town2_build_name[$buildi]破壞1級</font>");
						$town2_build_data[$buildi]-=1;
						$town2_max=10000+$town2_build_data[3]*1000;
						last;
						}
						$buildi++;
					}
				}
			}
		}
		$town2_etc="$town2_hp,$town2_max,$town2_str,$town2_def,$town2_dex,$town2_flg,$town2_sta,$town2_mix_lv[1],$town2_mix_lv[2],$town2_mix_lv[3],$town2_mix_lv[4],$town2_mix_lv[5],$town2_mix_lv[6],$town2_mix_lv[7],$town2_mix[1],$town2_mix[2],$town2_mix[3],$town2_mix[4],$town2_mix[5],$town2_mix[6],$town2_mix[7]";
		
		if($town2_id ne ""){
			
			@NTOWN=();
			foreach(@TOWN_DATA){
				($town4_id,$town4_name,$town4_con,$town4_ele,$town4_gold,$town4_arm,$town4_pro,$town4_acc,$town4_ind,$town4_tr,$town4_s,$town4_x,$town4_y,$town4_build,$town4_etc)=split(/<>/);
				if("$town2_id" eq "$town4_id"){
					push(@NTOWN,"$town2_id<>$town2_name<>$town2_con<>$town2_ele<>$town2_gold<>$town2_arm<>$town2_pro<>$town2_acc<>$town2_ind<>$town2_tr<>$town2_s<>$town2_x<>$town2_y<>$town2_build<>$town2_etc<>\n");
				}else{
					push(@NTOWN,"$_");
				}
			}
			open(OUT,">./data/towndata.cgi") or &error('檔案開啟錯誤etc/inv2.pl(420)。');
			print OUT @NTOWN;
			close(OUT);
		}
		else{&error("資料出現異常。");}
	}
	$mdate2=time();
	
}

#回合別戰鬥結果表示
sub BINVPRINT{
	$blog.= <<"EOF";
<CENTER>
<TABLE border="0" width="80%" bgcolor="#000000" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="8" align="center" bgcolor="$FCOLOR"><B><a href="#lower"><FONT color="#ffffcc">第$turn回合</FONT></a></B></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="000063" align="center"><FONT color="$FCOLOR2"><B><FONT size="-1">$mname</FONT></B></FONT></TD>
      <TD colspan="4" bgcolor="9c0000" align="center"><B><FONT size="-1" color="$FCOLOR2">$ename</FONT></B></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$bmess</font></TD>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$mmess</font></TD>
    </TR>
	<TR>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mhp/$mmaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mmp/$mmaxmp</TD>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$ehp/$emaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$emp/$emaxmp</TD>
	 </TR>
  </TBODY>
</TABLE>
</CENTER>
<P>
EOF
}

sub MINVPRINT{
	$blog.= <<"EOF";
<CENTER>
<TABLE border="0" width="80%" bgcolor="#000000" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="8" align="center" bgcolor="$FCOLOR"><B><a href="#lower"><FONT color="#ffffcc">第$turn回合</FONT></a></B></TD>
    </TR>
    <TR>
	  <TD colspan="4" bgcolor="9c0000" align="center"><B><FONT size="-1" color="$FCOLOR2">$ename</FONT></B></TD>
      <TD colspan="4" bgcolor="000063" align="center"><FONT color="$FCOLOR2"><B><FONT size="-1">$mname</FONT></B></FONT></TD>
    </TR>
    <TR>
	  <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$mmess</font></TD>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$bmess</font></TD>
    </TR>
	<TR>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$ehp/$emaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$emp/$emaxmp</TD>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mhp/$mmaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mmp/$mmaxmp</TD>
	</TR>
  </TBODY>
</TABLE>
</CENTER>
<P>
EOF
}

sub log_print{
	$header = <<"EOM";
	<html>
	<head>
	<META HTTP-EQUIV="Content-type" CONTENT="text/html; charset=utf-8">
	<STYLE type="text/css">
	<!--
A:HOVER{
 color: $ALINK
}
.BC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[0] $ELE_BG[0] $ELE_BG[0] $ELE_BG[0];border-style : double double double double;background-color : $ELE_BG[0];color : black;}
.TC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $FCOLOR $FCOLOR $FCOLOR $FCOLOR;border-style : double double double double;background-color : $FCOLOR;color : black;}
.CC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$con_ele] $ELE_BG[$con_ele] $ELE_BG[$con_ele] $ELE_BG[$con_ele];border-style : double double double double;background-color : $ELE_BG[$con_ele];color : black;}
.CC2 {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$con2_ele] $ELE_BG[$con2_ele] $ELE_BG[$con2_ele] $ELE_BG[$con2_ele];border-style : double double double double;background-color : $ELE_BG[$con2_ele];color : black;}
.MC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$wele] $ELE_BG[$wele] $ELE_BG[$wele] $ELE_BG[$wele];border-style : double double double double;background-color : $ELE_BG[$wele];color : black;}
.MFC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width : $ELE_BG[$con_ele];border-top-color : $ELE_BG[$con_ele];border-right-color : $ELE_BG[$con_ele];border-bottom-color : $ELE_BG[$con_ele];border-left-color : $ELE_BG[$con_ele];border-style : double double double double;background-color : $ELE_C[$con_ele];color : black;}
.FC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width : $FCOLOR;border-top-color : $FCOLOR;border-right-color : $FCOLOR;border-bottom-color : $FCOLOR;border-left-color : $FCOLOR;border-style : double double double double;background-color : $FCOLOR2;color : black;}
.TOC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$town_ele] $ELE_BG[$town_ele] $ELE_BG[$town_ele] $ELE_BG[$town_ele];border-style : double double double double;background-color : $ELE_BG[$town_ele];color : black;}
.dmg { color: #FF0000; font-size: 10pt }
.clit { color: #0000FF; font-size: 10pt }
-->
	</STYLE>
	<title>$TITLE</title></head>
	<body background=\"$BGIF\" bgcolor=\"$BG\">
EOM

	open(OUT,">/var/www/html/hero_data/inv/$battlecount.html");
	print OUT $header;
	print OUT $blog;
	print OUT "</BODY></HTML>";
	close(OUT);
}

1;
