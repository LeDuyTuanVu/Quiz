/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vuldt.daos.AnswerDAO;
import vuldt.daos.QuestionDAO;
import vuldt.daos.SubjectDAO;
import vuldt.dtos.AnswerDTO;
import vuldt.dtos.QuestionDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class UpdateQuestionController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            String questionID = "", questionContent = "", answer1 = "", answer2 = "", answer3 = "", answer4 = "", answerCorrectTemp = "", subjectName = "", questionStatusTemp = "", answerID = "";
            if (request.getParameter("txtQuestionID") != null) {
                questionID = (String) request.getParameter("txtQuestionID");
            }
            if (request.getParameter("txtQuestionContent") != null) {
                questionContent = (String) request.getParameter("txtQuestionContent");
            }
            if (request.getParameter("txtAnswer1") != null) {
                answer1 = (String) request.getParameter("txtAnswer1");
            }
            if (request.getParameter("txtAnswer2") != null) {
                answer2 = (String) request.getParameter("txtAnswer2");
            }
            if (request.getParameter("txtAnswer3") != null) {
                answer3 = (String) request.getParameter("txtAnswer3");
            }
            if (request.getParameter("txtAnswer4") != null) {
                answer4 = (String) request.getParameter("txtAnswer4");
            }
            if (request.getParameter("txtCheckBox") != null) {
                answerCorrectTemp = (String) request.getParameter("txtCheckBox");
            }
            if (request.getParameter("comboxSubject") != null) {
                subjectName = (String) request.getParameter("comboxSubject");
            }
            if (request.getParameter("comboxStatus") != null) {
                questionStatusTemp = (String) request.getParameter("comboxStatus");
            }
            if (request.getParameter("answerID") != null) {
                answerID = (String) request.getParameter("answerID");
            }

            boolean check = true;
            if (questionContent.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_UPDATE_QUESTION", "Question's content must not empty !");
            }
            if (answer1.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_UPDATE_ANSWER", "Answer's content must not empty !");
            }
            if (answer2.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_UPDATE_ANSWER", "Answer's content must not empty !");
            }
            if (answer3.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_UPDATE_ANSWER", "Answer's content must not empty !");
            }
            if (answer4.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_UPDATE_ANSWER", "Answer's content must not empty !");
            }

            if (check) {
                QuestionDAO daoQuestion = new QuestionDAO();
                AnswerDAO daoAnswer = new AnswerDAO();
                QuestionDTO question = daoQuestion.getQuestionByID(questionID);
                SubjectDAO daoSubject = new SubjectDAO();
                ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
                listAnswer = daoAnswer.getAnswerByID(questionID);
                String subjectID = daoSubject.getSubjectID(subjectName);
                boolean checkChange = true;
                if (!question.getQuestionContent().equals(questionContent)) {
                    checkChange = false;
                } else if (question.isStatus() != Boolean.parseBoolean(questionStatusTemp)) {
                    checkChange = false;
                } else if (!question.getSubjectID().equals(subjectID)) {
                    checkChange = false;
                }
                ArrayList<String> listTemp = new ArrayList<>();
                listTemp.add(answer1);
                listTemp.add(answer2);
                listTemp.add(answer3);
                listTemp.add(answer4);
                for (int i = 0; i < listAnswer.size(); i++) {
                    if (!listTemp.contains(listAnswer.get(i).getAnswerContent())) {
                        checkChange = false;
                    }
                    if (listAnswer.get(i).isAnswerCorrect()) {
                        if (!listAnswer.get(i).getAnswerID().equals(answerCorrectTemp)) {
                            checkChange = false;
                        }
                    }
                }
                if (checkChange) {
                    request.setAttribute("MESS_UPDATE", "Please change something to update !");
                } else {
                    if (daoQuestion.updateQuestion(questionID, questionContent, subjectID, questionStatusTemp) != 0) {
                        String arr[] = answerID.split("-");
                        if (arr.length == 4) {
                            if (answerCorrectTemp.equals(arr[3])) {
                                daoAnswer.updateAnswer(answer1, "true", arr[3]);
                            } else {
                                daoAnswer.updateAnswer(answer1, "false", arr[3]);
                            }
                            if (answerCorrectTemp.equals(arr[2])) {
                                daoAnswer.updateAnswer(answer2, "true", arr[2]);
                            } else {
                                daoAnswer.updateAnswer(answer2, "false", arr[2]);
                            }
                            if (answerCorrectTemp.equals(arr[1])) {
                                daoAnswer.updateAnswer(answer3, "true", arr[1]);
                            } else {
                                daoAnswer.updateAnswer(answer3, "false", arr[1]);
                            }
                            if (answerCorrectTemp.equals(arr[0])) {
                                daoAnswer.updateAnswer(answer4, "true", arr[0]);
                            } else {
                                daoAnswer.updateAnswer(answer4, "false", arr[0]);
                            }
                        }
                    }
                    QuestionDTO questionTemp = daoQuestion.getQuestionByID(questionID);
                    questionTemp.setSubjectID(subjectName);
                    ArrayList<AnswerDTO> listAnswerTemp = daoAnswer.getAnswerByID(questionID);
                    session.setAttribute("QUESTION_UPDATE", questionTemp);
                    session.setAttribute("LIST_ANSWER_UPDATE", listAnswerTemp);
                    request.setAttribute("MESS_UPDATE", "Update successfully !");

                    ArrayList<String> listAllSubject = new ArrayList();
                    listAllSubject = daoSubject.getAllSubject();
                    ArrayList<QuestionDTO> listAllQuestion = new ArrayList<>();
                    listAllQuestion = daoQuestion.getAllQuestion();
                    session.setAttribute("LIST_QUESTION", listAllQuestion);
                    session.setAttribute("LIST_SUBJECT", listAllSubject);
                }
            }

        } catch (Exception e) {
            log("Error in UpdateQuestionController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("updateQuestion.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
