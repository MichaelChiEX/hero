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
<table border="0" width="80%" align=center height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="$FCOLOR2">守備解除</font></td>
    </tr>
    <tr>
      <td bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/country.jpg"></td>
      <td bgcolor="#330000"><font color="$FCOLOR2">已成功解除守備。</font></td>
    </tr>
    <tr>
    <td colspan="2" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
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
