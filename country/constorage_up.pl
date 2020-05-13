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
<table border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <tbody>
    <tr>
      <td colspan="4" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">擴充國庫</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></td>
      <td bgcolor="#330000" colspan="3"><font color="#ffffcc"><font color=#AAAAFF>$con_name國</font>目前的的國庫容量為<font color=yellow>$CONITEM_MAX</font><br>如果要擴充到<font color=yellow>$conitem_next</font>需要花費<font color=red>$up_gold萬</font></font>。<br><font color=yellow>目前國家資金:$scon_gold</font></td>
    </tr>
    <tr>
    <td colspan="4" align="center" bgcolor="ffffff">
	<br>
        <form action="./country.cgi" method="POST">
	<input type=hidden name=mode value=constorage_up2>
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=submit CLASS=FC value=擴充國庫容量上限></form>
	<br>
$BACKTOWNBUTTON
        </td>
    </tr>
  </tbody>
</table>
EOF

        &footer;
        exit;
}
1;
