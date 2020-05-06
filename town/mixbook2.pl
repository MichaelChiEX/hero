sub mixbook2 {
        &chara_open;
        &equip_open;

        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);
        $no1=0;
	@COMP=();
        $it_dmg=0;
        foreach(@ITEM){
                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
                if($it_ki eq"3" && $it_type eq"11" && $it_no ne"priv"){
			if($in{'comno'.$no1} eq"$no1"){
				$t_dmg+=$it_dmg;
				push(@COMP,"$no1\n");
			}
		}
                $no1++;
        }
$COMPS=@COMP;
	if($COMPS<2){
		&error("請選擇兩個以上的熟練之書進行合成");
	}
	$no1=@COMP;
	foreach(@COMP){
                $no1--;
		splice(@ITEM,$COMP[$no1],1);
	}
	push(@ITEM,"rea<>3<>熟練之書$t_dmg<>10000000<>$t_dmg<>0<>0<>80<>10<>寶物<>11<>1000<>\n");
	open(OUT,">./logfile/item/$in{'id'}.cgi");
	print OUT @ITEM;
	close(OUT);
        &header;

        print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="4" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">熟練之書合成室</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc"><font color=#AAAFFF>$mname</font>完成熟練之書$t_dmg</FONT></TD>
    </TR>
    <TR>
    <TD colspan="4" align="center" bgcolor="ffffff">
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

