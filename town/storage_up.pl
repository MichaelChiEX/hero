sub storage_up {
	&chara_open;
	&equip_open;
	&ext_open;
	
	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$no1=0;
	$itno="";
	$itsta2="";
	$it_count=@ITEM;
	$shit=0;
	if($it_count ne $in{'itcount'}){
		&error("你的手持物品數量改變了,可能有人傳送東西給你,請重新選擇擴充物品");
	}
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		if($it_ki>=0 && $it_ki<3) {
			if($in{'no'} eq"$no1" && $it_no eq"rea"){
				$itno=$no1;
				$itsta2=$it_sta;
				$shit=1;
				last;
			}
		}
		$no1++;
	}
	if(!$shit){&error("資料傳輸有誤");}	
	if($itno ne""){
		$STORITM_MAX++;
		$ext_storageadd++;
		if($itsta2 ne""){
			$STORITM_MAX++;
	                $ext_storageadd++;
		}
		&ext_input;
		splice(@ITEM,$in{'no'},1);
                open(OUT,">./logfile/item/$in{'id'}.cgi");
                print OUT @ITEM;
                close(OUT);
	}
	&header;
	
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">倉庫</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=#AAAAFF>$mname</font>的倉庫上限增加為<font color=yellow>$STORITM_MAX</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="right" bgcolor="ffffff">
	<form action="./town.cgi" method="POST">
	<INPUT type=hidden name=mode value=storage>
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=itype value=$in{'itype'}>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=submit CLASS=FC value=回到倉庫></TD></form>
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF

	&footer;
	exit;
}
1;
