sub unit_entry {
	&chara_open;
	&con_open;
	&town_open;
	&status_print;
	&time_data;

	open(IN,"./data/unit.cgi");
	@UNIT_DATA = <IN>;
	close(IN);

	if($in{'no'} eq ""){&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}
	$unit_count=0;
	foreach(@UNIT_DATA){
		($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bflg)=split(/<>/);
		if($bid eq $mid){&error("已在隊伍中。");}
		if($uid eq $in{'no'}){
			$unit = $uname;
			$unit_id = $uid;
			$l_chara = $lchara;
			$l_name = $lname;
			$hit = 1;
			$unit_count++;
		}
	}
	if($unit_count>9){
		&error("隊伍人數已達上限,無法再入隊");
	}
	if($hit){
		$munit = $unit_id;
		unshift(@UNIT_DATA,"$unit_id<>$l_chara<>$l_name<>$unit<>$mid<>$mname<><><>\n");
		open(OUT,">./data/unit.cgi") or &error('檔案開啟錯誤counrty/unit_entry.pl(27)。');
		print OUT @UNIT_DATA;
		close(OUT);
	}else{
		&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");
	}

	open(IN,"./data/unit.cgi");
	@UNIT_DATA = <IN>;
	close(IN);
	$MESFILE="./meslog/unit/$munit.cgi";
	$eid=4;

	open(IN,"$MESFILE");
	@MES_DATA = <IN>;
	close(IN);

	$smess="<font color=red>$mname成功加入了隊伍。</font>";
	unshift(@MES_DATA,"$mid<>4<>$aite<>$mchara<>$name<>$smess<>$daytime<>\n");
	splice(@MES_DATA,$MES_MAX);
	if($MESFILE ne".cgi"){
		open(OUT,">$MESFILE");
		print OUT @MES_DATA;
		close(OUT);
	}
	&header;
	&chara_input;
	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">入隊</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">加入了$unit隊伍。<br></font></td>
    </tr>
    <tr>
      <td colspan="2" align="center" bgcolor="#ffffcc">
$BACKTOWNBUTTON
      </td>
    </tr>
  </tbody>
</table>
<center></center>
EOF
	&footer;
	exit;
}
1;
