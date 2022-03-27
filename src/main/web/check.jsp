<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    request.setCharacterEncoding("gb2312");
    String uname=request.getParameter("name");
    String upassword=request.getParameter("password");
    String urole=request.getParameter("role");
    session.setAttribute("username",uname);
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    Connection connect= null;
    try {
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/archive_management","root","000000");
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
    assert connect != null;
    Statement statement= null;
    try {
        statement = connect.createStatement();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
    String sql="select * from tbl_user where username='"+uname+"'";
    assert statement != null;
    ResultSet resultSet= null;
    try {
        resultSet = statement.executeQuery(sql);
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
    try {
        assert resultSet != null;
        if(resultSet.next()){
            if(upassword.equals(resultSet.getObject("password"))){
                if(urole.equals(resultSet.getObject("role"))){
                    out.println("<script language='JavaScript'>alert('登录成功')</script>");
                    if(urole.equals("admin")){
                        response.setHeader("refresh","0;url=admin.jsp");
                    }
                    else if(urole.equals("operator")){
                        response.setHeader("refresh","0;url=operator.jsp");
                    }
                    else{
                        response.setHeader("refresh","0;url=browser.jsp");
                    }
                }
                else{
                    out.println("<script language='JavaScript'>alert('账号不存在，请重新输入')</script>");
                    response.setHeader("refresh","0;url=index.jsp");
                }
            }
            else{
                out.println("<script language='JavaScript'>alert('密码错误，请重新输入')</script>");
                response.setHeader("refresh","0;url=index.jsp");
            }
        }
        else{
            out.println("<script language='JavaScript'>alert('账号不存在，请重新输入')</script>");
            response.setHeader("refresh","0;url=index.jsp");
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
    try {
        resultSet.close();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
    try {
        statement.close();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
    try {
        connect.close();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>
</body>
</html>
