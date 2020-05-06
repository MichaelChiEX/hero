sub inn{
	&header;
	&chara_open;
	&town_open;
	&status_print;
	&ext_open;
	&quest_open;
        if($SP_LOG){
                &verchklog("宿$mhp/$mmp");
        }

	$inn_gold=int($mmaxhp+$mmaxmp+($mstr+$mvit+$mint+$mdex+$mfai+$magi)/3);
	if($inn_gold<10){$inn_gold=10;}
	if($mgold>300000){
		$inn_gold=100000;
		$mes="你目前的所持金大於<font color=yellow>３０</font>萬。所以收<font color=yellow>１０</font>萬住宿費。";
	}elsif($mgold<$inn_gold && $mbank<$inn_gold){
		$mes="<font color=yellow>你真的很窮，連住一晚的錢都沒有，這次就免費給你住吧。</font>";
	}else{
		$mes="本次住宿花費<font color=yellow>$inn_gold</font> Gold。";
	}
	$mhp=$mmaxhp;
	$mmp=$mmaxmp;
	if($mgold<$inn_gold){
		$mbank-=$inn_gold;
		if($mbank<0){$mbank=0;$hit=1;}
		
	}else{
		$mgold-=$inn_gold;
		if($mgold<0){$mgold=0;}
	}
	if(!$hit){
		$town_gold+=int($inn_gold/((1500-$town_ind)/250));
	}
	if($quest2_town_no eq $mpos && $quest2_limit_time>$date && $quest2_count<10){
		$quest2_count=0;
	}
	&quest_input;
	&ext_input;
	&town_input;
	open(IN,"./logfile/battle/$in{'id'}.cgi");
	@BC_DATA = <IN>;
	close(IN);
	($mhpr,$mmpr,$mtim)=split(/<>/,$BC_DATA[0]);

	$date = time();
	$rec = int(($date - $mtim)/12)/100;
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

	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">宿屋</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=#AAAAFF>$mname</font>在這住了一晚<BR>$mes。<BR>住一晚後你的<FONT COLOR=GREEN>ＨＰ</FONT>及<FONT COLOR=GREEN>ＭＰ</FONT>還有<FONT COLOR=GREEN>健康度</FONT>獲得回復。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	$STPR
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
