sub king_conv {
	&chara_open;
	&con_open;
	&town_open;
	&status_print;

	if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){&error("官職者以外人員無法進入。");}
	
	open(IN,"./blog/chat/0.cgi");
	@ACONV_DATA = <IN>;
	close(IN);
	open(IN,"./blog/chat/$con_id.cgi");
	@MCONV_DATA = <IN>;
	close(IN);

	$atable="<table border=0 bgcolor=$FCOLOR width=100%>";
	foreach(@ACONV_DATA){
		($lid,$laite,$leid,$lchara,$lname,$lmes,$ldaytime)=split(/<>/);
		$atable.="<tr><td align=center bgcolor=000000 width=15%><img src=\"$IMG/chara/$lchara.gif\"></td><td align=left bgcolor=000000 width=85%><b><font color=ffffff>$lname<BR>「$lmes」<BR></b>($ldaytime)</font></td></tr>";
	}
	$atable.="</table>";
	
	$mtable="<table border=0 bgcolor=$ELE_BG[$con_ele] width=100%>";
	foreach(@MCONV_DATA){
		($lid,$laite,$leid,$lchara,$lname,$lmes,$ldaytime)=split(/<>/);
		$mtable.="<tr><td align=center bgcolor=000000 width=15%><img src=\"$IMG/chara/$lchara.gif\"></td><td align=left bgcolor=000000 width=85%><b><font color=ffffff>$lname<BR>「$lmes」<BR></b>($ldaytime)</font></td></tr>";
	}
	$mtable.="</table>";
	
	
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if($con2_id ne $con_id){$conlist.="<option value=$con2_id>$con2_name國";}
	}

	&header;
	
	print <<"EOF";
	<TABLE border="0" width="95%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  	 <TBODY>
    	 <TR>
      	  <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">官職會議</FONT></TD>
    	 </TR>
    	 <TR>
      	  <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country.jpg"></TD>
      	  <TD bgcolor="#330000"><FONT color="#ffffcc">你正在官職會議大廳。<BR>全國官職人員都在此討論國家事務。</FONT></TD>
    	 </TR>
    	 <TR>
      	  <TD colspan="2" bgcolor=$FCOLOR align="center">
	<TABLE bgcolor=$FCOLOR WIDTH=100%>
	<TR><TD colspan=2 align=center>
	<font color=ffffcc>發言內容</font>
	</TD></TR>
	<TR><TD colspan=2 bgcolor=$FCOLOR2 align=center>
	<form action="./country.cgi" method="post">
	<input type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=king_chat>
	メッセージ：<input type=text name=mes size=60>
	<SELECT name=mes_sel>
	<option value=$con_id>$con_name本國
	<option value=0>全國
	$conlist
	</SELECT>
        <input type=submit class=FC value=送信><BR>
	</TD>
	</form>
	</TR>
	<TR>
	<TD bgcolor=$FCOLOR2 width=50%>
	全國會議資訊<br>
	$atable
	<TD bgcolor=$FCOLOR2 width=50%>
	$con_name國內會議資訊<br>
	$mtable
	</TD>
	</TR>
	</TD>
     	</TABLE>
	</TD>
    	 </TR>
	 <TR>
	  <TD colspan="2"align="center">
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
