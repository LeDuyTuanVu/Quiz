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
import vuldt.dtos.AnswerDTO;
import vuldt.utils.ConnectionDB;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class QuizDAO {

    Connection connect = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    public int getNumberQuiz() throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(quizID) as num from tblQuizs";
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

    public int insertQuiz(String quizID, String subjectID, String createQuiz) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "insert into tblQuizs(quizID, subjectID, createQuiz, status) values(?, ?, ?, ?)";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                pst.setString(2, subjectID);
                pst.setString(3, createQuiz);
                pst.setBoolean(4, true);
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

    public int insertQuizDetail(String quizID, String questionID) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "insert into tblQuizDetails(quizID, questionID, status) values(?, ?, ?)";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                pst.setString(2, questionID);
                pst.setBoolean(3, true);
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

    public ArrayList<String> getListQuestinQuiz(String quizID) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<String> listQuestionID = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                rs = pst.executeQuery();
                while (rs.next()) {
                    listQuestionID.add(rs.getString(""));
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
        return listQuestionID;
    }

    public int getNumberTakeQuiz() throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(takeQuizID) as num from tblTakeQuizs";
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

    public int insertTakeQuiz(String takeQuizID, String email, String quizID, float total, String makeQuizDate) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "insert into tblTakeQuizs(takeQuizID, quizID, email, total, makeQuizDate, status) values(?, ?, ?, ?, ?, ?)";
                pst = connect.prepareStatement(sql);
                pst.setString(1, takeQuizID);
                pst.setString(2, quizID);
                pst.setString(3, email);
                pst.setFloat(4, total);
                pst.setString(5, makeQuizDate);
                pst.setBoolean(6, false);
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

    public int submitQuiz(String quizID, String email) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "update tblTakeQuizs set status = ? where quizID = ? and email = ?";
                pst = connect.prepareStatement(sql);
                pst.setBoolean(1, true);
                pst.setString(2, quizID);
                pst.setString(3, email);
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

    public String getCorrectAnswerByQuestionID(String questionID) throws NamingException, SQLException, ClassNotFoundException {
        String answerID = "";
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select A.answerID from tblAnswers A, tblQuestions Q where A.questionID = Q.questionID and A.answerCorrect = ? and Q.questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, "true");
                pst.setString(2, questionID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    answerID = rs.getString("answerID");
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
        return answerID;
    }

    public int insertTakeQuizDetail(String takeQuizID, String quizID, String questionID) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        String ansRight = getCorrectAnswerByQuestionID(questionID);
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "insert into tblTakeQuizDetails(takeQuizID, quizID, questionID, ansFinal, ansRight, status) values(?, ?, ?, null, ?, ?)";
                pst = connect.prepareStatement(sql);
                pst.setString(1, takeQuizID);
                pst.setString(2, quizID);
                pst.setString(3, questionID);
                pst.setString(4, ansRight);
                pst.setBoolean(5, true);
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

    public HashMap<String, ArrayList<AnswerDTO>> getQuizByID(String quizID) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, ArrayList<AnswerDTO>> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select Q.questionID, A.answerID, A.answerContent, A.answerCorrect, A.status from tblAnswers A, tblQuestions Q, tblQuizDetails QD where A.questionID = Q.questionID and Q.questionID = QD.questionID and QD.quizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String questionID = rs.getString("questionID");
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    boolean status = rs.getBoolean("status");
                    AnswerDTO answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                    ArrayList<AnswerDTO> list = new ArrayList<>();
                    if (hash.containsKey(questionID)) {
                        list = hash.get(questionID);
                        list.add(answer);
                        hash.put(questionID, list);
                    } else {
                        list.add(answer);
                        hash.put(questionID, list);
                    }
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

    public HashMap<String, ArrayList<AnswerDTO>> getQuestionByID(String questionID) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, ArrayList<AnswerDTO>> hash = new HashMap<>();
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
                    ArrayList<AnswerDTO> list = new ArrayList<>();
                    if (hash.containsKey(questionID)) {
                        list = hash.get(questionID);
                        list.add(answer);
                        hash.put(questionID, list);
                    } else {
                        list.add(answer);
                        hash.put(questionID, list);
                    }
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

    public int getMinuteByQuizID(String quizID) throws NamingException, SQLException, ClassNotFoundException {
        int minute = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select S.minute\n"
                        + "from tblSubjects S, tblQuizs Q\n"
                        + "where S.subjectID = Q.subjectID and Q.quizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    minute = rs.getInt("minute");
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
        return minute;
    }

    public String getSubjectIDByQuizID(String quizID) throws NamingException, SQLException, ClassNotFoundException {
        String result = "";
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select subjectID from tblQuizs where quizID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, quizID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    result = rs.getString("subjectID");
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
