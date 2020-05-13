sub constorage_log {
&header;
        &chara_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無國庫");}
open(IN,"./logfile/constorage/$mcon"."_mes.cgi");
@MA = <IN>;
close(IN);
foreach(@MA){
	$mapl.="<b><font color=$FCOLOR>●$MA[$m]</font></b><br>";
	$m++;
}

print <<"EOF";
<center>
<table border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <tbody>
    <tr>
      <td colspan=2 align="center" bgcolor="$FCOLOR"><font color="#ffffcc">$con_name的國庫紀錄</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">在此你可以查看最近國庫的各項存取紀錄。</font></td>
    </tr>
	<tr>
    <td colspan=2 align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
   </td>
	</tr>
    <tr>
      <td colspan=2 bgcolor="#ffffcc"><font style="font-size:15px" color="#666600"><br>$mapl</font><br></td>
    </tr>
  </tbody>
</table>
<br>
</p>
</center>

<hr>
EOF

        &footer;
        exit;
}
1;
