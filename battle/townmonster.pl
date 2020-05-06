sub townmonster{
        &chara_open;
        &town_open;
        &con_open;
        &time_data;

        if($con_id eq 0 && $mid ne $GMID){&error("無所屬國，無法進行攻擊。");}
        $date = time();
        $btime = $BTIME - $date + $mdate;
        if($btime>0){&error("距離下次行動的時間還剩 $btime 秒。");}
                if($hour<8){&error("神獸可攻擊時間為08:00~24:00");}
        open(IN,"./data/unit.cgi");
        @UNIT_DATA = <IN>;
        close(IN);
        open(IN,"./data/townmonster.cgi");
        @tmdata = <IN>;
        close(IN);
        ($ename,$eab,$etec,$esk,$e_ex,$e_gold,$etown,$elv)=split(/<>/,$tmdata[0]);
        ($ehp,$emp,$estr,$evit,$eint,$efai,$edex,$eagi,$eele)=split(/,/,$eab);
        $emaxhp=$ehp;
        $emaxmp=$emp;
                if($etown ne $town_id){
                        &error("神獸已不在此地．．．");
                }elsif($ehp eq "0"){
                        &error("神獸不在此地．．．");
                }

                $unit_ppl_count=0;
                $unit_name="";
                $unit_mes="";
        foreach(@UNIT_DATA){
                ($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
                if($uid eq $mid){
                        $unit_name=$uname;
                        $unit_mes=$bmes;
                        $unit_ppl_count++;
                }
        }
                if ($unit_ppl_count eq 0){
                        &error("只有隊長才可以下達攻擊指令");
                }elsif ($unit_ppl_count < 3){
                        &error("你的隊伍人數不滿三人，無法攻擊");
                }
	$evup=$unit_ppl_count*$unit_ppl_count/20+0.7;
        $estr2=$estr;
        $evit2=$evit;
        $eint2=$eint;
        $efai2=$efai;
        $edex2=$edex;
        $eagi2=$eagi;
	$estr=int($estr * $evup);
        $evit=int($evit * $evup);
        $eint=int($eint * $evup);
        $efai=int($efai * $evup);
        $edex=int($edex * $evup);
        $eagi=int($eagi * $evup);

                $cppl=0;
        foreach(@UNIT_DATA){
                ($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
                if($uid eq $in{'id'}){
                                open(IN,"./logfile/chara/$bid.cgi");
                                @CH_DATAS = <IN>;
                                close(IN);
                                ($t_unit_mid,$t_unit_mpass,$t_unit_mname,$t_unit_murl,$t_unit_mchara,$t_unit_msex,$t_unit_mhp,$t_unit_mmaxhp,$t_unit_mmp,$t_unit_mmaxmp,$t_unit_mele,$t_unit_mstr,$t_unit_mvit,$t_unit_mint,$t_unit_mfai,$t_unit_mdex,$t_unit_magi,$t_unit_mmax,$t_unit_mcom,$t_unit_mgold,$t_unit_mbank,$t_unit_mex,$t_unit_mtotalex,$t_unit_mjp,$t_unit_mabp,$t_unit_mcex,$t_unit_munit,$t_unit_mcon,$t_unit_marm,$t_unit_mpro,$t_unit_macc,$t_unit_mtec,$t_unit_msta,$t_unit_mpos,$t_unit_mmes,$t_unit_mhost,$t_unit_mdate,$t_unit_mdate2,$t_unit_mclass,$t_unit_mtotal,$t_unit_mkati,$t_unit_mtype,$t_unit_moya,$t_unit_msk,$t_unit_mflg,$t_unit_mflg2,$t_unit_mflg3,$t_unit_mflg4,$t_unit_mflg5,$t_unit_mpet) = split(/<>/,$CH_DATAS[0]);
                                        $unit_mname.="$t_unit_mname<BR>";
                                        $unit_mhp+=$t_unit_mmaxhp;
                                        $unit_mmp+=$t_unit_mmaxmp;
                                        $unit_mmaxhp=$unit_mhp;
                                        $unit_mmaxmp=$unit_mmp;
                                        $unit_mstr+=$t_unit_mstr;
                                        $unit_mvit+=$t_unit_mvit;
                                        $unit_mint+=$t_unit_mint;
                                        $unit_mfai+=$t_unit_mfai;
                                        $unit_mdex+=$t_unit_mdex;
                                        $unit_magi+=$t_unit_magi;
                                        $unit_msk[$cppl]=$t_unit_msk;
                                        $unit_marm[$cppl]=$t_unit_marm;
                                        $unit_mpro[$cppl]=$t_unit_mpro;
                                        $unit_macc[$cppl]=$t_unit_macc;
                                        $unit_mpet[$cppl]=$t_unit_mpet;
                                        $unit_mele[$cppl]=$t_unit_mele;
                                        $cppl++;
                }

        }
        $unit_mmaxmp=int($unit_mmaxmp/$cppl);
	$unit_mmp=$unit_mmaxmp;
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
        if($mhpr<0.25){&error("目前的健康成度無法進行戰鬥。");}
        $unit_mhp=int($unit_mmaxhp*$mhpr);
        $unit_mmp=int($unit_mmaxmp*$mmpr);

        $date = time();
        $ktime = 600 - $date + $mdate2;
        #$ktime=0;
        if($ktime>0){&error("下次可攻擊的剩餘時間為 $ktime 秒。");}

        if($town_con ne $mcon && $con_id ne 0){&error("你未在自己的國土上，無法攻擊神獸。");}


#$town2_con ne"7"


        require './battle_group.cgi';
	$mdate2=time();
	&chara_input;
        &maplog5("<a href=\"/hero_data/inv/$battlecount.html\" TARGET=\"_blank\"><font color=red>【神獸】</font></a><font color=red>$con_name國</font>的<font color=blue>「$unit_name」</font>隊，對<font color=green>$ename</font>進行攻擊。");

        &unit_equip_open;
        $iflg = 1;
        &PARA;

        &TEC_OPEN;

        &header;
        $blog.= <<"EOF";
$testt
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
            <TD bgcolor=$FCOLOR2><FONT size="-1">$unit_mhp/$unit_mmaxhp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">攻擊力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$unit_mstr(+$unit_marmdmg<font color=red>+$unit_mpetdmg</font>)</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$unit_mmp/$unit_mmaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$unit_mvit(+$unit_mprodmg<font color=red>+$unit_maccdmg+$unit_mpetdef</font>)</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$unit_name隊</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1"></FONT></TD>
            <TD bgcolor=$FCOLOR2></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$unit_magi<font color=red>+$unit_mpetspeed</FONT></TD>
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
            <TD bgcolor=$FCOLOR2><FONT size="-1">$estr</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$emp/$emaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$evit</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ename</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1"></FONT></TD>
            <TD bgcolor=$FCOLOR2></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$eagi</FONT></TD>
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
	#健康度
        $mhpr=int($unit_mhp*100/$unit_mmaxhp)/100-0.1;
        if($mhpr<0.05){$mhpr=0.05;}
        $mmpr=int($unit_mmp*100/$unit_mmaxmp)/100-0.1;
        if($mmpr<0.05){$mmpr=0.05;}
        @N_BC=();
        unshift(@N_BC,"$mhpr<>$mmpr<>$date<>\n");
        open(OUT,">./logfile/battle/$in{'id'}.cgi");
        print OUT @N_BC;
        close(OUT);

        print <<"EOF";
        $blog
        <center>
$BACKTOWNBUTTON
        <P><hr size=0></center>
        </center>
EOF
        #&chara_input;
#神獸血量修改
#	$ehp=int($ehp*1.1);
        $eab="$ehp,$emp,$estr2,$evit2,$eint2,$efai2,$edex2,$eagi2,$eele";
	if($ehp eq 0){$etown=99;}
        $mdatass[0]="$ename<>$eab<>$etec<>$esk<>$e_ex<>$e_gold<>$etown<>$elv";
        open (OUT, "> ./data/townmonster.cgi");
        print OUT @mdatass;
        close (OUT);
#健康度
        $mhpr=int($mhp*100/$mmaxhp)/100-0.2;
        if($mhpr<0.05){$mhpr=0.05;}
        $mmpr=int($mmp*100/$mmaxmp)/100-0.2;
        if($mmpr<0.05){$mmpr=0.05;}
        @N_BC=();
        unshift(@N_BC,"$mhpr<>$mmpr<>$date<>\n");
        open(OUT,">./logfile/battle/$in{'id'}.cgi");
        print OUT @N_BC;
        close(OUT);

        &footer;
        exit;
}


sub BATTLE{##戰鬥處理
        while($turn<=50){
                $turn++;
                $bmess="";
                $mmess="";
                if($unit_mab[15] && $unit_mabdmg[15]>$eabdmg[15] && int(rand(3-$unit_mabdmg[15])) eq 0){$sensei = 1;}
                elsif($eab[15] && $eabdmg[15]>$unit_mabdmg[15] && int(rand(3-$eabdmg[15])) eq 0){$sensei = 0;}
                elsif(int(rand($mdex)) > int(rand($edex))){$sensei = 1;}
                else{$sensei = 0;}
                if($sensei){
                        if($unit_mhp>0){&MATT;}
                        if($ehp>0){&EATT;}
                }else{
                        if($ehp>0){&EATT;}
                        if($unit_mhp>0){&MATT;}
                }

                if($win){
                        $mkati++;
                        if($sensei){
                                &BINVPRINT;
                        } else {
                                &MINVPRINT;
                        }
                        $get_gold=1+int(rand(100));
                        $con_gold+=$get_gold*10000;
				        open(IN,"./logfile/constorage/$mcon"."_max.cgi");
				        $CONITEM_MAX = <IN>;
				        close(IN);
				
				        open(IN,"./logfile/constorage/$mcon.cgi");
				        @STORAGE = <IN>;
				        close(IN);
					$scount=@STORAGE;
					if ($scount eq ""){$scount eq "30";}
				        #掉寶數量 
				        $get_item_number=3+int(rand(3));
					#隊長與神獸同屬性掉寶+1
					if($mele eq $eele){
						$get_item_number++;
					}
					#國家與神獸同屬性掉寶+1
					if($con_ele eq $eele){
                                                $get_item_number++;
					}
                                        #城鎮與神獸同屬性掉寶+1
                                        if($town_ele eq $eele){
                                                $get_item_number++;
                                        }

				        for($get_item_no=0;$get_item_no<$get_item_number;$get_item_no++){
				        	if(($scount+$get_item_no)>=$CONITEM_MAX){
							$showcount=$scount+$get_item_no;
				        		$conmess.="<TR><TD bgcolor=\"#ffffcc\"><font color=red><b>$con_name國國庫物品數已達上限。(最大$CONITEM_MAX個,目前$showcount個)</b></font></TD></TR>";
				        	}else{
				        	    #=============================================選掉寶開始============================================
				        		$brand=int(rand(3))+1;
                                if($brand eq 1){
                                        $REA="rarearm";
                                        $reano=0;
                                        $b_no2 = int(rand(26));
                                        if(int(rand($rrand)) eq 1){
                                                $b_no2 = 26 + int(rand(36));
                                        }
                                        $ino=$b_no2;
					#殺人豆腐不再掉落
					if($ino eq 4){$ino=5;}
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
                                                $b_no2 = 25 + int(rand(24));
                                        }
                                        $ino=$b_no2;
                                }
                                open(IN,"./data/$REA.cgi");
                                @REA = <IN>;
                                close(IN);
                                ($it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos) = split(/<>/,$REA[$ino]);

                                        $rand_val=17-int($mtotal/10000);
                                        if ($rand_val<8) {
                                                $rand_val=8;
                                        }
                                        if ($mid eq $GMID) {$rand_val=2;}
                                        if (int(rand($rand_val*2)) eq 1) {
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

                                
                                #=============================================選掉寶結束============================================

				        		$conmess.="<TR><TD bgcolor=\"#ffffcc\">獲得了<font color=red><b>$it_name($ELE[$it_ele])($it_dmg/$it_wei)</b></font>。</TD></TR>";
				        		#push(@STORAGE,"$itno<>$in_type<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
                                                        push(@STORAGE,"rea<>$reano<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>0<>\n");
				        		&maplog_constorage("<font color=green>[神獸掉寶]</font><font color=blue>$unit_name隊</font>打倒了<font color=red>$ename</font>，獲得了<font color=green>$it_name($ELE[$it_ele])($it_dmg/$it_wei)</font>。");
				        	}
	                        open(OUT,">./logfile/constorage/$mcon.cgi");
	                        print OUT @STORAGE;
	                        close(OUT);

				        }
				        

                        &con_input;
                        &maplog5("<font color=red>【神獸】</font><font color=blue>$unit_name隊</font> 討伐 <font color=green>$ename</font> 獲得勝利！！！");
                        $blog.= <<"EOF";
                        <center>
                        <TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
                        <TBODY><TR>
                        <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">勝利！！！</FONT></TD>
                        </TR>
                        
                        <TABLE border="0" bgcolor="#990000">
                        <TBODY><TR>
                        <TD bgcolor="#ffffcc">$con_name國獲得<FONT color="#000099">$get_gold</FONT> 萬！</TD>
                        
                        </TR>
                        $conmess
                        </TBODY></TABLE>
                        </TD></TR>
                        </TBODY></TABLE>
                        </center>
EOF
                        last;
                }if($lose){
                        &maplog5("<font color=blue>【神獸】</font><font color=blue>$unit_name隊</font> 討伐 <font color=green>$ename</font> 失敗了。。");
                        if($sensei){
                                &BINVPRINT;
                        } else {
                                &MINVPRINT;
                        }
                        if(int(rand(4)) eq 2){
                        	$losecom="因為本次討伐失敗惹惱了神獸！！";
                        	$d_town_hp-=int(rand(400)+100);
                        	#$d_town_max=$d_town_hp;
                        	#$d_town_str=int($town_str/10);
                        	#$d_town_def=int($town_def/10);
                        	$town_hp-=$d_town_hp;
                        	#$town_max-=$d_town_hp;
                        	#$town_str-=$d_town_str;
                        	#$town_def-=$d_town_def;
                        	if($town_hp<1){$town_hp=1;}
                        	#if($town_max<1){$town_max=1;}
                        	#if($town_str<1){$town_str=1;}
                        	#if($town_def<1){$town_def=1;}
                        	$lose_gold=int(rand(500))+100;
                        	$con_gold-=$lose_gold*100000;
                        	if ($con_gold<0){$con_gold=0}
                        	&con_input;
                        	&town_input;
                        }else{
                        	$losecom="$unit_name被神獸$ename擊敗！";
                        	$uhide="<!--";
                        	$ehide="-->";
                        }
                        $blog.= <<"EOF";
                        <center>
                        <TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
                        <TBODY><TR>
                        <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">失敗！</FONT></TD>
                        </TR>
                        <TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">
                        <FONT color="#ff0000">$losecom</FONT><BR>
                        <BR>
						$uhide
                        <TABLE border="0" bgcolor="#990000">
                        <TBODY><TR>
                        <TD bgcolor="#ffffcc">$con_name國失去了<FONT color="#000099">$lose_gold</FONT> 萬！</TD>
                        </TR><TR>
                        <TD bgcolor="#ffffcc">$town_name的城壁值下降了<FONT color="#000099">$d_town_hp</FONT>！</TD>
                        </TR><TR>
                        <TD bgcolor="#ffffcc">$town_name的攻擊力下降了<FONT color="#000099">$d_town_str</FONT>！</TD>
                        </TR><TR>
                        <TD bgcolor="#ffffcc">$town_name的防禦力下降了<FONT color="#000099">$d_town_def</FONT>！</TD>
                        </TR></TBODY></TABLE>
                        $ehide
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

                $town2_hp=$ehp;
                $town2_str-=15;
                $town2_def-=15;
                if($town2_str<300){
                        $town2_str=300;
                }
                if($town2_def<300){
                        $town2_def=300;
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
      <TD colspan="4" bgcolor="000063" align="center"><FONT color="$FCOLOR2"><B><FONT size="-1">$unit_name</FONT></B></FONT></TD>
      <TD colspan="4" bgcolor="9c0000" align="center"><B><FONT size="-1" color="$FCOLOR2">$ename</FONT></B></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$bmess</font></TD>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$mmess</font></TD>
    </TR>
        <TR>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$unit_mhp/$unit_mmaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$unit_mmp/$unit_mmaxmp</TD>
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
      <TD colspan="4" bgcolor="000063" align="center"><FONT color="$FCOLOR2"><B><FONT size="-1">$unit_name</FONT></B></FONT></TD>
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
      <TD bgcolor="#ccffff" width=12.5%>$unit_mhp/$unit_mmaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$unit_mmp/$unit_mmaxmp</TD>
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

