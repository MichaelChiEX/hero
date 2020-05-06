sub king_com2 {
	&chara_open;
	&status_print;
	&town_open;
	&con_open;

	if($mid ne"$con_king"){&error("國王以外的人無法任命他人官職。");}
	if($con_id eq 0){&error("無所屬者無法操作。");}
	#if($in{'yname'} eq ""){&error("請輸入官職名稱。");}
	if($in{'yname'} ne "" && (length($in{'yname'}) < 2||length($in{'yname'}) > 8)){&error("官職名稱需輸入２～４個字。");}
	#if($in{'cand'} eq ""){&error("請選擇任命官職的人員。");}
	if($in{'no'} eq ""){&error("官職不明確。");}
	if($in{'cand'} ne ""){	
		$enemy_id=$in{'cand'};
		&enemy_open;

		for($i=0;$i<6;$i++){
			if($y_chara[$i] eq $in{'cand'} && $in{'no'} ne $i){
				&error("官職名稱重複。");
			}
		}
	}elsif($y_name[$in{'no'}] ne""){
		$t_name=$y_name[$in{'no'}];
		$t_id=$y_chara[$in{'no'}];
		if($t_id ne""){
	                $enemy_id=$in{'cand'};
	                &enemy_open;
		}
	}
	$y_name[$in{'no'}]="$in{'yname'}";
	$y_chara[$in{'no'}]="$in{'cand'}";
	$con_yaku="$y_name[0],$y_name[1],$y_name[2],$y_chara[0],$y_chara[1],$y_chara[2],$y_name[3],$y_name[4],$y_name[5],$y_chara[3],$y_chara[4],$y_chara[5]";
	&con_input;
        if($in{'cand'} ne ""){
		&eh_log("被$con_name國任命為<font color=red>$in{'yname'}</font>。","$con_name");
		$showcom="$ename被任命為<font color=red>$in{'yname'}";
	}elsif($t_name ne""){
		&eh_log("被$con_name國取消官職","$con_name");
		$showcom="$ename被取消官職";
	}
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">官職任命</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$showcom</FONT></TD>
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
