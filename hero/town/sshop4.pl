sub sshop4{
	&chara_open;
	&time_data;
	if($in{'no'} eq ""){&error("你未選擇要取回的物品。");}
		
	open(IN,"./data/sfree.cgi") or &error("檔案開啟錯誤town/sfree.pl(8)。");
	@FREE = <IN>;
	close(IN);

	($f_no,$f_ki,$f_name,$f_val,$f_dmg,$f_wei,$f_ele,$f_hit,$f_cl,$f_type,$f_sta,$f_flg,$f_id,$f_hname,$f_min,$f_max,$f_p,$f_last,$f_lname,$f_time,$f_pat)=split(/<>/,$FREE[$in{'no'}]);
	if ($f_id ne $mid){
		&error("你要取回的交易品不是你所有<br>請重新進入交易所確認");
	}
	if ($f_time>$date){
		&error("你要取回的文易品時間還沒到期");
	}

        open(IN,"./logfile/item/$mid.cgi") or &error("檔案開啟錯誤town/fget.pl(52)。");
        @ITEM = <IN>;
        close(IN);
	if(@ITEM>=$ITM_MAX){&error("你的持有物品數已達上限。(最大$ITM_MAX個)");}
        splice(@FREE,$in{'no'},1);
        push(@ITEM,"$f_no<>$f_ki<>$f_name<>$f_val<>$f_dmg<>$f_wei<>$f_ele<>$f_hit<>$f_cl<>$f_type<>$f_sta<>$f_flg<>\n");

        open(OUT,">./data/sfree.cgi");
        print OUT @FREE;
        close(OUT);

        open(OUT,">./logfile/item/$mid.cgi");
        print OUT @ITEM;
        close(OUT);
        &chara_input;

	&header;
	
print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#000000" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="$FCOLOR2">交易所</font></td>
    </tr>
    <tr>
      <td bgcolor="$FCOLOR2" width=20% align=center><img src="$IMG/etc/buki.jpg"></td>
      <td bgcolor="#330000"><font color="$FCOLOR2">你已成功取「$f_name」</font></td>
    </tr>
    <tr>
    <td colspan="2" align="center" bgcolor="ffffff">
	<form action="./town.cgi" method="POST">
	<input type=hidden name=mode value=sshop>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=submit CLASS=FC value=回到交易所></td></form>
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
