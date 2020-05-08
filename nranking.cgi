#! /usr/bin/perl
require './jcode.pl';
require './sub.cgi';
require './conf.cgi';

$dir="./logfile/ext";
opendir(dirlist,"$dir");
&time_data;
$i=0;
while($file = readdir(dirlist)){
    if($file =~ /\.cgi/i){
        $datames = "查詢：$dir/$file<br>\n";
        if(!open(cha,"$dir/$file")){
            &error("$dir/$file&#12364;&#12415;&#12388;&#12363;&#12426;&#12414;&#12379;&#12435;。<br>\n");
        }
        @cha = <cha>;
        close(cha);
        $list[$i]="$file";
        ($ext_storageadd,$vertime,$nowmap,$down_lv_limit,$member_point,$member_auto_sleep,$member_auto_savegold,$member_fix_time,$member_mix,$member_point_total,$ext_show_mode,$ext_kinghp,$ext_kingetc,$ext_robot_count,$ext_lock,$ext_mixs,$ext_total,$ext_q,$ext_r,$ext_s,$ext_t,$ext_u,$ext_v,$ext_w,$ext_x,$ext_y,$ext_z) = split(/<>/,$cha[0]);
        ($ext_tl_chara,$ext_tl_name,$ext_tl_month,$ext_tl_type[0],$ext_tl_type[1],$ext_tl_type[2],$ext_tl_type[3],$ext_tl_type[4],$ext_tl_type[5],$ext_tl_king,$ext_tl_lose,$ext_tl_lvup,$ext_tl_gift,$ext_tl_mix,$ext_tl_rshop,$ext_tl_goditem)=split(/,/,$ext_total);
        if ($ext_tl_month eq "$mon") {
            $ext_tl_total=$ext_tl_type[0]+$ext_tl_type[1]+$ext_tl_type[2]+$ext_tl_type[3]+$ext_tl_type[4]+$ext_tl_type[5];
            if ($ext_tl_total eq "" || $ext_tl_total eq "0"){$ext_tl_total=1;}
            if($ext_tl_gift eq "0" || $ext_tl_gift eq ""){
                    $ext_tl_nolucky=0.5 / $ext_tl_total; 
            }else{
                    $ext_tl_nolucky=$ext_tl_gift / $ext_tl_total; 
            }
            $ext_tl_nolucky=1/$ext_tl_nolucky;
            push(@CL_DATA,"$ext_tl_chara<>$ext_tl_name<>$ext_tl_month<>$ext_tl_type[0]<>$ext_tl_type[1]<>$ext_tl_type[2]<>$ext_tl_type[3]<>$ext_tl_type[4]<>$ext_tl_type[5]<>$ext_tl_king<>$ext_tl_lose<>$ext_tl_lvup<>$ext_tl_total<>$ext_tl_gift<>$ext_tl_mix<>$ext_tl_rshop<>$ext_tl_goditem<>$ext_tl_nolucky<>\n");
        }
    }
    if($mn>10000){&error("&#12523;&#12540;&#12503;");}
    $mn++;
}
closedir(dirlist);

@fields_idx = (13, 14, 15, 16, 17, 12, 9, 11, 10, 3, 4, 5, 6, 7, 8);
@sort_names = (
    "打寶之王", "原料之王", "魔女最愛", "神武之王", "壞運之王", "總戰數之王", "砍王之王", "升級之王", "戰敗之王", 
    "$TYPE[0]之王", "$TYPE[1]之王", "$TYPE[2]之王", "$TYPE[3]之王", "$TYPE[4]之王", "$TYPE[5]之王"
);

for($i=0;$i<15;$i++){
    $con_table[$i] = "
        <table CLASS=FC>
            <tr>
                <td colspan=4 align=center bgcolor=$ELE_BG[$con_ele]><font color=$FCOLOR2 size=5><b>$sort_names[$i]</b></font></td>
            </tr>
            <tr>
                <td width=25% CLASS=TC><font color=$FCOLOR2>順位</font></td><td width=25% CLASS=TC><font color=$FCOLOR2>名稱</font></td>
                <td width=25% CLASS=TC><font color=$FCOLOR2>頭像</font></td><td width=25% CLASS=TC><font color=$FCOLOR2>數值</font></td>
            </tr>";

    @sort_values = map {(split /<>/)[@fields_idx[$i]]} @CL_DATA;
    @sorted_cl_data = @CL_DATA[sort {@sort_values[$b] <=> @sort_values[$a]} 0..$#CL_DATA];
    for($n=0; $n<=10 && $n <= $#sorted_cl_data; $n++){
        @fields = split(/<>/, $sorted_cl_data[$n]); 
        $value = @fields[@fields_idx[$i]];
        $ext_tl_chara = @fields[0];
        $ext_tl_name = @fields[1];

        $rank = $n + 1;
        if ($rank eq 1) {
            $rank_field = "<font color=red size=4><b>★$rank位</b></font>";
            $value_field = "<font color=red size=4><b>$value</b></font>";
        }
        elsif ($rank < 4) {
            $rank_field = "<font color=blue size=3><b>$rank位</b></font>";
            $value_field = "<font color=blue size=3><b>$value</b></font>";
        }else{
            $rank_field = "$rank位";
            $value_field = $value;
        }
        $con_table[$i] .= "
            <tr>
                <td bgcolor=$ELE_C[$con_ele[0]] size=2>$rank_field</td>
                <td bgcolor=$ELE_C[$con_ele[0]] size=2>$ext_tl_name</td>
                <td bgcolor=$ELE_C[$con_ele[0]]><img width=35 height=35 src=\"$IMG/chara/$ext_tl_chara.gif\"></td>
                <td bgcolor=$ELE_C[$con_ele[0]]>$value_field</td>
            </tr>";
    }
    $con_table[$i] .= "</table>";
}

&header;
print"<table CLASS=TC width=100%><td align=center><font color=$FCOLOR2 size=4>本月戰數排名</font></td></table><BR>";
print"<center><a href=./jranking.cgi><font color=#FFFFFF><b>其他排名</b></font></a></center>";
print"<table colspan=5>";
for($i=0;$i<15;$i++){
        if($i%5 eq 0){
                print"<tr><td>$con_table[$i]</td>";
        }elsif($i%5 eq 4){
                print"<td>$con_table[$i]</td></tr>";
        }else{
                print"<td>$con_table[$i]</td>";
        }
}
print"</table>";
print"<center><font color=yellow>遊戲人數：$mn名</font></center><BR>";
&mainfooter;

exit;

