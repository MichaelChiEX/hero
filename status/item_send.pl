sub item_send {
        &chara_open;
        &status_print;
        &con_open;
        &ext_open;
        ($ext_mix[0],$ext_mix[1],$ext_mix[2],$ext_mix[3],$ext_mix[4],$ext_mix[5],$ext_mix[6],$ext_mix[7])=split(/,/,$ext_mixs);
        ($act[1],$act[2],$act[3],$act[4],$act[5],$act[6],$act[7],$act[8],$act[9])=split(/,/,$ext_action);
        for($i=1;$i<9;$i++){
                $actlist1.="<TD bgcolor=\"$ELE_C[$mele]\" align=\"center\">$ACTITEM[$i]</TD>";
                $actlist2.="<TD bgcolor=\"$ELE_C[$mele]\" align=\"center\">$act[$i]</TD>";
        }
        #$dir="./logfile/chara";
        #opendir(dirlist,"$dir");
        $i=0;
        #while($file = readdir(dirlist)){
        #       if($file =~ /\.cgi/i){
        #               $datames = "查詢：$dir/$file<br>\n";
        #               if(!open(cha,"$dir/$file")){
        #                       &error("找不到案檔：$dir/$file。<br>\n");
        #               }
        #               @cha = <cha>;
        #               close(cha);
        #               $list[$i]="$file";
        #               ($rid,$rpass,$rname,$rurl,$rchara,$rsex,$rhp,$rmaxhp,$rmp,$rmaxmp,$rele,$rstr,$rvit,$rint,$rfai,$rdex,$ragi,$rmax,$rcom,$rgold,$rbank,$rex,$rtotalex,$rjp,$rabp,$rcex,$runit,$rcon,$rarm,$rpro,$racc,$rtec,$rsta,$rpos,$rmes,$rhost,$rdate,$rsyo,$rclass,$rtotal,$rkati,$rtype) = split(/<>/,$cha[0]);
        #               $clist[$rcon].="<option value=$rid>$rname";
        #       }
        #       $mn++;
        #}
        #closedir(dirlist);

        #foreach(@CON_DATA){
        #       ($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
        #       $plist.="<option value=\"\">★★★$con2_name國★★★";
        #       $plist.="$clist[$con2_id]";
        #}
        #$plist.="<option value=\"\">★★★無所屬★★★";
        #$plist.="$clist[0]";
        $eleno=0;
        foreach(@ELE){
                if ($eleno>0){
                        $elelist.="<Option value=$eleno>$ELE[$eleno]原料</option>";
                }else{
                        $elelist.="<Option value=$eleno>建國之石</option>";
                }
                $eleno++;
        }
        $it_names[0]="力量之果";
        $it_names[1]="生命之果";
        $it_names[2]="智慧之果";
        $it_names[3]="精神之果";
        $it_names[4]="運氣之果";
        $it_names[5]="速度之果";
        $abno=0;
        foreach(@it_names){
                $ablist.="<Option value=$abno>$it_names[$abno]</option>";
                $abno++;
        }
        for($i=1;$i<=8;$i++){
                $ablist2.="<Option value=$i>$ACTITEM[$i]</option>";
        }
        open(IN,"./logfile/item/$mid.cgi");
        @ITEM = <IN>;
        close(IN);
        $no2=0;
        foreach(@ITEM){
                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
                $sel_val=int($it_val/2);
                $ittable.="<TR><TD width=5% bgcolor=ffffcc><input type=checkbox value=$no2 id=\"C$no2\" name=\"C$no2\"></TD><TD bgcolor=white><font size=2>$it_name</font></TD><TD bgcolor=white><font size=2>$sel_val</font></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD></TR>";
                $no2++;
        }
        if($in{'sendname'} ne""){
        $sendmsg="<BR><FONT color=#ffffcc><font color=blue>$mname</font>傳送<font color=red>$in{'senditem'}</font>給<font color=lighgreen>$in{'sendname'}</font>。</FONT>";
        }

        &header;

        print <<"EOF";
<TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">傳送物品</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/pub.jpg" width="157" height="100"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc">請直接輸入對方的角色名稱，並選擇要傳送的物品，每件物品傳送將花費銀行存款１０萬。$sendmsg</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="center">
        $STPR
        <form action="./status.cgi" method="post">
        接收者名稱：<input type=text name=player value="$in{'sendname'}">
        <!--
        <select name=player>
        $plist
        </select>
        -->
        <INPUT type=hidden name=itno id=itno>
        <INPUT type=hidden name=mode value=item_send2>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=itype value=$it_show_no>
        <INPUT type=hidden name=mode value=item_send2>
        <INPUT type=button value=勾選項目傳送 onclick="javascript:chkform(this.form,this);">
        <BR>
        <table border=0 width="90%" align=center bgcolor=$FCOLOR CLASS=TC>
        <BR>
        <TR><td colspan=7 align=center bgcolor="$FCOLOR"><font color=ffffcc>身上的物品清單</font></td></tr>
        <TR>
        <TD bgcolor=ffffcc><input type=button value=全選 onclick=javascript:selalls();></TD><td bgcolor=white><font size=2>名稱</font></td><td bgcolor=white><font size=2>價值</font></td><td bgcolor=white><font size=2>威力</font></td><td bgcolor=white><font size=2>重量</font></td><td bgcolor=white><font size=2>屬性</font></td><td bgcolor=white><font size=2>種類</font></td>
        </TR>
        $ittable
        </form>

        </table>
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=8 align=center><font color=ffffcc>目前原料數</font></td></tr>
        <tr>
        <td bgcolor=ffffcc>建國之石</td><td bgcolor=ffffcc>火</td><td bgcolor=ffffcc>水</td><td bgcolor=ffffcc>風</td><td bgcolor=ffffcc>星</td><td bgcolor=ffffcc>雷</td><td bgcolor=ffffcc>光</td><td bgcolor=ffffcc>闇</td>
        </tr>
        <tr>
        <td bgcolor=white>$ext_mix[0]</td><td bgcolor=white>$ext_mix[1]</td><td bgcolor=white>$ext_mix[2]</td><td bgcolor=white>$ext_mix[3]</td><td bgcolor=white>$ext_mix[4]</td><td bgcolor=white>$ext_mix[5]</td><td bgcolor=white>$ext_mix[6]</td><td bgcolor=white>$ext_mix[7]</td>
        </tr>
        </table>
        <form action="./status.cgi" method="post" id="sendf2">
        接收者名稱：<input type=text name=player value="$in{'sendname'}">
        傳送原料<select size="1" name="itno">
        $elelist
        </select>
        數量:<input type=text size=3 name=num value=1>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=item_send3>
        <INPUT type=button value=傳送原料 onclick="javascript:dis(this);subs(this.form);">
        </form>
<TABLE border="0" align=center width="100%" height="1" CLASS=MC>
  <TBODY>
    <TR>
      <TD colspan="6" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>目前所持能力果</font></TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$mele]" align="center">力量之果</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">生命之果</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">智慧之果</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">精神之果</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">幸運之果</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">速度之果</TD>
    </TR>
    <TR>
      <TD bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[0]</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[1]</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[2]</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[3]</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[4]</TD>
      <TD bgcolor="$ELE_C[$mele]" align="center">$ext_ab_item[5]</TD>
    </TR>
  </TBODY>
</TABLE>

        <form action="./status.cgi" method="post" id="sendf3">
        接收者名稱：<input type=text name=player value="$in{'sendname'}">
        傳送能力果<select size="1" name="itno">
        $ablist
        </select>
        數量:<input type=text size=3 name=num value=1>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=item_send4>
        <INPUT type=button value=傳送能力果 onclick="javascript:dis(this);subs(this.form);">
        </form>
<TABLE border="0" align=center width="100%" height="1" CLASS=MC>
  <TBODY>
    <TR>
      <TD colspan="9" align="center" bgcolor="$ELE_BG[$mele]"><font color=$ELE_C[$mele]>活動物品</font></TD>
    </TR>
    <TR>
      $actlist1
    </TR>
    <TR>
      $actlist2
    </TR>
  </TBODY>
</TABLE>
        <form action="./status.cgi" method="post" id="sendf4">
        接收者名稱：<input type=text name=player value="$in{'sendname'}">
        傳送活動物品<select size="1" name="itno">
        $ablist2
        </select>
        數量:<input type=text size=3 name=num value=1>
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=item_send5>
        <INPUT type=button value=傳送活動物品 onclick="javascript:dis(this);subs(this.form);">
        </form>

$BACKTOWNBUTTON
        </TD>
        </TR></font>
    </TR>
  </TBODY>
</TABLE>
<center></center>
<script language="javascript">
function dis(b){
	b.value='傳送中..';
	b.disabled=true;
}
function subs(f){
	f.submit();
}
function chkform(f,b){
        f.itno.value="";
        var chki=0;
        for(var i=0;i<$ITM_MAX;i++){
                var obj=document.getElementById('C'+i);
                if (obj){
                        if(obj.checked){
                                f.itno.value+=obj.value+",";
                                chki++;
                        }
                }
        }
        if(f.itno.value==""){
                alert('請選擇要存入的物品');
        }else{
	        b.value='傳送中..';
	        b.disabled=true;
                f.submit();
        }
}
function selalls(){
        for(var i=0;i<$ITM_MAX;i++){
                var obj=document.getElementById('C'+i);
                if (obj){
                        obj.checked=!obj.checked;
                }
        }
}
</script>
EOF

        &footer;
        exit;
}
1;

