sub fget{
	&chara_open;
	&time_data;
	if($in{'no'} eq ""){&error("請選擇取貨的物品。");}
	
	open(IN,"./data/free.cgi") or &error("檔案開案錯誤town/fget.pl(6)。");
	@FREE = <IN>;
	close(IN);

	($f_no,$f_ki,$f_name,$f_val,$f_dmg,$f_wei,$f_ele,$f_hit,$f_cl,$f_type,$f_sta,$f_flg,$f_id,$f_hname,$f_min,$f_max,$f_p,$f_last,$f_lname,$f_time,$f_pat)=split(/<>/,$FREE[$in{'no'}]);
	
	$date = time();
	$xdate = ($date-$f_time)/3600;

	if($mid ne $f_id && $f_last ne $mid){
#		&maplog("<font color=red>[警告]</font><font color=blue>$mname</font>嘗試利用不正當的手段對<font color=red>$f_name</font>進行劫標。");
		&error("資料傳輸有誤");
	}

	$bidc = "<font color=#AAAAFF>$mname</font>的<font color=#AAAAFF>$f_name</font>流標";
	if($mid ne $f_last && $mid eq $f_id && $xdate>240){
		$bidc = "拍賣品超過１０日被拍賣者取回。";
		$f_last = $mid;
		$bidflg = 1;
	}

	if((($mid ne $f_last && $mid eq $f_id) || ($mid eq $f_last && $mid ne $f_id)) && !$bidflg){
		
		if($mid eq $f_last){
			$enemy_id="$f_id";
			&enemy_open;
			if($mbank < $f_p){&error("銀行的金額不足。");}
			$mbank -= $f_p;
			$ebank+=$f_p;
		}
		elsif($mid eq $f_id){
			$enemy_id="$f_last";
			&enemy_open;
			if($ebank < $f_p){&error("銀行的金額不足。");}
			$mbank+=$f_p;
			$ebank -= $f_p;
		}else{
			&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");
		}

		&enemy_input;
		$f_p2=$f_p/10000;
		$bidc = "<font color=blue>$f_hname</font>的<font color=red>$f_name</font>被<font color=green>$f_lname</font>花費<font color=red>$f_p2萬</font>取得。";
                $mes_max=$MES3;
                $aite ="拍賣訊息";

                open(IN,"./logfile/mes/$f_id.cgi");
                @MMES_DATA = <IN>;
                close(IN);
                unshift(@MMES_DATA, "$GMID<>$f_id<>拍賣訊息<>gm<>拍賣訊息<>$bidc<>$tt<>\n");
if($mid eq $GMID){
        splice(@MMES_DATA,20);
}else{
        splice(@MMES_DATA,$mes_max);
}
                open(OUT,">./logfile/mes/$f_id.cgi");
                print OUT @MMES_DATA;
                close(OUT);		
		&maplog("<font color=green>[取標]</font><font color=blue>$f_hname</font>的<font color=red>$f_name</font>被<font color=green>$f_lname</font>花費<font color=red>$f_p2萬</font>取得。");
	}

	open(IN,"./logfile/item/$f_last.cgi") or &error("檔案開啟錯誤town/fget.pl(52)。");
	@ITEM = <IN>;
	close(IN);

	splice(@FREE,$in{'no'},1);
	push(@ITEM,"$f_no<>$f_ki<>$f_name<>$f_val<>$f_dmg<>$f_wei<>$f_ele<>$f_hit<>$f_cl<>$f_type<>$f_sta<>$f_flg<>\n");

	open(OUT,">./data/free.cgi");
	print OUT @FREE;
	close(OUT);

	open(OUT,">./logfile/item/$f_last.cgi");
	print OUT @ITEM;
	close(OUT);

	&chara_input;
	&header;
	
print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#000000" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">得標</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">$bidc</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
</TD>
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
