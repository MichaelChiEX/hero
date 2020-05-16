sub data_change2{
	&header;
	&chara_open;
	&ext_open;
	if($in{'chara'} eq ""){&error("請選擇正確的圖案。");}
	$dgold=100000;
	if($in{'chara'} =~ m/[^0-9]/){$dgold=100000000;}
	if ($dgold eq 100000000){
		if($mtotal<10000 && $member_point eq""){
			&error("你的戰數不足1萬戰");
		}
	}
	$mgold-=$dgold;
	if($mgold<0){&error("你的金額不足$dgold。");}
	$mchara=$in{'chara'};
	print <<"EOF";
<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">整型</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/house.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">圖案變更完成。重新登入後將更新你的頭像</font></td>
    </tr>
    <tr>
      <td colspan="2" align="right">
$BACKTOWNBUTTON
      </td>
    </tr>
  </tbody>
</table>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
