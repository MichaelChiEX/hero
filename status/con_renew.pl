sub con_renew{
	&header;
	&chara_open;
	&town_open;
	&con_open;
	if($con_id eq 0){
		$mcon=$con_id;
	}if($mflg2  =~ m/[^0-9]/){
		$mflg2=0;
	}
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">國家情報更新</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.gif"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">國家情報更新完成。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
$BACKTOWNBUTTON
	</TD>	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
