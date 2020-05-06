sub toubatsu2{
	#討伐
	&chara_open;
	&town_open;
	&con_open;
	if($in{'player'} eq ""){&error("請選擇對手。");}
	if($in{'player'} eq "$mid"){&error("對手不可選擇自己。");}
	
	$date = time();
	$btime = $BTIME - $date + $mdate;
	if($btime>0){&error("距離下次行動時間還剩 $btime 秒。");}

	open(IN,"./logfile/battle/$in{'id'}.cgi");
	@BC_DATA = <IN>;
	close(IN);

	open(IN,"./data/battlecount.cgi");
	@COUNT_DATA = <IN>;
	close(IN);
	($battlecount)=split(/<>/,$COUNT_DATA[0]);

	($mhpr,$mmpr,$mtim)=split(/<>/,$BC_DATA[0]);
	if($mhpr eq""){$mhpr=1;}
	if($mmpr eq""){$mmpr=1;}
                if($in{'player'} eq $GMID){
$mhpr=1;$mmpr=1;
                }

	if($mhpr<0.2){&error("目前的狀態無法進行討伐。");}
	$mhp=int($mmaxhp*$mhpr);
	$mmp=int($mmaxmp*$mmpr);

	$mtotal++;
	$date = time();
	$ktime = $KTIME - $date + $mdate2;
	if($ktime>0 && $mid ne $GMID){&error("離下次討伐時間剩 $ktime 秒。");}
	if($con_id eq 0){
		if($in{'player'} ne $GMID){
			&error("無所屬國角色無法進行。");
		}
	}
	
	foreach(@TOWN_DATA){
		($town2_id,$town2_name,$town2_con,$town2_ele,$town2_gold,$town2_arm,$town2_pro,$town2_acc,$town2_ind,$town2_tr,$town2_s,$town2_x,$town2_y,$town2_etc)=split(/<>/);
		if($in{'tid'} eq $town2_id){$tohit=1;last;}
		$tx++;
	}

	$dir="./logfile/chara";
	opendir(dirlist,"$dir");
	$i=0;
	while($file = readdir(dirlist)){
		if($file =~ /\.cgi/i){
			$datames = "查詢：$dir/$file<br>\n";
			if(!open(cha,"$dir/$file")){
				&error("找不到檔案：$dir/$file。<br>\n");
			}
			@cha = <cha>;
			close(cha);
			$list[$i]="$file";
			($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rabp,$rjp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
			if($rcon eq $town2_con){$zin++;}
			elsif($rcon eq $mcon){$zin2++;}
		}
		$mn++;
	}
	closedir(dirlist);

	$conhit=0;
	foreach(@CON_DATA){
		($con2_id,$con2_name,$con2_con,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
		if($town2_con eq $con2_id){$conhit=1;last;}
		$tx++;
	}
	if(!$conhit){$con2_ele=0;$con2_name="無所屬";}
	$imm_kill="1";	
	require './battle_suport.cgi';

	$dhit=0;

	$enemy_id=$in{'player'};
	&enemy_open;

	&maplog5("<a href=\"/hero_data/inv/$battlecount.html\" TARGET=\"_blank\"><font color=black>【討伐】</font></a><font color=red>$con_name國</font>的 <font color=blue>$mname</font> 對 <font color=red>$ename</font> 進行討伐。");
	
	&equip_open;
        #神之必殺效果減半
        $god_kill="2";
	&PARA;

	
	open(IN,"./logfile/battle/$enemy_id.cgi");
	@BE_DATA = <IN>;
	close(IN);
	($ehpr,$empr,$etim)=split(/<>/,$BE_DATA[0]);
	if($eid eq $GMID){
		$ehpr=1;
		$empr=1;
	}
	if($ehpr eq""){$ehpr=1;}
	if($empr eq""){$empr=1;}
	$ehp=int(($emaxhp+$ehpadd)*$ehpr);
	$emp=int($emaxmp*$empr);
	
	&TEC_OPEN;

	&header;
	$blog.= <<"EOF";
<TABLE border="0" width="100%" align=center height="144" CLASS=TOC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$ELE_BG[$town_ele]"><FONT color="#ffffcc">$town_name </FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#cccccc" width="30%">
      <TABLE border="0" width="100%" height="100%" bgcolor=$ELE_BG[$mele] align=right>
        <TBODY>
          <TR>
            <TD rowspan="2"><FONT size="-1"><img src="$IMG/chara/$mchara.gif"></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">HP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mhp/$mmaxhp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">攻擊力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mstr(+$marmdmg+<font color=red>$mpetdmg</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$marmname<BR>
            【$marmdmg/$marmwei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mmp/$mmaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mvit(+$mprodmg+$maccdmg+<font color=red>$mpetdef</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mproname<BR>
            【$mprodmg/$mprowei】</FONT></TD>
          </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$mname<font color=blue>$mpetname2</font></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2>$JOB[$mclass]</TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$magi+<font color=red>$mpetspeed</font></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">飾品</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$maccname<BR>
            【$maccdmg/$maccwei】</FONT></TD>
          </TR>
        </TBODY>
      </TABLE>
      </TD>
      <TD align="center" bgcolor="$FCOLOR2" width="20%"><IMG src="$IMG/town/machi.jpg" width="150" height="113" border="0"></TD>
      <TD bgcolor="#cccccc" width=30%>
      <TABLE border="0" width="100%" height="100%" bgcolor=$ELE_BG[$eele]>
        <TBODY>
          <TR>
            <TD rowspan="2"><FONT size="-1"><img src="$IMG/chara/$echara.gif"></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">HP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ehp/$emaxhp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">攻擊力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$estr(+$earmdmg+<font color=red>$epetdmg</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">武器</FONT></TD>
          <TD bgcolor=$FCOLOR2><FONT size="-1">$earmname<BR>【$earmdmg/$earmwei】</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">MP</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$emp/$emaxmp</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防御力</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$evit(+$eprodmg+$eaccdmg+<font color=red>$epetdef</font>)</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">防具</FONT></TD>
         <TD bgcolor=$FCOLOR2><FONT size="-1">$eproname<BR>【$eprodmg/$eprowei】</FONT></TD>
         </TR>
          <TR>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$ename<font color=blue>$epetname2</font></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">職業</FONT></TD>
            <TD bgcolor=$FCOLOR2>$JOB[$eclass]</TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">速度</FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">$eagi+<font color=red>$epetspeed</font></FONT></TD>
            <TD bgcolor=$FCOLOR2><FONT size="-1">飾品</FONT></TD>
          <TD bgcolor=$FCOLOR2><FONT size="-1">$eaccname<BR>【$eaccdmg/$eaccwei】</FONT></TD>
         </TR>
        </TBODY>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD bgcolor=#000000><font color="white" size="-1">「$mcom」</font></TD>
      <TD align=center bgcolor="666600"><font color="white" size="-1">戰鬥宣言</font></TD>
      <TD bgcolor=#000000><font color="white" size="-1">「$ecom」</font></TD>
    </TR>
  </TBODY>
</TABLE>
<BR><BR>
EOF
	&BATTLE;
	
	&log_print;

	@N_COUNT=();
	$battlecount+=1;
	if($battlecount>=10){$battlecount=1;}

	unshift(@N_COUNT,"$battlecount<>\n");
	open(OUT,">./data/battlecount.cgi");
	print OUT @N_COUNT;
	close(OUT);


	print <<"EOF";
	$blog
	<center>
$BACKTOWNBUTTON
	<P><hr size=0></center>
	</center>
EOF
	&chara_input;

#健康度
	$mhpr=int($mhp*100/$mmaxhp)/100-0.1;
	if($mhpr<0.05){$mhpr=0.05;}
	$mmpr=int($mmp*100/$mmaxmp)/100-0.1;
	if($mmpr<0.05){$mmpr=0.05;}
	@N_BC=();
	unshift(@N_BC,"$mhpr<>$mmpr<>$date<>\n");
	open(OUT,">./logfile/battle/$in{'id'}.cgi");
	print OUT @N_BC;
	close(OUT);
	
	$date = time();
	$ehpr=int($ehp*100/$emaxhp)/100-0.1;
	if($ehpr<0.05){$ehpr=0.05;}
	$empr=int($emp*100/$emaxmp)/100-0.1;
	if($empr<0.05){$empr=0.05;}
	@N_BE=();
	unshift(@N_BE,"$ehpr<>$empr<>$date<>\n");
	open(OUT,">./logfile/battle/$enemy_id.cgi");
	print OUT @N_BE;
	close(OUT);
	
	&footer;
	exit;
}


sub BATTLE{##戰鬥處理
	while($turn<=50){
		$turn++;
		$bmess="";
		$mmess="";
		if($mab[15] && $mabdmg[15]>$eabdmg[15] && int(rand($mabdmg[15])) eq 0){$sensei = 1;}
		elsif($eab[15] && $eabdmg[15]>$mabdmg[15] && int(rand($eabdmg[15])) eq 0){$sensei = 0;}
		elsif(int(rand($mdex)) > int(rand($edex))){$sensei = 1;}
		else{$sensei = 0;}
		if($sensei){
			if($mhp>0){&MATT;}
			if($ehp>0){&EATT;}
		}else{
			if($ehp>0){&EATT;}
			if($mhp>0){&MATT;}
		}if($win){
			$mkati++;
			if($sensei){
				&BATTLEPRINT;
			}else{
				&MBATTLEPRINT;
			}
			$mlv=int($mex/100)+1;
			$get_ex=50 + int(rand(10));
			if($mex<9900){
				$mex+=$get_ex;
			}
			$mtotalex+=$get_ex;
			$get_gold=$e_gold + int(rand($e_gold/3));
			if($get_gold>1000000){$get_gold=1000000;}
			$mgold+=$get_gold;
			$getabp=2;
			if($mab[22]){$getabp += 1;}

			$mabp+=$getabp;
			$mjp[$mtype]+=$getabp;
			if($mjp[$mtype]>$MAXJOB){$mjp[$mtype] = $MAXJOB;}
			
			##レベルアップ
			&LVUP;
			&maplog5("<font color=red>【勝利】</font>$mname　討伐 $ename 獲得勝利。");
			
			$blog.= <<"EOF";
			<center>
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">勝利！</FONT></TD>
    			</TR>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">獲得<FONT color="#cc0000">$get_ex</FONT>經驗值<BR>
      			獲得<FONT color="#000099">$get_gold</FONT> Gold！<BR>$com<BR>
      			獲得<FONT color="#cc0000">$getabp</FONT>熟練度<BR>
			<TABLE border="0" bgcolor="#990000">
        		<TBODY><TR>
            		<TD bgcolor="#ffffcc">經驗值</TD>
            		<TD bgcolor="#ffffcc">$mex(+$get_ex)point</TD>
          		</TR>
          		<TR><TD bgcolor="#ffffcc">Gold</TD>
            		<TD bgcolor="#ffffcc">$mgold(+$get_gold)Gold</TD>
          		</TR></TBODY></TABLE>
      			</TD></TR>
  			</TBODY></TABLE>
			</center>
EOF
			last;
		}if($lose){
			&maplog5("<font color=blue>【敗北】</font>$mname 討伐 $ename 失敗。。");
			
			#$bmess.="$mname所持金減半。";
			$lose_gold=$mgold-int($mgold/2);
			$mgold-=$lose_gold;
			if($sensei){
				&BATTLEPRINT;
			}else{
				&MBATTLEPRINT;
			}
			$blog.= <<"EOF";
			<center>
			<TABLE border="0" width="400" bgcolor="#000000" CLASS=TC>
  			<TBODY><TR>
      			<TD colspan="2" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">敗北！</FONT></TD>
    			</TR>
    			<TR><TD colspan="2" align="center" bgcolor="$FCOLOR2">
			<FONT color="#ff0000">$mname的所持金減半！！</FONT><BR>
      			<BR>

      			<TABLE border="0" bgcolor="#990000">
        		<TBODY><TR>
            		<TD bgcolor="#ffffcc">失去了<FONT color="#000099">$lose_gold</FONT> Gold！</TD>
          		</TR></TBODY></TABLE>
      			</TD></TR>
  			</TBODY></TABLE>
			</center>
EOF
			last;
		}
			if($sensei){
				&BATTLEPRINT;
			}else{
				&MBATTLEPRINT;
			}
		
	}
	if(!$win && !$lose){
			if($sensei){
				$mmess.="此戰未分出勝負$BACKTOWNBUTTON。";
				&BATTLEPRINT;
			}else{
				$bmess.="此戰未分出勝負$BACKTOWNBUTTON。";
				&MBATTLEPRINT;
			}
	}
	$mdate2=time();
	
}

#回合別戰鬥結果表示
sub BATTLEPRINT{
	$blog.= <<"EOF";
<CENTER>


<TABLE border="0" width="80%" bgcolor="#000000" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="8" align="center" bgcolor="$FCOLOR"><B><FONT color="#ffffcc">第$turn回合</FONT></B></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="000063" align="center"><FONT color="$FCOLOR2"><B><FONT size="-1">$mname</FONT></B></FONT></TD>
      <TD colspan="4" bgcolor="9c0000" align="center"><B><FONT size="-1" color="$FCOLOR2">$ename</FONT></B></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="#003300" align="center"><IMG src="$IMG/chara/$mchara.gif"></TD>
      <TD colspan="4" bgcolor="#003300" align="center"><IMG src="$IMG/chara/$echara.gif"></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$bmess</font></TD>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$mmess</font></TD>
    </TR>
    <TR>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mhp/$mmaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mmp/$mmaxmp</TD>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$ehp/$emaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$emp/$emaxmp</TD>
    </TR>
  </TBODY>
</TABLE>
</CENTER>
<BR><BR><BR><P>
EOF
}

sub MBATTLEPRINT{
	$blog.= <<"EOF";
<CENTER>


<TABLE border="0" width="80%" bgcolor="#000000" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="8" align="center" bgcolor="$FCOLOR"><B><FONT color="#ffffcc">$turn回合</FONT></B></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="9c0000" align="center"><B><FONT size="-1" color="$FCOLOR2">$ename</FONT></B></TD>
      <TD colspan="4" bgcolor="000063" align="center"><FONT color="$FCOLOR2"><B><FONT size="-1">$mname</FONT></B></FONT></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="#003300" align="center"><IMG src="$IMG/chara/$echara.gif"></TD>
      <TD colspan="4" bgcolor="#003300" align="center"><IMG src="$IMG/chara/$mchara.gif"></TD>
    </TR>
    <TR>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$mmess</font></TD>
      <TD colspan="4" bgcolor="$FCOLOR2" align="center"><font size=-1>$bmess</font></TD>
    </TR>
    <TR>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$ehp/$emaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$emp/$emaxmp</TD>
      <TD bgcolor="#ccffff" width=12.5%>HP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mhp/$mmaxhp</TD>
      <TD bgcolor="#ccffff" width=12.5%>MP</TD>
      <TD bgcolor="#ccffff" width=12.5%>$mmp/$mmaxmp</TD>
    </TR>
  </TBODY>
</TABLE>
</CENTER>
<BR><BR><BR><P>
EOF
}
sub log_print{
	$header = <<"EOM";
	<html>
	<head>
	<META HTTP-EQUIV="Content-type" CONTENT="text/html; charset=utf-8">
	<STYLE type="text/css">
	<!--
A:HOVER{
 color: $ALINK
}
.BC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[0] $ELE_BG[0] $ELE_BG[0] $ELE_BG[0];border-style : double double double double;background-color : $ELE_BG[0];color : black;}
.TC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $FCOLOR $FCOLOR $FCOLOR $FCOLOR;border-style : double double double double;background-color : $FCOLOR;color : black;}
.CC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$con_ele] $ELE_BG[$con_ele] $ELE_BG[$con_ele] $ELE_BG[$con_ele];border-style : double double double double;background-color : $ELE_BG[$con_ele];color : black;}
.CC2 {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$con2_ele] $ELE_BG[$con2_ele] $ELE_BG[$con2_ele] $ELE_BG[$con2_ele];border-style : double double double double;background-color : $ELE_BG[$con2_ele];color : black;}
.MC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$wele] $ELE_BG[$wele] $ELE_BG[$wele] $ELE_BG[$wele];border-style : double double double double;background-color : $ELE_BG[$wele];color : black;}
.MFC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width : $ELE_BG[$con_ele];border-top-color : $ELE_BG[$con_ele];border-right-color : $ELE_BG[$con_ele];border-bottom-color : $ELE_BG[$con_ele];border-left-color : $ELE_BG[$con_ele];border-style : double double double double;background-color : $ELE_C[$con_ele];color : black;}
.FC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width : $FCOLOR;border-top-color : $FCOLOR;border-right-color : $FCOLOR;border-bottom-color : $FCOLOR;border-left-color : $FCOLOR;border-style : double double double double;background-color : $FCOLOR2;color : black;}
.TOC {border-top-width : medium;border-right-width : medium;border-bottom-width : medium;border-left-width :medium; border-color : $ELE_BG[$town_ele] $ELE_BG[$town_ele] $ELE_BG[$town_ele] $ELE_BG[$town_ele];border-style : double double double double;background-color : $ELE_BG[$town_ele];color : black;}
.dmg { color: #FF0000; font-size: 10pt }
.clit { color: #0000FF; font-size: 10pt }
-->
	</STYLE>
	<title>$TITLE</title></head>
	<body background=\"$BGIF\" bgcolor=\"$BG\">
EOM

	open(OUT,">/var/www/html/hero_data/inv/$battlecount.html");
	print OUT $header;
	print OUT $blog;
	print OUT "</BODY></HTML>";
	close(OUT);
}

1;
