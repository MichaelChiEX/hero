sub money_get{ 
	&chara_open;
	&town_open;
	&con_open;
	if($mcon eq 0 && $mid ne $GMID){&error("無所屬國無法進行回收。");}
	if($mcon ne"$town_con" && $mid ne $GMID){&error("無法在自己的國家城鎮外進行回收。");}
	if($town_gold <=200000){&error("收益需要大於２０萬才可進行回收。");}
	
	$upgold=$town_gold;
	$upgold3=int($upgold/50000);
	$upgold2=int($upgold/20);
	if($upgold2>1000000){$upgold2=1000000;}
	if($mid ne $GMID){
		$con_gold+=$upgold3*50000;
        }
	$mcex+=$upgold3;
	$mgold+=$upgold2;
	$upgold=$upgold3*50000;
	$town_gold-=$upgold;
	$upgold=int($upgold)/10000;
	&maplog("<font color=orange>[回收]</font>$con_name國的<font color=blue>$mname</font>回收了<font color=red>$upgold萬</font>收益。");
	
	&town_input;
	&con_input;
	&chara_input;
	&header;
print <<"EOF";
<TABLE border="0" width="80%" align=center height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">回收收益金</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/pub.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">$upgold萬的收益金被回收了。<br>$mname獲得$upgold2 Gold。</FONT></TD>
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
