sub king_chat {
	&chara_open;
	&header;
	&con_open;
	&town_open;
	&time_data;

	if($in{'mes_sel'} eq ""){&error("請選擇發送對象。");}
	if($in{'mes'} eq ""){&error("請選擇討論訊息。");}
	if(length($in{'mes'}) > 200){&error("討論訊息需小於１００個文字。");}
	if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){&error("非官員以上人員無法進行會議。");}
	
	if($con_king eq"$mid"){$smess="<font color=orange>[國王]</font>$in{'mes'}";}
	else{
		for($k=0;$k<6;$k++){
			if($y_chara[$k] eq $mid){$smess="<font color=ff0099>[$y_name[$k]]</font>$in{'mes'}";}
		}
	}

	if($in{'mes_sel'} eq "0"){
		$MESFILE="./blog/chat/0.cgi";
		$name="<font color=$ELE_C[$con_ele]>$mname＠$con_name國</font>";
		$mes_max=10;$eid=1;
	}
	else{
		$MESFILE="./blog/chat/$in{'mes_sel'}.cgi";
		$name="<font color=$ELE_C[$con_ele]>$mname＠$con_name國</font>";
		$mes_max=10;$eid=2;
		if($in{'mes_sel'} ne"$con_id"){
			foreach(@CON_DATA){
				($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
				if($con2_id eq $in{'mes_sel'}){$chit=1;last;}
			}
			if(!$chit){&error("被選擇的國家無法進行會議。");}
			$name="<font color=$ELE_C[$con_ele]>$mname＠$con_name國</font> to <font color=$ELE_C[$con2_ele]>$con2_name國</font>へ";
			open(IN,"./blog/chat/$con_id.cgi");
			@MMES_DATA = <IN>;
			close(IN);
			unshift(@MMES_DATA,"$mid<>$con_id<>$aite<>$mchara<>$name<>$smess<>$daytime<>\n");
			splice(@MMES_DATA,$mes_max);
			open(OUT,">./blog/chat/$con_id.cgi");
			print OUT @MMES_DATA;
			close(OUT);
		}
	}
	
	$aite=$in{'mes_sel'};

	open(IN,"$MESFILE");
	@MES_DATA = <IN>;
	close(IN);
	if($in{'mes'} eq"clear"){
		$smess="♪～";
		@N_MES=();
		foreach(@MES_DATA){
			($mes_id,$mes_aite,$mes_eid,$mes_chara,$mes_name,$mes_mes,$mes_daytime)=split(/<>/);
			if($mid eq "$mes_id"){next;}
			else{push(@N_MES,"$_");}
		}
		@MES_DATA=@N_MES;
	}
	unshift(@MES_DATA,"$mid<>$con_id<>$aite<>$mchara<>$name<>$smess<>$daytime<>\n");
	splice(@MES_DATA,$mes_max);

	open(OUT,">$MESFILE");
	print OUT @MES_DATA;
	close(OUT);

	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="120" CLASS=FC>
  <TBODY>
    <TR>
      <TD align="center" bgcolor="#993300"><FONT color="#ffffcc">傳送完成</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#330000" height=100><FONT color="#ffffcc">已將內容傳送到對方手中。</FONT></TD>
    </TR>
    <TR>
      <TD align="center">
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
