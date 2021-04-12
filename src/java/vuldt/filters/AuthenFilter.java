/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vuldt.dtos.UserDTO;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class AuthenFilter implements Filter {

    private final String LOGIN = "signIn.jsp";

    private final List<String> STUDENT;
    private final List<String> ADMIN;

    private final String ST = "ST";
    private final String AD = "AD";
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public AuthenFilter() {
        STUDENT = new ArrayList<>();
        STUDENT.add("");
        STUDENT.add("CreateQuizController");
        STUDENT.add("GetQuestionController");
        STUDENT.add("HistoryController");
        STUDENT.add("HistoryDetailPageController");
        STUDENT.add("HistoryPageController");
        STUDENT.add("PagingHistoryController");
        STUDENT.add("home.jsp");
        STUDENT.add("history.jsp");
        STUDENT.add("historyDetail.jsp");
        STUDENT.add("TakeQuizPageController");
        STUDENT.add("error400.html");
        STUDENT.add("error403.html");
        STUDENT.add("error404.html");
        STUDENT.add("error500.html");
        STUDENT.add("error503.html");

        ADMIN = new ArrayList<>();
        ADMIN.add("");
        ADMIN.add("admin.jsp");
        ADMIN.add("AllQuestionController");
        ADMIN.add("CreateQuesionPageController");
        ADMIN.add("CreateQuestionController");
        ADMIN.add("DeleteQuestionController");
        ADMIN.add("PagingController");
        ADMIN.add("SearchByNameController");
        ADMIN.add("SearchByStatusController");
        ADMIN.add("SearchBySubjectController");
        ADMIN.add("UpdatePageController");
        ADMIN.add("UpdateQuestionController");     
        ADMIN.add("createQuestion.jsp");
        ADMIN.add("updateQuestion.jsp");
        ADMIN.add("error400.html");
        ADMIN.add("error403.html");
        ADMIN.add("error404.html");
        ADMIN.add("error500.html");
        ADMIN.add("error503.html");
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            String uri = req.getRequestURI();
            if (uri.contains(".png") || uri.contains(".jpg") || uri.contains("gif")) {
                chain.doFilter(request, response);
            } else {
                if (uri.contains("SignUpPageController") || uri.contains("signIn.jsp") || uri.contains("SignInPageController") || uri.contains("SignOutController")
                        || uri.contains("signUp.jsp") || uri.contains("SignUpController") || uri.contains("FirstInController") || uri.contains("SignInController") || uri.contains("admin.jsp")) {
                    chain.doFilter(request, response);
                    return;
                }
                int index = uri.lastIndexOf("/");
                String resout = uri.substring(index + 1);
                HttpSession session = req.getSession();
                if (session == null || session.getAttribute("USER") == null) {
                    res.sendRedirect(LOGIN);
                } else {
                    UserDTO user = (UserDTO) session.getAttribute("USER");
                    String roleID = user.getRoleID();
                    if (AD.equals(roleID) && ADMIN.contains(resout)) {
                        chain.doFilter(request, response);
                    } else if (ST.equals(roleID) && STUDENT.contains(resout)) {
                        chain.doFilter(request, response);
                    } else {
                        res.sendRedirect(LOGIN);
                    }
                }
            }
        } catch (Exception e) {
            log("Error in AuthenFilter: " + e.getMessage());
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthenFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
