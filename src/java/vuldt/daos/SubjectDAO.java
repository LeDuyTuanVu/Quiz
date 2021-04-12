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
import java.util.ArrayList;
import java.util.HashMap;
import javax.naming.NamingException;
import vuldt.utils.ConnectionDB;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class SubjectDAO {

    Connection connect = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    public ArrayList<String> getAllSubject() throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<String> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select subjectName from tblSubjects where status = ?";
                pst = connect.prepareStatement(sql);
                pst.setBoolean(1, true);
                rs = pst.executeQuery();
                while (rs.next()) {
                    list.add(rs.getString("subjectName"));
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
        return list;
    }

    public String getSubjectID(String subjectName) throws NamingException, SQLException, ClassNotFoundException {
        String subjectID = "";
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select subjectID from tblSubjects where subjectName = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, subjectName);
                rs = pst.executeQuery();
                if (rs.next()) {
                    subjectID = rs.getString("subjectID");
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
        return subjectID;
    }

    public String getSubjectName(String subjectID) throws NamingException, SQLException, ClassNotFoundException {
        String subjectName = "";
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select subjectName from tblSubjects where subjectID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, subjectID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    subjectName = rs.getString("subjectName");
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
        return subjectName;
    }

    public int getNumQuestion(String subjectID) throws NamingException, SQLException, ClassNotFoundException {
        int num = -1;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select numberQuestion from tblSubjects where subjectID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, subjectID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    num = rs.getInt("numberQuestion");
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
        return num;
    }

    public int getMinute(String subjectID) throws NamingException, SQLException, ClassNotFoundException {
        int num = -1;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select minute from tblSubjects where subjectID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, subjectID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    num = rs.getInt("minute");
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
        return num;
    }

    public HashMap<String, Integer> getListSubjectByStatus(String status) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, Integer> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select S.subjectName, count(S.subjectID) as num from tblSubjects S, tblQuestions Q where S.subjectID = Q.subjectID and Q.status = ? group by S.subjectName";
                pst = connect.prepareStatement(sql);
                pst.setString(1, status);
                rs = pst.executeQuery();
                while (rs.next()) {
                    hash.put(rs.getString("subjectName"), rs.getInt("num"));
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
        return hash;
    }

    public HashMap<String, Integer> getListSubjectByName(String subjectName) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, Integer> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select S.subjectName, count(S.subjectID) as num from tblSubjects S, tblQuestions Q where S.subjectID = Q.subjectID and Q.questionContent like ? group by S.subjectName";
                pst = connect.prepareStatement(sql);
                pst.setString(1, "%" + subjectName + "%");
                rs = pst.executeQuery();
                while (rs.next()) {
                    hash.put(rs.getString("subjectName"), rs.getInt("num"));
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
        return hash;
    }
}
