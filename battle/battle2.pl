sub battle2{
	#鬥技場
	&chara_open;
	&town_open;
	if($in{'mode'} eq ""){&error("資料傳輸錯誤，<a href='./login.cgi'>請重新登入</a>。");}
	$mgold-=10000;
	if($mgold<0){&error("所持金不足。");}

	$mtotal++;
	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error("距離下次行動還剩餘 $btime 秒。");}

	open(IN,"./data/chanp.cgi") or &error("檔案開啟錯誤battle/battle2.pl(13)。");
	@CHANP_DATA = <IN>;
	close(IN);
	($eid,$ename,$echara,$eele,$ehp,$emaxhp,$emp,$emaxmp,$estr,$evit,$eint,$efai,$edex,$eagi,$earm,$epro,$eacc,$etec,$esk,$etype,$eclass,$emes,$eex,$egold,$eren,$epet)=split(/<>/,$CHANP_DATA[0]);
	$ehp2=$ehp;
	$emp2=$emp;
	&equip_open;

	$epoint=int(($ehp+$emp)/3)+$estr+$evit+$eint+$efai+$edex+$eagi;
	#神之必殺效果減半
	$god_kill="2";
	&PARA;
	&TEC_OPEN;

	&header;
	
	print <<"EOF";
	<table border="0" width="100%" align=center height="144" CLASS=TOC>
		<tbody>
			<tr>
				<td colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]"><font color="#ffffcc">鬥技場</font></td>
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
							<td bgcolor=$FCOLOR2><font size="-1">$mstr(+$marmdmg<font color=red>+$mpetdmg</font>)</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">武器</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$marmname<br>
							【$marmdmg/$marmwei】</font></td>
						</tr>
						<tr>
							<td bgcolor=$FCOLOR2><font size="-1">MP</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$mmp/$mmaxmp</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">防御力</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$mvit(+$mprodmg+$maccdmg<font color=red>+$mpetdef</font>)</font></td>
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
					<td align="center" bgcolor="$FCOLOR2" width="20%"><img src="$IMG/etc/arena.jpg" width="150" height="113" border="0"></td>
					<td bgcolor="#cccccc" width=30%>
					<table border="0" width="100%" height="100%" bgcolor=$ELE_BG[$eele]>
						<tbody>
						<tr>
							<td rowspan="2"><font size="-1"><img src="$IMG/chara/$echara.gif"></font></td>
							<td bgcolor=$FCOLOR2><font size="-1">HP</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$ehp/$emaxhp</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">攻擊力</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$estr(+$earmdmg<font color=red>+$epetdmg</font>)</font></font></td>
							<td bgcolor=$FCOLOR2><font size="-1">武器</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$earmname<br>【$earmdmg/$earmwei】</font></td>
						</tr>
						<tr>
							<td bgcolor=$FCOLOR2><font size="-1">MP</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$emp/$emaxmp</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">防御力</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$evit(+$eprodmg+$eaccdmg<font color=red>+$epetdef</font>)</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">防具</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$eproname<br>【$eprodmg/$eprowei】</font></td>
						</tr>
						<tr>
							<td bgcolor=$FCOLOR2><font size="-1">$ename$epetname2</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">職業</font></td>
							<td bgcolor=$FCOLOR2></td>
							<td bgcolor=$FCOLOR2><font size="-1">速度</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$eagi(<font color=red>+$epetspeed</font>)</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">飾品</font></td>
							<td bgcolor=$FCOLOR2><font size="-1">$eaccname<br>【$eaccdmg/$eaccwei】</font></td>
						</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td bgcolor=#000000><font color="white" size="-1">「$mcom」</font></td>
				<td align=center bgcolor="666600"><font color="white" size="-1">戰鬥宣言</font></td>
				<td bgcolor=#000000><font color="white" size="-1">「$emes」</font></td>
			</tr>
		</tbody>
	</table>
	<br><br>
EOF


##戰鬥處理
	$turn=0;
	while($turn<=50){
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
			if($ehp>0){&EATT;}
		}else{
			if($ehp>0){&EATT;}
			if($mhp>0){&MATT;}
		}if($win){
			$mkati++;
			if($sensei){
				&BPRINT;
			} else {
				&MPRINT
			}
			$mlv=int($mex/100)+1;
			$get_ex=$epoint + int(rand($epoint/3));
			if($get_ex>50){$get_ex = 50 + int(rand(10));}
			if($get_ex<10){$get_ex = 10 + int(rand(10));}

			$mbex=$mex;
			if($mex<9900){
				$mex+=$get_ex;
			}
			$mtotalex+=$get_ex;
			$get_gold=$egold;
			push(@N_CHANP,"$mid<>$mname<>$mchara<>$mele<>$mmaxhp<>$mmaxhp<>$mmaxmp<>$mmaxmp<>$mstr<>$mvit<>$mint<>$mfai<>$mdex<>$magi<>$marm<>$mpro<>$macc<>$mtec<>$msk<>$mtype<>$mclass<>$mcom<>$mex<>20000<>1<>$mpet<>\n");
			open(OUT,">./data/chanp.cgi") or &error('檔案開啟有誤battle2.pl(151)。');
			print OUT @N_CHANP;
			close(OUT);

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
							獲得 <font color="#000099">$get_gold</font> Gold<br>$com<br>
							<table border="0" bgcolor="#990000">
							<tbody>
								<tr>
									<td bgcolor="#ffffcc">經驗值</td>
									<td bgcolor="#ffffcc">$mex(+$get_ex)point</td>
								</tr>
								<tr>
									<td bgcolor="#ffffcc">Gold</td>
									<td bgcolor="#ffffcc">$mgold(+$get_gold)Gold</td>
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
			$egold+=10000;
			$eren++;
			push(@N_CHANP,"$eid<>$ename<>$echara<>$eele<>$emaxhp<>$emaxhp<>$emaxmp<>$emaxmp<>$estr<>$evit<>$eint<>$efai<>$edex<>$eagi<>$earm<>$epro<>$eacc<>$etec<>$esk<>$etype<>$eclass<>$emes<>$eex<>$egold<>$eren<>$epet<>\n");
			open(OUT,">./data/chanp.cgi") or &error('檔案開啟有誤ballte/battle2.pl(187)。');
			print OUT @N_CHANP;
			close(OUT);

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
	<p><font color=red><b>$_[0]</b></font>
$BACKTOWNBUTTON
	<p><hr size=0></center>
	</center>
EOF
	&footer;
}

1;
