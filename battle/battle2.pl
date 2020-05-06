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
<TABLE border="0" width="100%" align=center height="144" CLASS=TOC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]"><FONT color="#ffffcc">鬥技場</FONT></TD>
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
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mstr(+$marmdmg<font color=red>+$mpetdmg</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$marmname<BR>
            【$marmdmg/$marmwei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mmp/$mmaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mvit(+$mprodmg+$maccdmg<font color=red>+$mpetdef</font>)</FONT></TD>
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
      <TD align="center" bgcolor="$FCOLOR2" width="20%"><IMG src="$IMG/etc/arena.jpg" width="150" height="113" border="0"></TD>
      <TD bgcolor="#cccccc" width=30%>
      <TABLE border="0" width="100%" height="100%" bgcolor=$ELE_BG[$eele]>
        <TBODY>
          <TR>
            <TD rowspan="2"><FONT size="-1"><img src="$IMG/chara/$echara.gif"></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">HP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ehp/$emaxhp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">攻擊力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$estr(+$earmdmg<font color=red>+$epetdmg</font>)</FONT></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$earmname<BR>【$earmdmg/$earmwei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$emp/$emaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$evit(+$eprodmg+$eaccdmg<font color=red>+$epetdef</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
	    <TD bgcolor=$FCOLOR2><FONT size="-1">$eproname<BR>【$eprodmg/$eprowei】</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ename$epetname2</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$eagi(<font color=red>+$epetspeed</font>)</FONT></TD>
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
      <TD bgcolor=#000000><font color="white" size="-1">「$emes」</font></TD>
    </TR>
  </TBODY>
</TABLE>
<BR><BR>
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
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">勝利！</FONT></TD>
    			</TR>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">獲得<FONT color="#cc0000">$get_ex</FONT>經驗值<BR>
      			獲得 <FONT color="#000099">$get_gold</FONT> Gold<BR>$com<BR>
      			<TABLE border="0" bgcolor="#990000">
        		<TBODY><TR>
            		<TD bgcolor="#ffffcc">經驗值</TD>
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
			#$bmess.="$mname所持金減半。";
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
	<P><font color=red><B>$_[0]</B></font>
$BACKTOWNBUTTON
	<P><hr size=0></center>
	</center>
EOF
	&footer;
}

1;
