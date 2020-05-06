sub build2 {
	&chara_open;
	&town_open;
	&con_open;
	$conkazu = @CON_DATA;
	if($conkazu>9){&error("目前國家數量已達上限，無法再建立國家。");}
	if($con_id ne 0){&error("無屬國者才可進行建國。");}
	if($town_id eq 0){&error("世界中心無法建國，請移動到其他城鎮建國。");}
	if($in{'ele'} eq ""){&error("請選擇國家屬性。");}
	if($in{'country'} eq ""){&error("請輸入國家名稱。");}
	if(length($in{'country'}) < 4||length($in{'country'}) > 12){&error("國家名稱請輸入２～６個文字。");}
	&ext_open;
        if ($ext_mix[0]<200 || $ext_mix[0] eq ""){&error("需要200顆建國之石才可建國");}
	$ext_mix[0]-=200;
	foreach(@CON_DATA){
		($con_id,$con_name,$con_ele,$con_gold,$con_king,$con_yaku,$con_cou,$con_mes,$con_etc)=split(/<>/);
		if("$con_id" eq "$town_con"){&error("此地已被他國占有，無法再次建國。");}
	}
        open(IN,"./data/procountry.cgi") or &error("檔案開啟失敗country/build.pl(19)。");
        @PROCON = <IN>;
        close(IN);

	open(IN,"./data/build.cgi") or &error("檔案開啟失敗country/build.pl(19)。");
	@BUILD = <IN>;
	close(IN);
	$maxid=@BUILD+1;
	$kengold=$BUGOLD;
	$mgold-=$kengold;
	$mcon=$maxid;
	$mcex+=500;

	if($mgold<0){&error("所持金不足$BUGOLD。");}

	$town_con=$maxid;
	&town_input;
	&ext_input;
	push(@CON_DATA,"$maxid<>$in{'country'}<>$in{'ele'}<>10000000<>$mid<><>1<><>0<>\n");
	open(OUT,">./data/country.cgi") or &error("檔案開啟失敗country/build.pl(33)。");
	print OUT @CON_DATA;
	close(OUT);

	&maplog("<font color=red><b>[建國]</b></font><font color=blue>$mname</font>建立了<b><font color=$ELE_BG[$in{'ele'}]>$in{'country'}國($ELE[$in{'ele'}])</font>。</b>");
	&maplog2("$mname 建立 $in{'country'}國。");
	&kh_log("<font color=red>$in{'country'}國</font>建國、<font color=red>成為國王</font>。","$in{'country'}");

        push(@PROCON,"$maxid<>$date<>\n");
        open(OUT,">./data/procountry.cgi") or &error("檔案開啟失敗country/build.pl(42)。");
        print OUT @PROCON;
        close(OUT);

	push(@BUILD,"$maxid<>$in{'country'}<>$in{'ele'}<>$mname<>$daytime<>\n");
	open(OUT,">./data/build.cgi") or &error("檔案開啟失敗country/build.pl(42)。");
	print OUT @BUILD;
	close(OUT);

	&chara_input;

	&header;
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">建國</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$in{'country'}國建立。</FONT></TD>
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
