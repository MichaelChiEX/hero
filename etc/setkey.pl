sub setkey{
	require './data/conf_fastkey.cgi';
    &chara_open;

    for($i=0;$i<37;$i++){
        $kclass="";
        if($key_class[$i] eq"town"){
            $kclass="城鎮設施";
        }elsif($key_class[$i] eq"status"){
            $kclass="各項設定";
        }elsif($key_class[$i] eq"country"){
            $kclass="軍事．內政";
        }
        $keytable.="<tr><td bgcolor=white><input type=checkbox class='fastkey' value=$i></td><td bgcolor=white>$kclass</td><td bgcolor=white>$key_name[$i]</td></tr>";
    }

    &header;
    print <<"EOF";
    <table border="0" width="80%" bgcolor="#ffffff" height="150" align=center class=FC>
        <tbody>
            <tr>
                <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">快速按鈕設定</font></td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc" width=20% align=center></td>
                <td bgcolor="#330000"><font color="#ffffcc">設定快速按鈕的功能會出現在畫面上直接可以點選，不需要再下拉選單，最多設定１０組，每次設定費用１００萬</font></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <table border=0 width="100%" bgcolor=$FCOLOR class=TC>
                        <tr>
                            <td colspan=7 align=center><font color=ffffcc>指令一覽</font></td>
                        </tr>
                        <tr>
                            <td bgcolor=white>勾選設定</td><td bgcolor=white>功能類別</td><td bgcolor=white>指令名稱</td>
                        </tr>
                        <form action="./etc.cgi" method="post" id=movef name=movef>
                        $keytable
                        <tr>
                            <td colspan=7 align=center bgcolor="ffffff">
                                <input type=hidden name=id value=$mid>
                                <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                                <input type=hidden name=no id=no>
                                <input type=hidden name=mode value=setkey2>
                                <input type=button value=設定(花費１００萬) class=FC onclick="javascript:chkform(this.form);">
                            </td>
                        </tr>
                        </form>
                    </table>
                    $BACKTOWNBUTTON
                </td>
            </tr>
        </tbody>
    </table>
    <script>
        function chkform(f){
            var fastkeys = [];
            document.querySelectorAll('.fastkey').forEach(function(element) {
                if(element.checked){
                    fastkeys.push(element.value);
                }
            })
            f.no.value=fastkeys.join(',');
            f.submit();
        }
    </script>
EOF
    &mainfooter;
    exit;
}
1;

