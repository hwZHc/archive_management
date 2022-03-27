package edu.nuist.studentadmin.dao;

import edu.nuist.studentadmin.model.User;

import java.util.List;


public interface UserDao {
    boolean checkLogin(String username, String password,String role);
    boolean checkName(String userName);
    boolean save(User user);
    boolean delete(int stuno);
    boolean update(User user);
    List<User> getAllStudents();
}
