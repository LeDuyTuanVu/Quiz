/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vuldt.daos.QuestionDAO;
import vuldt.daos.SubjectDAO;
import vuldt.dtos.AnswerDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class SearchByStatusController extends HttpServlet {

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
            QuestionDAO daoQuestion = new QuestionDAO();
            SubjectDAO daoSubject = new SubjectDAO();
            String statusQuestion = "";
            if (request.getParameter("comboxStatus") != null) {
                statusQuestion = (String) request.getParameter("comboxStatus");
            }
            if (statusQuestion.equals("status") || statusQuestion.equals("")) {
                request.setAttribute("MESS_SEARCH_BY_STATUS", "Please choose status's question you want to search !");
                session.setAttribute("HASH", "");
                session.setAttribute("STATUS_TXT", "status");
                session.setAttribute("NUMBER_PAGE", "");
            } else {
                HashMap<String, Integer> hash = new HashMap<>();
                hash = daoSubject.getListSubjectByStatus(statusQuestion);
                Set<String> key = hash.keySet();
                int count = 0, check = 0;
                String firstSubject = "";
                for (String subjectName : key) {
                    if (check == 0) {
                        firstSubject = subjectName;
                        check++;
                    }
                    Integer temp = hash.get(subjectName);
                    if (temp > 0) {
                        count++;
                    }
                }
                session.setAttribute("NUMBER_PAGE", count);
                HashMap<String, ArrayList<AnswerDTO>> hashMap = new HashMap<>();
                hashMap = daoQuestion.getQuestionByStatus(statusQuestion, firstSubject);
                request.setAttribute("MESS_SEARCH_BY_STATUS", "");
                session.setAttribute("HASH", hashMap);
                session.setAttribute("NAME_SUBJECT", firstSubject);
            }
            session.setAttribute("STATUS_TXT", statusQuestion);
            session.setAttribute("NAME_TXT", "");
            session.setAttribute("SUBJECT_TXT", "");
            session.setAttribute("PAGE", 1);
        } catch (Exception e) {
            log("Error in SearchByStatusController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("admin.jsp").forward(request, response);
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
