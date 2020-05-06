sub mode_change2{
	&header;
	&chara_open;
	&ext_open;
	$mflg="$in{'pmode'}";
	if($in{'modes'}eq"Y"){
		$ext_show_mode_maplog="Y";
	}else{
		$ext_show_mode_maplog="N";
	}
        if($in{'modes2'}eq"Y"){
                $ext_show_mode_guest="Y";
        }else{
                $ext_show_mode_guest="N";
        }
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">顯示型態變更</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/town/machi.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">畫面顯示型態變更完成。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	<form action="./top.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=submit CLASS=FC value=回到城鎮></form></TD>
	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&ext_input;
	&mainfooter;
	exit;
}
1;
