sub unit {
	&chara_open;
	&con_open;
	&town_open;
	&header;
	&status_print;
	open(IN,"./data/unit.cgi");
	@UNIT_DATA = <IN>;
	close(IN);

	@UNIT_DATA2 = @UNIT_DATA;

	$no=0;
	$unit="<table border=0 bgcolor=000000 width=90%>";
	$unit.="<tr><td colspan=6 width=100% bgcolor=$ELE_BG[0] align=center><font color=$ELE_C[0]>隊伍編成</font></td></tr>";
	$unit.="<tr><td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>請選擇</font></td>";
	$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>隊伍名稱</font></td>";
	$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>隊長</font></td>";
	$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>隊長名稱</font></td>";
	$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>隊員</font></td>";
	$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>隊伍介紹</font></td></tr>";
	foreach(@UNIT_DATA){
		($uid,$lchara,$lname,$uname,$bid,$bname,$bmes,$bcon)=split(/<>/);
		$tname = "";
		if($uid eq $bid && $mcon eq $bcon){
			$unit_count=0;
			foreach(@UNIT_DATA2){
				($u2id,$l2chara,$l2name,$u2name,$b2id,$b2name,$b2mes,$b2con)=split(/<>/);
				if($uid eq $u2id && $u2id ne $b2id){
					$tname.="$b2name,";
					$unit_count++;
				}
			}
			if($unit_count>8){
                                $unit.="<tr><td width=1% bgcolor=$ELE_BG[$lcon]><font color=yellow>隊伍已滿</font></td>";
			}else{
				$unit.="<tr><td width=1% bgcolor=$ELE_BG[$lcon]><input type=radio name=no value=$uid></td>";
			}
			$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0]>$uname</font></td>";
			$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2><img src=$IMG/chara/$lchara.gif></font></td>";
			$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>$lname</font></td>";
			$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>$tname</font></td>";
			$unit.="<td bgcolor=$ELE_C[0] align=center><font color=$ELE_BG[0] size=2>$bmes</font></td>";
			$no++;
		}
	}
	$rule.="</table>";

	print <<"EOF";
<table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
  <tbody>
    <tr>
      <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">隊伍編成</font></td>
    </tr>
    <tr>
      <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/country2.jpg"></td>
      <td bgcolor="#330000"><font color="#ffffcc">隊伍編成。<br>可在此進行隊伍的脫離、解散及解雇。<br></font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
	<form action="./country.cgi" method="POST">
	$unit
    </tr>
    <tr>
      <td colspan="6" align="center" bgcolor="#ffffcc">
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=unit_entry>
	<input type=submit CLASS=FC value=入隊></form>
	<form action="./country.cgi" method="POST">
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=unit_delete>
	<input type=submit CLASS=FC value=隊伍解散、脫離></form>
$BACKTOWNBUTTON
     </td>
    </tr>
    <tr>
      <td colspan=6 width=100% bgcolor=$ELE_BG[0] align=center><font color=$ELE_C[0]>組新隊伍（名聲１００以上）</font></td>
    </tr>
　　<tr bgcolor=$ELE_C[0]>
	<form action="./country.cgi" method="POST">
	<td colspan=3 align=right>隊伍名（２～１０字）</td>
      	<td colspan=3><input type=text name=unit></td>
    </tr>
    <tr bgcolor=$ELE_C[0]>
	<td colspan=3 align=right>隊伍介紹(２０字以內)</td>
      	<td colspan=3><input type=text size=60 name=com></td>
    </tr>
　　<tr>
      <td colspan="6" align="center" bgcolor="#ffffcc">
	<input type=hidden name=id value=$mid>
	<input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<input type=hidden name=mode value=unit_edit>
	<input type=submit CLASS=FC value=新隊伍編成></form>
	</td>
    </tr>
  </tbody>
</table>
<center></center>
EOF
	&footer;
	exit;
}
1;
