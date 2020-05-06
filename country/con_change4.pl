sub con_change4{
	&chara_open;
	&con_open;
	&town_open;
	&equip_open;
	if($con_id eq 0){&error("你已經是無屬國，無法再下野了。");}
	if($munit ne ""){&error("請先離開你的隊伍。");}
	if($con_king eq"$mid"){&error("你現在的身份是國王，無法下野。");}
	$mgold-=5000000;
	if($mgold<0){&error("身上的現金不足５００萬。");}
	#解除守備
        open(IN,"./data/def.cgi");
        @DEF = <IN>;
        close(IN);
        $hit=0;
        @NDEF=();
        foreach(@DEF){
                ($name,$id,$pos)=split(/<>/);
                if($id eq "$mid"){$hit=1;}
                else{push(@NDEF,"$_");}
        }
        if($hit){
                open(OUT,">./data/def.cgi");
                print OUT @NDEF;
                close(OUT);
        }
	$mcon=0;
	$mcex=0;
	$mhp=50;$mmaxhp=50;
	$mmp=30;$mmaxmp=30;
	$mstr=30;$mvit=30;
	$mint=30;$mfai=30;
	$mdex=30;$magi=30;
	$mex=0;
	if($marmno eq"mix" && $marmele eq $mele){$mmaxhp+=1000;}	
        if($mprono eq"mix" && $mproele eq $mele){$mmaxhp+=1000;}
        if($maccno eq"mix" && $maccele eq $mele){$mmaxmp+=1000;}
	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">下野</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">你已經成功下野，成為無所屬國民。</FONT></TD>
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
	&maplog("<font color=black>[下野]</font><font color=blue>$mname</font>離開了原有的國家，成為無所屬國民。");
	&kh_log("下野成為無所屬國民。","無所屬");

	&footer;
	exit;
}
1;
