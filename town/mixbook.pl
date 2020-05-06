sub mixbook {
        &chara_open;
        &equip_open;
        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);
        $no1=0;
        foreach(@ITEM){
                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
                $sel_val=int($it_val/2);
                if($it_no eq "rea" && $it_ki eq 3){$sel_val=3000000;}
                elsif($it_no eq "rea" && $it_ki eq 5){$sel_val=100000;}
                elsif($it_no eq "rea"){$sel_val=10000000;}
                if($it_ki eq"3" && $it_type eq"11" && $it_no ne"priv"){$ittable.="<TR><TD width=5% bgcolor=ffffcc><input type=checkbox name=comno$no1 value=$no1></TD><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$sel_val</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD></TR>";
		$SELECTALL.="selectf.comno$no1.checked=true;";
		}
                $no1++;
        }
        &header;

        print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">熟練之書合成室</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc"><font color=#AAAFFF>$mname</font>的熟練之書合成室,請點選你要合成的熟書進行合成</FONT></TD>
    </TR>
    <TR>

        <TD colspan="4" bgcolor="#ffffff" align=center valign=top>
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=4 align=center><font color=ffffcc><input type=button value=全選 onclick="javascript:selectall();">熟書一覽($no1/$ITM_MAX)</font></td></tr>
        <tr>
        <td bgcolor=white>選擇</td><td bgcolor=white>名稱</td><td bgcolor=white>價格</td><td bgcolor=white>威力</td>
        </tr>
        <form action="./town.cgi" method="post" name="selectf">
        $ittable
        <TR><TD colspan="4" align=center bgcolor="ffffff">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=itype value=$itype>
        <INPUT type=hidden name=mode value=mixbook2>
	<INPUT type=submit value=開始合成>
        </TD></TR></form>
        </table>
        </TD>
    </TR>
    <TR>
    <TD colspan="4" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
        </TD>
    </TR>
  </TBODY>
</TABLE>
<script language="javascript">
function selectall(){
$SELECTALL
}
</script>
EOF

        &footer;
        exit;
}
1;

