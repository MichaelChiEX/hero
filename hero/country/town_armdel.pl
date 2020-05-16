#! /usr/bin/perl
sub town_armdel {
        &chara_open;
        &status_print;
        &con_open;
        &town_open;
        #&error("目前正在進行程式更新中,將要加入奧義開發,請先存好國庫的錢。");
        if($con_id eq 0){&error("無所屬國無法進行刪除。");}

                open(IN,"./data/carm.cgi");
                @CARM = <IN>;
                close(IN);

                #open(IN,"./data/ability.cgi");
                #@ABILITY = <IN>;
                #close(IN);

                open(IN,"./data/towndata.cgi");
                @T_LIST = <IN>;
                close(IN);
#

                $item_count=0;
                foreach(@CARM){
                        ($arm_t,$arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos)=split(/<>/);
		                foreach(@T_LIST){
        			        ($zcid,$zname,$zcon,$zele,$zmoney,$zarm,$zpro,$zacc,$zind,$zs,$ztr,$zx,$zy,$zbuild,$zetc)=split(/<>/);
							if ($zcon eq $mcon && $zcid eq $arm_pos) {
		                		($town_hp,$town_max,$town_str,$town_def,$town_dex,$town_flg)=split(/,/,$zetc);
		                        $buy_area=$zname."(".$zx.",".$zy.")";

                                if ($arm_val>=10000) {
                                        $arm_val="<font color=blue>" . int($arm_val/10000) ."萬</font>". $arm_val%10000 ." Gold";
                                } else {
                                        $arm_val=$arm_val . " Gold";
                                }
                                #
                                #foreach(@ABILITY){
                                #($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                #        if($arm_sta eq $abno){
                                #                $sta_name=$abname."(".$abcom.")";
                                #        }
                                #}
                                
                                $armtable.="<tr bgcolor=white style='color: $ELE_BG[$arm_ele]'><td><input type=radio name=dno value=$item_count size=2></td><td><font size=2>$arm_name</font></td><!--<td><font size=2>$sta_name</font></td>--><td id=td_$item_count>$ELE[$arm_ele]</td><td><font size=2>$arm_dmg</font></td><td><font size=2>$arm_wei</font></td><td align=right><font size=2>$arm_val</font></td><td align=right><font size=2>$buy_area</font></td></tr>";
                            }
                        }
					$item_count++;
		         }
	&header;
        print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">武器．防具刪除</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/buki.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">特產品刪除，刪除一品特產品需要花費國家資金１０００萬。<br>目前國家的資金：$scon_gold Gold</font></td>
    </tr>
    <tr>
<table border="0" width="80%" align=center bgcolor="#ffffff" height="1" CLASS=TC>
  <tbody>
    <tr>
      <td align="center" bgcolor="$FCOLOR"><font color="#FFFFCC">
                本國特產清單</font></td>
    </tr>
    <tr>
      <td align=center bgcolor="ffffff" height="48">
        <table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
        <tr><td colspan=7 align=center><font color=ffffcc>清單</font></td></tr>
        <tr>
        <td bgcolor=ffffcc height="19" width="5%">　</td>
        <td bgcolor=ffffcc height="19" width="20%">名稱</td>
        <!--<td bgcolor=ffffcc height="19" width="35%">奧義</td>-->
        <td bgcolor=ffffcc height="19" width="7%">屬性</td>
        <td bgcolor=ffffcc height="19" width="7%">威力</td>
        <td bgcolor=ffffcc height="19" width="7%">重量</td>
        <td bgcolor=ffffcc height="19" width="15%" align="right">價格</td>
        <td bgcolor=ffffcc height="19" width="20%" align="CENTER">產地</td>
        </tr>
<form action="./country.cgi" method="post">
        $armtable
        </table>
		</td>
	</tr>
       <tr bgcolor=ffffcc>
      	<td colspan="2" align="center">
        <input type=hidden name=id value=$mid>
        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
        <input type=hidden name=mode value=town_armdel2>
        <input type=submit value=確定刪除 CLASS=FC></form>
$BACKTOWNBUTTON
      	</td>
       </tr>
    </tbody>
</table>
</td>

    </tr>
  </tbody>
</table>

EOF
        &footer;
        exit;
}
1;

