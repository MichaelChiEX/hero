sub battle_entry{
        &chara_open;
        &status_print;
        &time_data;
	($maxstr,$maxvit,$maxint,$maxmen,$maxdex,$maxagi,$maxlv) = split(/,/,$mmax);
        $maxtotal=$maxstr+$maxvit+$maxint+$maxint+$maxmen+$maxdex+$maxagi;
        if ($maxtotal >5000){
                $join[2]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
                $join[1]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
                $join[0]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
	}elsif ($maxtotal >3000){
                $join[3]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
		$join[1]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
		$join[0]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
	}elsif($maxtotal>2000){
                $join[3]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
		$join[2]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
		$join[0]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
	}else{
                $join[3]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
		$join[2]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
                $join[1]="onclick=\"javascript:alert('你無法參加本組比賽');return false;\"";
	}
        &header;

        print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">天下第一武道會參賽報名</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/arena.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">天下第一武道會會場！<br>每週舉行一次比賽！<br>如果對自己的能力有信心可以報名參加，比賽過程將被紀錄下來讓所有人觀看。<br>名額不限，能力不足者也可以參加，但你可能第一場比賽就被秒殺。<br>比賽時角色的各項能力將視當下比賽時角色能力而定，非報名時能力<br>比賽時間為每週日,當天無法取消及報名,當日八點產出對戰名單,九點開戰,各組每兩分鐘一戰</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <font size=4 color=red><b>你目前的潛在能力為$maxtotal</b></font>
        <form action="./town.cgi" method="post">
        <input type=hidden name=id value=$mid>
        <input type=hidden name=join value=3>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=battle_entry2>
        <input type=submit value=報名參加英雄組(潛在能力5000以上,報名費2000萬) CLASS=FC $join[3]></form>
        <form action="./town.cgi" method="post">
        <input type=hidden name=id value=$mid>
	<input type=hidden name=join value=2>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=battle_entry2>
        <input type=submit value=報名參加高手組(潛在能力3000~5000,報名費1000萬) CLASS=FC $join[2]></form>
        <form action="./town.cgi" method="post">
        <input type=hidden name=id value=$mid>
	<input type=hidden name=join value=1>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=battle_entry2>
        <input type=submit value=報名參加進階組(潛在能力3000以下,2000以上,報名費600萬) CLASS=FC $join[1]></form>
        <form action="./town.cgi" method="post">
        <input type=hidden name=id value=$mid>
        <input type=hidden name=join value=0>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=battle_entry2>
        <input type=submit value=報名參加新手組(潛在能力2000以下,報名費300萬) CLASS=FC $join[0]></form>
        <form action="./town.cgi" method="post" target="_blank">
        <input type=hidden name=mode value=battle_entry_list>
        <input type=submit value=查詢目前各組報名清單 CLASS=FC></form>
        <form action="./town.cgi" method="post" target="_blank">
        <input type=hidden name=mode value=battle_entry_history>
        <input type=submit value=查詢目前/上次賽況 CLASS=FC></form>
        <form action="./town.cgi" method="post">
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=entry_can>
        <input type=submit value=取消參加 CLASS=FC></form>
$BACKTOWNBUTTON
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
