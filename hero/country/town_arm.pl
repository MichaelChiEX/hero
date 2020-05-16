sub town_arm {
	&chara_open;
	&status_print;
	&con_open;
	&town_open;
	#&error("目前正在進行程式更新中,將要加入奧義開發,請先存好國庫的錢。");
	if($con_id eq 0){&error("無所屬國無法進行開發。");}
	if($town_con ne $mcon){&error("$town_con不在自己國家城鎮中，無法進行開發$mcon。");}

	$list="<select name=eqp>";
	$list.="<option value=t_arm>武器";
	$list.="<option value=t_pro>防具";
	$list.="<option value=t_acc>飾品";
	$list.="</select>";

	##屬性選択
	$j=0;
	$elelist="<select name=ele>";
	$elelist.="<option value=\"\">-請選擇屬性-";
	foreach(@ELE){
		$elelist.="<option value=$j>$ELE[$j]";
		$j++;
	}
	$elelist.="</select>";

	##種類２選択
	$tlist="<select name=atype>";
	foreach(@ARM){
		$tlist.="<option value=$_>$_";
	}
	$tlist.="</select>";

	&header;
	
	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">武器．防具開發</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">特產品的開發。<br>請選擇要開發的項目並輸入要投資的金額。<br>如果選擇的屬性與國家或城鎮的屬性一樣，將會有加成的效果。<br>每個城填可開發三樣特產品。<br>目前國家的資金：$scon_gold</font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	<form action="./country.cgi" method="post">
	種類：$list 
	種類２（武器種類選擇）：$tlist <br>
	名稱：<input type=text size=15 name=name>
	屬性：$elelist<br>
	威力：<input type=text size=5 name=dmg>萬Gold
	重量：<input type=text size=5 name=wei>萬Gold<br>
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=town_arm2>
	<input type=submit value=開發 CLASS=FC></form>
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
