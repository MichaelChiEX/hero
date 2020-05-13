sub kunren2{
	#訓練
	&chara_open;
	&town_open;
	if($in{'player'} eq ""){&error("未選擇要與自己進行訓練的對象。");}
	if($in{'player'} eq "$mname"){&error("自己無法與自己訓練。");}
	
	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			if(!open(cha,"$dir/$file")){
				&error("找不到案檔：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			($rid,$rpass,$rname,$rurl) = split(/<>/,$cha[0]);
			if ($rname eq $in{'player'}){
				$enemy_id=$rid;
				$shit=1;
				last;
			}
		}
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
    <table border="0" width="100%" align=center height="144" CLASS=TOC>
    <tbody>
        <tr>
            <td colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]"><font color="#ffffcc">$town_name $sen$SEN[$in{'mode'}]</font></td>
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
                            <td bgcolor=$FCOLOR2><font size="-1">$mstr $chi1(+$marmdmg<font color=red>+$mpetdmg</font>)</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">武器</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">$marmname<br>
                            【$marmdmg/$marmwei】</font></td>
                        </tr>
                        <tr>
                            <td bgcolor=$FCOLOR2><font size="-1">MP</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">$mmp/$mmaxmp</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">防御力</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">$mvit $chi1(+$mprodmg+$maccdmg<font color=red>+$mpetdef</font>)</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">防具</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">$mproname<br>
                            【$mprodmg/$mprowei】</font></td>
                        </tr>
                        <tr>
                            <td bgcolor=$FCOLOR2><font size="-1">$mname$petname2</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">職業</font></td>
                            <td bgcolor=$FCOLOR2>$JOB[$mclass]</td>
                            <td bgcolor=$FCOLOR2><font size="-1">速度</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">$magi<font color=red>+$mpetspeed</font></font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">飾品</font></td>
                            <td bgcolor=$FCOLOR2><font size="-1">$maccname<br>
                            【$maccdmg/$maccwei】</font></td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td align="center" bgcolor="$FCOLOR2" width="20%"><img src="$IMG/town/machi.jpg" width="150" height="113" border="0"></td>
            <td bgcolor="#cccccc" width=30%>
            <table border="0" width="100%" height="100%" bgcolor=$ELE_BG[$eele]>
                <tbody>
                    <tr>
                        <td rowspan="2"><font size="-1"><img src="$IMG/chara/$echara.gif"></font></td>
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
            <td bgcolor=#000000><font color="white" size="-1">「$ecom」</font></td>
        </tr>
    </tbody>
    </table>
    <br><br>
EOF


##戰鬥處理
	$turn=0;
	while($turn<=30){
		$turn++;
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
			
			$mgold+=$get_gold;

			##レベルアップ
			&LVUP;

			print <<"EOF";
			<center>
			<table border="0" width="400" bgcolor="#000000" CLASS=TC>
                <tbody>
                    <tr>
                        <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">勝利！</font></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" bgcolor="$FCOLOR2">
                            獲得<font color="#cc0000">$get_ex</font>經驗值<br>
                            獲得<font color="#000099">$get_gold</font> Gold！<br>
                            獲得<font color="#cc0000">$getabp</font>熟練<br>
                            $com
                            <br>
                            <table border="0" bgcolor="#990000">
                                <tbody>
                                    <tr>
                                        <td bgcolor="#ffffcc">經驗值</td>
                                        <td bgcolor="#ffffcc">$mex(+$get_ex)point</td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#ffffcc">Gold</td>
                                        <td bgcolor="#ffffcc">$mgold(+$get_gold2)Gold</td>
                                    </tr>       
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
			</center>
EOF
			last;
		}if($lose){
			$lose_gold=$mgold-int($mgold/2);
			$mgold-=$lose_gold;

			if($sensei){
				&BPRINT;
			} else {
				&MPRINT;
			}
			print <<"EOF";
			<center>
			<table border="0" width="400" bgcolor="#000000" CLASS=TC>
                <tbody>
                    <tr>
                        <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">勝利！</font></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" bgcolor="$FCOLOR2">
                            <font color="#ff0000">$mname的所持金減半！！</font><br>
                            <br>
                            <table border="0" bgcolor="#990000">
                                <tbody>
                                    <tr>
                                        <td bgcolor="#ffffcc">失去了<font color="#000099">$lose_gold</font> Gold！</td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
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
	<input type=hidden name=mode value=inn>
	<input type="submit" value="宿屋" CLASS=FC>
	</form>
	<p><hr size=0></center>
	</center>
EOF
	&footer;
}

1;
