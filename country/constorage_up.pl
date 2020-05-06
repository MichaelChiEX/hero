sub constorage_up {
        &chara_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無國庫");}
        open(IN,"./logfile/constorage/$mcon"."_max.cgi");
        $CONITEM_MAX = <IN>;
        close(IN);

	if ($CONITEM_MAX eq""){
		$CONITEM_MAX=10;
	}
	$canget=1;
	if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){
		&error("非官員以上人員無法擴充國庫。");
	}
	$up_gold=($CONITEM_MAX-10)*100+500;
	$conitem_next=$CONITEM_MAX+1;
        &header;

        print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="4" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">擴充國庫</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc"><font color=#AAAAFF>$con_name國</font>目前的的國庫容量為<font color=yellow>$CONITEM_MAX</font><BR>如果要擴充到<font color=yellow>$conitem_next</font>需要花費<font color=red>$up_gold萬</font></font>。<BR><font color=yellow>目前國家資金:$scon_gold</FONT></TD>
    </TR>
    <TR>
    <TD colspan="4" align="center" bgcolor="ffffff">
	<BR>
        <form action="./country.cgi" method="POST">
	<INPUT type=hidden name=mode value=constorage_up2>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=submit CLASS=FC value=擴充國庫容量上限></form>
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
