#! /usr/bin/perl
require './jcode.pl';
require './sub.cgi';
require './conf.cgi';
&decode;

@SNAME = ("系統公告", "使用紀錄", "警告紀錄", "改名紀錄", "打寶紀錄", "傳送紀錄", "寵物轉生紀錄", "鐵匠注入奧義紀錄", "任務紀錄", "外掛紀錄");
@SFILE = ("maplog9", "maplog4", "maplog3", "maplog6", "maplog7", "maplog8", "maplog10", "maplogmix", "questlog", "robotlog");

$logid=$in{'id'};
if($logid eq ""){
    $logid="0";
}

open(IN,"./data/@SFILE[$logid].cgi");
@MA = <IN>;
close(IN);

foreach $m(@MA){
    $mapl.="<b><font color=$FCOLOR>●$m</font></b><br>";
}
for($i=0;$i<10;$i++){
	$mapmenu.="<a href=./syslog.cgi?id=$i>@SNAME[$i]</a>　";
}

&header;
print <<"EOF";
<center>
<table border="0" bgcolor="#660033" width="700" cellspacing="5" height="509">
  <tbody>
    <tr>
        <td colspan="2" bgcolor="#ffffcc" height="1" align="center">
            $mapmenu
        </td>
    </tr>
    <tr>
      <td colspan="2" bgcolor="#ffffcc"><font style="font-size:15px" color="#666600"><@SNAME[$logid]><br>$mapl</font><br></td>
    </tr>
  </tbody>
</table>
<BR>
</P>
</center>
<hr>
EOF
&mainfooter;
exit;
