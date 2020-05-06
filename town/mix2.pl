sub mix2 {
	&chara_open;
	&equip_open;
	&ext_open;
	if($in{'no'} eq""){&error("請選擇你要合成的項目");}
	if($in{'usegold'} =~ m/[^0-9]/||$in{'wei'} =~ m/[^0-9]/){&error("請輸入正確的金額。");}
	if($in{'useabp'} =~ m/[^0-9]/||$in{'wei'} =~ m/[^0-9]/){&error("請輸入正確的熟練。");}
	if(($in{'useabp'}+$in{'usegold'})<100){&error("你的成功率為0,請輸入足夠的熟練或金錢");}
	if($mabp<$in{'useabp'}){&error("你的熟練不足。");}
	if($in{'usegold'}>99999){&error("你輸入的金額或熟練過大，請重新輸入。");}
	if($mbank<(int($in{'usegold'})*10000)){&error("你銀行裏的存款不足。");}
	#アビリティ情報
	($msk[0],$msk[1]) = split(/,/,$msk);
	open(IN,"./data/ability.cgi");
	@ABILITY = <IN>;
	close(IN);
        $useabp=int($in{'useabp'});
        $usegold=int($in{'usegold'}*10000);
        open(IN,"./logfile/ability/$mid.cgi");
        @ABDATA = <IN>;
        close(IN);
	$cans=0;
	foreach(@ABDATA){
		($kabno,$kabname,$kabcom,$kabdmg,$kabrate,$kabpoint,$kabclass,$kabtype)=split(/<>/);
		if($kabno eq"87"){
			$cans=1;
			last;
		}
	}
	if(!$cans){
		&error("請先從鐵匠身上學習合成奧義並裝備上。");
	}
	open(IN,"./logfile/item/$mid.cgi");
	@ITEM = <IN>;
	$itemtotal=@ITEM;
	if("$itemtotal" ne"$in{'itemtotal'}"){&error("你的手持物品數量在你進入工房後變更,請重新進入工房選擇");}
	close(IN);
	$supoint=(int($in{'usegold'})+int($in{'useabp'}))/100;
	$no2=0;
	$mixno=0;
        if($ext_mix[1] eq ""){$ext_mix[1]=0;}
        if($ext_mix[2] eq ""){$ext_mix[2]=0;}
        if($ext_mix[3] eq ""){$ext_mix[3]=0;}
        if($ext_mix[4] eq ""){$ext_mix[4]=0;}
        if($ext_mix[5] eq ""){$ext_mix[5]=0;}
        if($ext_mix[6] eq ""){$ext_mix[6]=0;}
        if($ext_mix[7] eq ""){$ext_mix[7]=0;}
	#屬性武初始值
        $MIXARM[1]=[400,100];
        $MIXARM[2]=[300,70];
        $MIXARM[3]=[200,20];
        $MIXARM[4]=[300,50];
        $MIXARM[5]=[350,70];
        $MIXARM[6]=[320,60];
        $MIXARM[7]=[320,60];
	#屬性防初始值
        $MIXPRO[1]=[300,70];
        $MIXPRO[2]=[400,100];
        $MIXPRO[3]=[200,20];
        $MIXPRO[4]=[300,50];
        $MIXPRO[5]=[250,50];
        $MIXPRO[6]=[320,80];
        $MIXPRO[7]=[320,80];
	#屬性飾品初始值
        $MIXACC[1]=[50,0];
        $MIXACC[2]=[50,0];
        $MIXACC[3]=[50,0];
        $MIXACC[4]=[50,0];
        $MIXACC[5]=[50,0];
        $MIXACC[6]=[50,0];
        $MIXACC[7]=[50,0];
	#武威力屬性增加值
        $MIXARMADDDMG[1]=1+int(rand(3));
        $MIXARMADDDMG[2]=int(rand(2));
        $MIXARMADDDMG[3]=int(rand(2));
        $MIXARMADDDMG[4]=int(rand(3));
        $MIXARMADDDMG[5]=1+int(rand(2));
        $MIXARMADDDMG[6]=int(rand(3));
        $MIXARMADDDMG[7]=1+int(rand(2));
	#防威力屬性增加值
        $MIXPROADDDMG[1]=int(rand(2));
        $MIXPROADDDMG[2]=1+int(rand(3));
        $MIXPROADDDMG[3]=int(rand(2));
        $MIXPROADDDMG[4]=1+int(rand(2));
        $MIXPROADDDMG[5]=int(rand(3));
        $MIXPROADDDMG[6]=1+int(rand(2));
        $MIXPROADDDMG[7]=int(rand(3));
        #飾威力屬性增加值
        $MIXACCADDDMG[1]=1;
        $MIXACCADDDMG[2]=1;
        $MIXACCADDDMG[3]=1;
        $MIXACCADDDMG[4]=1;
        $MIXACCADDDMG[5]=1;
        $MIXACCADDDMG[6]=1;
        $MIXACCADDDMG[7]=1;
	#武重量屬性增加值
        $MIXARMADDWEI[1]=int(rand(2));
        $MIXARMADDWEI[2]=1;
        $MIXARMADDWEI[3]=1;
        $MIXARMADDWEI[4]=1;
        $MIXARMADDWEI[5]=int(rand(2));
        $MIXARMADDWEI[6]=1;
        $MIXARMADDWEI[7]=int(rand(2));
	#防重量屬性增加值
        $MIXPROADDWEI[1]=1;
        $MIXPROADDWEI[2]=int(rand(2));
        $MIXPROADDWEI[3]=1;
        $MIXPROADDWEI[4]=int(rand(2));
        $MIXPROADDWEI[5]=1;
        $MIXPROADDWEI[6]=int(rand(2));
        $MIXPROADDWEI[7]=1;
        #飾重量屬性增加值
        $MIXACCADDWEI[1]=1;
        $MIXACCADDWEI[2]=1;
        $MIXACCADDWEI[3]=1;
        $MIXACCADDWEI[4]=1;
        $MIXACCADDWEI[5]=1;
        $MIXACCADDWEI[6]=1;
        $MIXACCADDWEI[7]=1;
	#武上限
	$MIXMAXARM[1]=[700,50];
	$MIXMAXARM[2]=[450,0];
	$MIXMAXARM[3]=[450,-50];
	$MIXMAXARM[4]=[550,0];
	$MIXMAXARM[5]=[600,30];
	$MIXMAXARM[6]=[500,0];
	$MIXMAXARM[7]=[600,50];
	#防上限
	$MIXMAXPRO[1]=[450,0];
	$MIXMAXPRO[2]=[700,50];
	$MIXMAXPRO[3]=[450,-50];
	$MIXMAXPRO[4]=[550,0];
	$MIXMAXPRO[5]=[600,30];
	$MIXMAXPRO[6]=[600,50];
	$MIXMAXPRO[7]=[500,0];
        #飾品上限
        $MIXMAXACC[1]=[100,-50];
        $MIXMAXACC[2]=[100,-50];
        $MIXMAXACC[3]=[100,-50];
        $MIXMAXACC[4]=[100,-50];
        $MIXMAXACC[5]=[100,-50];
        $MIXMAXACC[6]=[100,-50];
        $MIXMAXACC[7]=[100,-50];
	$mixno2=0;
	foreach(@ITEM){
		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/);
		($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
		if($it_ki eq"5"){
			$mixno++;
                }elsif($it_ki eq"0" && $it_stas[0]>0 && $it_no eq"rea"){
                        $carmsta.="x";
                }elsif($it_ki eq"1" && $it_stas[0]>0 && $it_no eq"rea"){
                        $cprosta.="x";
                }elsif($it_ki eq"2" && $it_stas[0]>0 && $it_no eq"rea"){
                        $cpetsta.="x";
                        $caccsta.="x";
		}elsif($it_ki eq"7" && $it_stas[0]>0){
			if($it_dmg eq"0"){
				$carmsta2.="x";
			}elsif($it_dmg eq"1"){
				$cprosta2.="x";
                        }elsif($it_dmg eq"2"){
				$caccsta2.="x";
                        }elsif($it_dmg eq"4"){
				$cpetsta2.="x";
			}
		}
		$no2++;
	}
        #合成
	$mixno=1;
	$dno=0;
	$dcount=0;


      if($cans){
                foreach(@ext_mix){
                        if ($ext_mix[$mixno] >2){
                              if($in{'no'} eq"$mixno2") {
                              	    if($in{'itype'} ne"0" && $in{'itype'} ne"1" && $in{'itype'} ne"2"){&error("錯誤的裝備類別!");}
                                    if($in{'it_name'} eq""){&error("請輸入裝備名稱。");}
				    if(length($in{'it_name'}) > 32 || length($in{'it_name'}) < 4){&error("請輸入２～８個文字。");}
                                    if($in{'it_name'} =~ /※/ || $in{'it_name'} =~ /★/ || $in{'it_name'} =~ /稀有/ || $in{'it_name'} =~ /優良/) {&error2("請不要使用特殊字眼及符號(※、★、稀有、優良)。"); }
					$ext_mix[$mixno]-=3;
	                                if($in{'itype'} eq"0"){
	                                	$it_dmg2=$MIXARM[$mixno][0];
	                                	$it_wei2=$MIXARM[$mixno][1];
	                                }elsif($in{'itype'} eq"1"){
	                                	$it_dmg2=$MIXPRO[$mixno][0];
	                                	$it_wei2=$MIXPRO[$mixno][1];
	                                }elsif($in{'itype'} eq"2"){
                                                $it_dmg2=$MIXACC[$mixno][0];
                                                $it_wei2=$MIXACC[$mixno][1];
					}
	                                if($supoint>=int(rand(100))){
	                                	$susmsg="你成功的製作了<font color=#AAAAFF>★$in{'it_name'}($it_dmg2/$it_wei2)</font>";
	                                	&maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的製作了〔$EQU[$in{'itype'}]〕<font color=red>★$in{'it_name'}($ELE[$mixno])($it_dmg2/$it_wei2)</font>");
		                                push(@ITEM,"mix<>$in{'itype'}<>★$in{'it_name'}<>20000000<>$it_dmg2<>$it_wei2<>$mixno<><><><><><>\n");
		                            } else {
		                            	$susmsg="<font color=red>你製作失敗了</font>";
		                            }
	                          }
	                          $mixno2++;
		                }

#=======================================合成原料================================================
                        if ($ext_mix[$mixno]>1){
                        	if($in{'iele'} eq"" || $in{'iele'}<1 || $in{'ele'}>7){&error("請選擇要合成的原料");}
                        	if($in{'no'} eq"$mixno2") {
					$ext_mix[$mixno]-=2;
                                        if(($supoint*20)>=int(rand(100))){
                                                $susmsg="你成功的製作了<font color=#AAAAFF>$ELE[$in{'iele'}]原料</font>";
                                                #&maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的合成了<font color=red>某種原料</font>");
						$ext_mix[$in{'iele'}]++;
                                        } else {
                                                $susmsg="<font color=red>你合成失敗了</font>";
                                        }

                        	}
                        	$mixno2++;
                        }

                		$mixno++;
        		}
#=======================================強化武器===========================================
                if ($marmno eq"mix" && $ext_mix[$marmele]>0) {
                        if($in{'no'} eq"$mixno2"){
				        if($in{'enc_num'} eq ""){&error("請輸入強化的數量。");}
				        if($in{'enc_num'} =~ m/[^0-9]/){&error("請輸入正確強化的數量。");}
				        if($in{'enc_num'} <0){&error("請輸入正確的強化數量。");}
					if($in{'enc_num'}>$ext_mix[$marmele]){&error("你的$ELE[$marmele]原料不足");}
					$useabp=$useabp*$in{'enc_num'};
					$usegold=$usegold*$in{'enc_num'};
				        if($mabp<$useabp){&error("你的熟練不足$useabp。");}
        				if($mbank<$usegold){&error("你銀行裏的存款不足$usegold。");}
					for($i=1;$i<=$in{'enc_num'};$i++){
        #武威力屬性增加值
        $MIXARMADDDMG[1]=1+int(rand(3));
        $MIXARMADDDMG[2]=int(rand(2));
        $MIXARMADDDMG[3]=int(rand(2));
        $MIXARMADDDMG[4]=int(rand(3));
        $MIXARMADDDMG[5]=1+int(rand(2));
        $MIXARMADDDMG[6]=int(rand(3));
        $MIXARMADDDMG[7]=1+int(rand(2));
        #武重量屬性增加值
        $MIXARMADDWEI[1]=int(rand(2));
        $MIXARMADDWEI[2]=1;
        $MIXARMADDWEI[3]=1;
        $MIXARMADDWEI[4]=1;
        $MIXARMADDWEI[5]=int(rand(2));
        $MIXARMADDWEI[6]=1;
        $MIXARMADDWEI[7]=int(rand(2));

                        		if(($supoint*10)>=int(rand(100))){
                                ($xmarmno,$marmname,$xmarmval,$xmarmdmg,$xmarmwei,$xmarmele,$xmarmhit,$xmarmcl,$xmarmsta,$xmarmtype,$xmarmflg) = split(/,/,$marm);
					$ext_mix[$marmele]--;
                                        if ($xmarmwei>$MIXMAXARM[$xmarmele][1]){
                                                $xmarmwei-=$MIXARMADDWEI[$xmarmele];
                                                if ($xmarmwei<$MIXMAXARM[$xmarmele][1]){$xmarmwei=$MIXMAXARM[$xmarmele][1];}
                                        }else{
						$MIXARMADDDMG[$xmarmele]+=$MIXARMADDWEI[$xmarmele];
                                                $MIXARMADDWEI[$xmarmele]="已達到上限";
					}
					if ($xmarmdmg<$MIXMAXARM[$xmarmele][0]){
                                        	$xmarmdmg+=$MIXARMADDDMG[$xmarmele];
                                        	if ($xmarmdmg>$MIXMAXARM[$xmarmele][0]){$xmarmdmg=$MIXMAXARM[$xmarmele][0];}
					}else{
						$MIXARMADDDMG[$xmarmele]="已達到上限";
					}
                                        $susmsg.="<BR>第$i次:成功強化了<font color=#AAAAFF>$marmname</font><font color=yellow>威力+$MIXARMADDDMG[$xmarmele],重量-$MIXARMADDWEI[$xmarmele]</font>";
					
                                        $marm="$xmarmno,$marmname,$xmarmval,$xmarmdmg,$xmarmwei,$xmarmele,$xmarmhit,$xmarmcl,$xmarmsta,$xmarmtype,$xmarmflg";
                                }else{
                                	$susmsg.="<BR>第$i次:強化失敗了";
                                }
				}

                        }
                        $mixno2++;
                }
#========================================強化防具===============================================
                if ($mprono eq"mix" && $ext_mix[$mproele]>0) {
                        if($in{'no'} eq"$mixno2"){
                                        if($in{'enc_num'} eq ""){&error("請輸入強化的數量。");}
                                        if($in{'enc_num'} =~ m/[^0-9]/){&error("請輸入正確強化的數量。");}
                                        if($in{'enc_num'} <0){&error("請輸入正確的強化數量。");}
                                        if($in{'enc_num'}>$ext_mix[$mproele]){&error("你的$ELE[$mproele]原料不足");}
                                        $useabp=$useabp*$in{'enc_num'};
                                        $usegold=$usegold*$in{'enc_num'};
                                        if($mabp<$useabp){&error("你的熟練不足$useabp。");}
                                        if($mbank<$usegold){&error("你銀行裏的存款不足$usegold。");}
                                        for($i=1;$i<=$in{'enc_num'};$i++){
        #防威力屬性增加值
        $MIXPROADDDMG[1]=int(rand(2));
        $MIXPROADDDMG[2]=1+int(rand(3));
        $MIXPROADDDMG[3]=int(rand(2));
        $MIXPROADDDMG[4]=1+int(rand(2));
        $MIXPROADDDMG[5]=int(rand(3));
        $MIXPROADDDMG[6]=1+int(rand(2));
        $MIXPROADDDMG[7]=int(rand(3));
        #防重量屬性增加值
        $MIXPROADDWEI[1]=1;
        $MIXPROADDWEI[2]=int(rand(2));
        $MIXPROADDWEI[3]=1;
        $MIXPROADDWEI[4]=int(rand(2));
        $MIXPROADDWEI[5]=1;
        $MIXPROADDWEI[6]=int(rand(2));
        $MIXPROADDWEI[7]=1;

                        		if (($supoint*10)>=int(rand(100))){
                                ($xmprono,$mproname,$xmproval,$xmprodmg,$xmprowei,$xmproele,$xmprohit,$xmprocl,$xmprosta,$xmprotype,$xmproflg) = split(/,/,$mpro);
					$ext_mix[$mproele]--;
                                        if ($xmprowei>$MIXMAXPRO[$xmproele][1]){
                                                $xmprowei-=$MIXPROADDWEI[$xmproele];
                                                if ($xmprowei<$MIXMAXPRO[$xmproele][1]){$xmprowei=$MIXMAXPRO[$xmproele][1];}
                                        }else{
						$MIXPROADDDMG[$xmproele]+=$MIXPROADDWEI[$xmproele];
                                                $MIXPROADDWEI[$xmproele]="已達到上限";
                                        }
                                        if ($xmprodmg<$MIXMAXPRO[$xmproele][0]){
                                                $xmprodmg+=$MIXPROADDDMG[$xmproele];
                                                if ($xmprodmg>$MIXMAXPRO[$xmproele][0]){$xmprodmg=$MIXMAXPRO[$xmproele][0];}
                                        }else{
                                                $MIXPROADDDMG[$xmproele]="已達到上限";
                                        }
                                        $susmsg.="<BR>第$i次:成功強化了<font color=#AAAAFF>$mproname</font><font color=yellow>威力+$MIXPROADDDMG[$xmproele],重量-$MIXPROADDWEI[$xmproele]</font>";
                                        $mpro="$xmprono,$mproname,$xmproval,$xmprodmg,$xmprowei,$xmproele,$xmprohit,$xmprocl,$xmprosta,$xmprotype,$xmproflg";
								}else{
									$susmsg.="<BR>第$i次:強化失敗了";
								}
					}
                        }
                        $mixno2++;
                }
#=========================================================武注奧======================================================
                if ($marmno eq"mix" && $mixno2 eq $in{'no'} && $carmsta ne"") {
                		if($in{'iarmsta'} eq""){
                			&error("請選擇要注入的武器");
                		}
                		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'iarmsta'}]);
				($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                		if($it_ki eq"0" && $it_stas[0]>0 && $it_no eq"rea"){
							foreach(@ABILITY){
	                                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
	                                if($it_stas[0] eq $abno){
	                                        last;
	                                }
	                        }
	                        $spoint=int(($it_dmg-($it_wei*3))/10);
	                        if($it_ele eq $marmele) {
					$spoint+=10;
					if($it_ele eq $mele){$spoint+=10;}
				}
	                        $spoint+=int($supoint/5);if($spoint>50){$spoint=50;}
				if($member_mix){$spoint+=50;$member_mix="";}
	                        $rpoint=int(rand(100));
	                        splice(@ITEM,$in{'iarmsta'},1);
	                        if ($spoint>=$rpoint || $mid eq $GMID){
	                        	($xmarmno,$marmname,$xmarmval,$xmarmdmg,$xmarmwei,$xmarmele,$xmarmhit,$xmarmcl,$xmarmsta,$xmarmtype,$xmarmflg) = split(/,/,$marm);
					($xmarm_stas[0],$xmarm_stas[1])=split(/:/,$xmarmsta);
	                        	$xmarmsta=$abno;
					if($xmarm_stas[1] ne ""){$xmarmsta.=":$xmarm_stas[1]";}
	                        	$marm="$xmarmno,$marmname,$xmarmval,$xmarmdmg,$xmarmwei,$xmarmele,$xmarmhit,$xmarmcl,$xmarmsta,$xmarmtype,$xmarmflg";
	                        	$susmsg="奧義「$abname」注入成功，成功值$spoint以內，實值$rpoint";
	                        	&maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將「<font color=green>$abname</font>」注入了<font color=red>$marmname</font>");
					&maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將「<font color=green>$abname</font>」注入了<font color=red>$marmname</font>");
	                        }else{
	                        	$susmsg="奧義「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
	                        	&maplog("<font color=red>[製作]</font><font color=blue>$mname</font>將「<font color=green>$abname</font>」注入<font color=red>$marmname</font>失敗了");
					&maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>將「<font color=green>$abname</font>」注入<font color=red>$marmname</font>失敗了");
	                        }
                		}else{
                			&error("注入的武器有誤,請重新選擇");
                		}
                         $mixno2++;
                }elsif($marmno eq"mix" && $carmsta ne""){
			$mixno2++;
		}
#========================================================防注奧=========================================================
                if ($mprono eq"mix" && $mixno2 eq $in{'no'} && $cprosta ne"") {
                		if($in{'iprosta'} eq""){
                			&error("請選擇要注入的防具");
                		}
                		($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'iprosta'}]);
				($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                		if($it_ki eq"1" && $it_stas[0]>0 && $it_no eq"rea"){
							foreach(@ABILITY){
	                                ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
	                                if($it_stas[0] eq $abno){
	                                        last;
	                                }
	                        }
	                        $spoint=int(($it_dmg-($it_wei*3))/10);
	                        if($it_ele eq $mproele) {
					$spoint+=10;
					if($it_ele eq $mele){$spoint+=10;}
				}
	                        $spoint+=int($supoint/5);if($spoint>50){$spoint=50;}
				if($member_mix){$spoint+=50;$member_mix="";}
	                        $rpoint=int(rand(100));
	                        splice(@ITEM,$in{'iprosta'},1);
	                        if ($spoint>=$rpoint || $mid eq $GMID){
	                        	($xmprono,$mproname,$xmproval,$xmprodmg,$xmprowei,$xmproele,$xmprohit,$xmprocl,$xmprosta,$xmprotype,$xmproflg) = split(/,/,$mpro);
					($xmpro_stas[0],$xmpro_stas[1])=split(/:/,$xmprosta);
	                        	$xmprosta=$abno;
					if($xmpro_stas[1] ne""){$xmprosta.=":$xmpro_stas[1]";}
	                        	$mpro="$xmprono,$mproname,$xmproval,$xmprodmg,$xmprowei,$xmproele,$xmprohit,$xmprocl,$xmprosta,$xmprotype,$xmproflg";
	                        	$susmsg="奧義「$abname」注入成功，成功值$spoint以內，實值$rpoint";
	                        	&maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將「<font color=green>$abname</font>」注入了<font color=red>$mproname</font>");
                                        &maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將「<font color=green>$abname</font>」注入了<font color=red>$mproname</font>");
	                        }else{
	                        	$susmsg="奧義「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
	                        	&maplog("<font color=red>[製作]</font><font color=blue>$mname</font>將「<font colorgreen>$abname</font>」注入<font color=red>$mproname</font>失敗了");
                                        &maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>將「<font colorgreen>$abname</font>」注入<font color=red>$mproname</font>失敗了");
	                        }
                		}else{
                			&error("注入的防具有誤,請重新選擇");
                		}
                         $mixno2++;
                }elsif($mprono eq"mix" && $cprosta ne""){
                        $mixno2++;
                }

#========================================================寵注奧=========================================================
                if ($mpetname ne"" && $mixno2 eq $in{'no'} && $cpetsta ne"") {
                                if($in{'ipetsta'} eq""){
                                        &error("請選擇要注入寵物的飾品");
                                }
                                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'ipetsta'}]);
				($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                                if($it_ki eq"2" && $it_stas[0]>0 && $it_no eq"rea"){
                                        foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                last;
                                        }
                                }
                                $spoint=int(($it_dmg-($it_wei*3))/10);
                                if($it_ele eq $mpetele) {
					$spoint+=10;
					if($it_ele eq $mele){$spoint+=10;}
				}
                                $spoint+=int($supoint/5);if($spoint>50){$spoint=50;}
				if($member_mix){$spoint+=50;$member_mix="";}
                                $rpoint=int(rand(100));
                                splice(@ITEM,$in{'ipetsta'},1);
                                if ($spoint>=$rpoint || $mid eq $GMID){
                                        ($xmpetno,$mpetname,$xmpetval,$xmpetdmg,$xmpetwei,$xmpetele,$xmpethit,$xmpetcl,$xmpetsta,$xmpettype,$xmpetflg) = split(/,/,$mpet);
					($xmpet_stas[0],$xmpet_stas[1])=split(/:/,$xmpetsta);
                                        $xmpetsta=$abno;
					if($xmpet_stas[1] ne""){$xmpetsta.=":$xmpet_stas[1]";}
                                        $mpet="$xmpetno,$mpetname,$xmpetval,$xmpetdmg,$xmpetwei,$xmpetele,$xmpethit,$xmpetcl,$xmpetsta,$xmpettype,$xmpetflg";
                                        $susmsg="「$mpetname」成功學習了奧義「$abname」，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=green>[製作]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>成功的學習了「<font color=green>$abname</font>」");
                                        &maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>成功的學習了「<font color=green>$abname</font>」");
                                }else{
                                        $susmsg="奧義「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=red>[製作]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>學習「<font color=green>$abname</font>」失敗了");
					&maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>的<font color=red>$mpetname</font>學習「<font color=green>$abname</font>」失敗了");
                                }
                                }else{
                                        &error("注入的飾品有誤,請重新選擇");
                                }
                         $mixno2++;
                }elsif($mpetname ne"" && $cpetsta ne""){
                        $mixno2++;
                }
#========================================================寵化熟書=========================================================
                if ($mpetname ne"" && $mixno2 eq $in{'no'} && $ext_mix[$mpetele]>2) {
			$ext_mix[$mpetele]-=3;
                        $getabp=($mpetdmg+$mpetdef+$mpetspeed*2)*10;
			$mpet="";
			push(@ITEM,"priv<>3<>寵物的熟練之書<>1000000<>$getabp<>0<>0<>80<>10<>合成<>11<><>\n");
                        $susmsg="「$mpetname」成功化為「寵物的熟練之書($getabp)」";
                        $mixno2++;
                }elsif($mpetname ne"" && $ext_mix[$mpetele]>2){
                        $mixno2++;
                }
#========================================強化飾品===============================================
                if ($maccno eq"mix" && $ext_mix[$maccele]>2) {
                        if($in{'no'} eq"$mixno2"){
                                        if($in{'enc_num'} eq ""){&error("請輸入強化的數量。");}
                                        if($in{'enc_num'} =~ m/[^0-9]/){&error("請輸入正確強化的數量。");}
                                        if($in{'enc_num'} <0){&error("請輸入正確的強化數量。");}
                                        if($in{'enc_num'}*3>$ext_mix[$maccele]){&error("你的$ELE[$maccele]原料不足");}
                                        $useabp=$useabp*$in{'enc_num'};
                                        $usegold=$usegold*$in{'enc_num'};
                                        if($mabp<$useabp){&error("你的熟練不足$useabp。");}
                                        if($mbank<$usegold){&error("你銀行裏的存款不足$usegold。");}
                                        for($i=1;$i<=$in{'enc_num'};$i++){

                                        if (($supoint*10)>=int(rand(100))){
                                ($xmaccno,$maccname,$xmaccval,$xmaccdmg,$xmaccwei,$xmaccele,$xmacchit,$xmacccl,$xmaccsta,$xmacctype,$xmaccflg) = split(/,/,$macc);
					$ext_mix[$maccele]-=3;
                                        if ($xmaccwei>$MIXMAXACC[$xmaccele][1]){
                                                $xmaccwei-=$MIXACCADDWEI[$xmaccele];
                                                if ($xmaccwei<$MIXMAXACC[$xmaccele][1]){$xmaccwei=$MIXMAXACC[$xmaccele][1];}
                                        }else{
                                                $MIXACCADDDMG[$xmaccele]+=$MIXACCADDWEI[$xmaccele];
                                                $MIXACCADDWEI[$xmaccele]="已達到上限";
                                        }
                                        if ($xmaccdmg<$MIXMAXACC[$xmaccele][0]){
                                                $xmaccdmg+=$MIXACCADDDMG[$xmaccele];
                                                if ($xmaccdmg>$MIXMAXACC[$xmaccele][0]){$xmaccdmg=$MIXMAXACC[$xmaccele][0];}
                                        }else{
                                                $MIXACCADDDMG[$xmaccele]="已達到上限";
                                        }
                                        $susmsg="<BR>第$i次:你已成功強化了<font color=#AAAAFF>$maccname</font><font color=yellow>威力+$MIXACCADDDMG[$xmaccele],重量-$MIXACCADDWEI[$xmaccele]</font>";
                                        $macc="$xmaccno,$maccname,$xmaccval,$xmaccdmg,$xmaccwei,$xmaccele,$xmacchit,$xmacccl,$xmaccsta,$xmacctype,$xmaccflg";
                                                                }else{
                                                                        $susmsg.="<BR>第$i次:強化失敗了";
                                                                }
					}
                        }
                        $mixno2++;
                }
#========================================================飾注奧=========================================================
                if ($maccno eq"mix" && $mixno2 eq $in{'no'} && $caccsta ne"") {
                                if($in{'iaccsta'} eq""){
                                        &error("請選擇要注入的飾品");
                                }
                                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'iaccsta'}]);
                                ($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                                if($it_ki eq"2" && $it_stas[0]>0 && $it_no eq"rea"){
                                foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                last;
                                        }
                                }
                                $spoint=int(($it_dmg-($it_wei*3))/10);
                                if($it_ele eq $maccele) {
                                        $spoint+=10;
                                        if($it_ele eq $mele){$spoint+=10;}
                                }
                                $spoint+=int($supoint/10);if($spoint>50){$spoint=50;}
                                if($member_mix){$spoint+=50;$member_mix="";}
                                $rpoint=int(rand(100));
                                splice(@ITEM,$in{'iaccsta'},1);
                                if ($spoint>=$rpoint || $mid eq $GMID){
                                        ($xmaccno,$maccname,$xmaccval,$xmaccdmg,$xmaccwei,$xmaccele,$xmacchit,$xmacccl,$xmaccsta,$xmacctype,$xmaccflg) = split(/,/,$macc);
                                        ($xmacc_stas[0],$xmacc_stas[1])=split(/:/,$xmaccsta);
                                        $xmaccsta=$abno;
                                        if($xmacc_stas[1] ne""){$xmaccsta.=":$xmacc_stas[1]";}
                                        $macc="$xmaccno,$maccname,$xmaccval,$xmaccdmg,$xmaccwei,$xmaccele,$xmacchit,$xmacccl,$xmaccsta,$xmacctype,$xmaccflg";
                                        $susmsg="奧義「$abname」注入成功，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將「<font color=green>$abname</font>」注入了<font color=red>$maccname</font>");
                                        &maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將「<font color=green>$abname</font>」注入了<font color=red>$maccname</font>");
                                }else{
                                        $susmsg="奧義「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=red>[製作]</font><font color=blue>$mname</font>將「<font colorgreen>$abname</font>」注入<font color=red>$maccname</font>失敗了");
                                        &maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>將「<font colorgreen>$abname</font>」注入<font color=red>$maccname</font>失敗了");
                                }
                                }else{
                                        &error("注入的飾品有誤,請重新選擇");
                                }
                         $mixno2++;
                }elsif($maccno eq"mix" && $caccsta ne""){
                        $mixno2++;
                }
#===============================================武注奧石=============================================
                if ($marmno eq"mix" && $mixno2 eq $in{'no'} && $carmsta2 ne"") {
                                if($in{'iarmsta2'} eq""){
                                        &error("請選擇要注入的奧義之石(武)");
                                }
                                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'iarmsta2'}]);
                                ($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                                if($it_ki eq"7" && $it_stas[0]>0 && $it_dmg eq"0"){
                                foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                last;
                                        }
                                }
                                $spoint=int(($it_dmg-($it_wei*3))/10);
                                $spoint+=int($supoint/20);if($spoint>50){$spoint=50;}
                                if($member_mix){$spoint+=50;$member_mix="";}
                                $rpoint=int(rand(100));
                                splice(@ITEM,$in{'iarmsta2'},1);
                                if ($spoint>=$rpoint || $mid eq $GMID){
                                        ($xmarmno,$marmname,$xmarmval,$xmarmdmg,$xmarmwei,$xmarmele,$xmarmhit,$xmarmcl,$xmarmsta,$xmarmtype,$xmarmflg) = split(/,/,$marm);
					($xmarm_stas[0],$xmarm_stas[1])=split(/:/,$xmarmsta);
                                        $xmarmsta="$xmarm_stas[0]:$abno";
                                        $marm="$xmarmno,$marmname,$xmarmval,$xmarmdmg,$xmarmwei,$xmarmele,$xmarmhit,$xmarmcl,$xmarmsta,$xmarmtype,$xmarmflg";
                                        $susmsg="奧義之石「$abname」注入成功，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$marmname</font>");
                                        &maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$marmname</font>");
                                }else{
                                        $susmsg="奧義之石「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$marmname</font>失敗了");
                                        &maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$marmname</font>失敗了");
                                }
                                }else{
                                        &error("注入的武器有誤,請重新選擇");
                                }
                         $mixno2++;
                }elsif($marmno eq"mix" && $carmsta2 ne""){
                        $mixno2++;
                }
#==============================================防注奧石===========================================================
                if ($mprono eq"mix" && $mixno2 eq $in{'no'} && $cprosta2 ne"") {
                                if($in{'iprosta2'} eq""){
                                        &error("請選擇要注入的奧義之石(防)");
                                }
                                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'iprosta2'}]);
                                ($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                                if($it_ki eq"7" && $it_stas[0]>0 && $it_dmg eq"1"){
                                foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                last;
                                        }
                                }
                                $spoint=int(($it_dmg-($it_wei*3))/10);
                                $spoint+=int($supoint/20);if($spoint>50){$spoint=50;}
                                if($member_mix){$spoint+=50;$member_mix="";}
                                $rpoint=int(rand(100));
                                splice(@ITEM,$in{'iprosta2'},1);
                                if ($spoint>=$rpoint || $mid eq $GMID){
                                        ($xmprono,$mproname,$xmproval,$xmprodmg,$xmprowei,$xmproele,$xmprohit,$xmprocl,$xmprosta,$xmprotype,$xmproflg) = split(/,/,$mpro);
                                        ($xmpro_stas[0],$xmpro_stas[1])=split(/:/,$xmprosta);
                                        $xmprosta="$xmpro_stas[0]:$abno";
                                        $mpro="$xmprono,$mproname,$xmproval,$xmprodmg,$xmprowei,$xmproele,$xmprohit,$xmprocl,$xmprosta,$xmprotype,$xmproflg";
                                        $susmsg="奧義之石「$abname」注入成功，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$mproname</font>");
                                        &maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$mproname</font>");
                                }else{
                                        $susmsg="奧義之石「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$mproname</font>失敗了");
                                        &maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$mproname</font>失敗了");
                                }
                                }else{
                                        &error("注入的防具有誤,請重新選擇,$cprosta2");

                                }
                         $mixno2++;
                }elsif($mprono eq"mix" && $cprosta2 ne""){
                        $mixno2++;
                }
                if ($maccno eq"mix" && $mixno2 eq $in{'no'} && $caccsta2 ne"") {
                                if($in{'iaccsta2'} eq""){
                                        &error("請選擇要注入的奧義之石(飾)");
                                }
                                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'iaccsta2'}]);
                                ($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                                if($it_ki eq"7" && $it_stas[0]>0 && $it_dmg eq"2"){
                                foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                last;
                                        }
                                }
                                $spoint=int(($it_dmg-($it_wei*3))/10);
                                $spoint+=int($supoint/20);if($spoint>50){$spoint=50;}
                                if($member_mix){$spoint+=50;$member_mix="";}
                                $rpoint=int(rand(100));
                                splice(@ITEM,$in{'iaccsta2'},1);
                                if ($spoint>=$rpoint || $mid eq $GMID){
                                        ($xmaccno,$maccname,$xmaccval,$xmaccdmg,$xmaccwei,$xmaccele,$xmacchit,$xmacccl,$xmaccsta,$xmacctype,$xmaccflg) = split(/,/,$macc);
                                        ($xmacc_stas[0],$xmacc_stas[1])=split(/:/,$xmaccsta);
                                        $xmaccsta="$xmacc_stas[0]:$abno";
                                        $macc="$xmaccno,$maccname,$xmaccval,$xmaccdmg,$xmaccwei,$xmaccele,$xmacchit,$xmacccl,$xmaccsta,$xmacctype,$xmaccflg";
                                        $susmsg="奧義之石「$abname」注入成功，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$maccname</font>");
                                        &maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$maccname</font>");
                                }else{
                                        $susmsg="奧義之石「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$maccname</font>失敗了");
                                        &maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$maccname</font>失敗了");
                                }
                                }else{
                                        &error("注入的飾品有誤,請重新選擇");
                                }
                         $mixno2++;
                }elsif($maccno eq"mix" && $caccsta2 ne""){
                        $mixno2++;
                }
                if ($mpetname ne"" && $mixno2 eq $in{'no'} && $cpetsta2 ne"") {
                                if($in{'ipetsta2'} eq""){
                                        &error("請選擇要注入的奧義之石(寵)");
                                }
                                ($it_no,$it_ki,$it_name,$it_val,$it_dmg,$it_wei,$it_ele,$it_hit,$it_cl,$it_sta,$it_type,$it_flg)=split(/<>/,$ITEM[$in{'ipetsta2'}]);
                                ($it_stas[0],$it_stas[1])=split(/:/,$it_sta);
                                if($it_ki eq"7" && $it_stas[0]>0 && $it_dmg eq"4"){
                                foreach(@ABILITY){
                                        ($abno,$abname,$abcom,$abdmg,$abrate,$abpoint,$abclass,$abtype)=split(/<>/);
                                        if($it_stas[0] eq $abno){
                                                last;
                                        }
                                }
                                $spoint=int(($it_dmg-($it_wei*3))/10);
                                $spoint+=int($supoint/20);if($spoint>50){$spoint=50;}
                                if($member_mix){$spoint+=50;$member_mix="";}
                                $rpoint=int(rand(100));
                                splice(@ITEM,$in{'ipetsta2'},1);
                                if ($spoint>=$rpoint || $mid eq $GMID){
                                        ($xmpetno,$mpetname,$xmpetval,$xmpetdmg,$xmpetwei,$xmpetele,$xmpethit,$xmpetcl,$xmpetsta,$xmpettype,$xmpetflg) = split(/,/,$mpet);
                                        ($xmpet_stas[0],$xmpet_stas[1])=split(/:/,$xmpetsta);
                                        $xmpetsta="$xmpet_stas[0]:$abno";
                                        $mpet="$xmpetno,$mpetname,$xmpetval,$xmpetdmg,$xmpetwei,$xmpetele,$xmpethit,$xmpetcl,$xmpetsta,$xmpettype,$xmpetflg";
                                        $susmsg="奧義之石「$abname」注入成功，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$mpetname</font>");
                                        &maplogmix("<font color=green>[製作]</font><font color=blue>$mname</font>成功的將奧義之石「<font color=green>$abname</font>」注入了<font color=red>$mpetname</font>");
                                }else{
                                        $susmsg="奧義之石「$abname」注入失敗，成功值$spoint以內，實值$rpoint";
                                        &maplog("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$mpetname</font>失敗了");
                                        &maplogmix("<font color=red>[製作]</font><font color=blue>$mname</font>將奧義之石「<font colorgreen>$abname</font>」注入<font color=red>$mpetname</font>失敗了");
                                }
                                }else{
                                        &error("注入的寵物有誤,請重新選擇");
                                }
                         $mixno2++;
                }elsif($mpetname ne"" && $cpetsta2 ne""){
                        $mixno2++;
                }


        }
  if ($susmsg eq"") {
                &error("無法合成你所選擇的項目!$in{'no'}");
        }
	$mabp-=$useabp;
	$mbank-=$usegold;
#	$mabp-=int($in{'useabp'});
#	$mbank-=int($in{'usegold'}*10000);
	&chara_input;
	&ext_input;
	open(OUT,">./logfile/item/$in{'id'}.cgi");
        print OUT @ITEM;
        close(OUT);

	&header;
	
	print <<"EOF";
<TABLE border="0" width="80%" bgcolor="#ffffff" height="150" align=center CLASS=FC>
  <TBODY>
    <TR>
      <TD colspan="2" align="center" bgcolor="#993300"><FONT color="#ffffcc">工房</FONT></TD>
    </TR>
    <TR>
      <TD bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/inn2.jpg"></TD>
      <TD bgcolor="#330000"><FONT color="#ffffcc"><font color=#AAAAFF>$mname</font>$susmsg</FONT></TD>
    </TR>
    <TR>
      <TD colspan="2" align="right">
        <form action="./town.cgi" method="POST">
        <INPUT type=hidden name=id value=$mid>
        <INPUT type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
	<INPUT type=hidden name=mode value=mix>
        <INPUT type=submit CLASS=FC value=回到工房></form></TD>

    </TR>
  </TBODY>
</TABLE>

EOF

	&footer;
	exit;
}
1;
