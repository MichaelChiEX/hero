sub move2{
	&chara_open;
	&town_open;
        open(IN,"./logfile/ability/$mid.cgi");
        @ABDATA = <IN>;
        close(IN);

        foreach(@ABDATA){
                ($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
                if($kabno eq"55"){
                        $moveall=1;
                        last;
                }
        }

	if($in{'tid'} eq ""){&error_old("請選擇你要移動到的地點。");}
	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0 && $mid ne $GMID){&error_old("距離下次可行動的時間剩餘 $btime 秒。");}
	foreach(@TOWN_DATA){
		($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y)=split(/<>/);
		if($in{'tid'} eq $town2_id){last;}
		$tx++;
	}
	if(abs($town2_x-$town_x) > 1 && abs($town2_y-$town_y) > 1 && !$moveall){
		$xx=abs($town2_x-$town_x);
		$yy=abs($town2_y-$town_y);
		$coins=($xx+$yy)*5;
                if($mbank+$mgold>100000000){
                        $coins*=4;
                }elsif($mbank+$mgold>30000000){
			$coins*=2;
		}
		$mbank-=$coins*10000;
		if($mbank<0){&error("你銀行的資金不足$coins萬");}
	}
	$mpos=$in{'tid'};
	&chara_input;

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">移動</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">已經到了 $town2_name。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
	
	<form action="./top.cgi" method="POST">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	
	<INPUT type=submit CLASS=FC value=進入$town2_name>
	</TD>
	
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&mainfooter;
	exit;
}
1;
