#_/_/_/_/_/_/_/_/_/#
#_/ 登&#37682;情報變更 _/#
#_/_/_/_/_/_/_/_/_/#

sub data_change {
#one_piece118.gif
#bleach188.gif
#naruto389.gif
        &chara_open;
        &ext_open;
        &header;
		if ($mtotal>=10000 || $member_point ne""){
			$sel="<a href=act_icon.cgi?sel=one_piece target=_blank>動態頭像一覽</a><BR><a href=\"#\" onclick=\"javascript:changeSel('',627);\">一般頭像</a>　<a href=\"#\" onclick=\"javascript:changeSel('one_piece',117);\">海賊王頭像</a>　<a href=\"#\" onclick=\"javascript:changeSel('naruto',388);\">火影忍者頭像</a>　<a href=\"#\" onclick=\"javascript:changeSel('bleach',187);\">死神頭像</a>　<a href=\"#\" onclick=\"javascript:changeSel('fma',84);\">鋼之鍊金術師</a><BR>";
		}
        print <<"EOM";
        <TABLE border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
         <TBODY>
         <TR>
          <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">美容院</FONT></TD>
         </TR>
         <TR>
          <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/house.jpg"></TD>
          <TD bgcolor="#330000"><FONT color="#ffffcc">你好,歡迎來到美容院。<BR>請選擇你要修改的圖案。<BR>一般頭像整型一次需要<font color=red>１０萬</font>。大於1萬戰可選其他頭像，整型一次需要１億</FONT></TD>
         </TR>
         <TR>
          <TD colspan=2 align=center bgcolor=$FCOLOR2>
           <TABLE bgcolor=$FCOLOR>
            <form action="./status.cgi" method="post" name=para>
            <TR>
             <TD><img src=\"$IMG/chara/$mchara.gif\" name=\"Img\"></TD>
            </TR>
           </TABLE>
           $sel
           <select id=chara name=chara onChange=\"changeImg()\">

           </select><br>選擇你要的圖案。<BR>
           <input type=submit CLASS=FC value=變更>
           <input type=hidden name=id value=$mid>
           <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
           <input type=hidden name=mode value=data_change2>
           </form>
$BACKTOWNBUTTON
           </TD>
          </TR>
          </TBODY>
         </TABLE>
        </CENTER>
        <script language="JavaScript">
        var sel='';
        function changeImg(){
                num=document.getElementById('chara').selectedIndex+1;
                document.Img.src="$IMG/chara/" + sel + num +".gif";
        }
        function changeSel(selname,selnum){
                sel=selname;
                        while(document.getElementById('chara').length>0){
                                document.getElementById('chara').remove(0);
                        }
                        for (var i=0;i<=selnum;i++){
                                document.getElementById('chara').options[i] = new Option('圖案'+(i+1), sel + (i+1));
                        }
                        document.getElementById('chara').selectedIndex=0;
                        changeImg();
        }
        changeSel('',627);
        </script>

EOM

        &footer;
        exit;
}

1;

