sub equip3{
        &chara_open;
        if($in{'num'} eq ""){&error("請輸入使用的數量。");}
        if($in{'num'} =~ m/[^0-9]/){&error("請輸入正確使用的數量。");}
        if($in{'num'} <0){&error("請輸入正確的使用數量。");}
        if($in{'abno'} eq ""){&error("請選擇正確的使用物品。");}
        if($in{'abno'} =~ m/[^0-9]/){&error("請選擇正確的使用物品");}
        if($in{'abno'} <0 || $in{'abno'}>5){&error("請輸入正確的使用物品。");}
        $it_name[0]="力量之果";
        $it_name[1]="生命之果";
        $it_name[2]="智慧之果";
        $it_name[3]="精神之果";
        $it_name[4]="運氣之果";
        $it_name[5]="速度之果";
        &ext_open;
        if($ext_ab_item[$in{'abno'}] eq "" || $ext_ab_item[$in{'abno'}] eq"0"){&error("你沒有$it_name[$in{'abno'}]");}
        $ext_ab_item[$in{'abno'}]-=$in{'num'};
        if($ext_ab_item[$in{'abno'}]<0){&error("你的$it_name[$in{'abno'}]數量不足");}
        $it_dmg=$in{'abno'};
                        $upval = $in{'num'};
                        if($it_dmg eq "0" && $mmaxstr<500){
                                $mmaxstr += $upval;
                                if($mmaxstr>500){&error("吃下後力量會超過上限！");}
                                $mess.="<font color=orange>力量 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "1" && $mmaxvit<500){
                                $mmaxvit += $upval;
                                if($mmaxvit >500){&error("吃下後生命會超過上限！");}
                                $mess.="<font color=orange>生命 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "2" && $mmaxint<500){
                                $mmaxint += $upval;
                                if($mmaxint >500){&error("吃下後智力會超過上限！");}
                                $mess.="<font color=orange>智力 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "3" && $mmaxmen<500){
                                $mmaxmen += $upval;
                                if($mmaxmen >500){&error("吃下後精神會超過上限！");}
                                $mess.="<font color=orange>精神 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "4" && $mmaxdex<500){
                                $mmaxdex += $upval;
                                if($mmaxdex >500){&error("吃下後運氣會超過上限！");}
                                $mess.="<font color=orange>運氣 界限值上昇了$upval點！！</font><BR>";
                        }elsif($it_dmg eq "5" && $mmaxagi<500){
                                $mmaxagi += $upval;
                                if($mmaxagi >500){&error("吃下後速度會超過上限！");}
                                $mess.="<font color=orange>速度 界限值上昇了$upval點！！</font><BR>";
                        }else{
                                &error("<font color=red>再吃$in{'num'}個你的$it_name[$it_dmg]就超過500上限了</font>");
                        }
                        $mmax="$mmaxstr,$mmaxvit,$mmaxint,$mmaxmen,$mmaxdex,$mmaxagi,$mmaxlv";

        &ext_input;
        &chara_input;
        &header;
	
	print <<"EOF";
<TABLE border="0" width="80%" align=center height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="$FCOLOR2">使用</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/inn.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="$FCOLOR2">你使用了$in{'num'}個<font color=blue>$it_name[$it_dmg]$mess</font>。</FONT></TD>
    </TR>
    <TR>
    <TD colspan="2" align="center" bgcolor="ffffff">
<form action="./status.cgi" method=post id="statusf" target="actionframe">
      <input type=hidden name=id value=$mid>
      <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
      <input type=hidden name=mode value=equip>
        <input type=submit value="回到使用畫面">
</form>
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
