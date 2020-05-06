sub discharge2 {
	&chara_open;
	&status_print;
	&town_open;
	&con_open;

	if($mid ne"$con_king" && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){&error("國王及官職以外人員無法進行解雇。");}
	if($con_id eq 0){&error("無所屬國無法進行解雇。");}
	
	if($in{'cand'} eq ""){&error("請選擇正確的解雇對象。");}
	
	$enemy_id=$in{'cand'};
	&enemy_open;

	for($i=0;$i<6;$i++){
		if($y_chara[$i] eq $in{'cand'}){
			&error("解雇對象目前正當任官職，請先解除他的官職。");
		}
	}
	if($mcex < 100){&error("你的名聲不足１００。");}
	$mcex-=100;
	$ecex=0;
	$econ=0;

	if($eunit){
		open(IN,"./data/unit.cgi");
		@UNIT_DATA = <IN>;
		close(IN);
		@NUNIT=();

		foreach(@UNIT_DATA){
			($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
			if($bid eq $eid){
				if($eid eq $uid){$hit=1;}
				else{$hit=2;}
			}
			else{push(@NUNIT,"$_");}
		}
		if($hit eq 1){
			foreach(@NUNIT){
				($u2id,$l2chara,$l2name,$u2name,$b2id,$b2name,$b2mes,$b2con)=split(/<>/);
				if($u2id eq $eid){
					$enemy_id2="$b2id";
					&enemy_open2;
					$e2unit="";
					if($e2id){
						&enemy_input2;
					}
				}
				else{push(@N2UNIT,"$_");}
			}
			open(OUT,">./data/unit.cgi") or &error('檔案開啟錯誤ountry/discharge2.pl(52)。');
			print OUT @N2UNIT;
			close(OUT);
		}elsif($hit eq 2){
			open(OUT,">./data/unit.cgi") or &error('檔案開啟錯誤ountry/discharge2.pl(56)。');
			print OUT @NUNIT;
			close(OUT);
		}
		$eunit="";
	}
	#解除守備
        open(IN,"./data/def.cgi");
        @DEF = <IN>;
        close(IN);
        $hit=0;
        @NDEF=();
        foreach(@DEF){
                ($name3,$eid3,$pos3)=split(/<>/);
                if($enemy_id eq "$eid3"){$hit=1;}
                else{push(@NDEF,"$_");}
        }
        if($hit){
                open(OUT,">./data/def.cgi");
                print OUT @NDEF;
                close(OUT);
        }
	&eh_log("被$con_name國<font color=red>解雇</font>。","$con_name");
	&maplog("<font color=red>[解雇]</font><font color=$ELE_BG[$con_ele]>$con_name國</font>的<font color=blue>$mname</font>解雇了<font color=red>$ename</font>。");

	&time_data;
	open(IN,"./logfile/out/$eid.cgi");
	@data = <IN>;
	close(IN);

	unshift(@data, "$con_id<>$daytime<>\n");
	open (OUT, "> ./logfile/out/$eid.cgi");
	print OUT @data;
	close (OUT);
	&enemy_input;
	&chara_input;

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">解雇</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$ename<font color=red>已被解雇</font>。</FONT></TD>
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


sub enemy_open2{
	open(IN,"./logfile/chara/$enemy_id2.cgi");
	@E_DATA = <IN>;
	close(IN);
	($e2id,$e2pass,$e2name,$e2url,$e2chara,$e2sex,$e2hp,$e2maxhp,$e2mp,$e2maxmp,$e2ele,$e2str,$e2vit,$e2int,$e2fai,$e2dex,$e2agi,$e2max,$e2com,$e2gold,$e2bank,$e2ex,$e2totalex,$e2jp,$e2abp,$e2cex,$e2unit,$e2con,$e2arm,$e2pro,$e2acc,$e2tec,$e2sta,$e2pos,$e2mes,$e2host,$e2date,$e2syo,$e2class,$e2total,$e2kati,$e2type,$e2oya,$e2sk,$e2flg,$e2flg2,$e2flg3,$e2flg4,$e2flg5,$e2pet) = split(/<>/,$E_DATA[0]);
	$e2lv = int($e2ex/100)+1;
}

sub enemy_input2 {
	$date = time();
	@NE_DATA=();
	unshift(@NE_DATA,"$e2id<>$e2pass<>$e2name<>$e2url<>$e2chara<>$e2sex<>$e2hp<>$e2maxhp<>$e2mp<>$e2maxmp<>$e2ele<>$e2str<>$e2vit<>$e2int<>$e2fai<>$e2dex<>$e2agi<>$e2max<>$e2com<>$e2gold<>$e2bank<>$e2ex<>$e2totalex<>$e2jp<>$e2abp<>$e2cex<>$e2unit<>$e2con<>$e2arm<>$e2pro<>$e2acc<>$e2tec<>$e2sta<>$e2pos<>$e2mes<>$host<>$date<>$e2date2<>$e2class<>$e2total<>$e2kati<>$e2type<>$e2oya<>$e2sk<>$e2flg<>$e2flg2<>$e2flg3<>$e2flg4<>$e2flg5<>$e2pet<><>\n");
	open(OUT,">./logfile/chara/$enemy_id2.cgi") or &error('檔案開啟錯誤country/discharge2.pl(121)。');
	print OUT @NE_DATA;
	close(OUT);
}
1;
