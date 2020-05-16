#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';

&decode;

if($CHARA_ENT){&error2("目前無法建立帳號。");}

$elelist="<option>-請選擇角色屬性-</option>";
for($i=0; $i<=$#ELE; $i++){
    $elelist.="<option value=$i>$ELE[$i]</option>";
}

$chara_list="";
for($i=1; $i<=$CHARAIMG; $i++){
    $chara_list.="<option value='$i'>圖案[$i]</option>";
}

&header;
print <<"EOF";
<script>
function changeImg(obj){
  	document.Img.src="$IMG/chara/"+ obj.value +".gif";
}
</script>
<center>
<form action="./chara_make.cgi" name=para method="POST">
<table border="0" width="700" height="500" class=TC>
    <tbody>
        <tr>
            <td colspan="2" bgcolor="$FCOLOR" align="center"><font size="+2"><b><font color="#ffffcc" size="+2">建立新的角色</font></b></font></td>
        </tr>
        <tr>
            <td colspan="2" bgcolor="#ffffcc">※建立你的角色。<br>
            ※請特別注意:帳號、密碼、電子郵件請輸入正確。輸入錯誤將造成無法登入。<br>
            <font color=red>※禁止開分身,若發現開分身,將會被禁止登入遊戲。</font>
            </td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">角色名稱</td>
            <td bgcolor="#ffffcc"><input size=30 name=name><br>
            ※請使用全形２～８個字(或半形４～１６個字)</td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">帳號</td>
            <td bgcolor="#ffffcc"><input size=20 name=id><br>
            ※帳號請使用４～８個半形字</td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">密碼</td>
            <td bgcolor="#ffffcc"><input type=password size=20 name=pass><br>
            ※密碼請使用４～８個半形字</td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">Email</td>
            <td bgcolor="#ffffcc"><input type=text size=20 name=mail value=@><br>
            ※請輸入你的Email $mailcom</td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">Email（確認用）</td>
            <td bgcolor="#ffffcc"><input type=text size=20 name=mailconfirm value=@><br>
            ※請再度輸入你的Email。</td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">角色圖案</td>
            <td bgcolor="#ffffcc">
                <img src=\"$IMG/chara/1.gif\" name=\"Img\"><br>
                <select name=img onChange="changeImg(this)">
                    $chara_list
                </select><br>請選擇角色的圖案。
            </td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">性別</td>
            <td bgcolor="#ffffcc"><select name="sex"><option value="0">男性<option value="1">女性</select></td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc">屬性</td>
            <td bgcolor="#ffffcc"><select name=ele>$elelist</select></td>
        </tr>
        <tr>
            <td colspan="2" bgcolor="#ffffcc" align="center"><input type="submit"CLASS=FC value="建立角色"></td>
        </tr>
    </tbody>
</form>
</table>
</center>
EOF

&mainfooter;
exit;

