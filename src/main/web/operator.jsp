<%--
  Created by IntelliJ IDEA.
  User: �ܳ�
  Date: 2021-12-29
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=gb2312" %>
<html>
<head>
  <title>����Ա����</title>
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

<form method="post" id="form4" name="form4" action="download.jsp">
  <table>
    <tr>
      <td>����</td>
      <td>����</td>
      <td>������</td>
    </tr>
    <%
      // �������ݿ����
      String userName= "root";
      String password= "000000";
      String dbName= "archive_management";
      String host= "localhost";
      String port= "3306";
      String url= "jdbc:mysql://" +host+ ":" +port+ "/" +dbName;
      // ����������
      Connection connect;   // �����������ݿ�
      Statement statement = null; // ������sql���
      ResultSet resultSet;    // �����ѯ���
      // ע�����ݿ�����
      Class.forName("com.mysql.cj.jdbc.Driver");
      // �������ݿ�
      connect = DriverManager.getConnection(url, userName, password);
      // ����SQL���
      String sql="select * from tbl_archive";
      try {
        statement = Objects.requireNonNull(connect).createStatement();
      } catch (SQLException e) {
        e.printStackTrace();
      }
      resultSet = Objects.requireNonNull(statement).executeQuery(sql);
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

  </table>
</form>
<form id="form8" name="form8" action="upload.jsp" enctype="multipart/form-data" method="post">
  <table>
    <tr>
      <td>�ϴ��ļ�</td>
      <td><input type="file" name="file"></td>
      <td><input type="submit" value="�ύ">
    </tr>
  </table>
</form>
</body>
</html>
