sub petup2 {
        &chara_open;

        if($mpet eq""){&error("你必須帶著你的寵物才可以訓練牠！！");}

        &status_print;
        &town_open;
        &equip_open;
        open(IN,"./logfile/ability/$mid.cgi");
        @ABDATA = <IN>;
        close(IN);

        foreach(@ABDATA){
                ($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
                if($kabno eq"83"){
                        $mab[83]=1;
                        last;
                }
        }
        ($msk[0],$msk[1]) = split(/,/,$msk);
        open(IN,"./data/ability.cgi");
        @ABILITY = <IN>;
        close(IN);
        $abname1="";
        $showpetname="";
        $ej=0;
        $tranpoints=999999;
        if ($mpet ne"") {
                $showpetname="$mpetname($ELE[$mpetele])";
                foreach(@PETDATA){
                        if ($PETDATA[$ej][0] eq $mpetname){
                                $tranpoints=$PETDATA[$ej][5]/10000;
                                last;
                        }
			$ej++;
                }

        }
        if ($tmppoints eq 0) {
                &error("您的寵物無法訓練！！");
        }elsif ($ej>=49 && $mpetlv>=10){
                &error("您的寵物已經達到最強狀態，不需要再訓練了！！");
        }
#取得83訓練師奧義
        foreach(@ABILITY){
                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                if($msk[0] eq $abno || $msk[1] eq $abno || $marmsta eq $abno || $mprosta eq $abno || $maccsta eq $abno || $mpetsta eq $abno){
                        $mab[$abno]=1;
                }
                if($mpetsta eq $abno){
                        $abname1=$abname;
                }
        }
        if ($mab[83] ne 1){
                &error("你必須有馴獸的技能，才可以訓練你的寵物");
        }elsif ($in{'gold'} eq"Y" && $mgold<$tranpoints*10000){
                &error("你的手持金不足$tranpoints萬，無法訓練你的寵物");
        }elsif ($in{'gold'} ne"Y" && $mabp<$tranpoints){
		&error("你的熟練度不足$tranpoints，無法訓練你的寵物");
	}

	$showmsg="";
($mpetcno,$mpetname,$mpetdmg,$mpetdef,$mpetspeed,$mpetele,$mpetlv,$mpetcl,$mpetsta,$mpettype,$mpetflg) = split(/,/,$mpet);

	if ($mpetlv eq 10){
		$rndpet=6+int(rand(4));
		$petupID=$PETDATA[$ej][$rndpet];
		if ($PETDATA[$petupID][5] eq"100000000"){
			$rndpet=6+int(rand(4));
			$petupID=$PETDATA[$ej][$rndpet];
		}
		if ($petupID>0) {
			$mpetlv=0;
			&maplog("<font color=darkgreen>[寵物]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>轉生成為<font color=red>$PETDATA[$petupID][0]</font>");
			&maplog10("<font color=darkgreen>[寵物]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>轉生成為<font color=red>$PETDATA[$petupID][0]</font>");
			$mpetname=$PETDATA[$petupID][0];
			$showmsg="恭喜你，你的寵物已轉生成為<font color=#AAAAFF>$mpetname</font>";
			if ($in{'gold'} eq"Y"){
				$mgold-=$tranpoints*10000;
			}else{
                                $mabp-=$tranpoints;
			}
		}else{
			$showmsg="你的寵物無法再轉生！";
		}
	}else{
		$mpetlv+=1;
		$mpetdmg+=$PETDATA[$ej][1];
		$mpetdef+=$PETDATA[$ej][2];
		$mpetspeed+=$PETDATA[$ej][3];
		$showmsg="你的寵物升級了，<font color=yellow>威力+$PETDATA[$ej][1]、防禦+$PETDATA[$ej][2]、速度+$PETDATA[$ej][3]";
                if ($in{'gold'} eq"Y"){
                        $mgold-=$tranpoints*10000;
                }else{
                        $mabp-=$tranpoints;
                }
	}
	$mpet="$mpetcno,$mpetname,$mpetdmg,$mpetdef,$mpetspeed,$mpetele,$mpetlv,$mpetcl,$mpetsta,$mpettype,$mpetflg";

	&chara_input;
        &header;

        print <<"EOF";

<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">寵物店</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc">$showmsg。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="4" align="right" bgcolor="ffffff">
        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=petup>
        <INPUT type=submit CLASS=FC value=回到寵物店></TD></form>
        </TD>
    </TR>
  </TBODY>
</TABLE>
EOF

        &footer;
        exit;
}
1;
