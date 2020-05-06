sub kunren2{
	#訓練
	&chara_open;
	&town_open;
	if($in{'player'} eq ""){&error("未選擇要與自己進行訓練的對象。");}
	if($in{'player'} eq "$mname"){&error("自己無法與自己訓練。");}
        $dir="./logfile/chara";
        opendir(dirlist,"$dir");
        $i=0;
        while($file = readdir(dirlist)){
                if($file =~ /\.cgi/i){
                        $datames = "查詢：$dir/$file<br>\n";
                        if(!open(cha,"$dir/$file")){
                                &error("找不到案檔：$dir/$file。<br>\n");
                        }
                        @cha = <cha>;
                        close(cha);
                        $list[$i]="$file";
                        ($rid,$rpass,$rname,$rurl) = split(/<>/,$cha[0]);
                        if ($rname eq $in{'player'}){
                                $enemy_id=$rid;
                                $shit=1;
                                last;
                        }
                }
                $mn++;
        }
        closedir(dirlist);
        if (!$shit) {&error("找不到你輸入的對象");}

	$mtotal++;
	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error("離下次可戰鬥時間剩 $btime 秒。");}

	&enemy_open;

	&equip_open;
        #神之必殺效果減半
        $god_kill="2";
	&PARA;
	&TEC_OPEN;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="100%" align=center height="144" CLASS=TOC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]"><FONT color="#ffffcc">$town_name $sen$SEN[$in{'mode'}]</FONT></TD>
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
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mstr $chi1(+$marmdmg<font color=red>+$mpetdmg</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$marmname<BR>
            【$marmdmg/$marmwei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mmp/$mmaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mvit $chi1(+$mprodmg+$maccdmg<font color=red>+$mpetdef</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mproname<BR>
            【$mprodmg/$mprowei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mname$petname2</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2>$JOB[$mclass]</TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$magi<font color=red>+$mpetspeed</font></FONT></TD>
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
      <TD bgcolor=#000000><font color="white" size="-1">「$ecom」</font></TD>
    </TR>
  </TBODY>
</TABLE>
<BR><BR>
EOF


##戰鬥處理
	$turn=0;
	while($turn<=30){
		$turn++;
		if($turn>100){&error("ループ");}
		$bmess="";
		$mmess="";
		if($mab[15] && $mabdmg[15]>$eabdmg[15] && int(rand(3-$mabdmg[15])) eq 0){$sensei = 1;}
		elsif($eab[15] && $eabdmg[15]>$mabdmg[15] && int(rand(3-$eabdmg[15])) eq 0){$sensei = 0;}
		elsif(int(rand($mdex)) > int(rand($edex))){$sensei = 1;}
		else{$sensei = 0;}
		if($sensei){
			if($mhp>0){&MATT;}
			if($ehp>0){
				&EATT;
			}
		}else{
			if($ehp>0){
				&EATT;
			}
			if($mhp>0){&MATT;}
		}
		if($win){
			$mkati++;
			if($sensei){
				&BPRINT;
			} else {
				&MPRINT;
			}
			$mlv=int($mex/100)+1;
			
			$epoint=int($emaxhp+$emaxmp+($estr+$evit+$eint+$edex+$efai+$eagi)/3);
	
			$get_ex=(int($epoint/15) + 10 + int(rand(10)));
			if($get_ex>50){$get_ex = 50 + int(rand(10));}
			if($get_ex<10){$get_ex = 10 + int(rand(10));}

			
			if($mab[22]){
				$get_ex = int($get_ex*1.2);
				$getabp += 1;
			}

			$getabp=3;
			
			$mbex=$mex;
			if($mex<9900){
				$mex+=$get_ex;
			}
			$mtotalex+=$get_ex;
			$get_gold=($epoint + int(rand($epoint/5)))*4;

			$mabp+=$getabp;
			$bmjp[$mtype]=$mjp[$mtype];
			$mjp[$mtype]+=$getabp;
			if($mjp[$mtype]>$MAXJOB){$mjp[$mtype] = $MAXJOB;}
			
			$get_gold2=$get_gold+$add_gold + $z_gold;

			$mgold+=$get_gold2;

			##レベルアップ
			&LVUP;

			print <<"EOF";
			<center>
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">勝利！</FONT></TD>
    			</TR>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">
      			獲得<FONT color="#cc0000">$get_ex</FONT>經驗值<BR>
      			獲得<FONT color="#000099">$get_gold</FONT> Gold！<BR>
			獲得<FONT color="#cc0000">$getabp</FONT>熟練<BR>
			$com<BR>
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
			
			#$bmess.="$mname所持金減半。";
			$lose_gold=$mgold-int($mgold/2);
			$mgold-=$lose_gold;

			if($sensei){
				&BPRINT;
			} else {
				&MPRINT;
			}
			print <<"EOF";
			<center>
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">勝利！</FONT></TD>
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
			&BPRINT;
		} else {
			&MPRINT;
		}
	}
	if(!$win && !$lose){
		
		&atp;
		if($sensei){
			$mmess.="此戰未分出勝負。";
			&BPRINT;
		} else {
			$bmess.="此戰未分出勝負。";
			&MPRINT;
		}
	}

	&chara_input;

	print <<"EOF";
	<center>
$BACKTOWNBUTTON
	<form action="./town.cgi" method="POST">
	<input type=hidden name=id value="$mid">
	<input type=hidden name=pass value="$mpass">
	
	<INPUT type=hidden name=mode value=inn>
	<input type="submit" value="宿屋" CLASS=FC>
	</form>
	<P><hr size=0></center>
	</center>
EOF
	&footer;
}

1;
