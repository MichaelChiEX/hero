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
<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">國家情報更新</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.gif"></td>
      <td bgcolor="#330000"><font color="#ffffcc">國家情報更新完成。</font></td>
    </tr>
    <tr>
      <td colspan="2" align="right">
$BACKTOWNBUTTON
	</td>	
    </tr>
  </tbody>
</table>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
