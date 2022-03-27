package edu.nuist.studentadmin.servlet;

import edu.nuist.studentadmin.dao.impl.UserDaoImpl;
import edu.nuist.studentadmin.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        // 1.获取注册信息
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        System.out.println(role);
        // 2.封装注册信息为对象
        User user = new User(username,password,role);
        // 3.调用 UserDao 对象，把 User 保存到数据库
        boolean save = new UserDaoImpl().save(user);
        // 4.根据返回结果，返回不同页面
        if(save) {
            if(role.equals("0")){
                resp.getWriter().write("<script>alert('Success!');location.href='browser.jsp'</script>");
            }
            else if(role.equals("1")){
                resp.getWriter().write("<script>alert('Success！');location.href='operator.jsp'</script>");
            }
            else {
                resp.getWriter().write("<script>alert('Success！');location.href='admin.jsp'</script>");
            }
        } else {
            resp.getWriter().write("<script>alert('Fail！');location.href='error.jsp'</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
