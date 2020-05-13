#! /usr/bin/perl
require './sub.cgi';
require './conf.cgi';
require './conf_eq.cgi';
&decode;
&header;

if($in{'mode'} eq"town_arm"){$idata="arm";$itype=0}
elsif($in{'mode'} eq"town_pro"){$idata="pro";$itype=1}
elsif($in{'mode'} eq"town_acc"){$idata="acc";$itype=2}
elsif($in{'mode'} eq"r_arm"){$idata="rarearm";$itype=0}
elsif($in{'mode'} eq"r_pro"){$idata="rarepro";$itype=1}
elsif($in{'mode'} eq"r_acc"){$idata="rareacc";$itype=2}
elsif($in{'mode'} eq"sp"){$itype=3}
else{$idata="arm";$itype=0}

open(IN,"./data/ability.cgi");
@ABILITY = <IN>;
close(IN);

open(IN,"./data/towndata.cgi");
@T_LIST = <IN>;
close(IN);

if ($itype <3){
	open(IN,"./data/$idata.cgi") or exit;
	@ARM_DATA = <IN>;
	close(IN);

	foreach(@ARM_DATA){
		($arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos)=split(/<>/);
		$arm_val = &format_val($arm_val);

		#奧義
		$sta_name="";
		foreach(@ABILITY){
			($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
			if($arm_sta eq $abno){
				$sta_name=$abname."(".$abcom.")";
			}
		}

		#產地
		if ($in{'mode'} ne "r_arm" && $in{'mode'} ne "r_pro" && $in{'mode'} ne "r_acc"){
			foreach(@T_LIST){
				($zcid,$zname,$zcon,$zele,$zmoney,$zarm,$zpro,$zacc,$zind,$zs,$ztr,$zx,$zy,$zbuild,$zetc)=split(/<>/);
				if ($arm_pos eq "all"){
					$buy_area="全部";
				}elsif($zcid eq $arm_pos){
					$buy_area=$zname."(".$zx.",".$zy.")";
				}
			}
		}
		$armtable.="
			<tr class='equip' data-ele='$ELE[$arm_ele]' bgcolor=white style='color: $ELE_BG[$arm_ele]'>
				<td><font size=2>$arm_name</font></td>
				<td><font size=2>$sta_name</font></td>
				<td>$ELE[$arm_ele]</td>
				<td><font size=2>$arm_dmg</font></td>
				<td><font size=2>$arm_wei</font></td>
				<td align=right><font size=2>$arm_val</font></td>
				<td align=right><font size=2>$buy_area</font></td>
			</tr>";
	}
} elsif ($itype eq 3) {
	#特產
	open(IN,"./data/carm.cgi");
	@CARM = <IN>;
	close(IN);

	#城
	foreach(@T_LIST){
		($zcid,$zname,$zcon,$zele,$zmoney,$zarm,$zpro,$zacc,$zind,$zs,$ztr,$zx,$zy,$zbuild,$zetc)=split(/<>/);
		$buy_area=$zname."(".$zx.",".$zy.")";
		#特產
		foreach(@CARM){
			($arm_t,$arm_name,$arm_val,$arm_dmg,$arm_wei,$arm_ele,$arm_hit,$arm_cl,$arm_sta,$arm_type,$arm_pos)=split(/<>/);
			
			if ($zcid eq $arm_pos){
				$arm_val = &format_val($arm_val);
				#奧義
				foreach(@ABILITY){
					($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
					if($arm_sta eq $abno){
						$sta_name=$abname."(".$abcom.")";
					}
				}
				if ($arm_t eq 0){
					$arm_t="武器";
				}elsif($arm_t eq 1){
					$arm_t="防具";
				}else{
					$arm_t="飾品";
				}
				$armtable.="
					<tr class='equip' data-ele='$ELE[$arm_ele]' bgcolor=white style='color: $ELE_BG[$arm_ele]'>
						<td><font size=2>$arm_name</font></td>
						<td><font size=2>$arm_t</font></td>
						<td>$ELE[$arm_ele]</td>
						<td><font size=2>$arm_dmg</font></td>
						<td><font size=2>$arm_wei</font></td>
						<td align=right><font size=2>$arm_val</font></td>
						<td align=right><font size=2>$buy_area</font></td>
					</tr>";
			}
		}
	}
}

sub format_val(){
	my($gold) = @_;
	if ($gold>=10000) {
		return "<font color=blue>" . int($gold/10000) ."萬</font>". $gold%10000 ." Gold";
	} else {
		return $gold . " Gold";
	}
}

print <<"EOF";
<table border="0" width="90%" align=center bgcolor="#000000" height="1" CLASS=TC>
    <tbody>
		<tr>
			<td align="center" bgcolor="$FCOLOR">
				<font color="#FFFFCC">裝備清單</font>
			</td>
		</tr>
		<tr>
			<td bgcolor="#ffffcc" align=center>
				<table border="0" width="100%" id="table1" cellspacing="1">
					<tr align=center>
						<td><a href="eqlist.cgi?mode=town_arm"><button CLASS=FC >商店武器</button></a></td>
						<td><a href="eqlist.cgi?mode=town_pro"><button CLASS=FC >商店防具</button></a></td>
						<td><a href="eqlist.cgi?mode=town_acc"><button CLASS=FC >商店飾品</button></a></td>
						<td><a href="eqlist.cgi?mode=r_arm"><button CLASS=FC >特殊武器</button></a></td>
						<td><a href="eqlist.cgi?mode=r_pro"><button CLASS=FC >特殊防具</button></a></td>
						<td><a href="eqlist.cgi?mode=r_acc"><button CLASS=FC >特殊飾品</button></a></td>
						<td><a href="eqlist.cgi?mode=sp"><button CLASS=FC >特產品清單</button></a></td>						
					</tr>
					<tr align=center>
						<td colspan=7 align=center>
							<input type=button CLASS=FC value=全部屬性 onclick="javascript:showd('all');">　
							<input type=button CLASS=FC value=$ELE[0]屬性 onclick="javascript:showd('$ELE[0]');">　
							<input type=button CLASS=FC value=$ELE[1]屬性 onclick="javascript:showd('$ELE[1]');">　
							<input type=button CLASS=FC value=$ELE[2]屬性 onclick="javascript:showd('$ELE[2]');">　
							<input type=button CLASS=FC value=$ELE[3]屬性 onclick="javascript:showd('$ELE[3]');">　
							<input type=button CLASS=FC value=$ELE[4]屬性 onclick="javascript:showd('$ELE[4]');">　
							<input type=button CLASS=FC value=$ELE[5]屬性 onclick="javascript:showd('$ELE[5]');">　
							<input type=button CLASS=FC value=$ELE[6]屬性 onclick="javascript:showd('$ELE[6]');">　
							<input type=button CLASS=FC value=$ELE[7]屬性 onclick="javascript:showd('$ELE[7]');">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align=center bgcolor="ffffff" height="48">
				<table border=0 width="100%" bgcolor=$FCOLOR CLASS=TC>
					<tr>
						<td colspan=7 align=center><font color=ffffcc>清單</font></td>
					</tr>
					<tr>
						<td bgcolor=ffffcc height="19" width="15%">名稱</td>
						<td bgcolor=ffffcc height="19" width="35%">奧義</td>
						<td bgcolor=ffffcc height="19" width="5%">屬性</td>
						<td bgcolor=ffffcc height="19" width="5%">威力</td>
						<td bgcolor=ffffcc height="19" width="5%">重量</td>
						<td bgcolor=ffffcc height="19" width="10%" align="right">價格</td>
						<td bgcolor=ffffcc height="19" width="15%" align="CENTER">產地</td>
					</tr>
					$armtable
				</table>
		</tr>
    </tbody>
</table>
<script>
function showd(ele) {
	document.querySelectorAll('.equip').forEach(function(element) {
		if(element.dataset.ele===ele || ele==='all'){
			element.style.display='';
		}else{
			element.style.display='none';
		}
	})
}
</script>
EOF
&mainfooter;
exit;
