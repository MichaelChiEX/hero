#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';

&decode;
&host_name;

if($CHARA_ENT){&error2("目前無法再新建帳號。");}
if($in{'id'} eq ""){&error2("請輸入帳號!");}
if ($in{'name'} =~ / / || $in{'name'} =~ /GM/ || $in{'name'} =~ /ＧＭ/ || $in{'name'} =~/,/) {&error("名字中請不要出現空格豆號或ＧＭ等字樣。"); }
if($in{'pass'} eq $in{'id'}){&error2("帳號與密碼不可一樣!");}
if($in{'pass'} eq ""){&error2("請輸入密碼!");}
if(length($in{'id'}) < 4||length($in{'id'}) > 8){&error2("帳號請使用４～８個半形字");}
if(length($in{'pass'}) < 4||length($in{'pass'}) > 8){&error2("密碼請使用４～８個半形字");}
if($in{'id'} eq $in{'pass'}){&error2("帳號與密碼不可一樣!"); }	
if ($in{'id'} =~ m/[^0-9a-zA-Z]/) {&error2("帳號請使用半形文字"); }
if ($in{'pass'} =~ m/[^0-9a-zA-Z]/) {&error2("密碼請使用半形文字"); }
if($in{'name'} eq ""){&error2("請輸入角色名稱");}
if(length($in{'name'}) < 4||length($in{'name'}) > 32){&error2("角色名稱請使用全形２～８個字(或半形４～１６個字)");}
if($in{'sex'} eq ""){&error2("請選擇性別。");}
if($in{'img'} eq ""){&error2("請選擇角色圖案。");}
if($in{'ele'} eq ""){&error2("請選擇屬性。");}
if ($in{'mail'} eq "" || $in{'mail'} !~ /(.*)\@(.*)\.(.*)/){&error2("你的Email輸入有誤");}
if ($in{'mail'} ne $in{'mailconfirm'}){&error2("你的Email兩次輸入不一致");}

$dir="./logfile/chara";
opendir(dirlist,"$dir");
while($file = readdir(dirlist)){
    if($file =~ /\.cgi/i){
        if(open(cha,"$dir/$file")){
            @cha = <cha>;
            close(cha);
            ($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
            if($rname eq $in{'name'}){closedir(dirlist);&error2("「$rname」已被其他玩家使用");}
        }
    }
}	
$id=$in{'id'};
$pass=$in{'pass'};
$hp=50;$mp=10;$str=20;$vit=20;$int=20;
$dex=20;$agi=20;$fai=20;
$gold=50;$ex=0;$cex=0;$bank=0;
$arm="0,新手木劍,0,0,0,0,80,10,0,0,0";
$pro="0,新手布衣,0,0,0,0,80,10,0,0,0";
$acc="0,新手指輪,0,0,0,0,80,10,0,0,0";
$tac="0,0,0,50,50";
$max="200,200,200,200,200,200";
$class=0;$kati=0;$total=0;$pos=0;
$pet="";
$date = time();

$con_id="0";
$con_name="無所屬";

$dir="./logfile/chara";
opendir(dirlist,"$dir");
while($file = readdir(dirlist)){
	if($file =~ /\.cgi/i){
		if(!open(chara,"$dir/$file")){
			&error("$dir/$file 找不到檔案。<br>\n");
		}
		@chara = <chara>;
		close(chara);
		$list[$i]="$file";
		($eid,$epass,$ename,$eurl,$echara,$esex,$ehp,$emaxhp,$emp,$emaxmp,$eele,$estr,$evit,$eint,$efai,$edex,$eagi,$emax,$ecom,$egold,$ebank,$eex,$etotalex,$ejp,$eabp,$ecex,$eunit,$econ,$earm,$epro,$eacc,$etec,$esta,$epos,$emes,$ehost,$edate,$esyo,$eclass,$etotal,$ekati,$etype,$eoya,$eaup,$eflg,$eflg2,$eflg3,$eflg4,$eflg5,$epet) = split(/<>/,$chara[0]);
	
		if($DOUBLE eq "1" && $ehost eq"$host"){
			&maplog3("<font color=red>[重複]</font><font color=blue>$in{'name'}</font>與<font color=blue>$ename</font>疑似為同一人。");
			&error2("同一個人無法建立兩個建號。");
		}
		if($eflg4 eq"$in{'mail'}"){&error2("你輸入的Email已被申請");}
		if($ename eq"$in{'name'}"){&error2("你輸入的角色名稱已被申請");}
		if($eid eq"$in{'id'}"){&error2("你輸入的帳號已被申請。");}
		
	}
}
closedir(dirlist);

unshift(@CHARA_DATA,"$id<>$pass<>$in{'name'}<><>$in{'img'}<>$in{'sex'}<>$hp<>$hp<>$mp<>$mp<>$in{'ele'}<>$str<>$vit<>$int<>$fai<>$dex<>$agi<>$max<><>$gold<>$bank<>0<>0<>0<>0<>$cex<><>$con_id<>$arm<>$pro<>$acc<>$tac<>$sta<>$pos<>$mes<>$host<>$date<>$date<>$class<>$total<>$kati<>0<><><>1<><><>$in{'mail'}<><>$pet<>\n");

open(OUT,">./logfile/chara/$in{'id'}.cgi") or &error2('建立失敗：角色檔案無法寫入。');
print OUT @CHARA_DATA;
close(OUT);

&kh_log("成為$con_name國的國民。",$con_name);
&maplog("<font color=999933>[新進]</font>歡迎<font color=333399>$in{'name'}</font>加入了「$con_name國」</font>。");

&header;
print <<"EOF";
<p align="center">
    <br>登錄完成
</p>
<center>
    <table border="0" width="415" height="67" bgcolor="#990099">
        <tbody>
            <tr>
                <td bgcolor="#660066" colspan="3" align="center"><font color="#ffffcc">登錄情報</font></td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc">角色名稱</td>
                <td bgcolor="#ffffcc">$in{'name'}</td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc">帳號</td>
                <td bgcolor="#ffffcc">$id</td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc">密碼</td>
                <td bgcolor="#ffffcc">$pass</td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc">所屬國家</td>
                <td bgcolor="#ffffcc">$con_name</td>
            </tr>
            <tr>
                <td colspan="3" bgcolor="#ffcc99"><font color="#993399">帳號已新建完成。<br>
                請記得你的帳號及密碼。<br>
                </td>
            </tr>
            <tr>
                <td colspan="3" align=center bgcolor="#ffcc99">
                    <form action="./top.cgi" method="POST">
                        <input type=hidden name=id value=$in{'id'}>
                        <input type=hidden name=pass value=$in{'pass'}>
                        <input type=submit CLASS=FC value=進入遊戲>
                    </form>
                </td>
            </tr>
        </tbody>
    </table>
</center>

EOF

&mainfooter;
exit;
