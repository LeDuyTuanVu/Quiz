/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.controllers;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import vuldt.daos.UserDAO;
import vuldt.dtos.AnswerDTO;
import vuldt.dtos.HistoryDTO;
import vuldt.dtos.QuestionDTO;
import vuldt.dtos.TakeQuizDetailDTO;
import vuldt.dtos.UserDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class SignInController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private final static String ERROR = "signIn.jsp";
    private final static String STUDENT = "home.jsp";
    private final static String ADMIN = "admin.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String email = "", password = "";
            if (request.getParameter("txtEmail") != null) {
                email = (String) request.getParameter("txtEmail");
            }
            if (request.getParameter("txtPassword") != null) {
                password = (String) request.getParameter("txtPassword");
            }

            HttpSession session = request.getSession();
            boolean check = true;
            if (email.trim().isEmpty()) {
                check = false;
                session.setAttribute("MESS_EMAIL_LOGIN", "Email must not empty !");
            } else if (email.charAt(0) == '@') {
                check = false;
                session.setAttribute("MESS_EMAIL_LOGIN", "Format email wrong !");
            } else if (!email.trim().matches("[a-zA-Z0-9]+" + "@fpt.edu.vn")) {
                check = false;
                session.setAttribute("MESS_EMAIL_LOGIN", "Format email wrong ! Email must be like tuanvu@fpt.edu.vn");
            } else {
                session.setAttribute("MESS_EMAIL_LOGIN", "");
            }

            if (password.trim().isEmpty()) {
                check = false;
                session.setAttribute("MESS_PASS_LOGIN", "Password must not empty !");
            } else {
                session.setAttribute("MESS_PASS_LOGIN", "");
            }

            if (check) {
                UserDTO user = new UserDTO();
                UserDAO daoUser = new UserDAO();
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
                BigInteger number = new BigInteger(1, hash);
                StringBuilder hexString = new StringBuilder(number.toString(16));
                while (hexString.length() < 32) {
                    hexString.insert(0, '0');
                }
                String newPassword = hexString.toString();
                user = daoUser.getUser(email, newPassword);
                if (user != null) {
                    QuestionDAO daoQuestion = new QuestionDAO();
                    if (user.isStatus()) {
                        if (user.getRoleID().equals("ST")) {
                            session.setAttribute("WELCOME", "Welcome " + user.getFullName() + " to FPT University !");
                            session.setAttribute("USER", user);
                            url = STUDENT;
                            TakeQuizDetailDAO daoTakeQuiz = new TakeQuizDetailDAO();
                            HistoryDTO history = daoTakeQuiz.getQuizNotSubmit(user.getEmail());
                            QuizDAO daoQuiz = new QuizDAO();
                            if (history != null) {
                                String arr[] = history.getMakeQuizDate().split(" ");
                                if (arr.length == 2) {
                                    String time = arr[1], day = arr[0];
                                    String currenntDay = java.time.LocalDate.now() + "";
                                    String currentTime = java.time.LocalTime.now() + "";
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    Date date1 = sdf.parse(day);
                                    Date date2 = sdf.parse(currenntDay);

                                    int h1 = 0, h2 = 0, m1 = 0, m2 = 0;
                                    float s1 = 0, s2 = 0;
                                    String arrTime1[] = currentTime.split(":");
                                    if (arrTime1.length == 3) {
                                        h1 = Integer.parseInt(arrTime1[0]);
                                        m1 = Integer.parseInt(arrTime1[1]);
                                        s1 = Float.parseFloat(arrTime1[2]);
                                    }
                                    String arrTime2[] = time.split(":");
                                    if (arrTime2.length == 3) {
                                        h2 = Integer.parseInt(arrTime2[0]);
                                        m2 = Integer.parseInt(arrTime2[1]);
                                        s2 = Float.parseFloat(arrTime2[2]);
                                    }
                                    int minute = 0;
                                    minute = daoQuiz.getMinuteByQuizID(history.getQuizID());
                                    if (date1.compareTo(date2) == 0) {
                                        float temp1 = 0, temp2 = 0;
                                        temp1 = (h1 * 60 + m1 + minute) * 60 + s1;
                                        temp2 = (h2 * 60 + m2) * 60 + s2;
                                        if (temp2 <= temp1) {
                                            AnswerDAO daoAnswer = new AnswerDAO();
                                            TakeQuizDetailDAO daoTakeQuizDetail = new TakeQuizDetailDAO();
                                            ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
                                            list = daoTakeQuizDetail.getListQuizDetail(history.getQuizID());
                                            session.setAttribute("LIST_DO_QUIZ", list);
                                            ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
                                            SubjectDAO daoSubject = new SubjectDAO();
                                            int numberQuestion = daoSubject.getNumQuestion(daoQuiz.getSubjectIDByQuizID(history.getQuizID()));

                                            session.setAttribute("M", minute);
                                            session.setAttribute("S", 0);
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
                                            String subjectName = "";
                                            subjectName = daoSubject.getSubjectName(daoQuiz.getSubjectIDByQuizID(history.getQuizID()));
                                            session.setAttribute("SUBJECT_NAME_CHOOSE", subjectName);
                                            session.setAttribute("OK", "Success!");
                                            session.setAttribute("QUIZ_ID", history.getQuizID());
                                        } else {
                                            daoQuiz.submitQuiz(history.getQuizID(), user.getEmail());
                                        }
                                    } else {
                                        daoQuiz.submitQuiz(history.getQuizID(), user.getEmail());
                                    }
                                }
                            }
                        } else {
                            int numberQuestion = 0, pageSize = 20, numberOfPage = 0;
                            numberQuestion = daoQuestion.getNumAllQuestion();
                            numberOfPage = numberQuestion / pageSize;
                            if (numberQuestion % pageSize != 0) {
                                numberOfPage++;
                            }
                            HashMap<String, ArrayList<AnswerDTO>> hashMap = new HashMap<>();
                            hashMap = daoQuestion.getAllQuestion(1);
                            session.setAttribute("HASH", hashMap);
                            session.setAttribute("NUMBER_PAGE", numberOfPage);
                            url = ADMIN;
                            session.setAttribute("USER", user);
                        }
                        SubjectDAO daoSubject = new SubjectDAO();
                        ArrayList<String> listAllSubject = new ArrayList();
                        listAllSubject = daoSubject.getAllSubject();
                        ArrayList<QuestionDTO> listAllQuestion = new ArrayList<>();
                        listAllQuestion = daoQuestion.getAllQuestion();
                        session.setAttribute("LIST_QUESTION", listAllQuestion);
                        session.setAttribute("LIST_SUBJECT", listAllSubject);
                        session.setAttribute("PAGE", 1);
                    } else {
                        session.setAttribute("MESS_LOGIN", "Sorry, your account has been locked !");
                    }
                } else {
                    session.setAttribute("MESS_LOGIN", "Email or password wrong !");
                }
            } else {
                session.setAttribute("MESS_LOGIN", "");
            }
            session.setAttribute("EMAIL", email);
            session.setAttribute("PASS", password);
        } catch (Exception e) {
            log("Error in SignInController: " + e.getMessage());
        } finally {
            response.sendRedirect(url);
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
