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
import vuldt.daos.QuestionDAO;
import vuldt.daos.TakeQuizDetailDAO;
import vuldt.dtos.QuestionDTO;
import vuldt.dtos.TakeQuizDetailDTO;
import vuldt.dtos.UserDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class PagingHistoryController extends HttpServlet {

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
            String quizID = "", email = "", subjectID = "", temp = "";
            int index = 1;
            if (session.getAttribute("QUIZ_ID") != null) {
                quizID = (String) session.getAttribute("QUIZ_ID");
            }
            UserDTO user = new UserDTO();
            if (session.getAttribute("USER") != null) {
                user = (UserDTO) session.getAttribute("USER");
                email = user.getEmail();
            }
            if (session.getAttribute("SUBJECT_ID") != null) {
                subjectID = (String) session.getAttribute("SUBJECT_ID");
            }
            if (request.getParameter("txtNumber") != null) {
                temp = (String) request.getParameter("txtNumber");
                index = Integer.parseInt(temp);
            }
            QuestionDAO daoQuestion = new QuestionDAO();
            TakeQuizDetailDAO daoTakeQuiz = new TakeQuizDetailDAO();
            ArrayList<TakeQuizDetailDTO> list = new ArrayList<>();
            list = daoTakeQuiz.getListQuizDetailHistory(email, subjectID, quizID, index);
            session.setAttribute("LIST_DETAIL_TAKE_QUIZ", list);
            session.setAttribute("SUBJECT_ID", subjectID);
            session.setAttribute("QUIZ_ID", quizID);
            ArrayList<QuestionDTO> listAllQuestion = new ArrayList<>();
            listAllQuestion = daoQuestion.getAllQuestion();
            session.setAttribute("LIST_QUESTION", listAllQuestion);
            session.setAttribute("PAGE", index);
        } catch (Exception e) {
            log("Error in PagingHistoryController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("historyDetail.jsp").forward(request, response);
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
