sub skill2{
	&chara_open;
	if($in{'skill'} eq ""){&error("請選擇要修練的奧義。");}
	
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);
	foreach(@ABILITY){
		($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
		if($abno eq $in{'skill'}){
			$hit=1;
			$mabp-=$abpoint;
			if($mabp < 0){&error("你的熟練度不足。");}
			
			open(IN,"./logfile/ability/$mid.cgi");
			@ABDATA = <IN>;
			close(IN);
			foreach(@ABDATA){
				($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
				if($kabno eq $abno){&error("你已經學習過此奧義。");}
			}
			push(@ABDATA,"$abno<>$abname<>$abcom<>$abdmg<>$abrate<>$abpoint<>$abclass<>$abtype<>l<>e<>\n");
			open(OUT,">./logfile/ability/$mid.cgi") or &error('檔案開案錯誤status/skill2.pl(23)。');
			print OUT @ABDATA;
			close(OUT);
			last;
		}
	}
	if(!$hit){&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">奧義修行</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color=#AAAAFF>$mname</font> <FONT color="#ffffcc">已學得</font> <font color=red>$abname</font>。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	<form action="./status.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=skill>
	<INPUT type=submit CLASS=FC value=回到奧義取得/修行畫面></form></TD>
	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
