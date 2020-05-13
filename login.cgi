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
<br>
<br>
<center>
<form action="login2.cgi" method="POST">
<table border="0" width="400" CLASS=FC>
  <tbody>
    <tr>
      <td bgcolor=$FCOLOR colspan=2 align=center><font size=3 color=$FCOLOR2>登入畫面</font></td>
    </tr>
    <tr>
      <td width="56" align=right>帳號</td>
      <td width="46"><input type=text size=15 name=id></td>
    </tr>
    <tr>
      <td width="56" align=right>密碼</td>
      <td width="46"><input type=password size=15 name=pass></td>
    </tr>
    <tr>
      <td colspan="2" align=center><font color=red><b>使用簡體中文的玩家請注意，請在公頻或國頻發言時先將字體轉為繁體字再進行發言，感謝</b></font></td>
    </tr>
    <tr>
      <td colspan="2" align=center>[<a href=del_chara.html>刪除分身</a>]<br><font color=red><b>如果你的帳號無法登入,請先確認下方「紀錄」中的「外掛紀錄」是不是有自己的名字,如果有,表示已被砍帳號</td>
    </tr>
    <tr>
      <td colspan="2" align=center><input type=submit CLASS=FC value=登入></td>
    </tr>
  </tbody>
</table>
</center>
</form>
EOF
&mainfooter;
exit;
