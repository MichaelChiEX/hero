sub def_out{
	&chara_open;
	&town_open;
	&con_open;
	open(IN,"./data/def.cgi");
	@DEF = <IN>;
	close(IN);
	$hit=0;
	@NDEF=();
	foreach(@DEF){
		($name,$id,$pos)=split(/<>/);
		if($id eq "$mid"){$hit=1;}
		else{push(@NDEF,"$_");}
	}
	if(!$hit){&error("目前不是守備狀態。");}

	open(OUT,">./data/def.cgi") or &error('檔案開啟錯誤country/def_out.pl(17)。');
	print OUT @NDEF;
	close(OUT);
	
	&header;
print <<"EOF";
<TABLE border="0" width="80%" align=center height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">守備解除</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/country.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">已成功解除守備。</FONT></TD>
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
	&footer;
	exit;
	

}
1;
