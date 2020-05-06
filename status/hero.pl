sub hero{
	&chara_open;
	&town_open;
	&con_open;

	open(IN,"./data/hero.cgi");
	@HERO = <IN>;
	close(IN);

	$num = @HERO-1;

	($bid,$bpass,$bname,$bchara,$bsex,$bhp,$bmaxhp,$bmp,$bmaxmp,$bele,$bstr,$bvit,$bint,$bfai,$bdex,$bagi,$bmax,$bcon,$bclass,$btotal,$bkati,$bpoint) = split(/<>/,$HERO[$num]);

	$mpoint=int(($mmaxhp+$mmaxmp)/3)+$mstr+$mvit+$mint+$mfai+$mdex+$magi;

	if($bpoint > $mpoint && $num > 8){
		&error("你目前的能力不足，你需要$bpoint點以上才可成為英雄　目前你的點為$mpoint點\n")
	}
	foreach(@HERO) {
		($bid,$bpass,$bname,$bchara,$bsex,$bhp,$bmaxhp,$bmp,$bmaxmp,$bele,$bstr,$bvit,$bint,$bfai,$bdex,$bagi,$bmax,$bcon,$bclass,$btotal,$bkati,$bpoint) = split(/<>/);

		if("$bid" eq "$in{'id'}"){
			splice(@HERO,$i,1,"$mid<>$mpass<>$mname<>$mchara<>$msex<>$mhp<>$mmaxhp<>$mmp<>$mmaxmp<>$mele<>$mstr<>$mvit<>$mint<>$mfai<>$mdex<>$magi<>$mmax<>$mcon<>$mclass<>$mtotal<>$mkati<>$mpoint<>\n");
			$flg=1;
			last;
		}
		$i++;
	}

	if(!$flg){
		unshift(@HERO,"$mid<>$mpass<>$mname<>$mchara<>$msex<>$mhp<>$mmaxhp<>$mmp<>$mmaxmp<>$mele<>$mstr<>$mvit<>$mint<>$mfai<>$mdex<>$magi<>$mmax<>$mcon<>$mclass<>$mtotal<>$mkati<>$mpoint<>\n");
	}

	@tmp = map {(split /<>/)[21]} @HERO;
	@HERO = @HERO[sort {$tmp[$b] <=> $tmp[$a]} 0 .. $#tmp];

	$num = @HERO;
	if($num > 10) { pop(@HERO); }

	open(OUT,">./data/hero.cgi") or &error('檔案開啟錯誤status/hero.pl(40)。');
	print OUT @HERO;
	close(OUT);

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">登録</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.gif"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">傳說中的英雄登錄成功！！你目英雄資料已記載在傳說中的英雄排行榜中！！</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
$BACKTOWNBUTTON
      </TD>	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
