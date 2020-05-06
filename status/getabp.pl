sub getabp {
	&chara_open;
	&status_print;

	open(IN,"./data/class.cgi") or &error("檔案開啟錯誤status/getabp.pl(5)。");
	@CLASS_DATA = <IN>;
	close(IN);
	

	require './data/abini.cgi';
	@jlist = split(/,/,$AJOB[$mclass]);

	$i=0;
	foreach(@jlist){
		$jobflg[$jlist[$i]] = 1;
		$i++;
	}

	$j=0;
	$joblist="<select name=job>";

	open(IN,"./logfile/job/$mid.cgi");
	@JOB_DATA = <IN>;
	close(IN);
	@job = split(/<>/,$JOB_DATA[0]);

	foreach(@CLASS_DATA){
		($cname,$cjp,$cnou,$cup,$cflg,$ctype)=split(/<>/);
		if($jobflg[$j] && $mclass ne $j){
			$jobtable.="<TR><TD width=5% bgcolor=ffffcc><input type=radio name=job value=$j></TD><TD bgcolor=$FCOLOR2>$cname</TD><TD bgcolor=$FCOLOR2>$TYPE[$ctype]</TD><TD bgcolor=$FCOLOR2 align=right>$job[$j]</TD></TR>";
		}
		$j++;
	}
	$joblist.="</select>";

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">取得熟練度</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">進階職業可以取得上階職業之前的剩餘熟練度。取得後本階職業熟練度增加上階職業剩餘熟練度的七成，上階職業熟練度歸０，。<BR>請選擇上階職業。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR 

	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=6 align=center><font color=ffffcc>可取得職業一覽表</font></td></tr>
	<tr>
	<td bgcolor=ffffcc></td><td bgcolor=$FCOLOR2 align=center>職業名稱</td><td bgcolor=$FCOLOR2 align=center>類型</td><td bgcolor=$FCOLOR2 align=center>剩餘熟練度</td>
	</tr>
	<form action="./status.cgi" method="post">
	$jobtable
	<TR><TD colspan=7 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=getabp2>
	<INPUT type=submit CLASS=FC value=開始取得></TD></TR></form>
	</table>
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
