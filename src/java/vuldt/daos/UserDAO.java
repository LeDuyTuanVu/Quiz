/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import vuldt.dtos.UserDTO;
import vuldt.utils.ConnectionDB;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class UserDAO {

    Connection connect = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    public UserDTO getUser(String email, String password) throws NamingException, SQLException, ClassNotFoundException {
        UserDTO user = null;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select email, fullName, password, roleID, status from tblUsers where email = ? and password = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                rs = pst.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(email, fullName, "*******", roleID, status);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (connect != null) {
                connect.close();
            }
        }
        return user;
    }

    public boolean checkEmailExist(String email) throws NamingException, SQLException, ClassNotFoundException {
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select email from tblUsers where email = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, email);
                rs = pst.executeQuery();
                if (rs.next()) {
                    return true;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (connect != null) {
                connect.close();
            }
        }
        return false;
    }

    public int insertUser(UserDTO user) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "insert into tblUsers(email, fullName, password, roleID, status) values(?, ?, ?, ?, ?)";
                pst = connect.prepareStatement(sql);
                pst.setString(1, user.getEmail());
                pst.setString(2, user.getFullName());
                pst.setString(3, user.getPassword());
                pst.setString(4, user.getRoleID());
                pst.setBoolean(5, user.isStatus());
                result = pst.executeUpdate();
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (connect != null) {
                connect.close();
            }
        }
        return result;
    }
}
