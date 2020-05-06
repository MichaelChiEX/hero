sub change2{
	&chara_open;
	&equip_open;
	&ext_open;
	if($in{'job'} eq ""){&error("你沒有選擇要轉職的職業。");}
	if($mlv<50){&error("轉職失敗:你的等級未達到５０級。");}
	($ext_tl_chara,$ext_tl_name,$ext_tl_month,$ext_tl_type[0],$ext_tl_type[1],$ext_tl_type[2],$ext_tl_type[3],$ext_tl_type[4],$ext_tl_type[5],$ext_tl_king,$ext_tl_lose,$ext_tl_lvup,$ext_tl_gift,$ext_tl_mix,$ext_tl_rshop,$ext_tl_goditem)=split(/,/,$ext_total);
	open(IN,"./data/class.cgi") or &error("檔案開啟失敗status\change1.pl(6)。");
	@CLASS_DATA = <IN>;
	close(IN);

	($cname,$cjp,$cnou,$cup,$cflg,$ctype)=split(/<>/,$CLASS_DATA[$in{'job'}]);
	($hpup,$mpup,$strup,$vitup,$intup,$faiup,$dexup,$agiup) = split(/,/,$cup);
	$uptmp=int($ext_tl_lvup/100);
	if($uptmp>50){$uptmp=50;}
        $memberup=$member_level*20;
	$stotalup=int($mtotal/2000);
	if ($stotalup>50){$stotalup=50;}
	$totalup=$stotalup+rand(int($mtotal/1000));
	if($memberup<$totalup){$memberup=$totalup;}
	if($memberup>100){$memberup=100;}
	$showbouns="<BR>本月升級獎勵,所有屬性增加:$uptmp";
        $showbouns2="<BR>總戰數/會員等級加成,所有性增加:$memberup";
	for($i=0;$i<6;$i++){
		$jup[$i]=sqrt(sqrt(sqrt($mjp[$i])));
		$jup[$i]=int($jup[$i]*$jup[$i]*$jup[$i]);
		$jup2[$i]=0;
		if ($ext_tl_type[$i] ne""){
			$jup2[$i]+=int($ext_tl_type[$i]/10);
			if ($jup2[$i]>50){$jup2[$i]=50;}
			$showbouns.="<BR>本月$TYPE[$i]加值:$jup2[$i]";
		}
		if($jup2[$i] eq 50 && $uptmp eq 50){
			$jup3[$i]=int(rand(50));
			$showbouns.="<BR><font color=green>($TYPE[$i]額外加值:$jup3[$i])</font>";
		}else{
			$jup3[$i]=0;
		}
#int(rand($uptmp));
	}
if($marmno eq"mix" && $marmele eq $mele){$mmaxhp-=1000;}
if($mprono eq"mix" && $mproele eq $mele){$mmaxhp-=1000;}
if($maccno eq"mix" && $maccele eq $mele){$mmaxmp-=1000;}

	$mmaxmaxhp = $mmaxstr*5 + $mmaxvit*10 + $mmaxmen*3 - 1500;
	$mmaxmaxmp = $mmaxint*7 + $mmaxmen*3 - 1000;

	$mmaxhp=int(rand($mmaxhp/1.5))+$hpup;
	$mmaxmp=int(rand($mmaxmp/1.5))+$mpup;
	$mstr=int(rand($mstr/1.5)+$strup+$jup[0]+$jup2[0]+$jup3[0]+$uptmp+$memberup);
	$mvit=int(rand($mvit/1.5)+$vitup+$jup[4]+$jup2[4]+$jup3[4]+$uptmp+$memberup);
	$mint=int(rand($mint/1.5)+$intup+$jup[1]+$jup2[1]+$jup3[1]+$uptmp+$memberup);
	$mfai=int(rand($mfai/1.5)+$faiup+$jup[2]+$jup2[2]+$jup3[2]+$uptmp+$memberup);
	$mdex=int(rand($mdex/1.5)+$dexup+$jup[3]+$jup2[3]+$jup3[3]+$uptmp+$memberup);
	$magi=int(rand($magi/1.5)+$agiup+$jup[5]+$jup2[5]+$jup3[5]+$uptmp+$memberup);
	if($mmaxhp<100){$mmaxhp=100;}
	if($mmaxmp<30){$mmaxmp=30;}
	if($mmaxhp>$mmaxmaxhp){$mmaxhp=$mmaxmaxhp;}
	if($mmaxmp>$mmaxmaxmp){$mmaxmp=$mmaxmaxmp;}
if($marmno eq"mix" && $marmele eq $mele){$mmaxhp+=1000;}
if($mprono eq"mix" && $mproele eq $mele){$mmaxhp+=1000;}
if($maccno eq"mix" && $maccele eq $mele){$mmaxmp+=1000;}
	if($mmaxhp<$mhp){$mhp=$mmaxhp;}
	if($mmaxmp<$mmp){$mmp=$mmaxmp;}

	if($mstr<30){$mstr=30;}
	if($mvit<30){$mvit=30;}
	if($mint<30){$mint=30;}
	if($mfai<30){$mfai=30;}
	if($mdex<30){$mdex=30;}
	if($magi<30){$magi=30;}

	if($mstr>$mmaxstr){$mstr=$mmaxstr;}
	if($mvit>$mmaxvit){$mvit=$mmaxvit;}
	if($mint>$mmaxint){$mint=$mmaxint;}
	if($mfai>$mmaxmen){$mfai=$mmaxmen;}
	if($mdex>$mmaxdex){$mdex=$mmaxdex;}
	if($magi>$mmaxagi){$magi=$mmaxagi;}

	open(IN,"./logfile/job/$mid.cgi");
	@JOB_DATA = <IN>;
	close(IN);
	@job = split(/<>/,$JOB_DATA[0]);
	$job[$mclass] = $mabp;
		
	@N_JOB_DATA=();
	unshift(@N_JOB_DATA,"$job[0]<>$job[1]<>$job[2]<>$job[3]<>$job[4]<>$job[5]<>$job[6]<>$job[7]<>$job[8]<>$job[9]<>$job[10]<>$job[11]<>$job[12]<>$job[13]<>$job[14]<>$job[15]<>$job[16]<>$job[17]<>$job[18]<>$job[19]<>$job[20]<>$job[21]<>$job[22]<>$job[23]<>$job[24]<>$job[25]<>$job[26]<>$job[27]<>$job[28]<>$job[29]<>$job[30]<>$job[31]<>$job[32]<>$job[33]<>$job[34]<>$job[35]<>$job[36]<>$job[37]<>$job[38]<>\n");
	open(OUT,">./logfile/job/$mid.cgi") or &error('檔案讀取錯誤status\change2.pl(61)。');
	print OUT @N_JOB_DATA;
	close(OUT);

	($msk[0],$msk[1]) = split(/,/,$msk);

	if($mclass ne $in{'job'}){
		$msk="$msk[0],0";
		$mclass="$in{'job'}";
		$mtec="0,0,0,50,50";
	}
	
	$mtype="$ctype";
	$mex=0;
	
	$mabp = $job[$in{'job'}];

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">轉職神殿</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=#AAAAFF>$mname</font>轉業為<font color=red>「$JOB[$in{'job'}]」</font>。$showbouns
$showbouns2</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
$BACKTOWNBUTTON
      </TD>	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	#轉職後可降等50級
	$down_lv_limit=50;
	#轉職後洗點能力重置
	$ext_para_add="0,0,0,0,0,0";
	&ext_input;
	&footer;
	exit;
}
1;
