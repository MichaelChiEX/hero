sub setkey2{
    require './data/conf_fastkey.cgi';
    &header;
    &chara_open;

    if ($mbank<1000000){
        &error_old("你的銀行不足１００萬，無法設定快速鍵");
    }
    &fixext_open;
    
    @nums=split(/,/,$in{'no'});
    for($i=0;$i<10;$i++){
        $fixext_fkey[$i]="";
    }

    for($i=0; $i<=$#nums && $i<10; $i++){
        $code = @nums[$i];
        if($code ne "" && $key_class[$code] ne ""){
            $fixext_fkey[$i]=$key_class[$code].",".$key_cmd[$code].",".$key_name[$code];
        }
    }
    $mbank-=1000000;
    &fixext_input;
    &chara_input;

    print <<"EOF";
    <table border="0" width="80%" bgcolor="#ffffff" height="150" align=center class=FC>
        <tbody>
            <tr>
                <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">快速鍵設定</font></td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc" width=20% align=center></td>
                <td bgcolor="#330000"><font color="#ffffcc">快速鍵設定完成</font></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <form action="./top.cgi" method="POST">
                        <input type=hidden name=id value=$mid>
                        <input type=hidden name=pass value=$mpass>
                        <input type=hidden name=rmode value=$in{'rmode'}>
                        <input type=submit CLASS=FC value=回到城鎮>
                    </form>
                </td>
            </tr>
        </tbody>
    </ta>
EOF
    &footer;
    exit;
}
1;

