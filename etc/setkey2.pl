sub setkey2{
        &header;
        &chara_open;
        if ($mbank<1000000){
        	&error_old("你的銀行不足１００萬，無法設定快速鍵");
        }
        &fixext_open;
        require './data/conf_fastkey.cgi';
        @nums=split(/,/,$in{'no'});
        for($i=0;$i<10;$i++){
        	$fixext_fkey[$i]="";
        }
        $i=0;
        foreach(@nums){
			if($_ ne ""){
				if ($key_class[$_] ne ""){
					$fixext_fkey[$i]=$key_class[$_].",".$key_cmd[$_].",".$key_name[$_];
					$i++;
					if($i>10){last;}
				}
			}
		}
		$mbank-=1000000;
		&fixext_input;
		&chara_input;

        print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">快速鍵設定</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">快回鍵設定完成</TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
        <form action="./top.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>

        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=submit CLASS=FC value=回到城鎮>
        </TD>
</form>
    </TR>
  </TBODY>
</TABLE>
EOF
        &chara_input;
        &footer;
        exit;
}
1;

