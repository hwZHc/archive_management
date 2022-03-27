package edu.nuist.studentadmin.dao.impl;

import edu.nuist.studentadmin.dao.UserDao;
import edu.nuist.studentadmin.model.User;
import edu.nuist.studentadmin.utils.DBHelper;
import edu.nuist.studentadmin.utils.Md5Util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UserDaoImpl implements UserDao {
    @Override
    public boolean checkLogin(String username, String password,String role) {
        DBHelper dbHelper = new DBHelper();
        List<String> params = new ArrayList<>();
        params.add(username);
        params.add(Md5Util.md5(password));
        List<Object> query = dbHelper.query("select * from tbl_user where username=? and password=?", params);
        return query.size()>0;
    }

    @Override
    public boolean checkName(String userName) {
        return false;
    }

    @Override
    public boolean save(User user) {
        DBHelper dbHelper = new DBHelper();
        String sql = "INSERT INTO tbl_user(username,password,role) values(?,?,?);";
        List<Object> params = new ArrayList<>();
        params.add(user.getUsername());
        params.add(user.getPassword());
        params.add(user.getRole());
        int update = dbHelper.update(sql, params);
        return update > 0;
    }

    @Override
    public boolean delete(int stuno) {
        return false;
    }

    @Override
    public boolean update(User user) {
        return false;
    }

    @Override
    public List<User> getAllStudents() {
        DBHelper dbHelper = new DBHelper();
        List<User> Users = new ArrayList<>();
        List<Object> query = dbHelper.query("select * from tbl_user", null);
        for (Object o:query) {
            Map map = (Map)o;
            Users.add(
                    new User((String) map.get("username"), (String) map.get("password"),
                            (String) map.get("role"))
            );
        }
        return Users;
    }
}
