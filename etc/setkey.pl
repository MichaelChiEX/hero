sub setkey{
	require './data/conf_fastkey.cgi';
        &chara_open;
        $i=0;
        for($i=0;$i<37;$i++){
        	$kclass="";
        	if($key_class[$i] eq"town"){
        		$kclass="城鎮設施";
        	}elsif($key_class[$i] eq"status"){
        		$kclass="各項設定";
        	}elsif($key_class[$i] eq"country"){
        		$kclass="軍事．內政";
        	}
        	$keytable.="<TR><TD bgcolor=white><input type=checkbox name=C$i id=C$i value=$i></TD><TD bgcolor=white>$kclass</TD><TD bgcolor=white>$key_name[$i]</TD></TR>";
        }
        &header;
        print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">快速按鈕設定</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">設定快速按鈕的功能會出現在畫面上直接可以點選，不需要再下拉選單，最多設定１０組，每次設定費用１００萬</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>指令一覽</font></td></tr>
        <tr>
        <td bgcolor=white>勾選設定</td><td bgcolor=white>功能類別</td><td bgcolor=white>指令名稱</td>
        </tr>
        <form action="./etc.cgi" method="post" id=movef name=movef>
        $keytable
        <TR><TD colspan=7 align=center bgcolor="ffffff">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=no id=no>
        <INPUT type=hidden name=mode value=setkey2>
        <input type=button value=設定(花費１００萬) class=FC onclick="javascript:chkform(this.form);">
        </TD></TR></form>
        </table>
        <form action="./top.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>

        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=submit CLASS=FC value=回到城鎮>
        </TD>
</form>
    </TR>
  </TBODY>
</TABLE>
<script language=javascript>
function chkform(f){
        f.no.value="";
        var chki=0;
        for(var i=0;i<=$i;i++){
                var obj=document.getElementById('C'+i);
                if (obj){
                        if(obj.checked){
                                f.no.value+=obj.value+",";
                                chki++;
                        }
                }
        }
	f.submit();
}

</script>
EOF
        &mainfooter;
        exit;
}
1;

