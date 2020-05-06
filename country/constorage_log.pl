sub constorage_log {
&header;
        &chara_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無國庫");}
open(IN,"./logfile/constorage/$mcon"."_mes.cgi");
@MA = <IN>;
close(IN);
foreach(@MA){
	$mapl.="<b><font color=$FCOLOR>●$MA[$m]</font></b><BR>";
	$m++;
}

print <<"EOF";
<CENTER>
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan=2 align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">$con_name的國庫紀錄</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">在此你可以查看最近國庫的各項存取紀錄。</font></TD>
    </TR>
	<TR>
    <TD colspan=2 align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
   </TD>
	</TR>
    <TR>
      <TD colspan=2 bgcolor="#ffffcc"><FONT style="font-size:15px" color="#666600"><BR>$mapl</FONT><BR></TD>
    </TR>
  </TBODY>
</TABLE>
<BR>
</P>
</CENTER>

<hr>
EOF

        &footer;
        exit;
}
1;
