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
import vuldt.daos.SubjectDAO;
import vuldt.daos.TakeQuizDetailDAO;
import vuldt.dtos.HistoryDTO;
import vuldt.dtos.QuestionDTO;
import vuldt.dtos.UserDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class HistoryController extends HttpServlet {

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
            String nameSubject = "";
            int index = 1;
            if (request.getParameter("txtNameSubject") != null) {
                nameSubject = (String) request.getParameter("txtNameSubject");
            }

            if (nameSubject.isEmpty()) {
                if (session.getAttribute("NAME_SUBJEECT_SEARCH") != null) {
                    nameSubject = (String) session.getAttribute("NAME_SUBJEECT_SEARCH");
                }
            }
            if (request.getParameter("txtNumber") != null) {
                String temp = (String) request.getParameter("txtNumber");
                index = Integer.parseInt(temp);
            }
            session.setAttribute("NAME_SUBJEECT_SEARCH", nameSubject);
            UserDTO user = new UserDTO();
            if (session.getAttribute("USER") != null) {
                user = (UserDTO) session.getAttribute("USER");
            }
            if (session.getAttribute("USER") != null) {
                user = (UserDTO) session.getAttribute("USER");
            }
            TakeQuizDetailDAO daoTakeDetail = new TakeQuizDetailDAO();
            ArrayList<HistoryDTO> list = new ArrayList();
            String subjectID = "";
            SubjectDAO daoSubject = new SubjectDAO();
            subjectID = daoSubject.getSubjectID(nameSubject);
            
            list = daoTakeDetail.getListTakeQuizHistory(user.getEmail(), subjectID, index);
            
            
            int pageSize = 10, numberTakeQuiz = 0, numberPage = 0;
            numberTakeQuiz = daoTakeDetail.getNumTakeQuiz(user.getEmail(), subjectID);
            numberPage = numberTakeQuiz / pageSize;
            if (numberTakeQuiz % pageSize != 0) {
                numberPage++;
            }
            if (list.size() == 0) {
                request.setAttribute("EMPTY", "You do not have any quiz of this subject !");
            }
            session.setAttribute("NUMBER_PAGE", numberPage);
            session.setAttribute("LIST_HISTORY", list);
            ArrayList<QuestionDTO> listAllQuestion = new ArrayList<>();
            QuestionDAO daoQuestion = new QuestionDAO();
            listAllQuestion = daoQuestion.getAllQuestion();
            session.setAttribute("LIST_QUESTION", listAllQuestion);
            session.setAttribute("PAGE", index);
            session.setAttribute("SUBJECT_ID", subjectID);
        } catch (Exception e) {
            log("Error in HistoryController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("history.jsp").forward(request, response);
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
