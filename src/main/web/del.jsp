<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
<html>
<head>
    <title>删除用户</title>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/archive_management","root","000000");
    Statement statement=connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    String sql=null;
    ResultSet resultSet;
    request.setCharacterEncoding("UTF-8");
    String uname=request.getParameter("admin_name");
    String upassword=request.getParameter("admin_password");
    String urole=request.getParameter("admin_role");
    request.setCharacterEncoding("gb2312");
    sql="select * from tbl_user where username='"+uname+"'";
    resultSet=statement.executeQuery(sql);
    if(!resultSet.next())   {
        out.println("<script language='JavaScript'>alert('用户不存在！')</script>");
        response.setHeader("refresh","0;url=admin.jsp");
    }
    else{
        sql="delete from tbl_user where username='"+uname+"'";
        if(statement.executeUpdate(sql)<=0) {
            out.println("<script language='JavaScript'>alert('删除用户失败')</script>");
            response.setHeader("refresh","0;url=admin.jsp");
        }
        else {
            out.println("<script language='JavaScript'>alert('删除用户成功')</script>");
            response.setHeader("refresh","0;url=admin.jsp");
        }
    }
    statement.close();
    resultSet.close();
    connect.close();
%>
</body>
</html>

