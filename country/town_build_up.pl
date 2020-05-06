sub town_build_up {
        &chara_open;
        &status_print;
        &con_open;
        &town_open;
        if($con_id eq 0){&error("無所國無法進行城鎮軍事設施開發。");}
        if($town_con ne $mcon){&error("請在本國的城鎮軍事設施開發。");}

        $buildi=1;
        foreach(@town_build_name){
                if($buildi>0){
                        if ($town_build_data[$buildi] eq ""){$town_build_data[$buildi]="0";}
                        $need_gold=($town_build_data[$buildi]+1)*1000;
                        $need_cex=($town_build_data[$buildi])*200+500;
                        $build_list.="<tr style=\"font-size: 12px\"><td bgColor=\"white\"></td><td bgColor=\"white\">LV.$town_build_data[$buildi]</td><td bgColor=\"white\">$town_build_name[$buildi]</td><td bgColor=\"white\">國庫$need_gold萬</td><td bgColor=\"white\">$need_cex</td>";
                        $build_list.="<td bgColor=\"white\"><input CLASS=FC type=\"button\" onclick=\"javascript:build_ups($buildi);\" value=\"升級\" name=\"B1\"></td></tr>";
                }
                $buildi++;
		if($buildi>12){last;}	
        }
        &header;
        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">城鎮軍事設施開發</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">對$town_name進行軍事設施開發。<BR>開發需要符合以下聲聲需求，但不會扣除名聲，請選擇要開發的項目。<BR>國家資金：<font color="yellow">$scon_gold</FONT><BR><FONT color="#ffffcc"><a href="/hero_data/html/townbattle.html" target="_blank">設施說明</a></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
<table class="TC" border="0" width="100%" bgColor="#883300" id="table1">
        <tr>
                <td bgColor="white"></td>
                <td bgColor="white">目前等級</td>
                <td bgColor="white">建築名稱</td>
                <td bgColor="white">升級資金</td>
                <td bgColor="white">名聲需求</td>
                <td bgColor="white">升級</td>
        </tr>
$build_list

</table>
$BACKTOWNBUTTON
</TD>
                <form method="post" action="./country.cgi" name="build_up">
                        <INPUT type=hidden name=gold value=10000>
                        <INPUT type=hidden name=id value=$mid>
                        <INPUT type=hidden name=pow>
                        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                        <INPUT type=hidden name=mode value=town_build_up2>
                   </form>
    </TR>
  </TBODY>
</TABLE>
<script language="javascript">
function build_ups(buildi){
        build_up.pow.value=buildi;
        build_up.submit();
}
</script>
<center></center>
EOF
        &footer;
        exit;
}
1;

