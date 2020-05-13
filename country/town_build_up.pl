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
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">城鎮軍事設施開發</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/town.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">對$town_name進行軍事設施開發。<br>開發需要符合以下聲聲需求，但不會扣除名聲，請選擇要開發的項目。<br>國家資金：<font color="yellow">$scon_gold</font><br><font color="#ffffcc"><a href="/hero_data/html/townbattle.html" target="_blank">設施說明</a></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
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
</td>
                <form method="post" action="./country.cgi" name="build_up">
                        <input type=hidden name=gold value=10000>
                        <input type=hidden name=id value=$mid>
                        <input type=hidden name=pow>
                        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                        <input type=hidden name=mode value=town_build_up2>
                   </form>
    </tr>
  </tbody>
</table>
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

