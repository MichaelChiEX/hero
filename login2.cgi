#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';
&decode;

#重複チェック

open(IN,"./data/guest_list.cgi");
@gue = <IN>;
close(IN);
$guest=@gue;

if ($in{'id'} ne $GMID){
    if($guest>$LMAX){&error2("目前參加人數已達系統上線。");}
}

$login=1;
&chara_open;
#重複チェック
if ($in{'id'} ne $GMID && $memberhit ne"1"){
    foreach(@gue) {
		($gname,$gtime,$gcon,$ghost,$gid)=split(/<>/);
		if($gname ne $mname && $ghost eq $mhost){
			&maplog3("[重複]$mname與$gname ＩＰ相同，被系統禁止登入。");
			&error2("重複IP無法同時登入");
		}
	}
}

open(IN,"./data/country.cgi");
@CON_DATA = <IN>;
close(IN);
foreach(@CON_DATA){
    ($con_id,$con_name,$con_ele,$con_gold,$con_king,$con_yaku,$con_cou,$con_mes,$con_etc)=split(/<>/);
    if("$con_id" eq "$mcon"){$hit=1;last;}
}
if(!$hit){
    $mcon=0;
}

&chara_input;

&header;
print <<"EOF";
<br>
<br>
<center>
<form action="top.cgi" method="POST" target="main">
<table border="0" width="400" CLASS=FC>
  <tbody>
    <tr>
      <td bgcolor=$FCOLOR colspan=2 align=center><font size=3 color=$FCOLOR2>認證完成$com</font></td>
    </tr>
    <tr>
      <td colspan="2" align=center>
	<input type=hidden name=id value=$mid>
    	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=submit CLASS=FC value=$com2進入遊戲></td>
    </tr>
  </tbody>
</table>
</center>
</form>
EOF
&mainfooter;
exit;
