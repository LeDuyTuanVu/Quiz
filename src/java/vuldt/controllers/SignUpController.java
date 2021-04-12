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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vuldt.daos.UserDAO;
import vuldt.dtos.UserDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class SignUpController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private final static String ERROR = "signUp.jsp";
    private final static String SUCCESS = "home.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            UserDAO daoUser = new UserDAO();
            String email = "", fullName = "", password = "", rePassword = "";
            if (request.getParameter("txtEmail") != null) {
                email = (String) request.getParameter("txtEmail");
            }
            if (request.getParameter("txtFullName") != null) {
                fullName = (String) request.getParameter("txtFullName");
            }
            if (request.getParameter("txtPassword") != null) {
                password = (String) request.getParameter("txtPassword");
            }
            if (request.getParameter("txtRePassword") != null) {
                rePassword = (String) request.getParameter("txtRePassword");
            }

            HttpSession session = request.getSession();
            boolean check = true;
            if (email.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_EMAIL_SIGN_UP", "Email must not empty !");
            } else if (email.charAt(0) == '@') {
                check = false;
                request.setAttribute("MESS_EMAIL_SIGN_UP", "Format email wrong !");
            } else if (!email.trim().matches("[a-zA-Z0-9]+" + "@fpt.edu.vn")) {
                check = false;
                request.setAttribute("MESS_EMAIL_SIGN_UP", "Format email wrong ! Email must be like tuanvu@fpt.edu.vn");
            } else if (daoUser.checkEmailExist(email)) {
                check = false;
                request.setAttribute("MESS_EMAIL_SIGN_UP", "Sorry, this email was registered !");
            }

            if (fullName.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_NAME_SIGN_UP", "Full name must not empty !");
            } else if (!fullName.trim().matches("[a-zA-Z ]+")) {
                check = false;
                request.setAttribute("MESS_NAME_SIGN_UP", "Full name have no number and character !");
            }

            if (password.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_PASS_SIGN_UP", "Password must not empty !");
            } else if (!password.trim().matches("[a-zA-Z0-9]+")) {
                check = false;
                request.setAttribute("MESS_PASS_SIGN_UP", "Password contains only numbers and letters !");
            }

            if (rePassword.trim().isEmpty()) {
                check = false;
                request.setAttribute("MESS_REPASS_SIGN_UP", "Re-password must not empty !");
            } else if (!rePassword.equals(password)) {
                check = false;
                request.setAttribute("MESS_REPASS_SIGN_UP", "Re-password must be the same as password !");
            }

            if (check) {
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
                BigInteger number = new BigInteger(1, hash);
                StringBuilder hexString = new StringBuilder(number.toString(16));
                while (hexString.length() < 32) {
                    hexString.insert(0, '0');
                }
                String newPassword = hexString.toString();
                UserDTO user = new UserDTO(email, fullName, newPassword, "ST", true);
                if (daoUser.insertUser(user) != 0) {
                    url = SUCCESS;
                    session.setAttribute("WELCOME", "Welcome " + user.getFullName() + " to FPT University !");
                    request.setAttribute("MESS_SIGN_UP", "Sign up successfully !");
                } else {
                    request.setAttribute("MESS_SIGN_UP", "Sign up unsuccessfully !");
                }
            }
            session.setAttribute("EMAIL_SIGN_UP", email);
            session.setAttribute("NAME_SIGN_UP", fullName);
            session.setAttribute("PASS_SIGN_UP", password);
            session.setAttribute("REPASS_SIGN_UP", rePassword);
        } catch (Exception e) {
            log("Error in SignUpController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
