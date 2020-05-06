sub storage {
	&chara_open;
	&equip_open;
	&ext_open;
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);
	
	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
	$no1=0;
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		$it_type_name="";
		if($it_ki>=0 && $it_ki<5 || $it_ki eq"7") {
			($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
			foreach(@ABILITY){
					($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
					if($it_stas[0] eq $abno){
						$it_type_name=$abname.$it_type_name;
					}elsif($it_stas[1] eq $abno){
                                                $it_type_name.="、$abname";
                                        }
				}
			if($it_no eq"rea" && $it_ki>=0 && $it_ki<3){
				if($it_sta ne""){
					$storage_up.="<Option value=$no1>$it_name($it_dmg/$it_wei)(+2)</option>";
				}else{
                                        $storage_up.="<Option value=$no1>$it_name($it_dmg/$it_wei)(+1)</option>";
				}
			}
		}else{
			$it_type_name="";
		}
		if($it_ki ne"4" || $member_point ne""){$ittable.="<TR><TD width=45% bgcolor=ffffcc><input type=checkbox id=C$no1 name=C$no1 value=$no1><font size=2>$it_name</font><input type=button value=存入 onclick=javascript:this.form.no.value=$no1;this.form.submit();></TD><TD bgcolor=white><font size=2>$it_dmg</font></TD><TD bgcolor=white><font size=2>$it_wei</font></TD><TD bgcolor=white><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=white><font size=2>$EQU[$it_ki]</font></TD><TD bgcolor=white><font size=2>$it_type_name</font></TD></TR>";}
		$no1++;
	}
	if($storage_up ne""){
		$storage_up=<<"STEOF";
        <form action="./town.cgi" method="post">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=storage_up>
	<INPUT type=hidden name=itcount value=$no1>
        擴充倉庫：<select szie="1" name="no">$storage_up</select>
	<input type=button value="擴充" name="B1" onclick="javascript:if(confirm('確定要擴倉嗎?')){this.form.submit();};">
        </form>
STEOF
	}
	open(IN,"./logfile/storage/$mid.cgi");
	@STORAGE = <IN>;
	close(IN);
	$no2=0;$no3=0;
	$it_show_no=$in{'itype'};
	if ($it_show_no eq""){
		$it_show_no="0";
	}
	$it_show_no2="";
	if($it_show_no =~ m/[^0-9]/){$it_show_no2=$it_show_no;}
	foreach(@STORAGE){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		$it_type_name="";
		$ki_hit=0;
		if($it_show_no2 eq"" && $it_show_no eq $it_ki){$ki_hit=1;}
		elsif($it_show_no eq ""){}
		elsif($it_show_no2 ne "" && index($it_name,$it_show_no)>=0){$ki_hit=1;}
		if($ki_hit && ($it_ki>=0 && $it_ki<5 || $it_ki eq "7")) {
			($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
			foreach(@ABILITY){
					($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
					if($it_stas[0] eq $abno){
						$it_type_name=$abname.$it_type_name;
					}elsif($it_stas[1] eq $abno){
                                                $it_type_name.="、$abname";
                                        }
				}
		}
		$bgcolor="#ffffcc";
		if($it_ki eq"1"){
			$bgcolor="#CFFAFE";
		}elsif($it_ki eq"2"){
                        $bgcolor="#FED8FD";
                }elsif($it_ki eq"3"){
                        $bgcolor="#FDFCC6";
                }elsif($it_ki eq"4"){
                        $bgcolor="#D8FEE0";
                }elsif($it_ki eq"5"){
                        $bgcolor="#FED8FD";
                }elsif($it_ki eq"6"){
                        $bgcolor="#ffffcc";
                }elsif($it_ki eq"7"){
                        $bgcolor="#FFE8EA";
		}
		if($ki_hit){
			$no3++;
			$sttable.="<TR><TD width=5% bgcolor=$bgcolor><input type=checkbox id=S$no2 name=S$no2 value=$no2></TD><TD bgcolor=$bgcolor colspan=2><font size=2>$it_name<input type=button value=取出 onclick=javascript:this.form.no.value=$no2;this.form.submit();></font></TD><TD bgcolor=$bgcolor><font size=2>$it_dmg</font></TD><TD bgcolor=$bgcolor><font size=2>$it_wei</font></TD><TD bgcolor=$bgcolor><font size=2>$ELE[$it_ele]</font></TD><TD bgcolor=$bgcolor><font size=2>$EQU[$it_ki]</font></TD><TD bgcolor=$bgcolor><font size=2>$it_type_name</font></TD></TR>\n";
		}

		$no2++;
	}
	&header;
	for($eqi=0;$eqi<@EQU;$eqi++){
		if($eqi eq 6){
			$eqselect.="<td bgcolor=white></td>";
		}else{
		if($eqi eq $it_show_no){
			$eqselect.="<td bgcolor=white><b>$EQU[$eqi]</b></td>";
		}else{
			$eqselect.="<td bgcolor=white><a href='javascript:seleq($eqi);'>$EQU[$eqi]</a></td>";
		}
		}
	}	
	print <<"EOF";
<TABLE border="0" width="90%" align=center bgcolor="#000000" height="150" CLASS=TC>
  <TBODY>
    <TR>
      <TD colspan="3" align="center" bgcolor="$FCOLOR"><FONT color="#ffffcc">倉庫</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/storage.jpg"></TD>
      <TD bgcolor="#330000" colspan="3"><FONT color="#ffffcc"><font color=#AAAFFF>$mname</font>的倉庫<BR>你可以在此將身上的物品放入倉庫或從倉庫取出物品。<BR><font color=yellow>注意：寵物無法放到庫倉(贊助會員例外)</FONT></TD>
    </TR>
    <TR>
      <TD align=center bgcolor="ffffff" colspan=2 width=55% valign=top>
        <form action="./town.cgi" method="post" id="sortf">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=storage_sort>
        </form>

	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass>
        <input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=storage_sort_name>
	<tr><td colspan=8 align=center>
<font color=ffffcc>
<!--
<input type=submit value=名稱排序>
-->
倉庫物品一覽-$EQU[$it_show_no]($no3/$no2/$STORITM_MAX)
        </form>
<!--<INPUT type=button onclick="javascript:sortf.value='storage_sort';sortf.submit();" value=依種類排序>-->
</font></td></tr>
	<tr>
        <form action="./town.cgi" method="POST" id="eqf">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass>
        <input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=itype>
        <INPUT type=hidden name=mode value=storage>
        </form>
$eqselect
        </tr>
        <tr>
	<td bgcolor=ffffcc><input type=button value=反選 onclick="javascript:selalls();"></td><td bgcolor=white colspan="2">名稱:<input type=text name=searchf size=10 id=searchf value=$it_show_no2><input type=button value=查詢 onclick='javascript:seleq2();'></td><td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td><td bgcolor=white>種類</td><td bgcolor=white>奧義</td>
	</tr>
	<form action="./town.cgi" method="post">
	$sttable
	<TR><TD colspan=8 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=no id=no>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$it_show_no>
	<INPUT type=hidden name=mode value=storage_out>
        <INPUT type=button value=勾選項目取出倉庫 onclick="javascript:chkform(this.form,'S');">
	</TD></TR></form>
	</table>
	
	<TD bgcolor="#ffffff" align=center valign=top>
        <form action="./town.cgi" method="post">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <INPUT type=hidden name=mode value=storage_up>
        $storage_up(使用特武可擴充倉庫)
        </form>
	<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
	<tr><td colspan=7 align=center><font color=ffffcc>手持物品一覽($no1/$ITM_MAX)</font></td></tr>
	<tr>
	<td bgcolor=ffffcc><input type=button value=反選 onclick="javascript:selallx();"></td><td bgcolor=white>威力</td><td bgcolor=white>重量</td><td bgcolor=white>屬性</td><td bgcolor=white>種類</td><td bgcolor=white>奧義</td>
	</tr>
	<form action="./town.cgi" method="post" id="sitemf">
	$ittable
	<TR><TD colspan=8 align=center bgcolor="ffffff">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=no>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$it_show_no>
	<INPUT type=hidden name=mode value=storage_in>
	<INPUT type=button value=勾選項目存入倉庫 onclick="javascript:chkform(this.form,'C');">
	</TD></TR></form>
	</table>
	</TD>
    </TR>
    <TR>
    <TD colspan="3" align="center" bgcolor="ffffff">
$BACKTOWNBUTTON
	</TD>
    </TR>
  </TBODY>
</TABLE>
<Script language="javascript">
function seleq(eqno){
	eqf.itype.value=eqno;
	eqf.submit();
}
function seleq2(){
	var eqno=document.getElementById('searchf').value;
        if(eqno==''){
                alert('請輸入要查詢的關鍵字！');
        }else{
                eqf.itype.value=eqno;
                eqf.submit();
        }
}
function chkform(f,SName){
	f.no.value="";
	var chki=0;
	for(var i=0;i<$STORITM_MAX;i++){
		var obj=document.getElementById(SName+i);
		if (obj){
			if(obj.checked){
				f.no.value+=obj.value+",";
				chki++;
			}
		}
	}
	if(SName=='C' && (chki+$no2)>$STORITM_MAX){
		alert('你的倉庫已達上限，無法放入那麼多物品！');
	}else if(SName=='S' && (chki+$no1)>$ITM_MAX){
                alert('你手持物品已達上限，無法放入那麼多物品！');
	}else if(f.no.value==""){
		alert('請選擇要存入的物品');
	}else{
		f.submit();
	}
}
function selallx(){
        for(var i=0;i<$ITM_MAX;i++){
		var obj=document.getElementById('C'+i);
                if (obj){
			obj.checked=!obj.checked;
                }
        }
}
function selalls(){
        for(var i=0;i<$STORITM_MAX;i++){
                var obj=document.getElementById('S'+i);
                if (obj){
                        obj.checked=!obj.checked;
                }
        }
}

</Script>
EOF

	&footer;
	exit;
}
1;
