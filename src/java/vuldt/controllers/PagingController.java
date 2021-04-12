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
import vuldt.dtos.QuestionDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class PagingController extends HttpServlet {

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
            SubjectDAO daoSubject = new SubjectDAO();
            String subjectName = "", tempStatus = "", nameQuestion = "", num = "";
            if (session.getAttribute("SUBJECT_TXT") != null) {
                subjectName = (String) session.getAttribute("SUBJECT_TXT");
            }
            if (session.getAttribute("NAME_TXT") != null) {
                nameQuestion = (String) session.getAttribute("NAME_TXT");
            }
            if (session.getAttribute("STATUS_TXT") != null) {
                tempStatus = (String) session.getAttribute("STATUS_TXT");
            }
            if (request.getParameter("txtNumber") != null) {
                num = (String) request.getParameter("txtNumber");
            }
            if (num.isEmpty()) {
                num = "1";
            }
            int index = Integer.parseInt(num);
            QuestionDAO daoQuestion = new QuestionDAO();
            int numberQuestion = 0, pageSize = 20, numberOfPage = 0;
            HashMap<String, ArrayList<AnswerDTO>> hashMap = new HashMap<>();

            if (!nameQuestion.trim().isEmpty()) {
                HashMap<String, Integer> hash = new HashMap<>();
                hash = daoSubject.getListSubjectByName(nameQuestion);
                Set<String> key = hash.keySet();
                int count = 0;
                String firstSubject = "";
                for (String tempNameSubject : key) {
                    if (count == (index - 1)) {
                        firstSubject = tempNameSubject;
                        hashMap = daoQuestion.getQuestionByName(nameQuestion, firstSubject);
                    }
                    count++;
                }
                session.setAttribute("NUMBER_PAGE", count);
                session.setAttribute("HASH", hashMap);
                session.setAttribute("NAME_SUBJECT", firstSubject);
            } else if (!subjectName.equals("empty") && !subjectName.equals("null") && !subjectName.isEmpty()) {
                numberQuestion = daoQuestion.getNumQuestionBySubject(subjectName);
                numberOfPage = numberQuestion / pageSize;
                if (numberQuestion % pageSize != 0) {
                    numberOfPage++;
                }
                hashMap = daoQuestion.getQuestionBySubject(index, subjectName);
                session.setAttribute("HASH", hashMap);
                session.setAttribute("NUMBER_PAGE", numberOfPage);
            } else if (!tempStatus.equals("status") && !tempStatus.isEmpty()) {
                HashMap<String, Integer> hash = new HashMap<>();
                hash = daoSubject.getListSubjectByStatus(tempStatus);
                Set<String> key = hash.keySet();
                int count = 0;
                String firstSubject = "";
                for (String tempNameSubject : key) {
                    if (count == (index - 1)) {
                        firstSubject = tempNameSubject;
                        hashMap = daoQuestion.getQuestionByStatus(tempStatus, firstSubject);
                    }
                    count++;
                }
                session.setAttribute("NUMBER_PAGE", count);
                session.setAttribute("HASH", hashMap);
                session.setAttribute("NAME_SUBJECT", firstSubject);
            } else {
                numberQuestion = daoQuestion.getNumAllQuestion();
                numberOfPage = numberQuestion / pageSize;
                if (numberQuestion % pageSize != 0) {
                    numberOfPage++;
                }
                hashMap = daoQuestion.getAllQuestion(index);
                session.setAttribute("HASH", hashMap);
                session.setAttribute("NUMBER_PAGE", numberOfPage);
            }
            session.setAttribute("PAGE", index);
            ArrayList<String> listAllSubject = new ArrayList();
            listAllSubject = daoSubject.getAllSubject();
            ArrayList<QuestionDTO> listAllQuestion = new ArrayList<>();
            listAllQuestion = daoQuestion.getAllQuestion();
            session.setAttribute("LIST_QUESTION", listAllQuestion);
            session.setAttribute("LIST_SUBJECT", listAllSubject);
        } catch (Exception e) {
            log("Error in PagingController: " + e.getMessage());
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
