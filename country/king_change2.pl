sub king_change2 {
	&chara_open;
	&status_print;
	&town_open;
	&con_open;

	if($mid ne"$con_king" && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){&error("官職人員以外者無法進行。");}
	if($con_id eq 0){&error("無所屬國無法進行國王交替。");}
        if($con_id eq 9){&error("本國無法進行國王交替。");}
	if($mid ne"$con_king" && ($y_chara[0] eq $mid || $y_chara[1] ne $mid || $y_chara[2] ne $mid)){
		if($mcex < 3000){
			&error("名聲小於３０００無法執行。");
		}
		if($mgold < 10000000){
			&error("身上的現金不到１０００萬無法執行。");
		}
		$mgold -= 10000000;
	}
	if($in{'cand'} eq ""){&error("未選擇繼承者。");}
	
	$enemy_id=$in{'cand'};
	&enemy_open;

	for($i=0;$i<6;$i++){
		if($y_chara[$i] eq $in{'cand'}){
			&error("請先解除繼承者的官職，再進行交替。");
		}
	}
	$con_king = "$in{'cand'}";
	&con_input;
	&eh_log("任命$con_name國的<font color=red>國王</font>。","$con_name");
	&maplog("<font color=blueviolet>[國王交替]</font><font color=$ELE_BG[$con_ele]>$con_name國($ELE[$con_ele])</font>的<font color=blue>$mname</font>宣佈<font color=red>$ename</font>為新的國王。");
	
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">國王交替</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$ename被任命為<font color=red>$in{'yname'}</font>的國王。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
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
