sub con_change3{
	&chara_open;
	&con_open;
	&town_open;
	if($con_id eq 0){&error("無所屬國者無法進行下野。");}
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if("$con2_id" eq "$town_con"){$hit=1;last;}
	}
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">下野</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">你身上需要有５００萬才可以下野成為無所屬。<BR>而你的名聲及能力將回到原點。<BR>確定要下野？</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	<form action="./country.cgi" method="post">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=hidden name=mode value=con_change4>
	<INPUT type=submit value=下野 CLASS=FC></form>
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
