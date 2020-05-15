sub quest {
	&chara_open;
	&header;
	&ext_open;

	$date=time();
	&quest_open;
	#0討伐任務
	if ($ext_quest_total eq ""){
		$lifetotal=$ext_quest_total-$mtotal;
		$questbutton0=<<"BTN";
        <font color=blue>[$QUEST_NAME[0]]</font>最近各城鎮地怪物變多，請幫忙村民消滅牠們(請在任意城鎮何意地圖打怪)※不限時間
        <form action="./town.cgi" method="post">
            <input type=hidden name=id value=$mid>
            <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=mode value=quest2>
            <input type=hidden name=qno value=0>
            <input type=submit value=接$QUEST_NAME[0]任務 class=FC>
        </form>
        <br>
BTN
	}elsif($ext_quest_total <= $mtotal){
        $questbuttonok0=<<"BTN";
		<font color=blue>[$QUEST_NAME[0]]</font>感謝你的幫忙，讓大家在城鎮間走動更放心
	    <form action="./town.cgi" method="post">
	        <input type=hidden name=id value=$mid>
	        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	        <input type=hidden name=mode value=quest2>
	        <input type=hidden name=qno value=ok0>
        	<input type=submit value=完成$QUEST_NAME[0]任務 class=FC>
        </form>
	    <br>
BTN
	}elsif($mtotal < $ext_quest_total){
		$lifetotal=$ext_quest_total-$mtotal;
		$com="<font color=blue>[$QUEST_NAME[0]]</font>你目前正在進行村民委託的任務中(最近各城鎮地怪物變多，請幫忙村民消滅牠們(請在任意城鎮的任意地圖打任意怪$lifetotal隻))※不限時間";
	}
	#1贊助裝備任務(金錢加倍30分鐘)
    if($date<$quest_time[1]){
        $tmp_time=$quest_time[1]-$date;
        $com.="<br><br><font color=blue>[$QUEST_NAME[1]]</font>任務效果剩餘<b>$tmp_time</b>秒";
    }elsif($quest1_item eq ""){
        $questbutton1=<<"BTN";
        <font color=blue>[$QUEST_NAME[1]]</font>任務(購買指定的裝備給指定的任務屋)※限時１０分鐘
        <form action="./town.cgi" method="post">
            <input type=hidden name=id value=$mid>
            <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
            <input type=hidden name=mode value=quest2>
            <input type=hidden name=qno value=1>
            <input type=submit value=接$QUEST_NAME[1]任務 class=FC>
        </form>
        <br>
BTN
    }elsif($quest1_limit_time<=$date){
        $questbuttonok1=<<"BTN";
        <font color=blue>[$QUEST_NAME[1]]</font><font color=red>到$quest1_town_name購買$quest1_item，１０分鐘內送到$quest1_town_name的任務屋任務失敗</font>
        <form action="./town.cgi" method="post">
            <input type=hidden name=id value=$mid>
            <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
            <input type=hidden name=mode value=quest2>
            <input type=hidden name=qno value=1>
            <input type=submit value=結束$QUEST_NAME[1]任務 class=FC>
        </form>
        <br>
BTN
    }elsif($quest1_town_no eq $mpos){
        $tmp_time=$quest1_limit_time-$date;
        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);
        $ithit=0;
        foreach(@ITEM){
            ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
            if($it_name eq $quest1_item && $it_no ne"rea" && $it_no ne"mix"){
                $ithit=1;
                last;
            }
        }
        if($ithit){
            $questbuttonok1=<<"BTN";
            <font color=blue>[$QUEST_NAME[1]]</font>到$quest1_town_name購買$quest1_item，１０分鐘內送到$quest1_town_name的任務屋，剩餘<b>$tmp_time</b>秒";
            <form action="./town.cgi" method="post">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=mode value=quest2>
                <input type=hidden name=qno value=1>
                <input type=submit value=贊助「$quest1_item」完成$QUEST_NAME[1]任務 class=FC>
            </form>
            <br>
BTN
        }else{
                $com.="<br><br><font color=blue>[$QUEST_NAME[1]]</font><font color=red>你身上沒有「$quest1_item」，無法完成任務</font>※任務限時剩餘<b>$tmp_time</b>秒";
        }
    }else{
        $tmp_time=$quest1_limit_time-$date;
        $com.="<br><br><font color=blue>[$QUEST_NAME[1]]</font>任務,到$quest1_town_name購買$quest1_item，１０分鐘內送到$quest1_town_name的任務屋，剩餘<b>$tmp_time</b>秒";
    }
    #2自我挑戰任務(熟練加倍30分鐘)
    if($date<$quest_time[2]){
        $tmp_time=$quest_time[2]-$date;
        $com.="<br><br><font color=blue>[$QUEST_NAME[2]]</font>任務效果剩餘<b>$tmp_time</b>秒";
    }elsif($quest2_map eq ""){
        $questbutton2=<<"BTN";
        <font color=blue>[$QUEST_NAME[2]]</font>任務(在特定鎮城連十場不住宿存錢打勝指定地圖怪)※限時１０分鐘
        <form action="./town.cgi" method="post">
            <input type=hidden name=id value=$mid>
            <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
            <input type=hidden name=mode value=quest2>
            <input type=hidden name=qno value=2>
            <input type=submit value=接$QUEST_NAME[2]任務 class=FC>
        </form>
        <br>
BTN
    }elsif($quest2_limit_time<=$date){
        $questbuttonok2=<<"BTN";
        <font color=blue>[$QUEST_NAME[2]]</font><font color=red>１０分鐘內到$quest2_town_name的$SEN[$quest2_map]連續戰勝10場任務失敗</font>
        <form action="./town.cgi" method="post">
            <input type=hidden name=id value=$mid>
            <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
            <input type=hidden name=mode value=quest2>
            <input type=hidden name=qno value=2>
            <input type=submit value=結束$QUEST_NAME[2]任務 class=FC>
        </form>
        <br>
BTN

    }else{
        $tmp_time=$quest2_limit_time-$date;
        $tmp_l=10-$quest2_count;
        if($quest2_count>9){
            $questbuttonok2=<<"BTN";
            <font color=blue>[$QUEST_NAME[2]]</font>１０分鐘內到$quest2_town_name的$SEN[$quest2_map]連續戰勝10場任務，剩餘<b>$tmp_time</b>秒";
            <form action="./town.cgi" method="post">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=mode value=quest2>
                <input type=hidden name=qno value=2>
                <input type=submit value=完成$QUEST_NAME[2]任務 class=FC>
            </form>
            <br>
BTN

        }else{
            $com.="<br><br><font color=blue>[$QUEST_NAME[2]]</font><font color=green>１０分鐘內到$quest2_town_name的$SEN[$quest2_map]連續戰勝10場任務，剩餘$tmp_l場</font>※任務限時剩餘<b>$tmp_time</b>秒";
        }
    }
	#5原料任務
	if($date<$quest_time[5]){
		$tmp_time=$quest_time[5]-$date;
		$com.="<br><br><font color=blue>[$QUEST_NAME[5]]</font>任務效果剩餘<b>$tmp_time</b>秒";
	}elsif($quest5_mix eq ""){
        $questbutton5=<<"BTN";
        <font color=blue>[$QUEST_NAME[5]]</font>任務(將特定的原料送到各地的任務屋)※限時１０分鐘
        <form action="./town.cgi" method="post">
            <input type=hidden name=id value=$mid>
            <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
            <input type=hidden name=mode value=quest2>
            <input type=hidden name=qno value=5>
            <input type=submit value=接$QUEST_NAME[5]任務 class=FC>
        </form>
        <br>
BTN
	}elsif($quest5_limit_time<=$date){
        $questbuttonok5=<<"BTN";
	    <font color=blue>[$QUEST_NAME[5]]</font><font color=red>將$ELE[$quest5_mix]原料１０分鐘內送到$quest5_town_name任務失敗</font>
        <form action="./town.cgi" method="post">
            <input type=hidden name=id value=$mid>
            <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
            <input type=hidden name=mode value=quest2>
            <input type=hidden name=qno value=5>
            <input type=submit value=結束$QUEST_NAME[5]任務 class=FC>
        </form>
        <br>
BTN
	}elsif($quest5_town_no eq $mpos){
		$tmp_time=$quest5_limit_time-$date;
		if($ext_mix[$quest5_mix]>0){
            $questbuttonok5=<<"BTN";
            <font color=blue>[$QUEST_NAME[5]]</font>任務,將１個$ELE[$quest5_mix]原料１０分鐘內送到$quest5_town_name※任務限時剩餘<b>$tmp_time</b>秒";
            <form action="./town.cgi" method="post">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=mode value=quest2>
                <input type=hidden name=qno value=5>
                <input type=submit value=交出１個$ELE[$quest5_mix]原料完成$QUEST_NAME[5]任務 class=FC>
            </form>
            <br>
BTN
		}else{
			$com.="<br><br><font color=blue>[$QUEST_NAME[5]]</font><font color=red>你身上沒有$ELE[$quest5_mix]原料，無法完成任務</font>※任務限時剩餘<b>$tmp_time</b>秒";
		}
	}else{
        $tmp_time=$quest5_limit_time-$date;
		$com.="<br><br><font color=blue>[$QUEST_NAME[5]]</font>任務,將１個$ELE[$quest5_mix]原料１０分鐘內送到$quest5_town_name※任務限時剩餘<b>$tmp_time</b>秒";
	}
	print <<"EOF";
    <table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
        <tbody>
            <tr>
                <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">任事屋</font></td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn.jpg"></td>
                <td bgcolor="#330000"><font color="#ffffcc">這裏是村民的委託所，在這可以接到各種任務<br><font color=yellow>目前基本任務完成次數<b>$quest_count[0]</b>次</font></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                $com<br>
                $questbuttonok0
                $questbuttonok1
                $questbuttonok2
                $questbuttonok3
                $questbuttonok4
                $questbuttonok5
                $questbutton0
                $questbutton1
                $questbutton2
                $questbutton3
                $questbutton4
                $questbutton5
                <br>
                </font>
                $BACKTOWNBUTTON
                </td>
            </tr>
        </tbody>
    </table>
EOF
	&footer;
	exit;
}
1;
