sub constorage2 {
        &chara_open;
        &equip_open;
	&con_open;
	if($con_id eq 0){&error("無所屬國無國庫");}
        open(IN,"./data/ability.cgi");
        @ABILITY = <IN>;
        close(IN);

        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);

        open(IN,"./logfile/constorage/$mcon"."_max.cgi");
        $CONITEM_MAX = <IN>;
        close(IN);

        open(IN,"./logfile/constorage/$mcon.cgi");
        @STORAGE = <IN>;
        close(IN);

	if ($CONITEM_MAX eq ""){
		$CONITEM_MAX=10;
	}

        if($in{'mode'} eq"constorage_in"){
                $scom="存入了";
                $it_num=@ITEM;
                $num=$in{'no'};
                if($it_num>$num){
                        ($itno,$in_type,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_flg)=split(/<>/,$ITEM[$in{'no'}]);
                }
                if ($in_type eq"4") {
                        &error("寵物無法放到倉庫！");
                }elsif ($in_type eq"3") {
			&error("物品無法放到倉庫！");
		}elsif ($in_type eq"5") {
			&error("合成物品無法放到倉庫！");
		}elsif ($in_type eq"6") {
                        &error("無法存入活動物品！");
		}
                splice(@ITEM,$in{'no'},1);

                if($it_name){
                        if(@STORAGE>=$CONITEM_MAX){&error("國庫物品數已達上限。(最大$CONITEM_MAX個)");}
                        push(@STORAGE,"$itno<>$in_type<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
                        open(OUT,">./logfile/constorage/$mcon.cgi");
                        print OUT @STORAGE;
                        close(OUT);


                        open(OUT,">./logfile/item/$in{'id'}.cgi");
                        print OUT @ITEM;
                        close(OUT);

			&maplog_constorage("<font color=green>[國庫存入]</font><font color=blue>$mname</font>將<font color=green>$it_name</font>存入國庫中。");
                }else{&error("資料出現異常。");}
        }elsif($in{'mode'} eq"constorage_out"){
		if($con_king ne $mid && $y_chara[0] ne $mid && $y_chara[1] ne $mid && $y_chara[2] ne $mid && $y_chara[3] ne $mid && $y_chara[4] ne $mid && $y_chara[5] ne $mid){
			&error2("非官員以上人員無法提取裝備。");
		}
                $scom="取出了";
                $it_num=@STORAGE;
                $num=$in{'no'};
                if($it_num>$num){
                        ($itno,$in_type,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos)=split(/<>/,$STORAGE[$in{'no'}]);
                }

                splice(@STORAGE,$in{'no'},1);

                if($it_name){
                        if(@ITEM>=$ITM_MAX){&error("你的持有物品數已達上限。(最大$ITM_MAX個)");}
                        push(@ITEM,"$itno<>$in_type<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
                        open(OUT,">./logfile/constorage/$mcon.cgi");
                        print OUT @STORAGE;
                        close(OUT);

                        open(OUT,">./logfile/item/$in{'id'}.cgi");
                        print OUT @ITEM;
                        close(OUT);
			&maplog_constorage("<font color=red>[國庫提取]</font><font color=blue>$mname</font>從國庫<font color=green>$it_name</font>。");
                }else{&error("資料出現異常。");}
        }

        &header;

        print <<"EOF";

<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">國庫</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=#AAAAFF>$mname</font>$scom<font color=yellow>$it_name</font>。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">

        $STPR
        <form action="./country.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=constorage>
        <INPUT type=submit CLASS=FC value=回到國庫></form>
$BACKTOWNBUTTON
    </TR>
  </TBODY>
</TABLE>
EOF

        &footer;
        exit;
}
1;
