#!/usr/bin/perl

#################################################################
#   【免責事項】                                                #
#    このスクリプトはフリーソフトです。このスクリプトを使用した #
#    いかなる損害に対して作者は一切の責任を負いません。         #
#    また設置に関する質問はサポート掲示板にお願いいたします。   #
#    直接メールによる質問は一切お受けいたしておりません。       #
#################################################################

require './sub.cgi';
require './conf.cgi';

if($MENTE) { &error2("資料載入中。請稍等。"); }
&decode;
#if($ENV{'HTTP_REFERER'} !~ /i/ ){ &error2("アドレスバーに值を入力しないでください。"); }
&town_print;

#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/#
#        全 街 情 報 表 示       #
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/#

sub town_print {

	open(IN,"./data/towndata.cgi");
	@T_LIST = <IN>;
	close(IN);

	open(IN,"./data/country.cgi") or &error2('檔案開案失敗town_print.cgi(30)。');
	@COU_DATA = <IN>;
	close(IN);
	$country_no=1;
	foreach(@COU_DATA){
		($xxcid,$xxname,$xxele,$xxgold,$xxking,$xxyaku,$xxcou,$xxmes,$xxetc)=split(/<>/);
		$country_name[$xxcid]="$xxname";
		$country_no++;
		$c_ele[$xxcid] = $xxele; 
	}

	&header;

	print <<"EOM";
<table WIDTH="100%" CLASS=TC>
  <tbody>
    <tr>
      <th BGCOLOR=$TD_C2 height=5>都市名稱</th>
      <th BGCOLOR=$TD_C1 height=5>所屬國</th>
      <th BGCOLOR=$TD_C1 height=5>所在</th>
      <th BGCOLOR=$TD_C4 height=5>收益金</th>
      <th BGCOLOR=$TD_C3 height=5>屬性</th>
      <th BGCOLOR=$TD_C2 height=5>武器開發</th>
      <th BGCOLOR=$TD_C1 height=5>防具開發</th>
      <th BGCOLOR=$TD_C4 height=5>飾品開發</th>
      <th BGCOLOR=$TD_C3 height=5>產業值</th>
      <th BGCOLOR=$TD_C3 height=5>要塞</th>

    </tr>
EOM

	$town_c0=0;$town_c1=0;$town_c2=0;$town_c3=0;
	foreach(@T_LIST){
		($zcid,$zname,$zcon,$zele,$zmoney,$zarm,$zpro,$zacc,$zind,$zs,$ztr,$zx,$zy,$zbuild,$zetc)=split(/<>/);
		($town_hp,$town_max,$town_str,$town_def,$town_dex,$town_flg)=split(/,/,$zetc);
		$TOWN_NAME[$zcid]="$zname";
		$wc_ele = $c_ele[$zcon];
print <<"EOM";
<tr>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5 align=center><b><font color=$ELE_BG[$wc_ele]>$zname</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5 align=center><font color=$ELE_BG[$wc_ele]>$country_name[$zcon] 國</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5><font color=$ELE_BG[$wc_ele]>$zx-$zy</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5 align=right><font color=$ELE_BG[$wc_ele]>$zmoney GOLD</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5><font color=$ELE_BG[$wc_ele]>$ELE[$zele]</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5><font color=$ELE_BG[$wc_ele]>$zarm</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5><font color=$ELE_BG[$wc_ele]>$zpro</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5><font color=$ELE_BG[$wc_ele]>$zacc</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5><font color=$ELE_BG[$wc_ele]>$zind</td>
      <td BGCOLOR=$ELE_C[$wc_ele] height=5><font color=$ELE_BG[$wc_ele]>$town_hp/$town_max</td>
      
</tr>
EOM
	}

print <<"EOM";
  </tbody>
</table>
EOM

	&mainfooter;

	exit;
}
