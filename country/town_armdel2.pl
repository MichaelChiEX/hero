sub town_armdel2 {
        &chara_open;
        &status_print;
        &town_open;
        &con_open;
        if($con_id eq 0){&error("無所屬國無法進行刪除。");}
        if($mid ne $con_king){&error("國王以外的人無法刪除。");}
        if($mcex<500){&error("名聲需要大於５００。");}
        if(!$hit){&error("國家資料異常。");}
        if($in{'dno'} eq""){&error("請選擇要刪除裝備。");}

        $gold=10000000;
        
        open(IN,"./data/towndata.cgi");
        @T_LIST = <IN>;
        close(IN);
        open(IN,"./data/carm.cgi");
        @CARM = <IN>;
        close(IN);
        ($carm_t,$carm_name,$carm_val,$carm_dmg,$carm_wei,$carm_ele,$carm_hit,$carm_cl,$carm_type,$carm_sta,$carm_pos)=split(/<>/,$CARM[$in{'dno'}]);
	foreach(@T_LIST){
	        ($zcid,$zname,$zcon,$zele,$zmoney,$zarm,$zpro,$zacc,$zind,$zs,$ztr,$zx,$zy,$zbuild,$zetc)=split(/<>/);
		if ($zcon eq $mcon && $zcid eq $carm_pos) {
	        	$dno=$in{'dno'};
			last;
        	}
        }
	if ($dno eq "") {
		&error("找不到要刪除的特產品。");
	}

        $con_gold-=$gold;
        if($con_gold<0){&error("國庫的金額不足。");}
	splice(@CARM,$dno,1);
        #push(@CARM,"$armno<>$in{'name'}<>$armval<>$armdmg<>$armwei<>$in{'ele'}<>$armhit<>$armcl<>0<>$atype<>$town_id<>$con_id<>\n");
        open(OUT,">./data/carm.cgi");
        print OUT @CARM;
        close(OUT);

        &maplog("<font color=red>[特產品刪除]</font><font color=$ELE_BG[$con_ele]>$con_name國($ELE[$con_ele])</font> 的 <font color=blue>$mname</font> 刪除了特產品：<font color=$ELE_BG[$in{'ele'}]>$carm_name($carm_dmg/$carm_wei)($ELE[$carm_ele])</font>。");
        &con_input;
        &header;

        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">特產品刪除</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">成功刪除了持產品：<font color=red>$carm_name</font>($carm_dmg/$carm_wei)($ELE[$carm_ele])。</TD>
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
