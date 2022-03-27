<%--
  Created by IntelliJ IDEA.
  User: 周成
  Date: 2021-12-29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>


<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=gb2312" %>


<html>
<head>
    <title>浏览者界面</title>
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
<form method="post" id="form6" name="form6" action="" onsubmit="return check()">
    <table>
        <tr>
            <td>名称</td>
            <td>描述</td>
            <td>创建者</td>
        </tr>
        <%
            // 连接数据库参数
            String userName= "root";
            String password= "000000";
            String dbName= "archive_management";
            String host= "localhost";
            String port= "3306";
            String url= "jdbc:mysql://" +host+ ":" +port+ "/" +dbName;
            // 创建几个类
            Connection connect;   // 负责连接数据库
            Statement statement = null; // 负责发送sql语句
            ResultSet resultSet;    // 负责查询结果
            // 注册数据库驱动
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            // 连接数据库
            connect = DriverManager.getConnection(url, userName, password);
            // 发送SQL语句
            String sql="select * from tbl_archive";
            try {
                statement = Objects.requireNonNull(connect).createStatement();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            resultSet= Objects.requireNonNull(statement).executeQuery(sql);

            while(resultSet.next()) {
                String archName=resultSet.getString("archname");
                String creator=resultSet.getString("username");
                String description=resultSet.getString("description");

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
        <%--<td colspan="6"><button type="submit" onclick="form6.action='download.jsp';form6.submit()">下载文件</button></td>--%>
        <%--</tr>--%>
    </table>
</form>

</body>
</html>

