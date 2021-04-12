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
import vuldt.dtos.AnswerDTO;
import vuldt.utils.ConnectionDB;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class AnswerDAO {

    Connection connect = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    public int getNumAnswer() throws NamingException, SQLException, ClassNotFoundException {
        int result = -1;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(answerID) as num from tblAnswers";
                pst = connect.prepareStatement(sql);
                rs = pst.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("num");
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

    public int insertAnswer(AnswerDTO answer) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "insert into tblAnswers(answerID, answerContent, answerCorrect, questionID, status) values(?, ?, ?, ?, ?)";
                pst = connect.prepareStatement(sql);
                pst.setString(1, answer.getAnswerID());
                pst.setString(2, answer.getAnswerContent());
                pst.setBoolean(3, answer.isAnswerCorrect());
                pst.setString(4, answer.getQuestionID());
                pst.setBoolean(5, answer.isStatus());
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

    public ArrayList<AnswerDTO> getAnswerByID(String questionID) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<AnswerDTO> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select answerID, answerContent, answerCorrect, status from tblAnswers where questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, questionID);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    boolean status = rs.getBoolean("status");
                    AnswerDTO answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                    list.add(answer);
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

    public int updateAnswer(String answerContent, String answerCorrect, String answerID) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "update tblAnswers set answerContent = ?, answerCorrect = ? where answerID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, answerContent);
                pst.setString(2, answerCorrect);
                pst.setString(3, answerID);
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

    public ArrayList<AnswerDTO> getAnswerByQuizID(String quizID) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<AnswerDTO> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select A.answerID, A.answerContent, A.answerCorrect, A.questionID, A.status from tblAnswers A, tblQuestions Q, tblQuizDetails QD where A.questionID = Q.questionID and Q.questionID = QD.questionID and QD.quizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    boolean status = rs.getBoolean("status");
                    String questionID = rs.getString("questionID");
                    AnswerDTO answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                    list.add(answer);
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
}
