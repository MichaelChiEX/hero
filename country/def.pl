sub def{
	&chara_open;
	&town_open;
	&con_open;
	if($town_con ne $mcon){&error("只能在自己的國家守備。");}
	if($town_con eq 0){&error("此地無法守備。");}
	if($mcon eq 0){&error("無屬國者無法進行專備。");}
	open(IN,"./data/def.cgi");
	@DEF = <IN>;
	close(IN);
	$hit=0;

	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error("距離下次可行動的時間剩餘 $btime 秒。");}
	$totaldef=0;
	foreach(@DEF){
		($name,$id,$pos)=split(/<>/);
		if($id eq "$mid"){$hit=1;}
		if($pos eq $mpos){$totaldef++;}
	}
	if($totaldef>=$town_build_data[2] || $town_build_data[2] eq""){
		&error("此城鎮的崗哨不足，請增建崗哨！");
	}
	open(IN,"./logfile/battle/$in{'id'}.cgi");
	@BC_DATA = <IN>;
	close(IN);
	($mhpr,$mmpr,$mtim)=split(/<>/,$BC_DATA[0]);
	if($mhpr eq""){$mhpr=1;}
	if($mmpr eq""){$mmpr=1;}
	if($mhpr<0.25){&error("你的健康度不足，無法進行守備。");}

	if($hit){&error("你已在守備狀態。");}
	else{
		unshift(@DEF,"$mname<>$mid<>$mpos<>\n");
		open(OUT,">./data/def.cgi") or &error('檔案開啟錯誤country/def.cgi(33)。');
		print OUT @DEF;
		close(OUT);
	}
	&header;
print <<"EOF";
<TABLE border="0" width="80%" align=center height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">城鎮守備</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/country.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">已成功成為$town_name的守備。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF
	&chara_input;
	&footer;
	exit;
	

}
1;
