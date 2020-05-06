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
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">高級旅館</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=lightblue>$mname</font>於高級旅館住了一晚。<BR><font color=green>ＨＰ</font>最大值增加<font color=yellow>$hpup</font>、<font color=green>ＭＰ</font>最大值增加<font color=yellow>$mpup</font>。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
