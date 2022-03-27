<%@ page contentType="text/html;charset=gb2312" language="java" %>
<html>
<head>
    <title>登录界面</title>
    <link rel="stylesheet" media="screen" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
<style>
    .magic-radio+label {
        position: relative;
        padding-left: 25px; /* label与radio左端偏离量，与before left相同 */
        cursor: pointer;
    }
    .magic-radio+label:hover:before {
        border-color: #3e97eb;
    }
    .magic-radio+label:before { /* 圆形框 */
        position: absolute;
        top: 0;
        bottom: 0;
        left: -25px; /* 与padding-left相同 */
        right: 0;
        margin: auto;
        width: 15px;
        height: 15px;
        border-radius: 50%;
        content: '';
        border: 1px solid #c0c0c0;
    }
    .magic-radio+label:after { /* 中心圆点 */
        position: absolute;
        display: none;
        content: '';
        top: 0;
        left: -23.5px;
        bottom: 0;
        right: 0;
        margin: auto;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background-color: #3e97eb;
    }
    .magic-radio:checked+label:before {
        border-color: #3e97eb;
    }
    .magic-radio:checked+label:after {
        display: block;
    }
    .magic-radio[disabled]+label, .magic-radio[disabled]+label:before {
        cursor: not-allowed;
        color: #c0c0c0;
        border-color: #c0c0c0;
    }
    .magic-radio:checked[disabled]+label:before {
        border-color: #c9e2f9;
    }
    .magic-radio:checked[disabled]+label:after {
        background: #c9e2f9;
    }

</style>
</head>
<body>
<form method="post" id="form1" name="form1" onsubmit="return check()" action="check.jsp">
    <script language="JavaScript">
        function check() {
            if(document.form1.name.value===""){
                alert("账号不能为空");
            }
            else if(document.form1.password.value===""){
                alert("密码不能为空");
            }
        }



    </script>
    <table border="0" cellspacing="0" align="center">
        <tr>
            <td>选择身份</td>
            <td>
                <input name="role" type="radio" class="magic-radio" value="browser" checked="checked">浏览者
                <input name="role" type="radio" class="magic-radio" value="operator">操作员
                <input name="role" type="radio" class="magic-radio" value="admin">管理员
            </td>
        </tr>
        <tr>
            <td>账号</td>
            <td><input name="name" type="text" size="20"></td>
        </tr>
        <tr>
            <td>密码</td>
            <td><input name="password" type="password" size="20"></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input name="submit" type="submit" value="登录">
                <input name="reset" type="reset" value="重置">
            </td>

        </tr>
    </table>
</form>
<form action="register.html">
<table border="0" cellspacing="0" align="center">
    <tr>
        <td colspan="2" align="center">
            <button>用户注册</button>
        </td>
    </tr>
</table>

</form>
</body>
</html>
