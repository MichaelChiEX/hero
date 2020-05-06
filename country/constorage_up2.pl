sub constorage_up2 {
        &chara_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無國庫");}
        open(IN,"./logfile/constorage/$mcon"."_max.cgi");
        $CONITEM_MAX = <IN>;
        close(IN);

	if ($CONITEM_MAX eq ""){
		$CONITEM_MAX=10;
	}
	$canget=1;
	if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){
		&error("非官員以上人員無法擴充國庫。");
	}
	$up_gold=($CONITEM_MAX-10)*1000000+5000000;
	if($con_gold<$up_gold) {
		&error("國庫金額不足。");
	}
	open(OUT,">./logfile/constorage/$mcon"."_max.cgi");
	$conitem_next=$CONITEM_MAX+1;
        print OUT $conitem_next;
        close(OUT);
	$con_gold-=$up_gold;
	&con_input;
	&maplog_constorage("<font color=blue>[國庫擴充]$mname</font>將國庫存放上限提昇到<font color=red>$conitem_next</font>。");
        &header;

        print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="4" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">擴充國庫</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc"><font color=#AAAAFF>$con_name國</font>的國庫容量增加為<font color=yellow>$conitem_next</font>。</TD>
    </TR>
    <TR>
    <TD colspan="4" align="center" bgcolor="ffffff">
	<BR>
        <form action="./country.cgi" method="POST">
	<INPUT type=hidden name=mode value=constorage_up>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=submit CLASS=FC value=回到擴充畫面></form>
	<BR>
$BACKTOWNBUTTON
        </TD>
    </TR>
  </TBODY>
</TABLE>
EOF

        &footer;
        exit;
}
1;
