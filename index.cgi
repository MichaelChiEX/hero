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
	$mapl.="<b><font color=$FCOLOR>●$MA[$m]</font></b><br>";
	$m++;
}
$m=0;
open(IN,"./data/maplog9.cgi");
@SYL = <IN>;
close(IN);
foreach(@SYL){
        $mapsys.="<b><font color=$FCOLOR>●$SYL[$m]</font></b><br>";
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
<center>
<table border="0" width="700" cellspacing="5">
  <tbody>
    <tr>
      <td colspan="2" width="696" align="center"><font style="font-size:40px" font color="#ffff99">$TITLE</font><br><font color=ffffcc>★最大上線人數：$LMAX人<br></td>
    </tr>
    <tr>
      <td colspan="2" width="696" height="25" align="center">
	<font style="font-size:15px" font color="#ffff99">
	$print
	</td>
    </tr>

    <tr>
      <td colspan="2" bgcolor="#ffff99" width="696" height="23" align="left"><font style="font-size:15px" color="#666600">目前線上人員($player人)：$glist</font></td>
    </tr>
    <tr>
      <td colspan="2" id="Layer1" valign=top><font style="font-size:15px" color="#666600"><b><系統公告></b><br>$mapsys</font><br><font size=1>[Total $count Hit]</font></td>
    </tr>
    <tr>
      <td colspan="2" id="Layer1" valign=top><font style="font-size:15px" color="#666600"><b><最新情報></b><br>$mapl</font></td>
    </tr>
  </tbody>
</table>
<br>
</center>
EOF

&mainfooter;
exit;
