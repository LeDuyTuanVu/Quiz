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
import vuldt.dtos.QuestionDTO;
import vuldt.utils.ConnectionDB;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class QuestionDAO {

    Connection connect = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    public int getNumQuestion() throws NamingException, SQLException, ClassNotFoundException {
        int result = -1;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(questionID) as num from tblQuestions";
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

    public int insertQuestion(QuestionDTO question) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "insert into tblQuestions(questionID, questionContent, createDate, subjectID, status) values(?, ?, ?, ?, ?)";
                pst = connect.prepareStatement(sql);
                pst.setString(1, question.getQuestionID());
                pst.setString(2, question.getQuestionContent());
                pst.setString(3, question.getCreateDate());
                pst.setString(4, question.getSubjectID());
                pst.setBoolean(5, question.isStatus());
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

    public int getNumAllQuestion() throws NamingException, SQLException, ClassNotFoundException {
        int num = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(questionID) as num from tblQuestions";
                pst = connect.prepareStatement(sql);
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

    public int deleteQuestion(String questionID) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "update tblQuestions set status = ? where questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setBoolean(1, false);
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

    public HashMap<String, ArrayList<AnswerDTO>> getAllQuestion(int index) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, ArrayList<AnswerDTO>> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select answerID, answerContent, answerCorrect, questionID, status from (select ROW_NUMBER() over (order by questionContent desc) as stt, answerID, answerContent, answerCorrect, A.questionID, A.status from tblQuestions Q, tblAnswers A where Q.questionID = A.questionID) as X where stt between ?*80-79 and ?*80";
                pst = connect.prepareStatement(sql);
                pst.setInt(1, index);
                pst.setInt(2, index);
                rs = pst.executeQuery();
                while (rs.next()) {
                    ArrayList<AnswerDTO> list = new ArrayList<>();
                    AnswerDTO answer = new AnswerDTO();
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    String questionID = rs.getString("questionID");
                    boolean status = rs.getBoolean("status");
                    if (hash.containsKey(questionID)) {
                        list = hash.get(questionID);
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
                    } else {
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
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

    public ArrayList<QuestionDTO> getAllQuestion() throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<QuestionDTO> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select questionID, questionContent, createDate, subjectID, status from tblQuestions";
                pst = connect.prepareStatement(sql);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String questionID = rs.getString("questionID");
                    String questionContent = rs.getString("questionContent");
                    String createDate = rs.getString("createDate");
                    String subjectID = rs.getString("subjectID");
                    boolean status = rs.getBoolean("status");
                    QuestionDTO question = new QuestionDTO(questionID, questionContent, createDate, subjectID, status);
                    list.add(question);
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

    public String getSubjectIDByName(String subjectName) throws NamingException, SQLException, ClassNotFoundException {
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

    public HashMap<String, ArrayList<AnswerDTO>> getQuestionBySubject(int index, String subjectName) throws NamingException, SQLException, ClassNotFoundException {
        String subjectID = "";
        subjectID = getSubjectIDByName(subjectName);
        HashMap<String, ArrayList<AnswerDTO>> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select answerID, answerContent, answerCorrect, questionID, status from (select ROW_NUMBER() over (order by questionContent desc) as stt, answerID, answerContent, answerCorrect, A.questionID, A.status from tblQuestions Q, tblAnswers A where Q.questionID = A.questionID and Q.subjectID = ?) as X where stt between ?*80-79 and ?*80";
                pst = connect.prepareStatement(sql);
                pst.setString(1, subjectID);
                pst.setInt(2, index);
                pst.setInt(3, index);
                rs = pst.executeQuery();
                while (rs.next()) {
                    ArrayList<AnswerDTO> list = new ArrayList<>();
                    AnswerDTO answer = new AnswerDTO();
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    String questionID = rs.getString("questionID");
                    boolean status = rs.getBoolean("status");
                    if (hash.containsKey(questionID)) {
                        list = hash.get(questionID);
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
                    } else {
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
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

    public int getNumQuestionBySubject(String subjectName) throws NamingException, SQLException, ClassNotFoundException {
        String subjectID = "";
        subjectID = getSubjectIDByName(subjectName);
        int num = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(questionID) as num from tblQuestions where subjectID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, subjectID);
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

    public HashMap<String, ArrayList<AnswerDTO>> getQuestionByName(String nameQuestion, String subjectName) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, ArrayList<AnswerDTO>> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select Q.questionID, A.answerID, A.answerContent, A.answerCorrect, A.status from tblQuestions Q, tblAnswers A, tblSubjects S where Q.questionID = A.questionID and Q.subjectID = S.subjectID and Q.questionContent like ? and S.subjectName = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, "%" + nameQuestion + "%");
                pst.setString(2, subjectName);
                rs = pst.executeQuery();
                while (rs.next()) {
                    ArrayList<AnswerDTO> list = new ArrayList<>();
                    AnswerDTO answer = new AnswerDTO();
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    String questionID = rs.getString("questionID");
                    boolean statusAnswer = rs.getBoolean("status");
                    if (hash.containsKey(questionID)) {
                        list = hash.get(questionID);
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, statusAnswer);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
                    } else {
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, statusAnswer);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
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

    public int getNumQuestionByName(String nameQuestion) throws NamingException, SQLException, ClassNotFoundException {
        int num = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(questionID) as num from tblQuestions where questionContent like ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, "%" + nameQuestion + "%");
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

    public HashMap<String, ArrayList<AnswerDTO>> getQuestionByStatus(String status, String subjectName) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, ArrayList<AnswerDTO>> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select Q.questionID, A.answerID, A.answerContent, A.answerCorrect, A.status from tblQuestions Q, tblAnswers A, tblSubjects S where Q.questionID = A.questionID and Q.subjectID = S.subjectID and Q.status = ? and S.subjectName = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, status);
                pst.setString(2, subjectName);
                rs = pst.executeQuery();
                while (rs.next()) {
                    ArrayList<AnswerDTO> list = new ArrayList<>();
                    AnswerDTO answer = new AnswerDTO();
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    String questionID = rs.getString("questionID");
                    boolean statusAnswer = rs.getBoolean("status");
                    if (hash.containsKey(questionID)) {
                        list = hash.get(questionID);
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, statusAnswer);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
                    } else {
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, statusAnswer);
                        list.add(answer);
                        hash.put(rs.getString("questionID"), list);
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

    public int getNumQuestionByStatus(String statusQuestion) throws NamingException, SQLException, ClassNotFoundException {
        int num = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select count(questionID) as num from tblQuestions where status = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, statusQuestion);
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

    public HashMap<String, ArrayList<AnswerDTO>> getQuestion(String questionID) throws NamingException, SQLException, ClassNotFoundException {
        HashMap<String, ArrayList<AnswerDTO>> hash = new HashMap<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select Q.questionContent, Q.subjectID, Q.status, A.answerContent, A.answerID, A.answerCorrect, A.status from tblQuestions Q, tblAnswers A where Q.questionID = A.questionID and A.questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, questionID);
                rs = pst.executeQuery();
                while (rs.next()) {
                    ArrayList<AnswerDTO> list = new ArrayList<>();
                    AnswerDTO answer = new AnswerDTO();
                    String answerID = rs.getString("answerID");
                    String answerContent = rs.getString("answerContent");
                    boolean answerCorrect = rs.getBoolean("answerCorrect");
                    boolean status = rs.getBoolean("A.status");
                    if (hash.containsKey(questionID + "-" + rs.getString("questionContent") + "-" + rs.getString("subjectID"))) {
                        list = hash.get(questionID);
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                        list.add(answer);
                        hash.put(questionID + "-" + rs.getString("questionContent") + "-" + rs.getString("subjectID"), list);
                    } else {
                        answer = new AnswerDTO(answerID, answerContent, answerCorrect, questionID, status);
                        list.add(answer);
                        hash.put(questionID + "-" + rs.getString("questionContent") + "-" + rs.getString("subjectID"), list);
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

//    public int updateQuestion(String questionContent, String answer1, String answer2, String answer3, String answer4, String correctAnswer) throws NamingException, SQLException, ClassNotFoundException {
//        int result = 0;
//        try {
//            connect = ConnectionDB.getConnection();
//            if (connect != null) {
//                String sql = "";
//                pst = connect.prepareStatement(sql);
//                pst.setString(1, "");
//                result = pst.executeUpdate();
//            }
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (pst != null) {
//                pst.close();
//            }
//            if (connect != null) {
//                connect.close();
//            }
//        }
//        return result;
//    }
    public QuestionDTO getQuestionByID(String questionID) throws NamingException, SQLException, ClassNotFoundException {
        QuestionDTO question = null;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select questionContent, createDate, subjectID, status from tblQuestions where questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, questionID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    String questionContent = rs.getString("questionContent");
                    String createDate = rs.getString("createDate");
                    String subjectID = rs.getString("subjectID");
                    boolean status = rs.getBoolean("status");
                    question = new QuestionDTO(questionID, questionContent, createDate, subjectID, status);
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
        return question;
    }

    public int updateQuestion(String questionID, String questionContent, String subjectID, String status) throws NamingException, SQLException, ClassNotFoundException {
        int result = 0;
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "update tblQuestions set questionContent = ?, subjectID = ?, status = ? where questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, questionContent);
                pst.setString(2, subjectID);
                pst.setString(3, status);
                pst.setString(4, questionID);
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

    public String getQuestionID(String questionID) throws NamingException, SQLException, ClassNotFoundException {
        String result = "";
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select questionID from tblQuestions where questionID = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, questionID);
                rs = pst.executeQuery();
                if (rs.next()) {
                    result = rs.getString("questionID");
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

    public ArrayList<String> getListQuiz(int numberQuestion) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<String> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select top " + numberQuestion + " questionID from tblQuestions order by newid()";
                pst = connect.prepareStatement(sql);
                rs = pst.executeQuery();
                while (rs.next()) {
                    list.add(rs.getString("questionID"));
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

    public ArrayList<String> getListQuestionIDByStatus(String status) throws NamingException, SQLException, ClassNotFoundException {
        ArrayList<String> list = new ArrayList<>();
        try {
            connect = ConnectionDB.getConnection();
            if (connect != null) {
                String sql = "select questionID from tblQuestions where status = ?";
                pst = connect.prepareStatement(sql);
                pst.setString(1, status);
                rs = pst.executeQuery();
                while (rs.next()) {
                    list.add(rs.getString("questionID"));
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
