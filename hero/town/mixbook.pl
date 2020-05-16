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
                if($it_ki eq"3" && $it_type eq"11" && $it_no ne"priv"){$ittable.="<tr><td width=5% bgcolor=ffffcc><input type=checkbox name=comno$no1 value=$no1></td><td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$sel_val</font></td><td bgcolor=white><font size=2>$it_dmg</font></td></tr>";
		$SELECTALL.="selectf.comno$no1.checked=true;";
		}
                $no1++;
        }
        &header;

        print <<"EOF";
<table border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="$FCOLOR"><font color="#ffffcc">熟練之書合成室</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></td>
      <td bgcolor="#330000" colspan="3"><font color="#ffffcc"><font color=#AAAFFF>$mname</font>的熟練之書合成室,請點選你要合成的熟書進行合成</font></td>
    </tr>
    <tr>

        <td colspan="4" bgcolor="#ffffff" align=center valign=top>
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=4 align=center><font color=ffffcc><input type=button value=全選 onclick="javascript:selectall();">熟書一覽($no1/$ITM_MAX)</font></td></tr>
        <tr>
        <td bgcolor=white>選擇</td><td bgcolor=white>名稱</td><td bgcolor=white>價格</td><td bgcolor=white>威力</td>
        </tr>
        <form action="./town.cgi" method="post" name="selectf">
        $ittable
        <tr><td colspan="4" align=center bgcolor="ffffff">
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=itype value=$itype>
        <input type=hidden name=mode value=mixbook2>
	<input type=submit value=開始合成>
        </td></tr></form>
        </table>
        </td>
    </tr>
    <tr>
    <td colspan="4" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
        </td>
    </tr>
  </tbody>
</table>
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

