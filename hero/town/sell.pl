sub sell{
	&chara_open;
	if($in{'itno'} eq ""){&error("請選擇要賣出的物品。");}
	if($in{'itype'} eq"0"){$mode2="arm";}
	elsif($in{'itype'} eq"1"){$mode2="pro";}
	elsif($in{'itype'} eq"2"){$mode2="acc";}
	elsif($in{'itype'} eq"3"){$mode2="item";}
	
	open(IN,"./logfile/item/$in{'id'}.cgi") or &error("檔案開啟錯誤town/sell.pl(9)。");
	@ITEM = <IN>;
	close(IN);
	($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'itno'}]);
	#if($it_name eq ""){&error("その寶物は売れません。");}
	if($it_no eq "bug"){&error("");}
	$selgold=int($it_val/2);
	if($it_ki >4){}
	elsif($it_no eq "rea" && $it_name =~ /★/){$selgold=40000000;}
	elsif($it_no eq "rea" && $it_ki eq 3){$selgold=3000000;}
	elsif($it_no eq "rea"){$selgold=10000000;}
			
	$mgold+=int($selgold);
	splice(@ITEM,$in{'itno'},1);

	open(OUT,">./logfile/item/$in{'id'}.cgi");
	print OUT @ITEM;
	close(OUT);

	&chara_input;
	&header;
	
print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#000000" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="$FCOLOR2">$EQU[$in{'itype'}]屋</font></td>
    </tr>
    <tr>
      <td bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/buki.jpg"></td>
      <td bgcolor="#330000"><font color="$FCOLOR2">[$EQU[$in{'itype'}]屋]<br><font color=#AAAAFF>$it_name</font>將物品成功賣出，獲得<font color=yellow>$selgold Gold</font>。</font></td>
    </tr>
    <tr>
    <td colspan="2" align="center" bgcolor="ffffff">
	<form action="./town.cgi" method="POST">
	<input type=hidden name=mode value=$mode2>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=submit CLASS=FC value=回到店家></td></form>
	</td>
    </tr>
  </tbody>
</table>
<center></center>
EOF

	&footer;
	exit;
	
}
1;
