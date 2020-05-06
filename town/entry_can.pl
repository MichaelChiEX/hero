sub entry_can{
	&chara_open;
	&town_open;
	&con_open;
	&time_data;
	if(!$wday){&error("大會當日無法取消參賽。");}
	
	open(IN,"./data/entry_list.cgi") or &error("檔案開啟錯誤town/entry_can.pl(9)。");
	@ENTRY_DATA = <IN>;
	close(IN);
	@N_ENTRY=();
	$e_joint=999;
	foreach(@ENTRY_DATA){
		($e_join,$e_id,$e_name,$e_chara)=split(/<>/);
		if($e_id eq $mid){$ehit=1;$e_joint=$e_join;}
		else{push(@N_ENTRY,"$_");}
	}
	if(!$ehit){&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	$mgoldx=0;
        if ($e_joint eq"0"){
                $mgoldx=3000000;
        }elsif ($e_joint eq"1"){
                $mgoldx=6000000;
        }elsif ($e_joint eq"2"){
                $mgoldx=10000000;
        }elsif ($e_joint eq"3"){
                $mgoldx=20000000;
	}
	$mgold+=$mgoldx;
	open(OUT,">./data/entry_list.cgi");
	print OUT @N_ENTRY;
	close(OUT);
	&chara_input;
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">取消參賽</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">已取消了大會的參賽。退還 $mgoldx Gold</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
$BACKTOWNBUTTON
    </TR>
  </TBODY>
</TABLE>
EOF
	&footer;
	exit;
}
1;
