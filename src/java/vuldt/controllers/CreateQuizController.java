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
import vuldt.daos.QuestionDAO;
import vuldt.daos.QuizDAO;
import vuldt.daos.SubjectDAO;
import vuldt.daos.TakeQuizDetailDAO;
import vuldt.dtos.AnswerDTO;
import vuldt.dtos.HistoryDTO;
import vuldt.dtos.TakeQuizDetailDTO;
import vuldt.dtos.UserDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class CreateQuizController extends HttpServlet {

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
            TakeQuizDetailDAO daoTakeQuiz = new TakeQuizDetailDAO();
            UserDTO user = new UserDTO();
            if (session.getAttribute("USER") != null) {
                user = (UserDTO) session.getAttribute("USER");
            }
            String subjectName = "";
            if (request.getParameter("comboxSubject") != null) {
                subjectName = (String) request.getParameter("comboxSubject");
            }

            ArrayList<HistoryDTO> listNotReady = daoTakeQuiz.getListTakeQuizNotReady(user.getEmail(), 1);

            if (listNotReady.size() != 0) {
                String subjectTempt = "", takeQuizIDTemp = "";
                if(session.getAttribute("SUBJECT_IDD")!=null){
                    subjectTempt = (String)session.getAttribute("SUBJECT_IDD");
                }
                if(session.getAttribute("TAKE_QUIZ_IDD")!=null){
                    takeQuizIDTemp = (String)session.getAttribute("TAKE_QUIZ_IDD");
                }
                
                request.setAttribute("MESS_ERROR", "Sorry, you are doing quiz ! We not allow create a " + subjectName + " quiz !");
                int timeQuiz = new SubjectDAO().getMinute(subjectTempt);
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
            } else {

                boolean check = true;
                if (subjectName.isEmpty()) {
                    check = false;
                    request.setAttribute("MESS_SEARCH_QUIZ", "Please choose subject you want to do quiz !");
                } else if (subjectName.equals("empty")) {
                    check = false;
                    request.setAttribute("MESS_SEARCH_QUIZ", "Please choose subject you want to do quiz !");
                } else if (subjectName.equals("null")) {
                    check = false;
                    request.setAttribute("MESS_SEARCH_QUIZ", "Sorry, we don't have any subject to do quiz !");
                }

                if (check) {
                    int minute = 0, numberQuestion = 0;
                    QuizDAO daoQuiz = new QuizDAO();
                    SubjectDAO daoSubject = new SubjectDAO();
                    String subjectID = daoSubject.getSubjectID(subjectName);
                    QuestionDAO daoQuestion = new QuestionDAO();

                    int numberQuestionBySubject = 0;
                    numberQuestionBySubject = daoQuestion.getNumQuestionBySubject(subjectName);

                    numberQuestion = daoSubject.getNumQuestion(subjectID);
                    if (numberQuestionBySubject < numberQuestion) {
                        request.setAttribute("MESS_CREATE_QUIZ", "Sorry, we don't have enough question to do !");
                    } else {
                        minute = daoSubject.getMinute(subjectID);
                        ArrayList<String> listQuestionID = daoQuestion.getListQuiz(numberQuestion);
                        if (!listQuestionID.isEmpty()) {
                            if (listQuestionID.size() == numberQuestion) {
                                int tempQuizID = daoQuiz.getNumberQuiz() + 1;
                                String quizID = "quiz" + tempQuizID;

                                Calendar calendar = Calendar.getInstance();
                                int year = calendar.get(Calendar.YEAR);
                                int month = calendar.get(Calendar.MONTH) + 1;
                                int day = calendar.get(Calendar.DAY_OF_MONTH);
                                String createQuiz = year + "-" + month + "-" + day;
                                int tempTakeQuizID = daoQuiz.getNumberTakeQuiz() + 1;
                                String takeQuizID = "takeQuiz" + tempTakeQuizID;
                                String email = "";
                                float total = 0;
                                Calendar now = Calendar.getInstance();
                                int hourTemp = now.get(Calendar.HOUR_OF_DAY);
                                int minTemp = now.get(Calendar.MINUTE);
                                int secTemp = now.get(Calendar.SECOND);
                                String timeTemp = hourTemp + ":" + minTemp + ":" + secTemp;

                                if (daoQuiz.insertQuiz(quizID, subjectID, createQuiz + " " + timeTemp) != 0) {
                                    if (session.getAttribute("USER") != null) {
                                        user = (UserDTO) session.getAttribute("USER");
                                        email = user.getEmail();
                                        if (daoQuiz.insertTakeQuiz(takeQuizID, email, quizID, total, createQuiz + " " + timeTemp) != 0) {
                                            for (String ID : listQuestionID) {
                                                daoQuiz.insertQuizDetail(quizID, ID);
                                                daoQuiz.insertTakeQuizDetail(takeQuizID, quizID, ID);
                                            }
                                        }
                                    }
                                }

                                int timeQuiz = new SubjectDAO().getMinute(subjectID);
                                String makeQuizTime = daoTakeQuiz.getMakeQuizDate(takeQuizID);
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
                                
                                session.setAttribute("SUBJECT_IDD", subjectID);
                                session.setAttribute("TAKE_QUIZ_IDD", takeQuizID);
                                
                                session.setAttribute("SUBJECT_NAMEE", subjectName);

//                                String makeQuizTime = daoTakeQuiz.getMakeQuizDate(takeQuizID);
//                                String arr[] = makeQuizTime.split(" ");
//                                String time = "";
//                                if (arr.length == 2) {
//                                    time = arr[1];
//                                }
//                                int h = 0, m = 0, s = 0;
//                                String arr1[] = time.split(":");
//                                if (arr1.length == 3) {
//                                    h = Integer.parseInt(arr1[0]);
//                                    m = Integer.parseInt(arr1[1]);
//                                    s = Integer.parseInt(arr1[2]);
//                                }
//
//                                int hour = now.get(Calendar.HOUR_OF_DAY);
//                                int min = now.get(Calendar.MINUTE);
//                                int sec = now.get(Calendar.SECOND);
//
//                                int temp1 = (h * 60 + m + minute) * 60 + s;
//                                int temp2 = (hour * 60 + min) * 60 + sec;
//
//                                int minDoQuiz = temp1 - temp2;
//                                minute = minDoQuiz / 60;
//                                sec = minDoQuiz % 60;
//                                request.setAttribute("M", minute);
//                                request.setAttribute("S", sec);
                                session.setAttribute("TIME_DO_QUIZ", createQuiz + " " + timeTemp);
                                session.setAttribute("MINUTE_DO_QUIZ", minute);
                                session.setAttribute("QUIZ_ID", quizID);
                                AnswerDAO daoAnswer = new AnswerDAO();
                                TakeQuizDetailDAO daoTakeQuizDetail = new TakeQuizDetailDAO();
                                ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
                                list = daoTakeQuizDetail.getListQuizDetail(quizID);
                                session.setAttribute("LIST_DO_QUIZ", list);
                                ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
                                for (int i = 0; i < list.size(); i++) {
                                    TakeQuizDetailDTO takeQuiz = new TakeQuizDetailDTO();
                                    takeQuiz = list.get(i);
                                    listAnswer = daoAnswer.getAnswerByID(list.get(i).getQuestionID());
                                    session.setAttribute("LIST_ANSWER_QUIZ", listAnswer);
                                    session.setAttribute("TAKE_QUIZ_DETAIL", takeQuiz);
                                    session.setAttribute("QUESTION_NUMBER", 1);
                                    session.setAttribute("NUMBER_QUESTION", numberQuestion);
                                    break;
                                }
                                session.setAttribute("OK", "Success!");
                            } else {
                                request.setAttribute("MESS_CREATE_QUIZ", "Sorry, we don't have enough question to do !");
                            }
                        } else {
                            request.setAttribute("MESS_CREATE_QUIZ", "Sorry, we don't have any question !");
                        }
                    }
                }
                session.setAttribute("SUBJECT_NAME_CHOOSE", subjectName);
            }

        } catch (Exception e) {
            log("Error in CreateQuizController: " + e.getMessage());
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
