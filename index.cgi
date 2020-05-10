#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';
&decode;
&header;

open(IN,"./data/count.cgi");
@counter = <IN>;
close(IN);

($count)=split(/<>/,$counter[0]);
$count++;

@N_COUNT=();
unshift(@N_COUNT,"$count<>\n");
open(OUT,">./data/count.cgi");
print OUT @N_COUNT;
close(OUT);


open(IN,"./data/guest_list.cgi");
@gue = <IN>;
close(IN);

foreach(@gue){
	($fname,$ftime,$fcon,$fhost)=split(/<>/);
	$glist.="<font color=$ELE_BG[$gcon]>★$fname</font>";
}
$player=@gue;

open(IN,"./data/maplog.cgi");
@MA = <IN>;
close(IN);
foreach(@MA){
	$mapl.="<b><font color=$FCOLOR>●$MA[$m]</font></b><BR>";
	$m++;
}
$m=0;
open(IN,"./data/maplog9.cgi");
@SYL = <IN>;
close(IN);
foreach(@SYL){
        $mapsys.="<b><font color=$FCOLOR>●$SYL[$m]</font></b><BR>";
        $m++;
	if ($m>8){last;}
}


$print.="<a href=\"entry.cgi\"><font color=ffffcc>[建立帳號]</font></a>　";
$print.="<a href=\"login.cgi\"><font color=ffffcc>[繼續遊戲]</font></a>　";
$print.=&menu();
$print.="<a href=\"/del_chara.html\"><font color=ffffcc>[刪除分身]</font></a>　";

print <<"EOF";
<style type="text/css">
#Layer1 {
    background-color: #ffffcc;
}
</style>
<CENTER>
<TABLE border="0" width="700" cellspacing="5">
  <TBODY>
    <TR>
      <TD colspan="2" width="696" align="center"><FONT style="font-size:40px" font color="#ffff99">$TITLE</FONT><BR><font color=ffffcc>★最大上線人數：$LMAX人<BR></TD>
    </TR>
    <TR>
      <TD colspan="2" width="696" height="25" align="center">
	<FONT style="font-size:15px" font color="#ffff99">
	$print
	</TD>
    </TR>

    <TR>
      <TD colspan="2" bgcolor="#ffff99" width="696" height="23" align="left"><FONT style="font-size:15px" color="#666600">目前線上人員($player人)：$glist</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" id="Layer1" valign=top><FONT style="font-size:15px" color="#666600"><b><系統公告></b><BR>$mapsys</FONT><BR><font size=1>[Total $count Hit]</font></TD>
    </TR>
    <TR>
      <TD colspan="2" id="Layer1" valign=top><FONT style="font-size:15px" color="#666600"><b><最新情報></b><BR>$mapl</FONT></TD>
    </TR>
  </TBODY>
</TABLE>
<BR>
</CENTER>
EOF

&mainfooter;
exit;
