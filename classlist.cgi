#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';
&decode;
&header;

open(IN,"./data/ability.cgi");
@ABILITY = <IN>;
close(IN);

open(IN,"./data/class.cgi");
@CLASS_DATA = <IN>;
close(IN);

$JOBS[1]="1,2,3,4,5,6";
$JOBS[2]="7,8,9,10,11,12";
$JOBS[3]="17,18,19,20,22,21";
$JOBS[4]="23,24,25,26,28,27";
$JOBS[5]="13,14,15,16,29,30";
$JOBS[6]="31,32,33,34,35,36";

$ABDatas[0]="力";
$ABDatas[1]="命";
$ABDatas[2]="智";
$ABDatas[3]="精";
$ABDatas[4]="運";
$ABDatas[5]="速";
 
for($job_level=1;$job_level<7;$job_level++){
	if ($job_level <= 4){
		$title="$job_level";
	}elsif ($job_level eq 6){
		$title="5";
	}elsif ($job_level eq 5){
		$title="複合";
	}

	$ctable.="
	<p align=center><i><b><font size=4 color=#FFFFFF>$title階職</font></b></i></p>
	<table id=table6 cellSpacing=0 cellPadding=0 width=100% border=1 bgcolor=#FFFFFF>
		<tr>
			<td align=middle width=10% bgColor=#ccffff><b>系別</b></td>
			<td align=middle width=10% bgColor=#ccffff><b>名稱</b></td>
			<td align=middle width=30% bgColor=#ccffff><b>條件</b></td>
			<td align=middle width=15% bgColor=#ccffff>可習得奧義</td>
			<td align=middle width=35% bgColor=#ccffff>職業基本能力</td>
		</tr>";

	foreach $job_idx (split(/,/,$JOBS[$job_level])){
		($cname,$cjp,$cnou,$cup,$cflg,$ctype)=split(/<>/,$CLASS_DATA[$job_idx]);
		@cjp = split(/,/,$cjp);
		@cp = split(/,/,$cnou);
		@cu = split(/,/,$cup);

		@uplimit=(); @uplimit2=();
		#熟練、屬性條件
		for($i=0; $i<=5; $i++){
			if (@cjp[$i]>0) {
				push(@uplimit, "$TYPE[$i]:@cjp[$i]");
			}
			if (@cp[$i]>0) {
				push(@uplimit2, "$ABDatas[$i]:@cp[$i]");
			}
		}

		#奧義
		@clname=();
		foreach(@ABILITY){
			($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
			if($job_idx eq $abclass) {
				push(@clname, $abname);
			}
		}

		$uplimit = join("、", @uplimit);
		$uplimit2 = join("、", @uplimit2);
		$clname = join("、", @clname);

		if($clname eq""){
			$clname="「沒有專屬奧義」";
		}

		$ctable.="
		<tr>
			<td align=middle><font color=#ff0000>$TYPE[$ctype]</font></td>
			<td><font color=#0000ff>$cname</font></td>
			<td><font color=#808000>$uplimit<br>$uplimit2</font></td>
			<td><font color=#AA5555>$clname</td>
			<td align=middle><font color=#ff0000>ＨＰ：@cu[0],ＭＰ：@cu[1]<br>力：@cu[2],命：@cu[3],智：@cu[4],精：@cu[5],運：@cu[6],速@cu[7]</font></td>
		</tr>";
	}
	$ctable.="</table>";
}


print <<"EOF";
<p align="center"><font size="5" color=yellow><b><i>職業一覽</i></b></font></p>
$ctable
<p align="center"><font size="5" color=yellow><b><i>五階職技能說明</i></b></font></p>
<table border="1" width="100%" id="table1" border=1 bgcolor=#FFFFFF>
	<tr>
		<td>
		<p align="center"><b>職業名稱</b></td>
		<td>
		<p align="center"><b>技能名稱</b></td>
		<td>
		<p align="center"><b>技能說明</b></td>
	</tr>
	<tr>
		<td><b>劍宗</b></td>
		<td><font color="#0000FF">三刀流(絕技)</font></td>
		<td><font color="#808000">(rand(力量)+智力+精神)x威力-對手魔防</font></td>
	</tr>
	<tr>
		<td>　</td>
		<td><font color="#0000FF">魔斬</font></td>
		<td><font color="#808000">扣除對手ＭＰ(智力/2+rand(精神x2))</font></td>
	</tr>
	<tr>
		<td><b>大法師</b></td>
		<td><font color="#0000FF">血魔大法</font></td>
		<td><font color="#808000">耗損目前1/10ＨＰ，回覆1/10最大ＨＰ的ＭＰ</font></td>
	</tr>
	<tr>
		<td>　</td>
		<td><font color="#0000FF">煉獄之火(超魔)</font></td>
		<td><font color="#808000">威力x(智力+rand(精神)+rand(運))</font></td>
	</tr>
	<tr>
		<td><b>大祭司長</b></td>
		<td><font color="#0000FF">聖杯之水</font></td>
		<td><font color="#808000">回復1/10ＨＰ及ＭＰ</font></td>
	</tr>
	<tr>
		<td>　</td>
		<td><font color="#0000FF">聖光槍(超魔)</font></td>
		<td><font color="#808000">威力x(智力+rand(精神)+rand(運))</font></td>
	</tr>
	<tr>
		<td><b>熾天使</b></td>
		<td><font color="#0000FF">熾燄之槍(絕技)</font></td>
		<td><font color="#808000">運氣+rand(運氣x威力)(無視對方防禦)</font></td>
	</tr>
	<tr>
		<td>　</td>
		<td><font color="#0000FF">熾燄亂舞(絕技)</font></td>
		<td><font color="#808000">運氣+rand(運氣x威力)(無視對方防禦)</font></td>
	</tr>
	<tr>
		<td><b>羅煞</b></td>
		<td><font color="#0000FF">奪命之眼(絕技)</font></td>
		<td><font color="#808000">失去目前所有ＭＰ，造成對方1～失去ＭＰ的傷害</font></td>
	</tr>
	<tr>
		<td>　</td>
		<td><font color="#0000FF">嗜血羅煞(絕技)</font></td>
		<td><font color="#808000">生命力+rand(運x威力)(無視對方防禦)</font></td>
	</tr>
	<tr>
		<td><b>吸血鬼</b></td>
		<td><font color="#0000FF">血之牙(絕技)</font></td>
		<td><font color="#808000">吸取(rand(精神)+速度)ＨＰ</font></td>
	</tr>
	<tr>
		<td>　</td>
		<td><font color="#0000FF">魔之牙(絕技)</font></td>
		<td><font color="#808000">吸取(rand(精神)+速度)ＭＰ</font></td>
	</tr>
</table>

EOF
&mainfooter;
exit;

