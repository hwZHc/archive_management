<%--
  Created by IntelliJ IDEA.
  User: 周成
  Date: 2021-12-29
  Time: 15:36
  To change this template use File | Settings | File Templates.
--%>


<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.*" %>
<%@ page import="edu.nuist.studentadmin.model.User" %>
<%@ page import="edu.nuist.studentadmin.dao.impl.UserDaoImpl" %>
<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>
    <title>添加用户</title>
</head>
<body>
<%
    // 连接数据库参数
    String userName="root";
    String password="000000";
    String dbName="archive_management";
    String host="localhost";
    String port="3306";
    String url="jdbc:mysql://" +host+ ":" +port+ "/" +dbName;
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
    request.setCharacterEncoding("UTF-8");
    String uName = request.getParameter("admin_name");
    String uPassword = request.getParameter("admin_password");
    String uRole = request.getParameter("admin_role");
    String sql = "select * from tbl_user where username='"+ uName +"'";
    try {
        statement = Objects.requireNonNull(connect).createStatement();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    resultSet = Objects.requireNonNull(statement).executeQuery(sql);
    if (resultSet.next()) {
        out.println("<script language='JavaScript'>alert('用户已存在！')</script>");
    } else {
        User user = new User(uName, uPassword, uRole);
        boolean save = new UserDaoImpl().save(user);

        if (save) {
            if (uName.equals(null)) {
                out.println("<script language='JavaScript'>alert('添加用户失败')</script>");
            } else {
                out.println("<script language='JavaScript'>alert('添加用户成功')</script>");
            }
        }
        response.setHeader("refresh", "0;url=admin.jsp");
        statement.close();
        resultSet.close();
        connect.close();

    }
%>
</body>
</html>
