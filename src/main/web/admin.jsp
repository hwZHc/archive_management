<%--
  Created by IntelliJ IDEA.
  User: 周成
  Date: 2021-12-29
  Time: 13:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>管理员界面</title>
    <style>
        table{
            border-collapse:collapse;
            border: 1px;
            margin: 0 auto;
            text-align: center;
        }
        table td{
            width:50px; height:20px;
            border:solid 1px Black;
            padding:5px;
        }
    </style>
</head>
<body>
<form method="post" id="form2" name="form2" action="">
    <script>
        function check() {
            if(document.form2.admin_name.value===""){
                alert("账号不能为空");
                return false;
            }
            else return true;
        }

        function submitFrom(path) {
            if (check()) {
                document.form2.action = path;
                document.form2.submit();
            }
        }

    </script>

    <table>
        <tr>
            <td colspan="2">角色</td>
            <td colspan="2">账号</td>
            <td colspan="2">密码</td>
        </tr>
        <%
            // 连接数据库参数
            String userName= "root";
            String pwd= "000000";
            String dbName= "archive_management";
            String host= "localhost";
            String port= "3306";
            String url= "jdbc:mysql://" +host+ ":" +port+ "/" +dbName;
            // 创建几个类
            Connection connect;   // 负责连接数据库
            Statement statement = null; // 负责发送sql语句
            ResultSet resultSet;    // 负责查询结果
            // 注册数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 连接数据库
            connect = DriverManager.getConnection(url, userName, pwd);
            // 发送SQL语句
            String sql="select * from tbl_user";
            try {
                statement = Objects.requireNonNull(connect).createStatement();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            resultSet= Objects.requireNonNull(statement).executeQuery(sql);
            while(true) {
                try {
                    if (!resultSet.next()) break;
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                String name=resultSet.getString("username");
                String password=resultSet.getString("password");
                String role=resultSet.getString("role");
        %>
        <tr>
            <td colspan="2"><%=role%></td>
            <td colspan="2"><%=name%></td>
            <td colspan="2"><%=password%></td>
        </tr>
        <%
            }
        %>
        <tr>
            <td>请选择角色</td>
            <td>
                <label>
                    <select name="admin_role" size="1">
                        <option value="browser" selected="selected">browser</option>
                        <option value="operator">operator</option>
                        <option value="admin">admin</option>
                    </select>
                </label>
            </td>
            <td>账号</td>
            <td>
                <label>
                    <input name="admin_name" type="text" size="20">
                </label>
            </td>
            <td>密码</td>
            <td>
                <label>
                    <input name="admin_password" type="password" size="20">
                </label>
            </td>
        </tr>
        <tr>
            <td colspan="2"><button type="submit" onclick="submitFrom('add.jsp')">添加用户</button> </td>
            <td colspan="2"><button type="submit" onclick="submitFrom('updata.jsp')">修改用户</button> </td>
            <td colspan="2"><button type="submit" onclick="submitFrom('del.jsp')">删除用户</button> </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>文件名</td>
            <td>描述</td>
            <td>创建者</td>
        </tr>
        <%
            sql="select * from tbl_archive";
            resultSet=statement.executeQuery(sql);

            while(resultSet.next()) {
                String archName=resultSet.getString("archname");
                String description=resultSet.getString("description");
                String creator=resultSet.getString("username");
        %>
        <tr>
            <td ><a href="./upload/<%=archName%>" download="<%=archName%>"><%=archName%></a></td>
            <td ><%=description%></td>
            <td ><%=creator%></td>
        </tr>
        <%
            }
            statement.close();
            resultSet.close();
            connect.close();
        %>
        <%--<tr align="center">--%>
        <%--<td colspan="6"><button type="submit" onclick="form2.action='download.jsp';form2.submit()">下载文件</button></td>--%>
        <%--</tr>--%>
    </table>
</form>

</body>
</html>

