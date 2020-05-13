sub giveup2{
	&chara_open;
	&ext_open;
	$ext_kinghp="0";
	$nowmap="";
	&ext_input;

    &header;
	print <<"EOF";
    <table border="0" width="80%" bgcolor="#ffffff" height="150" align=center class=FC>
        <tbody>
            <tr>
                <td colspan="2" align="center" bgcolor="#993300"><font color="#ffffcc">放棄王座戰</font></td>
            </tr>
            <tr>
                <td bgcolor="#ffffcc" width=20% align=center><img src="$IMG/monster/625.gif"></td>
                <td bgcolor="#330000"><font color="#ffffcc"><font color=#AAAAFF>$mname</font>放棄了王座戰。</font></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    $BACKTOWNBUTTON
                </td>
            </tr>
        </tbody>
    </table>
EOF
	&chara_input;
	&footer;
	exit;
}
1;
