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
    //������Ӧ�ַ���ʹ�õı��룬���ܸ�֪�������ʲô���������ʾ
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");

    String udescription=request.getParameter("description");
    String uname=session.getAttribute("username").toString();
    //�����ϴ��ļ�������ֽ�
    double MAX_SIZE = 102400 * 102400;
    //������·���ı������
    String rootPath;
    //�����ļ�������
    DataInputStream in;
    FileOutputStream fileOut;
    //ȡ�û���������ľ��Ե�ַ
    String realPath = request.getSession().getServletContext().getRealPath("/");
    realPath = realPath.substring(0, realPath.indexOf("\\out"));
//    out.print(realPath);
    //�����ļ��ı���Ŀ¼
    rootPath = realPath + "\\src\\main\\web\\upload\\";
    //ȡ�ÿͻ����ϴ�����������
    String contentType = request.getContentType();
    try {
        if (contentType.contains("multipart/form-data")) {
            //�����ϴ�����
            in = new DataInputStream(request.getInputStream());
            int formDataLength = request.getContentLength();
            if (formDataLength > MAX_SIZE) {
                out.print("<script language='JavaScript'>alert('�ϴ��ļ�����')</script>");
                response.setHeader("refresh","0;url=opera.jsp");
                return;
            }
            //�����ϴ��ļ�������
            byte[] dataBytes = new byte[formDataLength];
            int byteRead;
            int totalBytesRead = 0;
            //�ϴ������ݱ�����byte��������
            while (totalBytesRead < formDataLength) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
            }
            //����byte���鴴���ַ���
            String file = new String(dataBytes, "GB2312");
            //ȡ���ϴ����ݵ��ļ���
            String saveFile = file.substring(file.indexOf("filename=\"") + 10);
            saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
            ufile=saveFile;
            int lastIndex = contentType.lastIndexOf("=");
            //ȡ�����ݵķָ��ַ���
            String boundary = contentType.substring(lastIndex + 1, contentType.length());
            //��������·�����ļ���
            String fileName = rootPath + saveFile;
            int pos;
            pos = file.indexOf("filename = \"");
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            int boundaryLocation = file.indexOf(boundary, pos) - 4;
            //ȡ���ļ����ݵĿ�ʼ��λ��
            int startPos = ((file.substring(0, pos)).getBytes()).length;
            int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
            File checkFile = new File(fileName);
            if (checkFile.exists()) {
                out.print("<script language='JavaScript'>alert('�ļ��Ѵ���')</script>");
                response.setHeader("refresh","0;url=operator.jsp");
                return;
            }
            //����ϴ��ļ���Ŀ¼�Ƿ����
            File fileDir = new File(rootPath);
            if (!fileDir.exists()) {
                fileDir.mkdirs();
            }
            //�����ļ��������
            fileOut = new FileOutputStream(fileName);
            //�����ļ�������
            fileOut.write(dataBytes, startPos, (endPos - startPos));
            fileOut.close();
        } else {
            out.print("<script language='JavaScript'>alert('���ϴ�Ŀ¼mutipart/form-data���͵��ļ�')</script>");
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
        out.print("<script language='JavaScript'>alert('�ļ��ϴ��ɹ�')</script>");
    }
    else{
        out.print("<script language='JavaScript'>alert('�ļ��ϴ�ʧ��')</script>");
    }
    response.setHeader("refresh","0;url=operator.jsp");
%>
</body>
</html>

