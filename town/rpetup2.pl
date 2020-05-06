sub rpetup2 {
        &chara_open;
        if($moya ne 6666){
                &error("請不要做不法的操作");
        }

        if($mpet eq""){&error("你必須帶著你的寵物才可以訓練牠！！");}

        &status_print;
        &town_open;
        &equip_open;
        ($msk[0],$msk[1]) = split(/,/,$msk);
        ($esk[0],$esk[1]) = split(/,/,$esk);
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
                                $tranpoints=$PETDATA[$ej][5];
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

#取得84傳說馴獸師奧義
        foreach(@ABILITY){
                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                if($msk[0] eq $abno || $msk[1] eq $abno || $marmsta eq $abno || $mprosta eq $abno || $maccsta eq $abno || $mpetsta eq $abno){
                        $mab[$abno]=1;
                }
                if($mpetsta eq $abno){
                        $abname1=$abname;
                }
        }
        if ($mab[84] ne 1){
                &error("你必須裝備傳說馴獸師奧義，才可以訓練你的寵物");
        }elsif ($mgold<$tranpoints){
		&error("你身上的金額不足$tranpoints，無法請傳說中的馴獸師訓練你的寵物");
	}
	($mpetcno,$mpetname,$mpetdmg,$mpetdef,$mpetspeed,$mpetele,$mpetlv,$mpetcl,$mpetsta,$mpettype,$mpetflg) = split(/,/,$mpet);
	$showmsg="";
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
			$showmsg="恭喜你，你的寵物已轉生成為<font color=lightblue>$mpetname</font>";

			$mgold-=$tranpoints;
			$moya=int(rand(20000));
		}else{
			$showmsg="你的寵物無法再轉生！";
		}
	}else{
		$mpetlv+=1;
		$mpetdmg+=$PETDATA[$ej][1];
		$mpetdef+=$PETDATA[$ej][2];
		$mpetspeed+=$PETDATA[$ej][3];
		$showmsg="你的寵物升級了，<font color=yellow>威力+$PETDATA[$ej][1]、防禦+$PETDATA[$ej][2]、速度+$PETDATA[$ej][3]";
		$mgold-=$tranpoints;
		$moya=int(rand(20000));
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
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/1.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc">$showmsg。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="4" align="right" bgcolor="ffffff">
$BACKTOWNBUTTON
        </TD>
    </TR>
  </TBODY>
</TABLE>
EOF

        &footer;
        exit;
}
1;
