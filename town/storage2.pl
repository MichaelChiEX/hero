sub storage2 {
	&chara_open;
        &ext_open;	
	if($in{'no'} eq "" && $in{'mode'} ne"storage_sort" && $in{'mode'} ne"storage_sort_name"){&error("資料傳輸有誤，<a href='./login.cgi'>請重新登入</a>。");}

	open(IN,"./logfile/item/$in{'id'}.cgi");
	@ITEM = <IN>;
	close(IN);
	
	open(IN,"./logfile/storage/$in{'id'}.cgi");
	@STORAGE = <IN>;
	close(IN);
	$ritype=$in{'itype'};
	if($in{'mode'} eq"storage_sort"){
		$btime = 60 - $date + $mdate2;
		if($btime>0){&error("離下次可重整時間剩於$btime 秒。");}
		@tmp1 = map {(split /<>/)[1]} @STORAGE;
		@STORAGE2 = @STORAGE[sort {$tmp1[$a] <=> $tmp1[$b]} 0 .. $#tmp1];
                open(OUT,">./logfile/storage/$in{'id'}.cgi");
                print OUT @STORAGE2;
                close(OUT);
		$mdate2=time();
        }elsif($in{'mode'} eq"storage_sort_name"){
                $btime = 60 - $date + $mdate2;
                if($btime>0){&error("離下次可重整時間剩於$btime 秒。");}
                @tmp1 = map {(split /<>/)[2]} @STORAGE;
                @STORAGE2 = @STORAGE[sort {$tmp1[$a] <=> $tmp1[$b]} 0 .. $#tmp1];
                open(OUT,">./logfile/storage/$in{'id'}.cgi");
                print OUT @STORAGE2;
                close(OUT);
                $mdate2=time();
	}elsif($in{'mode'} eq"storage_in"){
		$scom="存入了";
		$it_num=@ITEM;
		@nums=split(/,/,$in{'no'});
                $STT=@STORAGE;
		$splicei=0;
		foreach(@nums){
			$it_name="";
			if($_ ne ""){
				($itno,$in_type,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_flg)=split(/<>/,$ITEM[$_-$splicei]);
			}
			if($itno eq "bug"){&error("");}
			if ($in_type eq"4" && $member_point eq"") {
				&error("寵物無法放到倉庫！");
			}
                        if($it_name){
	        	        $ritype=$in_type;
				splice(@ITEM,$_-$splicei,1);
				$splicei++;
				$item_name.="、$it_name";
				if($STT>=$STORITM_MAX){&error("你的倉庫物品數已達上限。(最大$STORITM_MAX個)");}	
				push(@STORAGE,"$itno<>$in_type<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
				$SST++;
			}
		}
		open(OUT,">./logfile/storage/$in{'id'}.cgi");
		print OUT @STORAGE;
		close(OUT);
		
		open(OUT,">./logfile/item/$in{'id'}.cgi");
		print OUT @ITEM;
		close(OUT);
	}elsif($in{'mode'} eq"storage_out"){
		$scom="取出了";
		$it_num=@STORAGE;
		@nums=split(/,/,$in{'no'});
		$STT=@ITEM;
                $splicei=0;
                foreach(@nums){
			$it_name="";
                        if($_ ne ""){
				($itno,$in_type,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_type,$it_sta,$it_pos)=split(/<>/,$STORAGE[$_-$splicei]);
			}
			if($it_name){
                                splice(@STORAGE,$_-$splicei,1);
                                $splicei++;
                                $item_name.="、$it_name";
				if($STT>=$ITM_MAX){&error("你的持有物品數已達上限。(最大$ITM_MAX個)");}
				push(@ITEM,"$itno<>$in_type<>$it_name<>$it_val<>$it_dmg<>$it_wei<>$it_ele<>$it_hit<>$it_cl<>$it_type<>$it_sta<>$it_flg<>\n");
				$STT++;
			}
		}
		open(OUT,">./logfile/storage/$in{'id'}.cgi");
		print OUT @STORAGE;
		close(OUT);

		open(OUT,">./logfile/item/$in{'id'}.cgi");
		print OUT @ITEM;
		close(OUT);
	}

	&chara_input;

	&header;
	
	print <<"EOF";
        <form action="./town.cgi" method="POST" id="backf">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass>
	<input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=itype value=$ritype>
        <INPUT type=hidden name=mode value=storage>
        </form>
<script language="javascript">
document.getElementById('backf').submit();
</script>
EOF
	&footer;
	exit;
	
}
1;
