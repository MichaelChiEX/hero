#! /usr/bin/perl
require './jcode.pl';
require './sub.cgi';
require './conf.cgi';
#require './data/town_mes.cgi';
 
&decode;
if($ENV{'HTTP_REFERER'} !~ /cgi$/ ){ &error2("<a href='./login.cgi'>請重新登入</a>。"); }
$tmode = "timer";
&chara_open;
#if($murl ne ""){&error2("此帳號尚未認證,請先收信啟用帳號。");}
&town_open;
&con_open;
&time_data;
foreach(@CON_DATA){
        ($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
        if("$con2_id" eq "$town_con"){$hit=1;last;}
} 
&fixext_open;
foreach(@fixext_fkey){
	($fclass,$fcmd,$fname)=split(/,/,$_);
	if($fclass ne""){
		if($fastbutton eq""){
		$fastbutton.="<input type=button value=$fname onclick=fastkeyform('$fclass','$fcmd');>";
		}else{
                $fastbutton.="　<input type=button value=$fname onclick=fastkeyform('$fclass','$fcmd');>";
		}
	}
}
if(!$hit){$con2_ele=0;$con2_name="無所屬";$con2_id=0;}
&ext_open;
$maplogshow="";
if($ext_show_mode ne"N"){
	$maplogshow=<<"SOF";
            <table width=100% CLASS=CC id="other_msg">
            <tr>
            <td bgcolor="$ELE_BG[$con_ele]" width=50%>
                <font color="$ELE_C[$con_ele]">最近事件</font>
            </td>
            <td bgcolor="$ELE_BG[$con_ele]" width=50%>
                <font color="$ELE_C[$con_ele]">戰鬥紀錄</font>
            </td>
            </tr>
            <tr>
            <td bgcolor="$ELE_C[$con_ele]">
            <font color="$ELE_BG[$con_ele]" id="maplog"></font>
            </td>
            <td bgcolor="$ELE_C[$con_ele]">
            <font color="$ELE_BG[$con_ele]" id="maplog2"></font>
            </td>
            </tr></table>
SOF
}
if ($mid eq $GMID){
        $member_fix_time2=2;
} 
&header;
if($in{'id'} eq""){&error2("帳號不存在，<a href='./login.cgi'>請重新登入</a>。");}
if($in{'pass'} eq""){&error2("密碼不存在，<a href='./login.cgi'>請重新登入</a>。");}
 
if($hour > 20 || $hour < 4){$timg ="$TOWN_IMG2";}
else{$timg ="$TOWN_IMG";}
if($mflg<2){require'./etc/top_print.pl';&top_print;}
$status_s=<<"EOF";
<div style="position: absolute; width: 187px; height: 143px; z-index: 1; left: 145px; top: 400px" id="s_status"  style="display:none">
<table border="1" width="269" cellspacing="0" cellpadding="0" style="font-size: 12px" bgcolor="#FFFFcc">
        <tr>
                <td align="right" height="20" width="49"><font color="red">ＨＰ</font></td>
                <td height="20" width="80" align="right" style="color:red" id="chara_maxmaxhp"></td>
                <td align="right" height="20" width="66"><font color="blue">ＭＰ</font></td>
                <td height="20" width="66" align="right" style="color:blue" id="chara_maxmaxmp"></td>
        </tr>
        <tr>
                <td align="right" height="20" bgcolor="#CCCCFF">力量</td>
                <td align="right" id="chara_max0"></td>
                <td align="right" bgcolor="#FFCCFF">劍術熟練</td>
                <td align="right" style="color:#FF0000" id="chara_mjp0"></td>
        </tr>
        <tr>
                <td align="right" height="20" bgcolor="#CCCCFF">生命力</td>
                <td align="right" id="chara_max1"></td>
                <td align="right" bgcolor="#FFCCFF">體術熟練</td>
                <td align="right" style="color:#FF0000" id="chara_mjp4"></td>
        </tr>
        <tr>
                <td align="right" height="20" bgcolor="#CCCCFF">智力</td>
                <td align="right" id="chara_max2"></td>
                <td align="right" bgcolor="#FFCCFF">魔術熟練</td>
                <td align="right" style="color:#FF0000" id="chara_mjp1"></td>
        </tr>
        <tr>
                <td align="right" height="20" bgcolor="#CCCCFF">精神</td>
                <td align="right" id="chara_max3"></td>
                <td align="right" bgcolor="#FFCCFF">神術熟練</td>
                <td align="right" style="color:#FF0000" id="chara_mjp2"></td>
        </tr>
        <tr>
                <td align="right" height="20" bgcolor="#CCCCFF">運氣</td>
                <td align="right" id="chara_max4"></td>
                <td align="right" bgcolor="#FFCCFF">弓術熟練</td>
                <td align="right" style="color:#FF0000" id="chara_mjp3"></td>
        </tr>
        <tr>
                <td align="right" height="20" bgcolor="#CCCCFF">速度</td>
                <td align="right" id="chara_max5"></td>
                <td align="right" bgcolor="#FFCCFF">忍術熟練</td>
                <td align="right" style="color:#FF0000" id="chara_mjp5"></td>
        </tr>
</table>
</div>
EOF
 
##畫面表示
print <<"EOF";
<style type="text/css">
<!--
#ver1 {
 z-index:1;
 FILTER: alpha(opacity=80); /* IE使用的半透明 */
 -moz-opacity: 0.8; /* Firefox使用的半透明*/
 background-color: #ffffDD;
 width: 186px;
 height: 36px;
}
-->
</style>

$status_s
<table width=94% align=center CLASS=CC>
	    <tr>
	    <td>
		<font align=left color="ffffff" size=3 id="totalPlayer">
	    </td>
		<tr>
	    <td bgcolor="ffffff" id="guestList">
	    </TD>
	    </tr><tr><td><iframe onload="javascript:try{setframeheight();}catch(e){}" framebroder="0" width="100%" height="500" id="actionframe" name="actionframe" style="display:none" scrolling="no"></iframe>
	    </td>
	    </tr>
	    </table>
	<CENTER>
	<table CLASS=CC width=94% id="subTable">
	    <TR>
	    <TD colspan=11 bgcolor=$ELE_BG[$con_ele] style="color:$ELE_C[$con_ele]" id="con_name1">
	    </TD>
	    </TR>
	    <TR>
	    <TD colspan=11 bgcolor=$ELE_C[$con_ele] style="color:$ELE_BG[$con_ele]" id="con_mes">
	    </TD>
	    </TR>
	</table>
	<TABLE border="0" width="95%" id="mainTable">
	<TBODY>
	  $top_print
          <TR>
            <TD height="39">
<a name="upl"></a>
            <TABLE border="0" width=100% bgcolor="#FFFFFF" CLASS=CC>
              <TBODY>
                <TR>
                <form action="./etc.cgi" method="post">
                <input type=hidden name=id value=$mid>
                <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=mode value=setkey>
                  <TD bgcolor="#FFFFFF" width=100>快速指令<INPUT type="submit" CLASS=MFC value="設定" onSubmit="return" check()>
		</TD>
</form>
                <form action="" method="post" id="fastf" target="actionframe">
                <input type=hidden name=id value=$mid>
                <INPUT type=hidden name=pass value=$mpass>
                <input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=rnd>
                <input type=hidden name=mode></form>
		<TD bgcolor="#FFFFFF" align=right>$fastbutton</TD>
		</TR>
		</TBODY>
	</TABLE>
	</TD>
	</TR>
          <TR>
            <TD height="39">
<a name="upl"></a>
            <TABLE border="0" width=100% bgcolor="$FCOLOR2" CLASS=CC>
              <TBODY>
                <TR>
                  <TD colspan="5"><FONT color="#ffffcc">角色狀態</FONT></TD>
                  <TD><FONT color="#ffffcc">指令清單</FONT></TD>
		<TD colspan="2">
<table border=0 width=100% id=table1 cellspacing=0 cellpadding=0>
	<tr>
		<td><DIV id=tok style="color:white"><b>讀取資料中..</b></DIV></td>
		<td align=right><input type=submit CLASS=MFC value="[F5]更新" onclick="javascript:get_all_data();" id="rebutton"></td>
	</tr>
</table>
		</TD>
                </TR>
                <TR>
                  <TD bgcolor="$ELE_C[$mele]" width="50" rowspan="4"><a href="#downl"><img border=0 onmouseover="s_status.style.display='';" onmouseout="s_status.style.display='none';" src="$IMG/chara/$mchara.gif"></a></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">等級</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%" id="mlv"></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">屬性</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%" id="mele"></TD>
                  <TD bgcolor="$ELE_C[$mele]" style="color:blue">訓練．戰鬥</TD>
                  <TD bgcolor="$ELE_C[$mele]">
                <form action="./battle.cgi" method="post" id="battlef" target="actionframe">
                <input type=hidden name=id value=$mid>
                <INPUT type=hidden name=pass value=$mpass>
                <input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=rnd>
                <SELECT name=mode style="WIDTH: 160px">
		</SELECT>
<div style="color:blue;display:none" id="keyver">
請輸入驗證碼：<input type=text name=rnd2 size=10>
</div>
		</TD>
                  <TD bgcolor="$ELE_C[$mele]" width=5%><INPUT type="button" id="battlebutton" CLASS=MFC value="實行" onClick="javascript:spshow=true;actform(this.form);"></TD>
                </form></TR>
                <TR>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">HP</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%" id="mhp" style="color:red"></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">職業</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%" id="mclass"></TD>
                  <TD bgcolor="$ELE_C[$mele]" style="color:red">城鎮設施</TD>
                  <TD bgcolor="$ELE_C[$mele]">
	<form action="./town.cgi" method="post" id="townf" target="actionframe">
                <input type=hidden name=id value=$mid>
                <INPUT type=hidden name=pass value=$mpass>
                <input type=hidden name=rmode value=$in{'rmode'}>
                  <SELECT name=mode>
                    <OPTION value=inn>宿屋
                    <OPTION value=quest>任務屋
                    <OPTION value=arm>武器店
                    <OPTION value=pro>防具店
                    <OPTION value=acc>飾品店
                    <OPTION value=item>道具店
                    <OPTION value=petup>寵物店
                    <OPTION value=mix>工房
                    <OPTION value=mix_change>原料黑商
                    <OPTION value=mixbook>熟書合成室
                    <OPTION value=bank>銀行
                    <OPTION value=storage>倉庫
                    <OPTION value=arena>鬥技場
                    <OPTION value=hinn>高級旅館
                    <OPTION value=fshop>拍賣所
                    <OPTION value=sshop>交易所
                    <OPTION value=battle_entry>天下第一武道會
                </SELECT>
      		  </TD>
                  <TD bgcolor="$ELE_C[$mele]" width=5%>
			<INPUT type="button" CLASS=MFC id="townbutton" value="實行" onClick="javascript:actform(this.form);">
		</TD></form>
                </TR>
                <TR>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">MP</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%" id="mmp" style="color:blue"></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">熟練度</TD>
                  <TD bgcolor="$ELE_C[$mele]" id="mabp"></TD>
                  <TD bgcolor="$ELE_C[$mele]" style="color:green">各項設定</TD>
                  <TD bgcolor="$ELE_C[$mele]">
               <form action="./status.cgi" method=post id="statusf" target="actionframe">
                <input type=hidden name=id value=$mid>
                <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>

                <SELECT name=mode>
                    <OPTION value=status>查看個人資料
                    <OPTION value=equip>使用/裝備/寵物
                    <OPTION>==== 傳送 ====
                    <OPTION value=money_send>傳送金錢
                    <OPTION value=item_send>傳送道具
                    <OPTION>==== 技能設定 ====
                    <OPTION value=tec_set>技能變更
                    <OPTION value=sk_set>奧義變更
                    <OPTION value=skill>奧義取得/修行
                    <OPTION>==== 職業 ====
                    <OPTION value=change>轉職
                    <OPTION value=getabp>取得熟練度
                    <OPTION>==== 煉金 ====
                    <OPTION value=renkin>製作物品
                    <OPTION>==== 自訂 ====
                    <OPTION value=data_change>美容院
                    <OPTION value=prof_edit>更改自傳
                    <OPTION>==== 其他 ====
                    <OPTION value=hero>登錄傳說英雄
                    <OPTION value=backup>資料備份
                    <OPTION value=con_renew>更新所屬國家情報
                    </SELECT>

                    </TD>
                  <TD bgcolor="$ELE_C[$mele]" width=5%>
		<INPUT type="button" CLASS=MFC id="statusbutton" value="實行" onClick="javascript:actform(this.form);"></TD>
		  </form>
                </TR>
                <TR>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">經驗值</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%" id="mex"></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">名聲</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%" id="mcex"></TD>
                  <TD bgcolor="$ELE_C[$mele]">軍事&#12539;內政</TD>
                  <TD bgcolor="$ELE_C[$mele]">
		<form action="./country.cgi" method="post" target="actionframe" id="countryf">
		<input type=hidden name=id value=$mid>
		<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		
		<SELECT name=mode> 
		  <OPTION>====== 交流 ======
                    <OPTION value=all_conv selected>世界留言板
                    <OPTION value=con_conv>$con_name國留言板
                    <OPTION value=all_rule>世界法規
                    <OPTION value=rule>$con_name國法規
                    <OPTION value=king_conv>官職會議
                    <OPTION>====== 軍事 ======
		    <OPTION value=town_build_up>軍防建設
                    <OPTION value=town_def_up>徵兵
                    <OPTION value=town_def_tran>練兵
                    <OPTION value=ram_down>施計
                    <OPTION>====== 內政 ======
                    <OPTION value=money_get>回收收益金
                    <OPTION value=suport_money>貢獻資金
                    <OPTION value=town_up>都市開發
                    <OPTION value=town_arm>武器．防具開發
		    <OPTION value=town_armdel>武器．防具刪除
                    <OPTION value=sirei>更改國家公告
		    <OPTION value=unit>隊伍編成
		    <OPTION>====== 王&#12539;官職 ======
		    <OPTION value=king_com>任命官職
		    <OPTION value=king_change>國王交替
		    <OPTION value=discharge>解雇
		    <OPTION>====== 警備 ======
                    <OPTION value=def>城鎮守備
                    <OPTION value=def_out>解除守備
                    <OPTION >=======獨立=========
                    <OPTION value=con_change>入國
                    <OPTION value=con_change3>下野
                    <OPTION value=build>建國
                    <OPTION>====== 國庫 ======
		    <OPTION value=constorage>國庫
		    <OPTION value=constorage_up>國庫擴充
                    <OPTION value=constorage_log>國庫紀錄
                    </SELECT></TD>
                  <TD bgcolor="$ELE_C[$mele]" width=5%>
<INPUT type="button" CLASS=MFC id="countrybutton" value="實行" onClick="javascript:actform(this.form);"></TD>
		</form>
                </TR>
                <TR>
                  <TD bgcolor="$ELE_C[$mele]" width="72" id="mname"></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="10%">資金<br>銀行</TD>
                  <TD bgcolor="$ELE_C[$mele]" width="134" id="mgold"></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="86" id="mtype"></TD>
                  <TD bgcolor="$ELE_C[$mele]" width="34" id="mjps"></TD>
                  <TD bgcolor="$ELE_C[$mele]">其他</TD>
                  <TD bgcolor="$ELE_C[$mele]">
		<form action="./etc.cgi" method="post">
		<input type=hidden name=id value=$mid>
		<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		
		<SELECT name=mode> 
		　　<OPTION value=move selected>移動
                    <OPTION value=inv>城鎮攻擊
		    <OPTION value=mode_change>更改顯示畫面
     		 </SELECT>
		</TD>
                  <TD bgcolor="$ELE_C[$mele]" width=5%>
		<INPUT type="submit" CLASS=MFC value="實行" onSubmit="return" check()>
		</TD></FORM>
                </TR>
		
              </TBODY>
            </TABLE>
            </TD>
          </TR>
          <TR>
            <TD>
$maplogshow
	    </td>
          </TR>
	  
 
          <TR>
    <TD>
    <TABLE CLASS=TC WIDTH=100%>
	<TR><TD colspan=2 align=center>
	<font color=ffffcc>CHAT</font><BR>
<input type="button" value="[F5]更新所有資料" CLASS=FC style="WIDTH: 200px" onclick="javascript:get_all_data();" id="rbutton">
	</TD></TR>
	<TR><TD colspn=2 bgcolor=$FCOLOR2 align=center>
	</TD>
	</TR>
	<TR>
	<TD bgcolor=$FCOLOR2 width=50% valign='top'>
	<a name="downl">世界頻道</a><BR>
	世頻發言：<input type=text name=mes1 size=30 onKeyPress="return submitenter(1,event)" id="mes1">
    <input type=button id=chat_button1 name=chat_button1 class=FC value=發言 onclick="javascript:chkchat(1);"><a href="#upl">↑↑↑↑↑↑</a>
<table border=0 bgcolor=$FCOLOR width=100% id=mes_all>
</table>
	<br>
        $mname的私頻</font><input type="button" value="[F5]更新所有資料" CLASS=FC onclick="javascript:get_all_data();" id="rbutton2"><BR>
        私頻發言：<input type=text name=mes3 size=30 onKeyPress="return submitenter(3,event)" id="mes3">
    <input type=button id=chat_button3 name=chat_button3 class=FC value=發言 onclick="javascript:chkchat(3);">
<BR>發言對象名稱：</font><input type=text name=aite size=10 id=aite>
<a href="#upl">↑↑↑↑↑↑</a>
        </form>
<table border=0 bgcolor=$FCOLOR width=100% id=mes_private>
</table>
	<TD bgcolor=$FCOLOR2 width=50% valign='top'>
所屬國頻道<BR>
	$con_name國頻發言：<input type=text name=mes2 size=30 onKeyPress="return submitenter(2,event)" id="mes2">
    <input type=button id=chat_button2 name=chat_button2 class=FC value=發言 onclick="javascript:chkchat(2);"><a href="#upl">↑↑↑↑↑↑</a>
	</form>
<table border=0 bgcolor=$FCOLOR width=100% id=mes_con>
</table>
 
	<br>
        <a name="down2"></a>隊伍頻<BR>
        隊伍發言：<input type=text name=mes4 size=30 onKeyPress="return submitenter(4,event)" id="mes4">
    <input type=button id=chat_button4 name=chat_button4 class=FC value=發言 onclick="javascript:chkchat(4);"><a href="#upl">↑↑↑↑↑↑</a>
        </form>
<table border=0 bgcolor=$FCOLOR width=100% id=mes_unit>
</table>
	</TD>
	</TR>
	</TD>
     </TABLE>
	</TD>
	</TR>
        </TBODY>
      </TABLE>
      </TD>
    </TR>
<form action="./status.cgi" method="post" target="chat_post" name="m_all" id="m_all">
        <input type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=chat>
        <input type=hidden name=mes_sel>
        <input type=hidden name=mes>
        <input type=hidden name=aite>
</form>
<iframe src="" width=0 height=0 name=chat_post id=chat_post></iframe>
  </TBODY>
</TABLE>
</CENTER>
<div id="newmsg" style="position:absolute;filter:blendTrans(duration=1); visibility:hidden; background-color:black;width:400px;height:100px;z-index:20;left: 50px;top:0px;"><table border=0 bgcolor=#gray width=100% id=newmsgtb></table></div>
<div id=ver1 style="position: absolute; left: 144px; top: 148px;display:none"><img src="" height="80" width="200" id="verimg"></div>";
<SCRIPT LANGUAGE = "JavaScript"> 
var spshow=true;
function keyDownHandler(e) {   
    if (e) { // Firefox
	if(e.keyCode ==116){
                if(getObj('actionframe').style.display !='none')
                getObj('actionframe').contentWindow.location.reload();
		else if(!getObj('rbutton').disabled)
		get_all_data();
        	e.preventDefault();   
	        e.stopPropagation();
	}else if(e.keyCode==115){
                if(getObj('actionframe').style.display !='none')
                backtown();
                e.preventDefault();
                e.stopPropagation();
	}
    } else { // IE
	if(window.event.keyCode == 116){   
	        window.event.keyCode = 0;
                if(getObj('actionframe').style.display!='none')
                document.frames('actionframe').location.reload();
		else if(!getObj('rbutton').disabled)
		get_all_data();
        	return false;
	}else if(window.event.keyCode == 115){
                window.event.keyCode = 0;
                if(getObj('actionframe').style.display!='none')
                backtown();
                return false;
	}
    }   
}   
document.onkeydown = keyDownHandler;
var userAgent = window.navigator.userAgent;
var isIE = userAgent.indexOf("MSIE") > 0;
getObj('s_status').style.display='none';
var chattime=5;
var battlemap='';
var mcon='$mcon';
function cdtime(){
	if (chattime>0){
		for(var i=1;i<5;i++){
			var buttonObj=getObj('chat_button'+i);
			buttonObj.value=chattime;
			buttonObj.disabled=true;
		}
		chattime--;
	}else{
                for(var i=1;i<5;i++){
                        var buttonObj=getObj('chat_button'+i);
                        buttonObj.value='發言';
                        buttonObj.disabled=false;
                }
	}
	setTimeout("cdtime();",1000);
}
function submitenter(mes_sel,e){
	if (e.keyCode==13){
		chkchat(mes_sel);
		return false;
	}
	else{
		return true;
	}
}
function chkchat(mes_sel){
	var mes=getObj('mes'+mes_sel);
	if(mes){
	if (mes.value ==''){
		alert('請輸入訊息內容!');
	}else{
		if (chattime==0){
			var form=getObj('m_all');
			form.mes.value=mes.value;
			form.mes_sel.value=mes_sel;
			form.aite.value=getObj('aite').value;
			form.submit();
			mes.value='';
			chattime=10;
		}else{
			alert('下次可發言時間剩餘'+chattime+'秒');
		}
	}
	}else{
		alert('程式發生錯誤');
	}
}
setTimeout('get_all_data()',1000);
cdtime();
var systime=0;
var lastchattime='';
var logtime='';
var mtime='';
var fmes=[0,0,0,0,0];
var shotmes=['','','','',''];
var moya=0;
var BTIME=-1;
var Mmr=0;
function loading(msgs,disb){
	BTIME=-1;
 	getObj("tok").innerHTML =("<font color=yellow>剩餘秒數讀取中...</font>");
         getObj('rbutton').value=msgs;
         getObj('rbutton').disabled=disb;
         getObj('rbutton2').value=msgs;
         getObj('rbutton2').disabled=disb;
	 getObj('rebutton').disabled=disb;
	 getObj('rebutton').value=msgs;
	getObj('battlebutton').disabled=disb;
        getObj('townbutton').disabled=disb;
        getObj('statusbutton').disabled=disb;
        getObj('countrybutton').disabled=disb;

}
loading('讀取資料中...',true);
function get_all_data(){
	loading('更新中...',true);
	sid=Math.random();
	var url='';
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var spage='';
  	url='ajax.cgi?id=$in{'id'}&pass=$in{'pass'}&tt='+lastchattime+'&mdate='+mtime+'&logtime='+logtime+'&moya='+moya;
	url=url+"&sid="+sid;
	xmlHttp.onreadystatechange=function(){
		if(xmlHttp.readyState==4){
			var d = xmlHttp.responseText;
			if(d.length>10){
				var tow_data = d.split('\\n');
				for (var i=tow_data.length-1;i>-1;i--){
					var dt=tow_data[i].split('<>');
					if(dt[0]=='VER'){
						if (dt[1] !='$AJAXVER'){
							alert('因為系統版本更新，本頁面將自動重新整理');
							location.reload();
						}else{
				                        loading('[F5]更新所有資料',false);
				                        list_init();
				                        getObj('guestList').innerHTML="";
				                        fmes[1]=0;fmes[2]=0;fmes[3]=0;fmes[4]=0;
						}
						break;
					}
				}
		                for (var i=tow_data.length-1;i>-1;i--){
					if(tow_data[i].length>5){
				            	var dt=tow_data[i].split('<>');
						if(dt[0]=='ERROR'){
							alert(dt[1]);
							location.href='index.cgi';
							break;
						}else if(dt[0]=='ERROR2'){
							alert(dt[1]);
							break;
						}else if(dt[0]=='CHAT'){
						    chat_show(tow_data[i]);
						}else if(dt[0]=='GUEST'){
						    guest_show(tow_data[i]);
                                                }else if(dt[0]=='TOWNDEF'){
                                                        town_def_show(tow_data[i]);
						}else if(dt[0]=='TOWN'){
							town_show(tow_data[i]);
						}else if(dt[0]=='COUNTRY'){
                                                        country_show(tow_data[i]);
						}else if(dt[0]=='BATTLE'){
							bat_list_show(tow_data[i]);
						}else if(dt[0]=='GUESTCOUNT'){
							getObj('totalPlayer').innerHTML="目前線上人數："+dt[1]+"人";
						}else if(dt[0]=='CHARA'){
						    chara_show(tow_data[i]);
						}else if(dt[0]=='ALLTIME'){
							if(logtime != dt[4]){getObj('maplog').innerHTML="";getObj('maplog2').innerHTML="";}
							logtime=dt[4];
							lastchattime=dt[3];
							mtime=dt[2];
							systime=dt[1];
							BTIME=dt[5];
						}else if(dt[0]=='MAPLOG'){
							maplog_show(getObj('maplog'),dt[1]);
                                                }else if(dt[0]=='MAPLOG2'){
							maplog_show(getObj('maplog2'),dt[1]);
						}else if(dt[0]=='ACTION'){
							list_show(getObj('townf').mode,'last',dt[1],'yellow');
                                                }else if(dt[0]=='TOWNSP'){
							list_show(getObj('townf').mode,'first',dt[1],'#ffc0cb');
							if(spshow){
								spshow=false;
								alert('城鎮出現特殊的選項');
							}
                                                }else if(dt[0]=='STATUSSP'){
							list_show(getObj('statusf').mode,'first',dt[1],'#CCFFCC');
							if(spshow){
								spshow=false;
								alert('各項設定出現特殊的選項');
							}
						}else if(dt[0]=='MEMBER'){
							if (dt[0]=='1'){Mmr=1;}
						}
					}
				}
      			}
			if(getObj('town_datas'))
			getObj('shot_mesg').innerHTML=shotmes[1]+shotmes[2]+shotmes[3]+shotmes[4];
		}else if(xmlHttp.readyState==2){
			loading('更新中...',true);
		}
	}
 
	if (url != '') {
		xmlHttp.open("GET",url,true);
		xmlHttp.send(null);
	}
 
}
function country_show(dtstr){
  var dt=dtstr.split('<>');
  getObj('con_name1').innerHTML=dt[2]+"國公告";
  getObj('con_mes').innerHTML=dt[8];
  if(getObj('town_datas')){
	getObj('con_gold_name').innerHTML=dt[2]+"國資金";
	getObj('con_gold').innerHTML=chdl(dt[4]);
  }
}
function maplog_show(obj,ldata){
  obj.innerHTML="●" +ldata+ "<BR>"+obj.innerHTML;
}
function chat_show(dtstr){
  var dt=dtstr.split('<>');
  var oTb;
  var shmt="";
  var fmes_tmp=0;
  var dows="downl";
  var privadd=0;
  if(dt[1]=='1'){
     shmt="世";
     oTb = getObj('mes_all');
  }else if(dt[1]=='2'){
     shmt="國";
     oTb = getObj('mes_con');
  }else if(dt[1]=='3'){
     privadd=0;
     shmt="私";dows="down2";
     oTb = getObj('mes_private');
     create_tb(getObj('newmsgtb'),dt[2],dt[3],dt[4],dt[5],1);
     shownewmsg();
  }else if(dt[1]=='4'){
     shmt="隊";dows="down2";
     oTb = getObj('mes_unit');
  }
  fmes[dt[1]]++;fmes_tmp=fmes[dt[1]];
  if(oTb){
     create_tb(oTb,dt[2],dt[3],dt[4],dt[5],$MES1+privadd);
     if(getObj('town_datas')){
        shotmes[dt[1]]="<a href=#"+dows+"><font color=#AAAAFF>["+shmt+"]</font></a>"+dt[3]+dt[4]+"<font color=gray>"+dt[5]+"</font><BR>";
     }
  }
}
function town_def_show(dtstr){
  if(getObj('town_datas')){
	getObj('def_list').innerHTML="";
	  var dt=dtstr.split('<>');
	  for(var i=1;i<dt.length;i++){
		var dt2=dt[i].split(' ');
		getObj('def_list').innerHTML+="<IMG Src=$IMG/town/shield.jpg><a href=\\\"javascript:void(0)\\\" onClick=\\\"javascipt:show_other_status('"+dt2[1]+"');\\\">"+dt2[0]+"</a>";
	  }
  }
}
function bat_list_show(dtstr){
  var dt=dtstr.split('<>');
  var batlist=getObj('battlef').mode;
  var j=batlist.options.length;
  var wMap = ['1','2','3','4','30','31','40','kunren','toubatsu',''];
  for(var i=0;i<j;i++){
	batlist.remove(0);
  }
  for(var i=1;i<dt.length;i++){
	var dt2=dt[i].split(',');
	if(dt2[0].length>1){
		var op=document.createElement("option"); 
		batlist.appendChild(op);
	        op.text=dt2[0];
	        op.value=dt2[1];
		var t=false;
		for(var j=0;j<wMap.length;j++){
			if (wMap[j]==dt2[1]){
				t=true;
				break;
			}
		}
		if(!t){
			op.style.backgroundColor="yellow";
		}
	}
  }
  if(batlist.options[0].value=='1' && battlemap != ''){
    j=batlist.options.length;
    for(var i=0;i<j;i++){
	if(batlist.options[i].value == battlemap){
try{
		batlist.options[i].selected=true;
}catch(e){}
  	}
    }
  }
}
function list_show(nlist,insertaddr,dtstr,color){
  var dt2=dtstr.split(',');
  if(insertaddr =='last'){
	var op=document.createElement("option");
        nlist.appendChild(op);
        op.text=dt2[0];
        op.value=dt2[1];
	if(color !=''){op.style.backgroundColor=color;}
  }else{
//     if(isIE){
	var op=document.createElement("option");
        nlist.insertBefore(op,nlist.options[0]);
        op.text=dt2[0];
        op.value=dt2[1];
//     }else{
//	nlist.insertBefore(new Option(dt2[0],dt2[1]), nlist.options[0]);
//     }
//     if(color !=''){nlist.options[0].style.backgroundColor=color;}
        if(color !=''){op.style.backgroundColor=color;}
     nlist.options[0].selected=true;
  }

}
function list_init(){
  var townlist=getObj('townf').mode;
  var j=townlist.options.length-1;
  for (var i=j;i>=0;i--){
     if(townlist.options[i].value !='battle_entry')
	townlist.remove(i);
     else
        break;
  }
  j=townlist.options.length-1;
  for (var i=j;i>=0;i--){
    if(townlist.options[0].value !='inn')
	townlist.remove(0);
    else
        break;
  }
  var statuslist=getObj('statusf').mode;
  j=statuslist.options.length-1;
  for (var i=j;i>=0;i--){
     if(statuslist.options[0].value !='status')
        statuslist.remove(0);
     else
        break;
  }
}
function town_show(dtstr){
  var dt=dtstr.split('<>');
  if(getObj('town_datas')){
  	var dtetc=dt[15].split(',');
	var dtbuild=dt[14].split(',');
	getObj('town_gold').innerHTML=chdl(dt[5]);
	getObj('town_xy').innerHTML=dt[12] + ' - ' + dt[13];
	getObj('town_arm').innerHTML=dt[6];
	getObj('town_pro').innerHTML=dt[7];
	getObj('town_acc').innerHTML=dt[8];
	getObj('town_ind').innerHTML=dt[9];
	getObj('town_hp').innerHTML=dtetc[0]+'//'+dtetc[1];
	var add_str,add_def;
	try{
	add_str='+'+Math.floor(dtetc[2]*dtbuild[5]/20);
	}catch(e){}
	try{
        add_def='+'+Math.floor(dtetc[3]*dtbuild[6]/20);
	}catch(e){}
	getObj('town_str').innerHTML=dtetc[2]+''+add_str;
	getObj('town_def').innerHTML=dtetc[3]+''+add_def;
	getObj('town_name2').innerHTML=dt[2]+'的情報';
	getObj('town_name1').innerHTML=dt[2];
	getObj('con2_name').innerHTML=dt[3];
	getObj('town_ele').innerHTML=dt[4];
        getObj('town_def_max').innerHTML=dtbuild[2];
  }
}
function guest_show(dtstr){
  var dt=dtstr.split('<>');
  var oTb = getObj('guestList');
  oTb.innerHTML="★<a href=\\\"javascript:void(0)\\\" onClick=\\\"javascipt:show_other_status('"+dt[1]+"');\\\"><font color="+dt[2]+">"+dt[3]+"</a></font>"+oTb.innerHTML;;
}
function chara_show(dtstr){
  var dt=dtstr.split('<>');
  if(mcon != dt[24]){
          alert('因為更換國家，系統將自動重新整理');
          location.reload();
  }
  var mjp=dt[20].split(',');
  var mmax=dt[14].split(',');
  for(var i=0;i<6;i++){
	getObj('chara_mjp'+i).innerHTML=mjp[i];
        getObj('chara_max'+i).innerHTML=dt[8+i]+'('+mmax[i]+')';
  }
  var m_maxmaxhp=mmax[0]*5+mmax[1]*10+mmax[3]*3-2000;
  var m_maxmaxmp=mmax[2]*5 + mmax[3]*3 -800;
  getObj('mname').innerHTML=dt[1]+'<BR>'+'戰數：'+dt[36];
  getObj('chara_maxmaxhp').innerHTML=dt[4]+'('+m_maxmaxhp+')';
  getObj('chara_maxmaxmp').innerHTML=dt[6]+'('+m_maxmaxmp+')';
  getObj('mlv').innerHTML=parseInt(dt[18]/100)+1;
  getObj('mele').innerHTML=dt[7];
  getObj('mhp').innerHTML=dt[3]+'/'+dt[4];
  getObj('mmp').innerHTML=dt[5]+'/'+dt[6];
  getObj('mabp').innerHTML=dt[21];
  getObj('mtype').innerHTML=dt[47]+'熟練度';
  getObj('mex').innerHTML=dt[18];
  getObj('mclass').innerHTML=dt[35];
  getObj('mcex').innerHTML=dt[22];
  getObj('mjps').innerHTML=mjp[dt[38]];
	getObj('ver1').style.display='none';
	getObj('keyver').style.display='none';
	getObj('battlef').rnd2.value=dt[39];
  moya=dt[39];
  getObj('mgold').innerHTML='<font color=blue>'+chdl(dt[16])+'</font><br><font color=green>'+chdl(dt[17])+'</font>';
}
function show_other_status(dt1){
	window.open('./status_print.cgi?id='+dt1, 'newwin', 'width=600,height=400,scrollbars =yes');
} 
function create_tb(tbl1,chara,lname,lmes,daytime,maxmsg){
	var oTr=tbl1.insertRow(0);
	var oTd=oTr.insertCell(-1);
	oTd.bgColor="#000000";
	oTd.align="middle";
	oTd.width="15%";
	oTd.innerHTML='<img border=0 src=$IMG/chara/'+chara+'.gif></a>';
	var oTd2=oTr.insertCell(-1);
	oTd.align="left";
	oTd2.bgColor="#000000";
	oTd2.innerHTML='<b>'+lname+'<BR><font color=ffffff>「'+lmes+'」</b></font><font color=#999999 size=1><BR>('+daytime+')</font>';
		var rws=tbl1.getElementsByTagName('TR');
	if(tbl1.rows.length>maxmsg){
		tbl1.rows[maxmsg].parentNode.removeChild(tbl1.rows[maxmsg]);
 
	}
 
}
function GetXmlHttpObject(){
	var xmlHttp=null;
	try
	  {
	  // Firefox, Opera 8.0+, Safari
	  xmlHttp=new XMLHttpRequest();
	  }
	catch (e)
	  {
	  // Internet Explorer
	  try
	    {
	    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	    }
	  catch (e)
	    {
	    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	    }
	  }
	return xmlHttp;
}
function opstatue(pid){
        window.open('./status_print.cgi?id='+pid, 'newwin', 'width=600,height=400,scrollbars =yes');
}
        now=new Date();
function to() {
	if(BTIME>0){BTIME--;
        getObj("tok").innerHTML =("<font color=#FFFFFF>距下次行動剩餘" + BTIME + "秒</font>");
	}
        if(BTIME<1 && !getObj('battlebutton').disabled){
                getObj("tok").innerHTML =("<font color=#FFFFFF><b>行動ＯＫ</b></font>");
        }
        setTimeout("to()", 1000);
}
function fastkeyform(fc,fi){
	fastf.action=fc+'.cgi';
	fastf.mode.value=fi;
	actform(fastf);
}
function actform(form){
	getObj('mainTable').style.display='none';
        getObj('subTable').style.display='none';
	getObj('actionframe').style.display='';
	getObj('battlef').rnd.value=getObj('battlef').rnd2.value;
	getObj('ver1').style.display='none';
	try{
		var nmp=form.mode.options[form.mode.selectedIndex].value;
		if(nmp =='1' || nmp=='2' ||nmp=='3' || nmp=='4' || nmp=='30' || nmp=='31' || nmp=='40'){
			battlemap=nmp;
		}
	}catch(e){}
	form.submit();
}
function backtown(){
	if(isIE){
		parent.frames['main'].focus();
	}
	try{
		getObj('statusf').mode.options[0].selected=true;
		getObj('countryf').mode.options[1].selected=true;
		getObj('townf').mode.options[0].selected=true;
	}catch(e){}
	getObj('mainTable').style.display='';
	getObj('subTable').style.display='';
	getObj('actionframe').style.display='none';
	if(isIE){
		document.frames('actionframe').document.body.innerHTML='<BR><BR><p align="center"><i><font size=4 color=white>資料讀取中....</font></i></p>';
	}else{
	var iObj = document.getElementById('actionframe').contentDocument;
	iObj.body.innerHTML='<BR><BR><p align="center"><i><font color=white size=4>資料讀取中....</font></i></p>';
	}
        var iObj;
       if(isIE){
            iObj=getObj('actionframe');
            iObj.style.height="400px";
        }else{
            iObj = getObj('actionframe');
            iObj.style.height="400px";
        }

	get_all_data();
	scrollToTop.action();
}
function chdl(dl){
	var dl1="";
	var dl2="";
	var dl3="";
	var ldl="";
	if(dl>99999999){
		dl1=parseInt(dl/100000000)+'億';
	}
	if(dl>9999){
		dl2=parseInt((dl % 100000000)/10000)+'萬';
	}
	if(dl % 10000>1){
		dl3=(dl%10000);
	}
	ldl=dl1+dl2+dl3;
	if(ldl==''){ldl="0 Gold"}else if(dl<10000){ldl+=" Gold";}
	return ldl;
}
function getObj(objName){
	return document.getElementById(objName);
}
function setframeheight(){
        var iObj;
       if(isIE){
            iObj=getObj('actionframe');
            iObj2=document.frames('actionframe').document.body;
            iObj.style.height=iObj2.scrollHeight;
        }else{
            iObj = getObj('actionframe');
	    iObj.style.height=iObj.contentDocument.body.scrollHeight;
        }
}
	scrollToTop=new Object();
	scrollToTop.scrollTop=null;
	scrollToTop.scrollLeft=null;
	scrollToTop.action=function(){
		if(isIE){
			parent.frames('main').focus;
		}else{
//			parent.contentDocument.getElementById('main').focus;
		}
		if(scrollToTop.scrollTop==null){
		var pageY = window.pageYOffset || (document.documentElement.scrollTop || document.body.scrollTop);
		var pageX = window.pageXOffset || (document.documentElement.scrollLeft || document.body.scrollLeft);  
		scrollToTop.scrollTop=pageY;
		scrollToTop.scrollLeft=pageX;
		}
		scrollToTop.scrollTop=0;
		window.scroll(scrollToTop.scrollLeft,scrollToTop.scrollTop); 
		if(scrollToTop.scrollTop>0){ 
		return;
		}
		scrollToTop.scrollTop=null;
		scrollToTop.scrollLeft=null;
	}

function MoveLayer() {
	var x = 50;
	var y = 100;
	var _y = document.body.scrollTop + y;
	var diff =(_y - parseInt(document.getElementById('newmsg').style.top))*.40;
	var rey=_y-diff;
	document.getElementById('newmsg').style.top=rey;
	document.getElementById('newmsg').style.right=x;
	setTimeout("MoveLayer();", 500);
}

function shownewmsg(msg){
	document.getElementById('newmsg').style.visibility='visible';
	MoveLayer("newmsg");
	setTimeout('hidemsg()',5000);
}
function hidemsg(){
	document.getElementById('newmsg').style.visibility='hidden';
}
to();
//-->
</SCRIPT>
EOF
 
&mainfooter;
 
exit;
1;


