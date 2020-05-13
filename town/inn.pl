sub inn{
	&header;
	&chara_open;
	&town_open;
	&status_print;
	&ext_open;
	&quest_open;

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
<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">宿屋</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc"><font color=#AAAAFF>$mname</font>在這住了一晚<br>$mes。<br>住一晚後你的<font COLOR=GREEN>ＨＰ</font>及<font COLOR=GREEN>ＭＰ</font>還有<font COLOR=GREEN>健康度</font>獲得回復。</font></td>
    </tr>
    <tr>
      <td colspan="2" align="right">
	$STPR
$BACKTOWNBUTTON
	</td>
    </tr>
  </tbody>
</table>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
