/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vuldt.daos.QuestionDAO;
import vuldt.dtos.AnswerDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class SearchBySubjectController extends HttpServlet {

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
            String subjectName = "";
            if (request.getParameter("comboxSubject") != null) {
                subjectName = (String) request.getParameter("comboxSubject");
            }
            if (subjectName.equals("empty") || subjectName.equals("")) {
                request.setAttribute("MESS_SEARCH_BY_SUBJECT", "Please choose subject you want to search !");
                session.setAttribute("HASH", "");
                session.setAttribute("NUMBER_PAGE", "");
            } else if (subjectName.equals("null")) {
                request.setAttribute("MESS_SEARCH_BY_SUBJECT", "Sorry, we don't have any subject !");
                session.setAttribute("HASH", "");
                session.setAttribute("NUMBER_PAGE", "");
            } else {
                HashMap<String, ArrayList<AnswerDTO>> hashMap = new HashMap<>();
                hashMap = daoQuestion.getQuestionBySubject(1, subjectName);
                session.setAttribute("HASH", hashMap);
                request.setAttribute("MESS_SEARCH_BY_SUBJECT", "");

                int numberQuestion = 0, pageSize = 20, numberOfPage = 0;
                numberQuestion = daoQuestion.getNumQuestionBySubject(subjectName);
                numberOfPage = numberQuestion / pageSize;
                if (numberQuestion % pageSize != 0) {
                    numberOfPage++;
                }
                session.setAttribute("NUMBER_PAGE", numberOfPage);
            }
            session.setAttribute("NAME_TXT", "");
            session.setAttribute("STATUS_TXT", "");
            session.setAttribute("SUBJECT_TXT", subjectName);
            session.setAttribute("PAGE", 1);
        } catch (Exception e) {
            log("Error in SearchBySubjectController: " + e.getMessage());
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
