sub data_change {
    &chara_open;
    &ext_open;
    &header;

    $chara_options="";
    for($i=1; $i<=$CHARAIMG; $i++){
        $chara_options.="<option value='$i'>圖案[$i]</option>";
    }

    print <<"EOM";
    <center>
    <table border="0" width="80%" align=center bgcolor="#ffffff" height="150" CLASS=FC>
        <tbody>
            <tr>
                <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">美容院</font></td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/etc/house.jpg"></td>
                <td bgcolor="#330000">
                    <font color="#ffffcc">你好,歡迎來到美容院。<BR>請選擇你要修改的圖案。<BR>
                    頭像整型一次需要<font color=red>１０萬</font>。整型一次需要１億</font>
                </td>
            </tr>
            <tr>
                <td colspan=2 align=center bgcolor=$FCOLOR2>
                    <form action="./status.cgi" method="post" name=para>
                        <img src="$IMG/chara/$mchara.gif" name="Img"><br>
                        <select id=chara name=chara onChange="changeImg(this)">
                        $chara_options
                        </select><br>選擇你要的圖案。<BR>
                        <input type=submit CLASS=FC value=變更>
                        <input type=hidden name=id value=$mid>
                        <input type=hidden name=pass value=$mpass><input type=hidden name=rmode value=$in{'rmode'}>
                        <input type=hidden name=mode value=data_change2>
                    </form>
                    $BACKTOWNBUTTON
                </td>
            </tr>
        </tbody>
    </table>
    </center>
    <script>
    function changeImg(obj){
        document.Img.src="$IMG/chara/"+ obj.value +".gif";
    }
    </script>
EOM

    &footer;
    exit;
}

1;

