sub hinn2{
	&chara_open;
	&town_open;

	&equip_open;
	if($marmno eq"mix" && $mele eq $marmele){$mmaxhp-=1000;}
	if($mprono eq"mix" && $mele eq $mproele){$mmaxhp-=1000;}
	if($maccno eq"mix" && $mele eq $maccele){$mmaxmp-=1000;}
        $hinn_gold=int($mmaxhp+$mmaxmp+$mstr+$mvit+$mint+$mdex+$mfai+$magi)*5000;
	if($hinn_gold<1000000){$hinn_gold=1000000;}
	if($mgold<$hinn_gold){&error("所持金不足。")};
	$mgold-=$hinn_gold;

	$mmaxmaxhp = $mmaxstr*5 + $mmaxvit*10 + $mmaxmen*3 - 2000;
	$mmaxmaxmp = $mmaxint*5 + $mmaxmen*3 - 800;

	$hpup = 250 + int(rand(251));
	$mpup = 120 + int(rand(121));

	$mmaxhp += $hpup;
	$mmaxmp += $mpup;
			
	if($mmaxhp>$mmaxmaxhp){$mmaxhp=$mmaxmaxhp;}
	if($mmaxmp>$mmaxmaxmp){$mmaxmp=$mmaxmaxmp;}
        if($marmno eq"mix" && $mele eq $marmele){$mmaxhp+=1000;}
        if($mprono eq"mix" && $mele eq $mproele){$mmaxhp+=1000;}
        if($maccno eq"mix" && $mele eq $maccele){$mmaxmp+=1000;}
	$town_gold+=int($hinn_gold/((1500-$town_ind)/250));

	&town_input;
	
	&header;
	
	print <<"EOF";
<table border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">高級旅館</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc"><font color=lightblue>$mname</font>於高級旅館住了一晚。<br><font color=green>ＨＰ</font>最大值增加<font color=yellow>$hpup</font>、<font color=green>ＭＰ</font>最大值增加<font color=yellow>$mpup</font>。</font></td>
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
