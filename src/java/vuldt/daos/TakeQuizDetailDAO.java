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
import javax.naming.NamingException;
import vuldt.dtos.HistoryDTO;
import vuldt.dtos.TakeQuizDetailDTO;
import vuldt.utils.ConnectionDB;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class TakeQuizDetailDAO {

    Connection connect = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    public ArrayList<TakeQuizDetailDTO> getListQuizDetail(String quizID) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select takeQuizID, quizID, questionID, ansFinal, ansRight, status from tblTakeQuizDetails where quizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String takeQuizID = rs.getString("takeQuizID");
                    String questionID = rs.getString("questionID");
                    String ansFinal = rs.getString("ansFinal");
                    String ansRight = rs.getString("ansRight");
                    boolean status = rs.getBoolean("status");
                    TakeQuizDetailDTO temp = new TakeQuizDetailDTO(takeQuizID, quizID, questionID, ansFinal, ansRight, status);
                    list.add(temp);
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

    public int updateAnswer(String answerID, String questionID) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "update tblTakeQuizDetails set ansFinal = ? where questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, answerID);
                pst.setString(2, questionID);
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

    public int updateTotal(float total, String quizID) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "update tblTakeQuizs set total = ? where quizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setFloat(1, total);
                pst.setString(2, quizID);
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

    public ArrayList<TakeQuizDetailDTO> getListQuizDetailHistory(String email, String subjectName, String quizID, int index) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select takeQuizID, quizID, questionID, ansFinal, ansRight, status from (select ROW_NUMBER() over (order by TQD.quizID desc) as stt, TQD.takeQuizID, TQD.quizID, TQD.questionID, TQD.ansFinal, TQD.ansRight, TQD.status\n"
                        + "from tblTakeQuizDetails TQD, tblQuizs Q, tblSubjects S, tblTakeQuizs TQ\n"
                        + "where TQD.quizID = Q.quizID and Q.subjectID = S.subjectID and TQ.quizID = Q.quizID and S.subjectID = ? and TQ.email = ? and TQD.quizID = ?) as X where stt between ?*10-9 and ?*10";
                pst = connect.prepareStatement(sql);
                pst.setString(1, subjectName);
                pst.setString(2, email);
                pst.setString(3, quizID);
                pst.setInt(4, index);
                pst.setInt(5, index);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String takeQuizID = rs.getString("takeQuizID");
                    String questionID = rs.getString("questionID");
                    String ansFinal = rs.getString("ansFinal");
                    String ansRight = rs.getString("ansRight");
                    boolean status = rs.getBoolean("status");
                    TakeQuizDetailDTO temp = new TakeQuizDetailDTO(takeQuizID, quizID, questionID, ansFinal, ansRight, status);
                    list.add(temp);
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

    public int getNumTakeQuizHistory(String email, String subjectID, String quizID) throws NamingException, SQLException, ClassNotFoundException {
        int num = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select COUNT(TQD.questionID) as num\n"
                        + "	from tblTakeQuizDetails TQD, tblTakeQuizs TQ, tblQuizs Q\n"
                        + "	where TQD.takeQuizID = TQ.takeQuizID and TQ.quizID = Q.quizID and TQ.email = ? and \n"
                        + "	Q.subjectID = ? and TQD.quizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, subjectID);
                pst.setString(3, quizID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    num = rs.getInt("num");
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

    public ArrayList<HistoryDTO> getListTakeQuizHistory(String email, String subjectID, int index) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<HistoryDTO> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select takeQuizID, makeQuizDate, quizID, total, status from (select ROW_NUMBER() over (order by TQ.takeQuizID desc) as stt, TQ.takeQuizID, \n"
                        + "TQ.makeQuizDate, TQ.quizID, TQ.total, TQ.status from tblTakeQuizs TQ, tblQuizs Q\n"
                        + "where TQ.quizID = Q.quizID and email = ? and Q.subjectID = ? and TQ.status = ?) as X where stt between ?*10-9 and ?*10";
                pst = connect.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, subjectID);
                pst.setBoolean(3, true);
                pst.setInt(4, index);
                pst.setInt(5, index);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String takeQuizID = rs.getString("takeQuizID");
                    String quizID = rs.getString("quizID");
                    float total = rs.getFloat("total");
                    String makeQuizDate = rs.getString("makeQuizDate");
                    boolean status = rs.getBoolean("status");
                    HistoryDTO history = new HistoryDTO(takeQuizID, quizID, email, total, makeQuizDate, status);
                    list.add(history);
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
    
    public ArrayList<HistoryDTO> getListTakeQuizNotReady(String email, int index) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<HistoryDTO> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select takeQuizID, makeQuizDate, quizID, total, status from (select ROW_NUMBER() over (order by TQ.takeQuizID desc) as stt, TQ.takeQuizID, \n"
                        + "TQ.makeQuizDate, TQ.quizID, TQ.total, TQ.status from tblTakeQuizs TQ, tblQuizs Q\n"
                        + "where TQ.quizID = Q.quizID and email = ? and TQ.status = ?) as X where stt between ?*10-9 and ?*10";
                pst = connect.prepareStatement(sql);
                pst.setString(1, email);
                pst.setBoolean(2, false);
                pst.setInt(3, index);
                pst.setInt(4, index);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String takeQuizID = rs.getString("takeQuizID");
                    String quizID = rs.getString("quizID");
                    float total = rs.getFloat("total");
                    String makeQuizDate = rs.getString("makeQuizDate");
                    boolean status = rs.getBoolean("status");
                    HistoryDTO history = new HistoryDTO(takeQuizID, quizID, email, total, makeQuizDate, status);
                    list.add(history);
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

    public int getNumTakeQuiz(String email, String subjectID) throws NamingException, SQLException, ClassNotFoundException {
        int num = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(TQ.takeQuizID) as num\n"
                        + "from tblTakeQuizs TQ, tblQuizs Q \n"
                        + "where TQ.quizID = Q.quizID and email = ? and Q.subjectID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, subjectID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    num = rs.getInt("num");
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

    public HistoryDTO getQuizNotSubmit(String email) throws NamingException, SQLException, ClassNotFoundException {
        HistoryDTO temp = null;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select takeQuizID, quizID, email, total, makeQuizDate, status\n"
                        + "from tblTakeQuizs\n"
                        + "where email = ? and status = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, "false");
                rs = pst.executeQuery();
                while (rs.next()) {
                    String takeQuizID = rs.getString("takeQuizID");
                    String quizID = rs.getString("quizID");
                    float total = rs.getFloat("total");
                    String makeQuizDate = rs.getString("makeQuizDate");
                    boolean status = rs.getBoolean("status");
                    temp = new HistoryDTO(takeQuizID, quizID, email, total, makeQuizDate, status);
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
        return temp;
    }

    public String getMakeQuizDate(String takeQuizID) throws NamingException, SQLException, ClassNotFoundException {
        String result = "";
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select makeQuizDate from tblTakeQuizs where takeQuizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, takeQuizID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    result = rs.getString("makeQuizDate");
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
        return result;
    }
}
