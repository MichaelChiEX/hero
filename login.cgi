#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';
&decode;

open(IN,"./data/guest_list.cgi");
@gue = <IN>;
close(IN);

$guest=@gue;
if($guest>$LMAX){
    &error2("參加人數已達上限，負荷上限防止機置啟動!");
}


&header;
print <<"EOF";
<BR>
<BR>
<CENTER>
<form action="login2.cgi" method="POST">
<TABLE border="0" width="400" CLASS=FC>
  <TBODY>
    <TR>
      <TD bgcolor=$FCOLOR colspan=2 align=center><font size=3 color=$FCOLOR2>登入畫面</font></TD>
    </TR>
    <TR>
      <TD width="56" align=right>帳號</TD>
      <TD width="46"><input type=text size=15 name=id></TD>
    </TR>
    <TR>
      <TD width="56" align=right>密碼</TD>
      <TD width="46"><input type=password size=15 name=pass></TD>
    </TR>
    <TR>
      <TD colspan="2" align=center><font color=red><b>使用簡體中文的玩家請注意，請在公頻或國頻發言時先將字體轉為繁體字再進行發言，感謝</b></font></TD>
    </TR>
    <TR>
      <TD colspan="2" align=center>[<a href=del_chara.html>刪除分身</a>]<BR><font color=red><b>如果你的帳號無法登入,請先確認下方「紀錄」中的「外掛紀錄」是不是有自己的名字,如果有,表示已被砍帳號</TD>
    </TR>
    <TR>
      <TD colspan="2" align=center><input type=submit CLASS=FC value=登入></TD>
    </TR>
  </TBODY>
</TABLE>
</CENTER>
</form>
EOF
&mainfooter;
exit;
