#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';

 
&decode;

&chara_open;
&town_open;
&con_open;
&time_data;
foreach(@CON_DATA){
    ($con2_id,$con2_name,$con2_ele,$con2_gold,$con2_king,$con2_yaku,$con2_cou,$con2_mes,$con2_etc)=split(/<>/);
    if("$con2_id" eq "$town_con"){$hit=1;last;}
} 
if(!$hit){$con2_ele=0;$con2_name="無所屬";$con2_id=0;}

&fixext_open;
foreach(@fixext_fkey){
	($fclass,$fcmd,$fname)=split(/,/,$_);
	if($fclass ne""){
		$fastbutton.="<input type=button value=$fname onclick=fastkeyform('$fclass','$fcmd');>";
	}
}

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
&header;
if($hour > 20 || $hour < 4){$timg ="$TOWN_IMG2";}
else{$timg ="$TOWN_IMG";}
if($mflg<2){require'./etc/top_print.pl';&top_print;}
$status_s=<<"EOF";
<div style="position: absolute; width: 187px; height: 143px; z-index: 1; left: 145px; top: 400px; display:none" id="s_status">
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
<style>
.mes_block{
    height:700px;
    width:100%;
    overflow:auto;
}
.mes_block td:nth-child(1){
    text-align: center;
    width: 15%;
    background-color: #000000;
}
.mes_block td:nth-child(2){
    align: left;
    width: 85%;
    background-color: #000000;
}
</style>
$status_s
<table width=94% align=center CLASS=CC>
	    <tr>
	    <td>
		<font align=left color="ffffff" size=3 id="totalPlayer">
	    </td>
		<tr>
	    <td bgcolor="ffffff" id="guestList">
	    </td>
	    </tr><tr><td><iframe onload="javascript:try{setframeheight();}catch(e){}" framebroder="0" width="100%" height="500" id="actionframe" name="actionframe" style="display:none" scrolling="no"></iframe>
	    </td>
	    </tr>
	    </table>
	<center>
	<table CLASS=CC width=94% id="subTable">
	    <tr>
	    <td colspan=11 bgcolor=$ELE_BG[$con_ele] style="color:$ELE_C[$con_ele]" id="con_name1">
	    </td>
	    </tr>
	    <tr>
	    <td colspan=11 bgcolor=$ELE_C[$con_ele] style="color:$ELE_BG[$con_ele]" id="con_mes">
	    </td>
	    </tr>
	</table>
	<table border="0" width="95%" id="mainTable">
	<tbody>
	  $top_print
          <tr>
            <td height="39">
<a name="upl"></a>
            <table border="0" width=100% bgcolor="#FFFFFF" CLASS=CC>
              <tbody>
                <tr>
                <form action="./etc.cgi" method="post" target="actionframe">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=mode value=setkey>
                  <td bgcolor="#FFFFFF" width=100>快速指令<input type="button" CLASS=MFC value="設定" onclick="actform(this.form)">
		</td>
</form>
                <form action="" method="post" id="fastf" target="actionframe">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass>
                <input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=rnd>
                <input type=hidden name=mode></form>
		<td bgcolor="#FFFFFF" align=right>$fastbutton</td>
		</tr>
		</tbody>
	</table>
	</td>
	</tr>
          <tr>
            <td height="39">
            <table border="0" width=100% bgcolor="$FCOLOR2" CLASS=CC>
              <tbody>
                <tr>
                  <td colspan="5"><font color="#ffffcc">角色狀態</font></td>
                  <td><font color="#ffffcc">指令清單</font></td>
		<td colspan="2">
<table border=0 width=100% id=table1 cellspacing=0 cellpadding=0>
	<tr>
		<td><DIV id=tok style="color:white"><b>讀取資料中..</b></DIV></td>
		<td align=right><input type=submit CLASS=MFC value="[F5]更新" onclick="javascript:get_all_data();" id="rebutton"></td>
	</tr>
</table>
		</td>
                </tr>
                <tr>
                  <td bgcolor="$ELE_C[$mele]" width="50" rowspan="4"><a href="#downl"><img border=0 onmouseover="s_status.style.display='';" onmouseout="s_status.style.display='none';" src="$IMG/chara/$mchara.gif"></a></td>
                  <td bgcolor="$ELE_C[$mele]" width="10%">等級</td>
                  <td bgcolor="$ELE_C[$mele]" width="10%" id="mlv"></td>
                  <td bgcolor="$ELE_C[$mele]" width="10%">屬性</td>
                  <td bgcolor="$ELE_C[$mele]" width="10%" id="mele"></td>
                  <td bgcolor="$ELE_C[$mele]" style="color:blue">訓練．戰鬥</td>
                  <td bgcolor="$ELE_C[$mele]">
                <form action="./battle.cgi" method="post" id="battlef" target="actionframe">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass>
                <input type=hidden name=rmode value=$in{'rmode'}>
                <input type=hidden name=rnd>
                <select name=mode style="WIDTH: 160px">
		</SELECT>
<input type="checkbox" id="autoattack" />自動戰鬥
		</td>
                  <td bgcolor="$ELE_C[$mele]" width=5%><input type="button" id="battlebutton" CLASS=MFC value="實行" onClick="javascript:spshow=true;actform(this.form);"></td>
                </form></tr>
                <tr>
                  <td bgcolor="$ELE_C[$mele]" width="10%">HP</td>
                  <td bgcolor="$ELE_C[$mele]" width="10%" id="mhp" style="color:red"></td>
                  <td bgcolor="$ELE_C[$mele]" width="10%">職業</td>
                  <td bgcolor="$ELE_C[$mele]" width="10%" id="mclass"></td>
                  <td bgcolor="$ELE_C[$mele]" style="color:red">城鎮設施</td>
                  <td bgcolor="$ELE_C[$mele]">
	<form action="./town.cgi" method="post" id="townf" target="actionframe">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass>
                <input type=hidden name=rmode value=$in{'rmode'}>
                  <select name=mode>
                    <option value=inn>宿屋</option>
                    <option value=quest>任務屋</option>
                    <option value=arm>武器店</option>
                    <option value=pro>防具店</option>
                    <option value=acc>飾品店</option>
                    <option value=item>道具店</option>
                    <option value=petup>寵物店</option>
                    <option value=mix>工房</option>
                    <option value=mix_change>原料黑商</option>
                    <option value=mixbook>熟書合成室</option>
                    <option value=bank>銀行</option>
                    <option value=storage>倉庫</option>
                    <option value=arena>鬥技場</option>
                    <option value=hinn>高級旅館</option>
                    <option value=fshop>拍賣所</option>
                    <option value=sshop>交易所</option>
                    <option value=battle_entry>天下第一武道會</option>
                    <option value="action">活動兌換屋</option>
                </SELECT>
      		  </td>
                  <td bgcolor="$ELE_C[$mele]" width=5%>
			<input type="button" CLASS=MFC id="townbutton" value="實行" onClick="javascript:actform(this.form);">
		</td></form>
                </tr>
                <tr>
                  <td bgcolor="$ELE_C[$mele]" width="10%">MP</td>
                  <td bgcolor="$ELE_C[$mele]" width="10%" id="mmp" style="color:blue"></td>
                  <td bgcolor="$ELE_C[$mele]" width="10%">熟練度</td>
                  <td bgcolor="$ELE_C[$mele]" id="mabp"></td>
                  <td bgcolor="$ELE_C[$mele]" style="color:green">各項設定</td>
                  <td bgcolor="$ELE_C[$mele]">
               <form action="./status.cgi" method=post id="statusf" target="actionframe">
                <input type=hidden name=id value=$mid>
                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>

                <select name=mode>
                    <option value=status>查看個人資料
                    <option value=equip>使用/裝備/寵物
                    <option>==== 傳送 ====
                    <option value=money_send>傳送金錢
                    <option value=item_send>傳送道具
                    <option>==== 技能設定 ====
                    <option value=tec_set>技能變更
                    <option value=sk_set>奧義變更
                    <option value=skill>奧義取得/修行
                    <option>==== 職業 ====
                    <option value=change>轉職
                    <option value=getabp>取得熟練度
                    <option>==== 煉金 ====
                    <option value=renkin>製作物品
                    <option>==== 自訂 ====
                    <option value=data_change>美容院
                    <option value=prof_edit>更改自傳
                    <option>==== 其他 ====
                    <option value=hero>登錄傳說英雄
                    <option value=con_renew>更新所屬國家情報
                    </SELECT>

                    </td>
                  <td bgcolor="$ELE_C[$mele]" width=5%>
		<input type="button" CLASS=MFC id="statusbutton" value="實行" onClick="javascript:actform(this.form);"></td>
		  </form>
                </tr>
                <tr>
                  <td bgcolor="$ELE_C[$mele]" width="10%">經驗值</td>
                  <td bgcolor="$ELE_C[$mele]" width="10%" id="mex"></td>
                  <td bgcolor="$ELE_C[$mele]" width="10%">名聲</td>
                  <td bgcolor="$ELE_C[$mele]" width="10%" id="mcex"></td>
                  <td bgcolor="$ELE_C[$mele]">軍事&#12539;內政</td>
                  <td bgcolor="$ELE_C[$mele]">
		<form action="./country.cgi" method="post" target="actionframe" id="countryf">
		<input type=hidden name=id value=$mid>
		<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		
		<select name=mode> 
		  <option>====== 交流 ======
                    <option value=all_conv selected>世界留言板
                    <option value=con_conv>$con_name國留言板
                    <option value=all_rule>世界法規
                    <option value=rule>$con_name國法規
                    <option value=king_conv>官職會議
                    <option>====== 軍事 ======
		    <option value=town_build_up>軍防建設
                    <option value=town_def_up>徵兵
                    <option value=town_def_tran>練兵
                    <option value=ram_down>施計
                    <option>====== 內政 ======
                    <option value=money_get>回收收益金
                    <option value=suport_money>貢獻資金
                    <option value=town_up>都市開發
                    <option value=town_arm>武器．防具開發
		    <option value=town_armdel>武器．防具刪除
                    <option value=sirei>更改國家公告
		    <option value=unit>隊伍編成
		    <option>====== 王&#12539;官職 ======
		    <option value=king_com>任命官職
		    <option value=king_change>國王交替
		    <option value=discharge>解雇
		    <option>====== 警備 ======
                    <option value=def>城鎮守備
                    <option value=def_out>解除守備
                    <option >=======獨立=========
                    <option value=con_change>入國
                    <option value=con_change3>下野
                    <option value=build>建國
                    <option>====== 國庫 ======
		    <option value=constorage>國庫
		    <option value=constorage_up>國庫擴充
                    <option value=constorage_log>國庫紀錄
                    </SELECT></td>
                  <td bgcolor="$ELE_C[$mele]" width=5%>
<input type="button" CLASS=MFC id="countrybutton" value="實行" onClick="javascript:actform(this.form);"></td>
		</form>
                </tr>
                <tr>
                  <td bgcolor="$ELE_C[$mele]" width="72" id="mname"></td>
                  <td bgcolor="$ELE_C[$mele]" width="10%">資金<br>銀行</td>
                  <td bgcolor="$ELE_C[$mele]" width="134" id="mgold"></td>
                  <td bgcolor="$ELE_C[$mele]" width="86" id="mtype"></td>
                  <td bgcolor="$ELE_C[$mele]" width="34" id="mjps"></td>
                  <td bgcolor="$ELE_C[$mele]">其他</td>
                  <td bgcolor="$ELE_C[$mele]">
		<form action="./etc.cgi" method="post">
		<input type=hidden name=id value=$mid>
		<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
		
		<select name=mode> 
		　　<option value=move selected>移動
                    <option value=inv>城鎮攻擊
		    <option value=mode_change>更改顯示畫面
     		 </SELECT>
		</td>
                  <td bgcolor="$ELE_C[$mele]" width=5%>
		<input type="submit" CLASS=MFC value="實行" onSubmit="return" check()>
		</td></FORM>
                </tr>
		
              </tbody>
            </table>
            </td>
          </tr>
          <tr>
            <td>
$maplogshow
	    </td>
          </tr>
          <tr>
    <td>
    <table CLASS=TC WIDTH=100%>
        <tr>
            <td colspan=2 align=center>
                <font color=ffffcc>CHAT</font><br>
                <input type="button" value="[F5]更新所有資料" CLASS=FC style="WIDTH: 200px" onclick="javascript:get_all_data();" id="rbutton">
            </td>
        </tr>
        <tr>
            <td bgcolor=$FCOLOR2 width=50% valign='top'>
                <a name="downl">世界頻道</a><br>
                世頻發言：<input type=text name=mes1 size=30 onKeyPress="return submitenter(1,event)" id="mes1">
                <input type=button id=chat_button1 name=chat_button1 class=FC value=發言 onclick="javascript:chkchat(1);"><a href="#upl">↑↑↑↑↑↑</a>
                <div class="mes_block">
                    <table border=0 bgcolor=$FCOLOR width=100% id=mes_all></table>
                </div>
	            <br>$mname的私頻</font><input type="button" value="[F5]更新所有資料" CLASS=FC onclick="javascript:get_all_data();" id="rbutton2"><br>
                私頻發言：<input type=text name=mes3 size=30 onKeyPress="return submitenter(3,event)" id="mes3">
                <input type=button id=chat_button3 name=chat_button3 class=FC value=發言 onclick="javascript:chkchat(3);">
                <br>發言對象名稱：</font><input type=text name=aite size=10 id=aite>
                <a href="#upl">↑↑↑↑↑↑</a>
                <div class="mes_block">
                    <table border=0 bgcolor=$FCOLOR width=100% id=mes_private></table>
                </div>
            </td>
	        <td bgcolor=$FCOLOR2 width=50% valign='top'>
                所屬國頻道<br>
                $con_name國頻發言：<input type=text name=mes2 size=30 onKeyPress="return submitenter(2,event)" id="mes2">
                <input type=button id=chat_button2 name=chat_button2 class=FC value=發言 onclick="javascript:chkchat(2);"><a href="#upl">↑↑↑↑↑↑</a>
                <div class="mes_block">
                    <table border=0 bgcolor=$FCOLOR width=100% id=mes_con></table>
                </div>
            	<br>
                <a name="down2"></a>隊伍頻<br>
                隊伍發言：<input type=text name=mes4 size=30 onKeyPress="return submitenter(4,event)" id="mes4">
                <input type=button id=chat_button4 name=chat_button4 class=FC value=發言 onclick="javascript:chkchat(4);"><a href="#upl">↑↑↑↑↑↑</a>
                <div class="mes_block">
                    <table border=0 bgcolor=$FCOLOR width=100% id=mes_unit></table>
                </div>
	        </td>
	    </tr>
    </table>
	</td>
	</tr>
        </tbody>
      </table>
      </td>
    </tr>
</tbody>
</table>
</center>
<div id="newmsg" style="position:fixed;filter:blendTrans(duration=1); display:none; background-color:black;width:400px;height:100px;z-index:20;left: 50px;top:100px;"><table border=0 width=100% id=newmsgtb></table></div>
<script> 
var spshow=true;
document.addEventListener('keydown', (e) => {
    if (e.key==='F4'){
        backtown();
        e.preventDefault();
        e.stopPropagation();
    }else if(e.key==='F5'){
        get_all_data();
        e.preventDefault();
        e.stopPropagation();
    }
});
var chattime=0;
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
    const mes = getObj('mes'+mes_sel);
	if(mes.value ==''){
        alert('請輸入訊息內容!');
    }else if(chattime !== 0){
        alert('下次可發言時間剩餘'+chattime+'秒');
    }else{
        const data = new URLSearchParams({
            mes: mes.value, mes_sel: mes_sel, aite:getObj('aite').value,
            id: "$mid", pass: "$mpass", mode: "chat"
        });
        fetch("status.cgi", {
            method: 'POST',
            body: data
        }).then(res => {
            if(!res.ok){
                res.text().then(text => alert(text));
            }else{
                mes.value='';
                chattime=10;
                get_all_data();
            }
        });
    }
}
cdtime();
var systime=0;
var lastchattime='';
var logtime='';
var mtime='';
var shotmes=['','','','',''];
var moya=0;
var BTIME=-1;
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
	var url='';
	xmlHttp = new XMLHttpRequest();
	if (xmlHttp==null) {
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	url='ajax.cgi?id=$in{'id'}&pass=$in{'pass'}&tt='+lastchattime+'&logtime='+logtime+'&moya='+moya;
	xmlHttp.onreadystatechange=function(){
		if(xmlHttp.readyState==4){
			var d = xmlHttp.responseText;
            var tow_data = d.split('\\n');
            loading('[F5]更新所有資料',false);
            list_init();
            getObj('guestList').innerHTML="";
            for (var i=tow_data.length-1;i>-1;i--){
                if(tow_data[i].length>5){
                    var dt=tow_data[i].split('<>');
                    if(dt[0]=='ERROR'){
                        alert(dt[1]);
                        location.href='index.cgi';
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
                        if(logtime != dt[3]){getObj('maplog').innerHTML="";getObj('maplog2').innerHTML="";}
                        systime=dt[1];
                        lastchattime=dt[2];
                        logtime=dt[3];
                        BTIME=dt[4];
                    }else if(dt[0]=='MAPLOG'){
                        maplog_show(getObj('maplog'),dt[1]);
                    }else if(dt[0]=='MAPLOG2'){
                        maplog_show(getObj('maplog2'),dt[1]);
                    }else if(dt[0]=='TOWNSP'){
                        list_show(getObj('townf').mode, dt[1],'#ffc0cb');
                        if(spshow){
                            spshow=false;
                            alert('城鎮出現特殊的選項');
                        }
                    }else if(dt[0]=='STATUSSP'){
                        list_show(getObj('statusf').mode, dt[1],'#CCFFCC');
                        if(spshow){
                            spshow=false;
                            alert('各項設定出現特殊的選項');
                        }
                    }
                }
            }
            
			getObj('shot_mesg').innerHTML=shotmes[1]+shotmes[2]+shotmes[3]+shotmes[4];
		}else if(xmlHttp.readyState==2){
			loading('更新中...',true);
		}
	}
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
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
  obj.innerHTML="●" +ldata+ "<br>"+obj.innerHTML;
}
function chat_show(dtstr){
    var dt=dtstr.split('<>');
    var oTb;
    var shmt="";
    var dows="downl";
    if(dt[1]=='1'){
        shmt="世";
        oTb = getObj('mes_all');
    }else if(dt[1]=='2'){
        shmt="國";
        oTb = getObj('mes_con');
    }else if(dt[1]=='3'){
        shmt="私";dows="down2";
        oTb = getObj('mes_private');
        create_tb(getObj('newmsgtb'),dt[2],dt[3],dt[4],dt[5],1);
        shownewmsg();
    }else if(dt[1]=='4'){
        shmt="隊";dows="down2";
        oTb = getObj('mes_unit');
    }
    if(oTb){
        create_tb(oTb,dt[2],dt[3],dt[4],dt[5],$MES_MAX);
        if(getObj('town_datas')){
            shotmes[dt[1]]="<a href=#"+dows+"><font color=#AAAAFF>["+shmt+"]</font></a>"+dt[3]+dt[4]+"<font color=gray>"+dt[5]+"</font><br>";
        }
    }
}
function town_def_show(dtstr){
    if(getObj('town_datas')){
        getObj('def_list').innerHTML="";
        var dt=dtstr.split('<>');
        for(var i=1;i<dt.length;i++){
            var dt2=dt[i].split(' ');
            getObj('def_list').innerHTML+="<img Src=$IMG/town/shield.jpg><a href=\\\"javascript:void(0)\\\" onClick=\\\"javascipt:show_other_status('"+dt2[1]+"');\\\">"+dt2[0]+"</a>";
        }
    }
}
function bat_list_show(dtstr){
    var dt=dtstr.split('<>');
    var batlist=getObj('battlef').mode;
    var wMap = ['1','2','3','4','30','31','40','kunren','toubatsu',''];
    batlist.innerHTML="";
    for(var i=1;i<dt.length;i++){
        var dt2=dt[i].split(',');
        var op=document.createElement("option"); 
        batlist.appendChild(op);
        op.text=dt2[0];
        op.value=dt2[1];
        if(wMap.indexOf(op.value) === -1){
            op.style.backgroundColor="yellow";
        }
    }
    if(batlist.options[0].value=='1' && battlemap != ''){
        j=batlist.options.length;
        for(var i=0;i<j;i++){
            if(batlist.options[i].value == battlemap){
                batlist.options[i].selected=true;
            }
        }
    }
}
function list_show(nlist,insertaddr,dtstr,color){
    var dt2=dtstr.split(',');
    var op=document.createElement("option");
    nlist.insertBefore(op,nlist.options[0]);
    op.text=dt2[0];
    op.value=dt2[1];

    if(color !=''){op.style.backgroundColor=color;}
    nlist.options[0].selected=true;
}
function list_init(){
    var townlist=getObj('townf').mode;
    var j=townlist.options.length-1;
    for (var i=j;i>=0;i--){
        if(townlist.options[i].value !='battle_entry'){
            townlist.remove(i);
        }else{
            break;
        }
    }
    j=townlist.options.length-1;
    for (var i=j;i>=0;i--){
        if(townlist.options[0].value !='inn'){
            townlist.remove(0);
        }else{
            break;
        }
    }
    var statuslist=getObj('statusf').mode;
    j=statuslist.options.length-1;
    for (var i=j;i>=0;i--){
        if(statuslist.options[0].value !='status'){
            statuslist.remove(0);
        }else{
            break;
        }
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
        var add_str='+'+Math.floor(dtetc[2]*dtbuild[5]/20);
        var add_def='+'+Math.floor(dtetc[3]*dtbuild[6]/20);
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
    getObj('mname').innerHTML=dt[1]+'<br>'+'戰數：'+dt[36];
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
    getObj('battlef').rnd.value=dt[39];
    moya=dt[39];
    getObj('mgold').innerHTML='<font color=blue>'+chdl(dt[16])+'</font><br><font color=green>'+chdl(dt[17])+'</font>';
}
function show_other_status(dt1){
	window.open('./status_print.cgi?id='+dt1, 'newwin', 'width=600,height=400,scrollbars =yes');
} 
function create_tb(tbl1,chara,lname,lmes,daytime,maxmsg){
	var oTr=tbl1.insertRow(0);
	var oTd=oTr.insertCell(-1);
	oTd.innerHTML='<img src=$IMG/chara/'+chara+'.gif></a>';
	var oTd2=oTr.insertCell(-1);
	oTd2.innerHTML='<b>'+lname+'<br><font color=ffffff>「'+lmes+'」</b></font><font color=#999999 size=1><br>('+daytime+')</font>';
    var rws=tbl1.getElementsByTagName('TR');
	if(tbl1.rows.length>maxmsg){
		tbl1.rows[maxmsg].parentNode.removeChild(tbl1.rows[maxmsg]);
	}
}

function opstatue(pid){
    window.open('./status_print.cgi?id='+pid, 'newwin', 'width=600,height=400,scrollbars =yes');
}
function to() {
	if(BTIME>0){
        BTIME--;
        getObj("tok").innerHTML =("<font color=#FFFFFF>距下次行動剩餘" + BTIME + "秒</font>");
	}
    if(BTIME<=0){
		getObj("tok").innerHTML =("<font color=#FFFFFF><b>行動ＯＫ</b></font>");
        if(getObj("autoattack").checked){
            const data = new URLSearchParams(new FormData(getObj('battlef')));
            fetch('battle.cgi', {
                method: 'POST',
                body: data
            }).then(response => {
                spshow=true;
                get_all_data();
            });
        }
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
	try{
		var nmp=form.mode.options[form.mode.selectedIndex].value;
		if(nmp =='1' || nmp=='2' ||nmp=='3' || nmp=='4' || nmp=='30' || nmp=='31' || nmp=='40'){
			battlemap=nmp;
		}
	}catch(e){}
	form.submit();
}
function backtown(){
    getObj('statusf').mode.options[0].selected=true;
    getObj('countryf').mode.options[1].selected=true;
    getObj('townf').mode.options[0].selected=true;

	getObj('mainTable').style.display='';
	getObj('subTable').style.display='';
	getObj('actionframe').style.display='none';

	var iObj = document.getElementById('actionframe').contentDocument;
	iObj.body.innerHTML='<br><br><p align="center"><i><font color=white size=4>資料讀取中....</font></i></p>';

    getObj('actionframe').style.height="400px";
	get_all_data();
	scrollTo(0,0);
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
    var iObj = getObj('actionframe');
    iObj.style.height=iObj.contentDocument.body.scrollHeight;
}
function shownewmsg(msg){
	document.getElementById('newmsg').style.display='';
	setTimeout('hidemsg()',5000);
}
function hidemsg(){
	document.getElementById('newmsg').style.display='none';
}
get_all_data();
to();
</script>
EOF
 
&mainfooter;
 
exit;
1;


