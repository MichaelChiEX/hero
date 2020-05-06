sub town_arm2 {
	&chara_open;
	&status_print;
	&town_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無法進行開發。");}
	if($town_con ne $mcon){&error("必需要在本國的城鎮才能進行開發。");}
	if($mid ne $con_king){&error("國王以外的人無法開發。");}
	if($mcex<500){&error("名聲需要大於５００。");}
	if(!$hit){&error("國家資料異常。");}
	if($in{'name'} eq""){&error("請輸入開發裝備名稱。");}
	if($in{'dmg'} eq ""||$in{'wei'} eq ""){&error("請輸入金額。");}
	if($in{'dmg'} =~ m/[^0-9]/||$in{'wei'} =~ m/[^0-9]/){&error("請輸入正確的金額。");}
	if($in{'dmg'} <50){&error("金額不得少於５０萬。");}
	if($in{'ele'} eq ""){&error("請選擇要開發的屬性。");}
	if ($in{'name'} =~ /※/ || $in{'name'} =~ /★/ || $in{'name'} =~ /稀有/ || $in{'name'} =~ /優良/) {&error2("請不要使用特殊字眼及符號(※、★、稀有、優良)。"); }
	
	$dmg=$in{'dmg'};
	$wei=$in{'wei'};
	$gold=($dmg+$wei)*10000;
	$up=0;
	if($in{'ele'} eq $town_ele){$up+=0.2;}
	if($in{'ele'} eq $con_id){$up+=0.2;}
	$dmg=int($dmg*(1+$up));
	$wei=int($wei*(1+$up));

	open(IN,"./data/carm.cgi");
	@CARM = <IN>;
	close(IN);
	$carmno=@CARM;
	if($carmno>50){&error("已達開發上限，無法再進行制作。");}

	foreach(@CARM){
		($carm_t,$carm_name,$carm_val,$carm_dmg,$carm_wei,$carm_ele,$carm_hit,$carm_cl,$carm_type,$carm_sta,$carm_pos)=split(/<>/);
		$arm_val=int($arm_val*(1-$val_off/100));
		if($town_id eq $carm_pos){
			$no++;
		}
	}
	if($no>2){&error("每個城鎮最多只能開發三樣特產品。");}

	$con_gold-=$gold;
	if($con_gold<0){&error("國庫的金額不足。");}
	if($in{'eqp'} eq"t_arm"){
		$armno=0;
		$atype=$in{'atype'};
		$com="武器";
	}elsif($in{'eqp'} eq"t_pro"){
		$armno=1;
		$atype="防具";
		$com="防具";
	}elsif($in{'eqp'} eq"t_acc"){
		$armno=2;
		$atype="飾品";
		$com="飾品";
	}
		
	if($in{'eqp'} eq"t_arm"||$in{'eqp'} eq"t_pro"){
		#威力決定
		$armdmg=int(sqrt($dmg)) + int(rand(sqrt($dmg)*4)) - int(rand(sqrt($wei)/2));
		if($armdmg>250){$armdmg=250;}
		$armdmg+=int(rand($up*50+5));
		$drand=int(rand(10));
		if($armdmg<10+$drand){$armdmg=10+$drand;}

#最小值武力
        $m_mindmg=int(sqrt($dmg)) - int(sqrt($wei)/2);
		if($m_mindmg>250){$m_mindmg=250;}
		$m_mindmg+=0;
		if($m_mindmg<10){$m_mindmg=10;}
#最大值武力
        $m_maxdmg=int(sqrt($dmg)) + int(sqrt($dmg)*4);
		if($m_maxdmg>250){$m_maxdmg=250;}
		$m_maxdmg+=int($up*50+5);
		if($m_maxdmg<10){$m_maxdmg=10;}

		#重量決定
		if($armdmg<200){
			$armwei=$armdmg - int(sqrt($wei)*2) - int(rand(sqrt($wei)*5));
			if($armwei<5){$armwei=5;}
			$armwei-=int(rand($up*30+5));
			if($armwei<5){$armwei=5-int(rand(10));}

		}else{
			$armwei=$armdmg - int(sqrt($wei)) - int(rand(sqrt($wei)*3));
			if($armwei<15){$armwei=15;}
			$armwei-=int(rand($up*30+5));
			if($armwei<15){$armwei=15-int(rand(10));}
		}
#威力小於２００時最小重量
			$m_minwei=$m_mindmg - int(sqrt($wei)*2) - int(sqrt($wei)*5);
			if($m_minwei<5){$m_minwei=5;}
			$m_minwei-=int($up*30+5);
			if($m_minwei<5){$m_minwei=5-10;}
#威力小於２００時最大重量
			$m_maxwei=$armdmg - int(sqrt($wei)*2);
			if($m_maxwei<5){$m_maxwei=5;}
#威力大於２００時最小重量
			$m_minweiex=$m_mindmg - int(sqrt($wei)) - int(sqrt($wei)*3);
			if($m_minweiex<15){$m_minweiex=15;}
			$m_minweiex-=int($up*30+5);
			if($m_minweiex<15){$m_minweiex=15-10;}
#威力大於２００時最大重量
			$m_maxweiex=$armdmg - int(sqrt($wei));
			if($m_maxweiex<15){$m_maxweiex=15;}

#範圍顯示
		#$msgex="最小威力：$m_mindmg　最大威力：$m_maxdmg<BR>威力小於２００時最小重量：$m_minwei　最大重量：$m_maxwei<BR>威力大於等於２００時最小重量：$m_minweiex　最大重量：$m_maxweiex";
		#值段
		$sa=$armdmg-$armwei;
		if($sa<1){$sa=1;}
		$armval=$armdmg*$armdmg*250+$sa*$sa*500;

		if($armdmg<30){$armval=int($armval/10);}
		elsif($armdmg<50){$armval=int($armval/5);}
		elsif($armdmg<100){$armval=int($armval/3);}
		elsif($armdmg<150){$armval=int($armval/2);}
		elsif($armdmg<200){$armval=int($armval/1.5);}
	
	}elsif($in{'eqp'} eq"t_acc"){
		#威力決定
		$armdmg=int(sqrt($dmg)/3) + int(rand(sqrt($dmg))) - int(rand(sqrt($wei)/5));
		if($armdmg>55+$up*50){$armdmg=55+$up*50;}
		$armdmg+=int(rand($up*20+3));

		#重量決定
		if($armdmg<50){
			$armwei=$armdmg - int(sqrt($wei)) - int(rand(sqrt($wei)*2));
			$armwei-=int(rand($up*10+2));
			if($armwei<0){$armwei=0-int(rand(10));}
		}else{
			$armwei=$armdmg - int(sqrt($wei)/2) - int(rand(sqrt($wei)));
			$armwei-=int(rand($up*10+2));
			if($armwei<5){$armwei=5-int(rand(5));}
		}
		
		#值段
		$sa=$armdmg-$armwei;
		if($sa<1){$sa=1;}
		$armval=$armdmg*$armdmg*2000+$sa*$sa*4000;
		if($armdmg<20){$armval=int($armval/10);}
		elsif($armdmg<30){$armval=int($armval/5);}
		elsif($armdmg<40){$armval=int($armval/3);}
		elsif($armdmg<50){$armval=int($armval/2);}
		elsif($armdmg<60){$armval=int($armval/1.5);}
	}else{&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}

	$armval=int($armval*0.8)+int(rand($armval*0.4));
	if($armval<1000){$armval=1000;}

	$armhit=75 + int(rand(10));
	$armcl=9 + int(rand(2));
	if($armno eq 0){
		if($atype eq"斧"){$armdmg=int($armdmg*1.15);$armwei+=20;}
		elsif($atype eq"杖"){$armdmg=int($armdmg*0.9);$armwei-=5;}
		elsif($atype eq"弓"){$armdmg=int($armdmg*1.1);$armwei+=12;}
		elsif($atype eq"拳"){$armdmg=int($armdmg*0.8);$armwei-=10;}
		elsif($atype eq"刀"){$armdmg=int($armdmg*0.95);$armwei-=3;}
		
	}
	push(@CARM,"$armno<>$in{'name'}<>$armval<>$armdmg<>$armwei<>$in{'ele'}<>$armhit<>$armcl<>0<>$atype<>$town_id<>$con_id<>\n");
	open(OUT,">./data/carm.cgi");
	print OUT @CARM;
	close(OUT);

	&maplog("<font color=green>[$com開發]</font><font color=$ELE_BG[$con_ele]>$con_name國($ELE[$con_ele])</font> 的 <font color=blue>$mname</font> 於 <font color=$ELE_BG[$town_ele]>$town_name($ELE[$town_ele])</font> 開發$com：<font color=$ELE_BG[$in{'ele'}]>$in{'name'}($armdmg/$armwei)($ELE[$in{'ele'}])</font>。");
	&con_input;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">$com　開發</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$com：<font color=red>$in{'name'}</font>($armdmg/$armwei)($ELE[$in{'ele'}])開發完成。<br>$msgex</FONT>$msgex</TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
$BACKTOWNBUTTON
      </TD>	
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF

	&footer;
	exit;
}
1;
