/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
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
public class CreateQuestionController extends HttpServlet {

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
            String question = "", answer1 = "", answer2 = "", answer3 = "", answer4 = "", correctAnswer = "", subjectName = "";
            if (request.getParameter("txtQuestion") != null) {
                question = (String) request.getParameter("txtQuestion");
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
            if (request.getParameter("comboxSubject") != null) {
                subjectName = (String) request.getParameter("comboxSubject");
            }

            String arr[] = (String[]) request.getParameterValues("checkBox");
            if (arr == null) {
                arr = new String[5];
            }

            boolean check = true;
            if (arr.length != 1) {
                check = false;
                request.setAttribute("MESS_CHECK_BOX", "Please check one correct answer !");
            }
            if (question.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_QUESTION", "Question must not empty !");
            }
            if (answer1.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_ANSWER1", "Answer must not empty !");
            }
            if (answer2.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_ANSWER2", "Answer must not empty !");
            }
            if (answer3.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_ANSWER3", "Answer must not empty !");
            }
            if (answer4.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_ANSWER4", "Answer must not empty !");
            }

            if (subjectName.equals("empty")) {
                check = false;
                request.setAttribute("MESS_SUBJECT", "Please enter subject for this question !");
            } else if (subjectName.equals("null")) {
                check = false;
                request.setAttribute("MESS_SUBJECT", "Sorry, we don't have any subject in system !");
            }

            if (arr[0] != null) {
                correctAnswer = arr[0];
            } else {
                correctAnswer = "";
            }

            boolean success = true;
            if (check) {
                QuestionDAO daoQuestion = new QuestionDAO();
                AnswerDAO daoAnswer = new AnswerDAO();
                QuestionDTO questionDTO = new QuestionDTO();
                AnswerDTO answerDTO = new AnswerDTO();
                SubjectDAO daoSubject = new SubjectDAO();
                int tempQuestionID = 0;
                if (daoQuestion.getNumQuestion() != -1) {
                    tempQuestionID = daoQuestion.getNumQuestion() + 1;
                }
                String newQuestionID = "question" + tempQuestionID;
                Calendar calender = Calendar.getInstance();
                int year = calender.get(Calendar.YEAR);
                int month = calender.get(Calendar.MONTH) + 1;
                int day = calender.get(Calendar.DAY_OF_MONTH);
                String createDate = year + "-" + month + "-" + day;
                String subjectID = daoSubject.getSubjectID(subjectName);
                questionDTO = new QuestionDTO(newQuestionID, question, createDate, subjectID, true);
                if (daoQuestion.insertQuestion(questionDTO) != 0) {
                    ArrayList<String> listAnswer = new ArrayList();
                    listAnswer.add(answer1);
                    listAnswer.add(answer2);
                    listAnswer.add(answer3);
                    listAnswer.add(answer4);
                    for (int i = 0; i < listAnswer.size(); i++) {
                        int temp = Integer.parseInt(correctAnswer);
                        int answerID = daoAnswer.getNumAnswer() + 1;
                        if (temp == (i + 1)) {
                            answerDTO = new AnswerDTO("answer" + answerID, listAnswer.get(i), true, newQuestionID, true);
                        } else {
                            answerDTO = new AnswerDTO("answer" + answerID, listAnswer.get(i), false, newQuestionID, true);
                        }
                        daoAnswer.insertAnswer(answerDTO);
                    }
                    request.setAttribute("MESS_CREATE_QUESTION", "Create question successfully !");
                    ArrayList<String> listAllSubject = new ArrayList();
                    listAllSubject = daoSubject.getAllSubject();
                    ArrayList<QuestionDTO> listAllQuestion = new ArrayList<>();
                    listAllQuestion = daoQuestion.getAllQuestion();
                    session.setAttribute("LIST_QUESTION", listAllQuestion);
                    session.setAttribute("LIST_SUBJECT", listAllSubject);
                } else {
                    success = false;
                    request.setAttribute("MESS_CREATE_QUESTION", "Create question unsuccessfully !");
                }
            } else {
                success = false;
            }
            if (success) {
                session.setAttribute("QUESTION", "");
                session.setAttribute("ANSWER1", "");
                session.setAttribute("ANSWER2", "");
                session.setAttribute("ANWERS3", "");
                session.setAttribute("ANSWER4", "");
                session.setAttribute("SUBJECT", "");
                session.setAttribute("CHECK_BOX", "");
            } else {
                session.setAttribute("QUESTION", question);
                session.setAttribute("ANSWER1", answer1);
                session.setAttribute("ANSWER2", answer2);
                session.setAttribute("ANWERS3", answer3);
                session.setAttribute("ANSWER4", answer4);
                session.setAttribute("SUBJECT", subjectName);
                session.setAttribute("CHECK_BOX", correctAnswer);
            }
        } catch (Exception e) {
            log("Error in CreateQuestionController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("createQuestion.jsp").forward(request, response);
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
