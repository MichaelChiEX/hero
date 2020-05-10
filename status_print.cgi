#!/usr/bin/perl

#################################################################
#   【免責事項】                                                #
#    このスクリプトはフリーソフトです。このスクリプトを使用した #
#    いかなる損害に対して作者は一切の責任を負いません。         #
#    また設置に関する質問はサポート掲示板にお願いいたします。   #
#    直接メールによる質問は一切お受けいたしておりません。       #
#################################################################

require './conf.cgi';
require './sub.cgi';

&decode;

$open_chara_id = decrypt($in{'id'});
$no_idle_check=1;
&chara_open;
&equip_open;

open(IN,"./data/ability.cgi");
@ABILITY = <IN>;
close(IN);

%ability_map=();
foreach(@ABILITY){
    ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
    $ability_map{$abno} = $abname;
}

%ab_hash = (arm=>$marmsta, pro=>$mprosta, acc=>$maccsta,pet=>$mpetsta);
while (($key, $value) = each(%ab_hash)) {
    @sk=split(/:/, $value);
    $abname = join("、", map{$ability_map{$_}} @sk);
    if($abname eq""){$abname="－";}
    $ab_hash{$key}=$abname;
}

if($mpetname ne""){
    $showpetname="$mpetname($ELE[$mpetele]).lv$mpetlv";
    $showpetval="<font size=2>威力:$mpetdmg<BR>防禦:$mpetdef<BR>速度:$mpetspeed</font>";
}

open(IN,"./logfile/prof/$mid.cgi");
@PROF_DATA = <IN>;
close(IN);
$com1="@PROF_DATA";

open(IN,"./data/country.cgi") or &error2('資料開啟錯誤。err no :country');
@COU_DATA = <IN>;
close(IN);

foreach(@COU_DATA){
    ($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
    if("$con2_id" eq "$mcon"){$hit=1;last;}
}

if(!$hit){
    $con2_id=0;
    $con2_name="無所屬";
    $con2_ele=0;
}

open(IN,"./logfile/history/$mid.cgi");
@HIS_DATA = <IN>;
close(IN);

$history="
    <table bgcolor=$ELE_BG[$con2_ele] width=100%>
        <tr>
            <td><font color=ffffff>所屬</font></td>
            <td><font color=ffffff>時間</font></td>
            <td><font color=ffffff>紀錄</font></td>
        </tr>";

foreach(@HIS_DATA){
    ($hcom,$hcon,$htime)=split(/<>/);
    $history.="
        <tr>
            <td bgcolor=$ELE_C[$con2_ele]>$hcon國</td>
            <td bgcolor=$ELE_C[$con2_ele] width=15%>$htime</td>
            <td bgcolor=$ELE_C[$con2_ele]>$hcom</td>
        </tr>";
}
$history.="</table>";

&header;

print <<"EOM";
<table border="0" width="80%" bgcolor="#000000" align=center>
    <tbody>
        <tr>
            <td colspan="7" bgcolor="$ELE_BG[$con2_ele]" align="center">
                <font color=ffffff>【$mname的基本資料】</font>
            </td>
        </form>
        </tr>
        <tr>
            <td bgcolor="$ELE_C[$con2_ele]" rowspan="5" width=10%><img src="$IMG/chara/$mchara.gif"></td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>所屬國</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$con2_name國</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>屬性</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$ELE[$mele]</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>職業</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$JOB[$mclass]</td>
        </tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>LV</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mlv</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>HP</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mhp/$mmaxhp</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>MP</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mmp/$mmaxmp</td>
        </tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>力</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mstr</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>生命</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mvit</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>智力</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mint</td>
        </tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>精神</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mfai</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>運氣</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mdex</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>速度</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$magi</td></tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>戰績</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mtotal戰$mkati勝</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>名聲</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mcex</td>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>擊倒人數</font></td>
            <td bgcolor="$ELE_C[$con2_ele]">$mflg2人</td>
        </tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>武器</font></td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=3>$marmname($ELE[$marmele])</td>
            <td bgcolor="$ELE_C[$con2_ele]" align=center>$ab_hash{arm}</td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=2 align=right>$marmdmg/$marmwei</td>
        </tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>防具</font></td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=3>$mproname($ELE[$mproele])</td>
            <td bgcolor="$ELE_C[$con2_ele]" align=center>$ab_hash{pro}</td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=2 align=right>$mprodmg/$mprowei</td>
        </tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>飾品</font></td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=3>$maccname($ELE[$maccele])</td>
            <td bgcolor="$ELE_C[$con2_ele]" align=center>$ab_hash{acc}</td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=2 align=right>$maccdmg/$maccwei</td>
        </tr>
        <tr>
            <td bgcolor="$ELE_BG[$con2_ele]"><font color=$ELE_C[$con2_ele]>寵物</font></td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=3>$showpetname</td>
            <td bgcolor="$ELE_C[$con2_ele]" align=center>$ab_hash{pet}</td>
            <td bgcolor="$ELE_C[$con2_ele]" colspan=2 align=right>$showpetval</td>
        </tr>
        <tr>
            <td colspan="7" bgcolor="$ELE_BG[$con2_ele]"><FONT color="$ELE_C[$con2_ele]">$mname的自傳</FONT></td>
        </tr>
        <tr>
            <td colspan="7" bgcolor="$ELE_C[$con2_ele]">$com1</td>
        </tr>
        <tr>
            <td colspan="7" bgcolor="$ELE_BG[$con2_ele]"><FONT color="$ELE_C[$con2_ele]">$mname的經歷</FONT></td>
        </tr>
        <tr>
            <td colspan="7" bgcolor="$ELE_C[$con2_ele]">$history</td>
        </tr>
    </tbody>
</table>
EOM

&mainfooter;
exit;


#----------------------#
#  パスワード照合處理  #
#----------------------#
sub decrypt {
	local($inpw) = @_;
	$encrypt = reverse($inpw);
	@dec = split(/\,/,"$encrypt");
	$inpw = pack("C*", @dec);
	
	return $inpw;
}
