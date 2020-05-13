sub item_send {
    &chara_open;
    &status_print;
    &con_open;
    &ext_open;

    # 活動
    ($ext_mix[0],$ext_mix[1],$ext_mix[2],$ext_mix[3],$ext_mix[4],$ext_mix[5],$ext_mix[6],$ext_mix[7])=split(/,/,$ext_mixs);
    ($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
    for($i=1;$i<=8;$i++){
        $actlist1.="<td bgcolor=\"$ELE_C[$mele]\" align=\"center\">$ACTITEM[$i]</td>";
        $actlist2.="<td bgcolor=\"$ELE_C[$mele]\" align=\"center\">$act[$i]</td>";
        $ablist2.="<option value=$i>$ACTITEM[$i]</option>";
    }

    # 原料
    for($i=0;$i<=$#ELE;$i++){
        if ($i>0){
            $elelist.="<option value=$i>$ELE[$i]原料</option>";
        }else{
            $elelist.="<option value=$i>建國之石</option>";
        }
    }
    
    # 果
    @it_names = ("力量之果", "生命之果", "智慧之果", "精神之果", "運氣之果", "速度之果");
    for($i=0; $i<=$#it_names; $i++){
        $ablist.="<option value=$i>$it_names[$i]</option>";
    }

    # 一般物品
    open(IN,"./logfile/item/$mid.cgi");
    @ITEM = <IN>;
    close(IN);
    for($i=0; $i<=$#ITEM; $i++){
        ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/, @ITEM[$i]);
        $sel_val=int($it_val/2);
        $ittable.="
            <tr>
                <td width=5% bgcolor=ffffcc><input type=checkbox class='item' value=$i></td>
                <td bgcolor=white><font size=2>$it_name</font></td><td bgcolor=white><font size=2>$sel_val</font></td>
                <td bgcolor=white><font size=2>$it_dmg</font></td><td bgcolor=white><font size=2>$it_wei</font></td>
                <td bgcolor=white><font size=2>$ELE[$it_ele]</font></td><td bgcolor=white><font size=2>$EQU[$it_ki]</font></td>
            </tr>";
    }

    if($in{'sendname'} ne""){
        $sendmsg="<br><font color=#ffffcc><font color=blue>$mname</font>傳送<font color=red>$in{'senditem'}</font>給<font color=lighgreen>$in{'sendname'}</font>。</font>";
    }

    &header;

    print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
    <tbody>
        <tr>
            <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">傳送物品</font></td>
        </tr>
        <tr>
            <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg" width="157" height="100"></td>
            <td bgcolor="#330000"><font color="#ffffcc">請直接輸入對方的角色名稱，並選擇要傳送的物品，每件物品傳送將花費銀行存款１０萬。$sendmsg</font></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                $STPR
                <form action="./status.cgi" method="post">
                接收者名稱：<input type=text name=player value="$in{'sendname'}">
                <input type=hidden name=itno id=itno>
                <input type=hidden name=mode value=item_send2>
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=itype value=$it_show_no>
                <input type=hidden name=mode value=item_send2>
                <input type=button value=勾選項目傳送 onclick="javascript:chkform(this.form,this);">
                <br>
                <table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
                    <br>
                    <tr>
                        <td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>身上的物品清單</font></td>
                    </tr>
                    <tr>
                    <tr>
                        <td bgcolor=ffffcc><input type=button value=全選 onclick=javascript:selalls();></td>
                        <td bgcolor=white>
                            <font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font>
                        </td>
                        <td bgcolor=white><font size=2>威力</font></td>
                        <td bgcolor=white><font size=2>重量</font></td>
                        <td bgcolor=white><font size=2>屬性</font></td>
                        <td bgcolor=white><font size=2>種類</font></td>
                    </tr>
                    $ittable
                </table>
                </form>
                <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
                    <tr><td colspan=8 align=center><font color=ffffcc>目前原料數</font></td></tr>
                    <tr>
                        <td bgcolor=ffffcc>建國之石</td>
                        <td bgcolor=ffffcc>火</td>
                        <td bgcolor=ffffcc>水</td>
                        <td bgcolor=ffffcc>風</td>
                        <td bgcolor=ffffcc>星</td>
                        <td bgcolor=ffffcc>雷</td>
                        <td bgcolor=ffffcc>光</td>
                        <td bgcolor=ffffcc>闇</td>
                    </tr>
                    <tr>
                        <td bgcolor=white>$ext_mix[0]</td>
                        <td bgcolor=white>$ext_mix[1]</td>
                        <td bgcolor=white>$ext_mix[2]</td>
                        <td bgcolor=white>$ext_mix[3]</td>
                        <td bgcolor=white>$ext_mix[4]</td>
                        <td bgcolor=white>$ext_mix[5]</td>
                        <td bgcolor=white>$ext_mix[6]</td>
                        <td bgcolor=white>$ext_mix[7]</td>
                    </tr>
                </table>
                <form action="./status.cgi" method="post" id="sendf2">
                    接收者名稱：<input type=text name=player value="$in{'sendname'}">
                    傳送原料
                    <select size="1" name="itno">
                        $elelist
                    </select>
                    數量:<input type=text size=3 name=num value=1>
                    <input type=hidden name=id value=$mid>
                    <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                    <input type=hidden name=mode value=item_send3>
                    <input type=hidden name=itkind value="stone">
                    <input type=button value=傳送原料 onclick="javascript:subs(this);">
                </form>
                <table border="0" align=center width="100%" height="1" CLASS=MC>
                    <tbody>
                        <tr>
                        <td colspan="6" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>目前所持能力果</font></td>
                        </tr>
                        <tr>
                        <td bgcolor="$ELE_C[$mele]" align="center">力量之果</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">生命之果</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">智慧之果</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">精神之果</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">幸運之果</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">速度之果</td>
                        </tr>
                        <tr>
                        <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[0]</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[1]</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[2]</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[3]</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[4]</td>
                        <td bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[5]</td>
                        </tr>
                    </tbody>
                </table>
                <form action="./status.cgi" method="post" id="sendf3">
                    接收者名稱：<input type=text name=player value="$in{'sendname'}">
                    傳送能力果
                    <select size="1" name="itno">
                        $ablist
                    </select>
                    數量:<input type=text size=3 name=num value=1>
                    <input type=hidden name=id value=$mid>
                    <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                    <input type=hidden name=mode value=item_send3>
                    <input type=hidden name=itkind value="fruit">
                    <input type=button value=傳送能力果 onclick="javascript:subs(this);">
                </form>
                <table border="0" align=center width="100%" height="1" CLASS=MC>
                    <tbody>
                        <tr>
                            <td colspan="9" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>活動物品</font></td>
                        </tr>
                        <tr>
                            $actlist1
                        </tr>
                        <tr>
                            $actlist2
                        </tr>
                    </tbody>
                </table>
                <form action="./status.cgi" method="post" id="sendf4">
                    接收者名稱：<input type=text name=player value="$in{'sendname'}">
                    傳送活動物品
                    <select size="1" name="itno">
                    $ablist2
                    </select>
                    數量:<input type=text size=3 name=num value=1>
                    <input type=hidden name=id value=$mid>
                    <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                    <input type=hidden name=mode value=item_send3>
                    <input type=hidden name=itkind value="act">
                    <input type=button value=傳送活動物品 onclick="javascript:subs(this);">
                </form>
                $BACKTOWNBUTTON
            </td>
        </tr>
    </tbody>
</table>
<script>
function subs(obj){
    obj.value='傳送中..';
	obj.disabled=true;
	obj.form.submit();
}
function chkform(f,b){
    var items = [];
	document.querySelectorAll('.item').forEach(function(element) {
		if(element.checked){
            items.push(element.value);
        }
	})

    if(!items){
        alert('請選擇要傳送的物品');
    }else{
        f.itno.value=items.join(',');
        b.value='傳送中..';
        b.disabled=true;
        f.submit();
    }
}
function selalls(){
	document.querySelectorAll('.item').forEach(function(element) {
		element.checked=!element.checked;
	})
}
</script>
EOF

    &footer;
    exit;
}
1;

