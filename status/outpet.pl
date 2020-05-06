sub outpet {
	&chara_open;

	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	close(IN);
                ($it_no2,$it_name2,$it_dmg2,$it_def2,$it_speed2,$it_ele2,$it_lv2,$it_cl2,$it_sta2,$it_type2,$it_flg2)=split(/,/,$mpet);
	if ($it_name2 ne"") {
                push(@ITEM,"$it_no2<>4<>$it_name2<>$it_dmg2<>$it_def2<>$it_speed2<>$it_ele2<>$it_lv2<>$it_cl2<>$it_sta2<>$it_type2<>$it_flg2<>\n");
                $mpet="";
		&chara_input;
                open(OUT,">./logfile/item/$in{'id'}.cgi");
                print OUT @ITEM;
                close(OUT);
	}
	&header;
	
	print <<"EOF";
	<form action="./status.cgi" method="POST" id="backf">
	<INPUT type=hidden name=id value=$mid>
	<INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=equip>
	</form>
<script language="javascript">
document.getElementById('backf').submit();
</script>
EOF
	exit;
	
}
1;
