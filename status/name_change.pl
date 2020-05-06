
sub name_change {
	require './conf_pet.cgi';
	&chara_open;
	&header;
	&status_print;
	&equip_open;
	$rename_gold=10000000;
	if ($marmno eq"mix"){
		$armradio="<input type=\"radio\" value=\"2\" name=\"changeitem\">更改「<font color=blue>$marmname</font>」名稱（２～８文字）<BR>";
	}
        if ($mprono eq"mix"){
                $proradio="<input type=\"radio\" value=\"3\" name=\"changeitem\">更改「<font color=blue>$mproname</font>」名稱（２～８文字）<BR>";
        }
        if ($maccno eq"mix"){
                $accradio="<input type=\"radio\" value=\"4\" name=\"changeitem\">更改「<font color=blue>$maccname</font>」名稱
（２～８文字）<BR>";
        }

        if ($mpetname ne""){
		$peti=49;
		$pethit=0;
		for($peti=49;$peti<77;$peti++){
			if($PETDATA[$peti][0] eq $mpetname && $mpetlv eq"10"){
				$pethit=1;
				last;	
			}
		}
		$peti=0;
		$pethit2=0;
		if($pethit ne 1){
			foreach(@PETDATA){
	                        if($PETDATA[$peti][0] eq $mpetname){
                                	$pethit2=1;
                        	        last;
                	        }
        	                $peti++;
	                }

		}
		if($pethit eq 1 || $pethit2 eq 0){
                	$petradio="<input type=\"radio\" value=\"5\" name=\"changeitem\">更改「<font color=blue>$mpetname</font>」名稱（２～８文字）<BR>";
		}
        }


	print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">改名神殿</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/palace2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">在這裏，你可以修改你的名字或寵物及特武的名字<BR>(一次只能改一樣,請把要改名的寵物或自製武器拿著)。<BR>寵物只可修改終階10級寵。<BR>改命需要花費你手中的５０００萬。<BR>請輸入你想要修改的名稱。</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
	$STPR 
	<form action="./status.cgi" method="post">
<input checked type="radio" value="1" name="changeitem">更改角色名稱（２～８文字）<BR>
$armradio
$proradio
$accradio
$petradio
<INPUT type=text size=20 name=rname><BR>

	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=name_change2>
	<INPUT type=submit value=確定改名 CLASS=FC></form>
$BACKTOWNBUTTON
    </TD>
    </TR>
  </TBODY>
</TABLE>
<center></center>
EOF

	&footer;
	exit;
}
1;
