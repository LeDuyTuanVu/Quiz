/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vuldt.daos.AnswerDAO;
import vuldt.daos.QuizDAO;
import vuldt.daos.SubjectDAO;
import vuldt.daos.TakeQuizDetailDAO;
import vuldt.dtos.AnswerDTO;
import vuldt.dtos.TakeQuizDetailDTO;
import vuldt.dtos.UserDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class GetQuestionController extends HttpServlet {

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
            int questionNumber = 0, numberQuestion = 0;
            String temp = "", action = "";
            if (request.getParameter("btnAction") != null) {
                action = (String) request.getParameter("btnAction");
                if (action.equals("PREVIOUS")) {
                    
                    String subjectTempt = "", takeQuizIDTemp = "";
                    if (session.getAttribute("SUBJECT_IDD") != null) {
                        subjectTempt = (String) session.getAttribute("SUBJECT_IDD");
                    }
                    if (session.getAttribute("TAKE_QUIZ_IDD") != null) {
                        takeQuizIDTemp = (String) session.getAttribute("TAKE_QUIZ_IDD");
                    }
                    int timeQuiz = new SubjectDAO().getMinute(subjectTempt);
                    TakeQuizDetailDAO daoTakeQuiz = new TakeQuizDetailDAO();
                    String makeQuizTime = daoTakeQuiz.getMakeQuizDate(takeQuizIDTemp);
                    SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date parsedDate = d.parse(makeQuizTime);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(parsedDate);
                    cal.add(Calendar.MINUTE, timeQuiz);
                    String newTime = d.format(cal.getTime());
                    Date ne = d.parse(newTime);
                    Date nowTemp = new Date();
                    long diff = ne.getTime() - nowTemp.getTime();
                    long diffSeconds = (diff / 1000 % 60) + 1;
                    long diffMinutes = diff / (60 * 1000) % 60;
                    long diffHours = diff / (60 * 60 * 1000);
                    session.setAttribute("HOUR_DO", diffHours);
                    session.setAttribute("MINUTES_DO", diffMinutes);
                    session.setAttribute("SECONDS_DO", diffSeconds);
                    
                    if (request.getParameter("txtQuestionNumber") != null) {
                        temp = (String) request.getParameter("txtQuestionNumber");
                        questionNumber = Integer.parseInt(temp);
                    }
                    if (request.getParameter("txtNumberQuestion") != null) {
                        temp = (String) request.getParameter("txtNumberQuestion");
                        numberQuestion = Integer.parseInt(temp);
                    }
                    if (questionNumber == 1) {

                    } else {
                        questionNumber--;
                        String questionID = "";
                        if (request.getParameter("txtQuestionDo") != null) {
                            questionID = (String) request.getParameter("txtQuestionDo");
                            String answerChoose = "";
                            if (request.getParameter("txtChecBox") != null) {
                                answerChoose = (String) request.getParameter("txtChecBox");
                            }
                            if (!answerChoose.isEmpty()) {
                                daoTakeQuiz.updateAnswer(answerChoose, questionID);
                            }

                            String quizID = "";
                            if (session.getAttribute("QUIZ_ID") != null) {
                                quizID = (String) session.getAttribute("QUIZ_ID");
                            }

                            ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
                            list = daoTakeQuiz.getListQuizDetail(quizID);
                            for (int i = 0; i < list.size(); i++) {
                                int x = i + 1;
                                if (questionNumber == x) {
                                    AnswerDAO daoAnswer = new AnswerDAO();
                                    TakeQuizDetailDTO takeQuiz = new TakeQuizDetailDTO();
                                    takeQuiz = list.get(i);
                                    ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
                                    listAnswer = daoAnswer.getAnswerByID(list.get(i).getQuestionID());
                                    session.setAttribute("TAKE_QUIZ_DETAIL", takeQuiz);
                                    session.setAttribute("QUESTION_NUMBER", questionNumber);
                                    session.setAttribute("LIST_ANSWER_QUIZ", listAnswer);
                                }
                            }
                        }
                    }
                } else if (action.equals("NEXT")) {
                    
                    String subjectTempt = "", takeQuizIDTemp = "";
                    if (session.getAttribute("SUBJECT_IDD") != null) {
                        subjectTempt = (String) session.getAttribute("SUBJECT_IDD");
                    }
                    if (session.getAttribute("TAKE_QUIZ_IDD") != null) {
                        takeQuizIDTemp = (String) session.getAttribute("TAKE_QUIZ_IDD");
                    }
                    int timeQuiz = new SubjectDAO().getMinute(subjectTempt);
                    TakeQuizDetailDAO daoTakeQuiz = new TakeQuizDetailDAO();
                    String makeQuizTime = daoTakeQuiz.getMakeQuizDate(takeQuizIDTemp);
                    SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date parsedDate = d.parse(makeQuizTime);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(parsedDate);
                    cal.add(Calendar.MINUTE, timeQuiz);
                    String newTime = d.format(cal.getTime());
                    Date ne = d.parse(newTime);
                    Date nowTemp = new Date();
                    long diff = ne.getTime() - nowTemp.getTime();
                    long diffSeconds = (diff / 1000 % 60) + 1;
                    long diffMinutes = diff / (60 * 1000) % 60;
                    long diffHours = diff / (60 * 60 * 1000);
                    session.setAttribute("HOUR_DO", diffHours);
                    session.setAttribute("MINUTES_DO", diffMinutes);
                    session.setAttribute("SECONDS_DO", diffSeconds);
                    
                    if (request.getParameter("txtQuestionNumber") != null) {
                        temp = (String) request.getParameter("txtQuestionNumber");
                        questionNumber = Integer.parseInt(temp);
                    }
                    if (request.getParameter("txtNumberQuestion") != null) {
                        temp = (String) request.getParameter("txtNumberQuestion");
                        numberQuestion = Integer.parseInt(temp);
                    }
                    if (questionNumber > numberQuestion) {

                    } else {
                        questionNumber++;
                        String questionID = "";
                        if (request.getParameter("txtQuestionDo") != null) {
                            questionID = (String) request.getParameter("txtQuestionDo");
                            String answerChoose = "";
                            if (request.getParameter("txtChecBox") != null) {
                                answerChoose = (String) request.getParameter("txtChecBox");
                            }
                            if (!answerChoose.isEmpty()) {
                                daoTakeQuiz.updateAnswer(answerChoose, questionID);
                            }

                            String quizID = "";
                            if (session.getAttribute("QUIZ_ID") != null) {
                                quizID = (String) session.getAttribute("QUIZ_ID");
                            }

                            ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
                            list = daoTakeQuiz.getListQuizDetail(quizID);
                            for (int i = 0; i < list.size(); i++) {
                                int x = i + 1;
                                if (questionNumber == x) {
                                    AnswerDAO daoAnswer = new AnswerDAO();
                                    TakeQuizDetailDTO takeQuiz = new TakeQuizDetailDTO();
                                    takeQuiz = list.get(i);
                                    ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
                                    listAnswer = daoAnswer.getAnswerByID(list.get(i).getQuestionID());
                                    session.setAttribute("TAKE_QUIZ_DETAIL", takeQuiz);
                                    session.setAttribute("QUESTION_NUMBER", questionNumber);
                                    session.setAttribute("LIST_ANSWER_QUIZ", listAnswer);
                                }
                            }
                        }
                    }
                } else if (action.equals("SUBMIT")) {
                    String quizID = "";
                    if (session.getAttribute("QUIZ_ID") != null) {
                        quizID = (String) session.getAttribute("QUIZ_ID");
                    }
                    QuizDAO daoQuiz = new QuizDAO();
                    UserDTO user = new UserDTO();
                    if (session.getAttribute("USER") != null) {
                        user = (UserDTO) session.getAttribute("USER");
                    }
                    daoQuiz.submitQuiz(quizID, user.getEmail());
                    String questionID = "";
                    if (request.getParameter("txtQuestionDo") != null) {
                        questionID = (String) request.getParameter("txtQuestionDo");
                        String answerChoose = "";
                        if (request.getParameter("txtChecBox") != null) {
                            answerChoose = (String) request.getParameter("txtChecBox");
                        }
                        TakeQuizDetailDAO daoTakeQuiz = new TakeQuizDetailDAO();
                        if (!answerChoose.isEmpty()) {
                            daoTakeQuiz.updateAnswer(answerChoose, questionID);
                        }
                    }

                    ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
                    TakeQuizDetailDAO daoTakeQuizDetail = new TakeQuizDetailDAO();
                    list = daoTakeQuizDetail.getListQuizDetail(quizID);
                    float point = 0, pointOneAnswer = 0;
                    int count = 0, numberQuestionTemp = 0;
                    numberQuestionTemp = list.size();
                    pointOneAnswer = ((float) 10) / numberQuestionTemp;
                    for (TakeQuizDetailDTO quiz : list) {
                        if (quiz.getAnsFinal() == null) {

                        } else {
                            if (quiz.getAnsFinal().equals(quiz.getAnsRight())) {
                                count++;
                                point += pointOneAnswer;
                            }
                        }
                    }
                    daoTakeQuizDetail.updateTotal(point, quizID);
                    session.setAttribute("QUIZ_ID", "");
                    session.setAttribute("LIST_ANSWER_QUIZ", "");
                    session.setAttribute("QUESTION_NUMBER", "");
                    session.setAttribute("QUESTION_NUMBER", "");
                    request.setAttribute("TOTAL", point);
                    request.setAttribute("NUM_CORRECT", count);
                    session.setAttribute("LIST_DO_QUIZ", "");
                    session.setAttribute("TAKE_QUIZ_DETAIL", "");
                    session.setAttribute("SUBJECT_NAME_CHOOSE", "");
                    ///////////////////////////////////////
                    session.setAttribute("SUBJECT_NAMEE", "");
                    ///////////////////////////////////////
                } else {
                    String subjectTempt = "", takeQuizIDTemp = "";
                    if (session.getAttribute("SUBJECT_IDD") != null) {
                        subjectTempt = (String) session.getAttribute("SUBJECT_IDD");
                    }
                    if (session.getAttribute("TAKE_QUIZ_IDD") != null) {
                        takeQuizIDTemp = (String) session.getAttribute("TAKE_QUIZ_IDD");
                    }
                    int timeQuiz = new SubjectDAO().getMinute(subjectTempt);
                    TakeQuizDetailDAO daoTakeQuiz = new TakeQuizDetailDAO();
                    String makeQuizTime = daoTakeQuiz.getMakeQuizDate(takeQuizIDTemp);
                    SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date parsedDate = d.parse(makeQuizTime);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(parsedDate);
                    cal.add(Calendar.MINUTE, timeQuiz);
                    String newTime = d.format(cal.getTime());
                    Date ne = d.parse(newTime);
                    Date nowTemp = new Date();
                    long diff = ne.getTime() - nowTemp.getTime();
                    long diffSeconds = (diff / 1000 % 60) + 1;
                    long diffMinutes = diff / (60 * 1000) % 60;
                    long diffHours = diff / (60 * 60 * 1000);
                    session.setAttribute("HOUR_DO", diffHours);
                    session.setAttribute("MINUTES_DO", diffMinutes);
                    session.setAttribute("SECONDS_DO", diffSeconds);

                    String questionID = "";
                    if (request.getParameter("txtQuestionDo") != null) {
                        questionID = (String) request.getParameter("txtQuestionDo");
                        String answerChoose = "";
                        if (request.getParameter("txtChecBox") != null) {
                            answerChoose = (String) request.getParameter("txtChecBox");
                        }
                        if (!answerChoose.isEmpty()) {
                            daoTakeQuiz.updateAnswer(answerChoose, questionID);
                        }

                        String quizID = "";
                        int numberChoose = 0;
                        numberChoose = Integer.parseInt(action);
                        if (session.getAttribute("QUIZ_ID") != null) {
                            quizID = (String) session.getAttribute("QUIZ_ID");
                        }

                        ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
                        list = daoTakeQuiz.getListQuizDetail(quizID);
                        for (int i = 0; i < list.size(); i++) {
                            int x = i + 1;
                            if (numberChoose == x) {
                                AnswerDAO daoAnswer = new AnswerDAO();
                                TakeQuizDetailDTO takeQuiz = new TakeQuizDetailDTO();
                                takeQuiz = list.get(i);
                                ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
                                listAnswer = daoAnswer.getAnswerByID(list.get(i).getQuestionID());
                                session.setAttribute("TAKE_QUIZ_DETAIL", takeQuiz);
                                session.setAttribute("QUESTION_NUMBER", numberChoose);
                                session.setAttribute("LIST_ANSWER_QUIZ", listAnswer);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            log("Error in GetQuestionController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("home.jsp").forward(request, response);
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
