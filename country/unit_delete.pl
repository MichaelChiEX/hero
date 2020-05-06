sub unit_delete {
	&chara_open;
	&con_open;
	&town_open;
	&status_print;
	open(IN,"./data/unit.cgi");
	@UNIT_DATA = <IN>;
	close(IN);
	@NUNIT=();
	@N2UNIT=();
	foreach(@UNIT_DATA){
		($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
		if($bid eq $mid){
			if($mid eq $uid){$hit=1;}
			else{$hit=2;}
		}
		else{push(@NUNIT,"$_");}
	}
	if($hit eq 1){
		foreach(@NUNIT){
			($u2id,$l2chara,$l2name,$u2name,$b2id,$b2name,$b2mes,$b2con)=split(/<>/);
			if($u2id eq $mid){
				$enemy_id="$b2id";
				&enemy_open2;
				$eunit="";
				if($eid){
					&enemy_input2;
				}
			}
			else{push(@N2UNIT,"$_");}
		}
		open(OUT,">./data/unit.cgi") or &error('檔案開啟錯誤country/unit_delete.pl(32)。');
		print OUT @N2UNIT;
		close(OUT);
		$mess="隊伍已成功解散了。";
	}elsif($hit eq 2){
		open(OUT,">./data/unit.cgi") or &error('檔案開啟錯誤country/unit_delete.pl(37)。');
		print OUT @NUNIT;
		close(OUT);
		$mess="已成功脫離原來的隊伍。";
	}else{
		&error("你目前不在隊伍中。");
	}
	$munit="";
	&chara_input;

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">脫離隊伍</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">$mess<BR></FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center" bgcolor="#ffffcc">
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

sub enemy_open2{
	open(IN,"./logfile/chara/$enemy_id.cgi");
	@E_DATA = <IN>;
	close(IN);
	($eid,$epass,$ename,$eurl,$echara,$esex,$ehp,$emaxhp,$emp,$emaxmp,$eele,$estr,$evit,$eint,$efai,$edex,$eagi,$emax,$ecom,$egold,$ebank,$eex,$etotalex,$ejp,$eabp,$ecex,$eunit,$econ,$earm,$epro,$eacc,$etec,$esta,$epos,$emes,$ehost,$edate,$esyo,$eclass,$etotal,$ekati,$etype,$eoya,$esk,$eflg,$eflg2,$eflg3,$eflg4,$eflg5,$epet) = split(/<>/,$E_DATA[0]);
	$elv = int($eex/100)+1;
}

sub enemy_input2 {
	$date = time();
	@NE_DATA=();
	unshift(@NE_DATA,"$eid<>$epass<>$ename<>$eurl<>$echara<>$esex<>$ehp<>$emaxhp<>$emp<>$emaxmp<>$eele<>$estr<>$evit<>$eint<>$efai<>$edex<>$eagi<>$emax<>$ecom<>$egold<>$ebank<>$eex<>$etotalex<>$ejp<>$eabp<>$ecex<>$eunit<>$econ<>$earm<>$epro<>$eacc<>$etec<>$esta<>$epos<>$emes<>$host<>$date<>$edate2<>$eclass<>$etotal<>$ekati<>$etype<>$eoya<>$esk<>$eflg<>$eflg2<>$eflg3<>$eflg4<>$eflg5<>$epet<><>\n");
	open(OUT,">./logfile/chara/$enemy_id.cgi") or &error('檔案開啟錯誤country/unit_delete.pl(86)。');
	print OUT @NE_DATA;
	close(OUT);
}
1;
