<%@ page contentType="text/html;charset=GB2312" language="java" %>
<%@ page import="java.io.*,java.util.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.rmi.ServerException" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    String ufile=null;
    //更改响应字符流使用的编码，还能告知浏览器用什么编码进行显示
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");

    String udescription=request.getParameter("description");
    String uname=session.getAttribute("username").toString();
    //定义上传文件的最大字节
    double MAX_SIZE = 102400 * 102400;
    //创建根路径的保存变量
    String rootPath;
    //声明文件读入类
    DataInputStream in;
    FileOutputStream fileOut;
    //取得互联网程序的绝对地址
    String realPath = request.getSession().getServletContext().getRealPath("/");
    realPath = realPath.substring(0, realPath.indexOf("\\out"));
//    out.print(realPath);
    //创建文件的保存目录
    rootPath = realPath + "\\src\\main\\web\\upload\\";
    //取得客户端上传的数据类型
    String contentType = request.getContentType();
    try {
        if (contentType.contains("multipart/form-data")) {
            //读入上传数据
            in = new DataInputStream(request.getInputStream());
            int formDataLength = request.getContentLength();
            if (formDataLength > MAX_SIZE) {
                out.print("<script language='JavaScript'>alert('上传文件过大')</script>");
                response.setHeader("refresh","0;url=opera.jsp");
                return;
            }
            //保存上传文件的数据
            byte[] dataBytes = new byte[formDataLength];
            int byteRead;
            int totalBytesRead = 0;
            //上传的数据保存在byte数组里面
            while (totalBytesRead < formDataLength) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
            }
            //根据byte数组创建字符串
            String file = new String(dataBytes, "GB2312");
            //取得上传数据的文件名
            String saveFile = file.substring(file.indexOf("filename=\"") + 10);
            saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
            ufile=saveFile;
            int lastIndex = contentType.lastIndexOf("=");
            //取得数据的分隔字符串
            String boundary = contentType.substring(lastIndex + 1, contentType.length());
            //创建保存路径的文件名
            String fileName = rootPath + saveFile;
            int pos;
            pos = file.indexOf("filename = \"");
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            int boundaryLocation = file.indexOf(boundary, pos) - 4;
            //取得文件数据的开始的位置
            int startPos = ((file.substring(0, pos)).getBytes()).length;
            int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
            File checkFile = new File(fileName);
            if (checkFile.exists()) {
                out.print("<script language='JavaScript'>alert('文件已存在')</script>");
                response.setHeader("refresh","0;url=operator.jsp");
                return;
            }
            //检查上传文件的目录是否存在
            File fileDir = new File(rootPath);
            if (!fileDir.exists()) {
                fileDir.mkdirs();
            }
            //创建文件的输出类
            fileOut = new FileOutputStream(fileName);
            //保存文件的数据
            fileOut.write(dataBytes, startPos, (endPos - startPos));
            fileOut.close();
        } else {
            out.print("<script language='JavaScript'>alert('请上传目录mutipart/form-data类型的文件')</script>");
            response.setHeader("refresh","0;url=operator.jsp");
        }
    } catch (Exception ex) {
        throw new ServerException(ex.getMessage());
    }
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/archive_management","root","000000");
    Statement statement=connect.createStatement();
    String sql="select * from tbl_archive";
    ResultSet resultSet=statement.executeQuery(sql);
    int i=1;
    while (resultSet.next()) i++;
    sql="insert into tbl_archive(archname,username,description) values "+"('"+ufile+"','"+uname+"','"+udescription+"')";
    if(statement.executeUpdate(sql)>0){
        out.print("<script language='JavaScript'>alert('文件上传成功')</script>");
    }
    else{
        out.print("<script language='JavaScript'>alert('文件上传失败')</script>");
    }
    response.setHeader("refresh","0;url=operator.jsp");
%>
</body>
</html>

