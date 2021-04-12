<%-- 
    Document   : history
    Created on : Feb 6, 2021, 2:23:04 AM
    Author     : Le Duy Tuan Vu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HISTORY</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Patua+One&display=swap" rel="stylesheet">    
        <style>
            .navbar .container-fluid .nav-link {
                color: #333333;
            }
            .navbar .container-fluid .nav-link:hover {
                color: #FF9933;
            }            
            .text-center .container .row .col-md-6 .panel{
                background-color: rgba(0, 0, 0, 0.8);
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-dark navbar-expand-lg fixed-top bg-light" id="mainNav" style="margin-left: 7px; margin-right: 7px">
            <div class="container-fluid"><a class="navbar-brand" href="#home" style="font-family: 'Patua One', cursive; color: #FF9933; font-size: 28px;"> FPT UNIVERSITY </a><button data-toggle="collapse" data-target="#navbarResponsive" class="navbar-toggler navbar-toggler-right" type="button" data-toogle="collapse" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><i class="fas fa-bars"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="nav navbar-nav ml-auto text-uppercase" style="margin-left: auto; font-family: 'Patua One', cursive; font-size: 19px">
                        <div style="margin-right: 18px">
                            <select style="border-radius: 4px; font-size: 15px; width: auto; font-family: 'Patua One', cursive; height: 35px; margin-top: 5px" name="comboxSubject" onchange="location = this.value;">
                                <c:if test="${not empty sessionScope.LIST_SUBJECT}">
                                    <option value="empty" style="font-family: 'Patua One', cursive"> &nbsp;Choose subject you want to search </option>
                                    <c:forEach var="name" items="${sessionScope.LIST_SUBJECT}">
                                        <c:if test="${sessionScope.NAME_SUBJEECT_SEARCH eq name}">
                                            <option selected="selected" value="HistoryController?txtNameSubject=${name}" style="font-family: 'Patua One', cursive"> &nbsp;${name} </option>
                                        </c:if>
                                        <c:if test="${sessionScope.NAME_SUBJEECT_SEARCH ne name}">
                                            <option value="HistoryController?txtNameSubject=${name}" style="font-family: 'Patua One', cursive"> &nbsp;${name} </option>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty sessionScope.LIST_SUBJECT}">
                                    <option value="null" style="font-family: 'Patua One', cursive"> &nbsp;There is no subject in the system ! </option>
                                </c:if>
                            </select>
                        </div>                       
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="TakeQuizPageController"> TAKE QUIZ </a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="SignOutController"> SIGN OUT </a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid" style="margin-top: 77px">
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <form action="HistoryDetailPageController">
                        <c:if test="${not empty sessionScope.LIST_HISTORY}">
                            <c:forEach var="detail" items="${sessionScope.LIST_HISTORY}" varStatus="counter">
                                <input type="hidden" name="txtTakeQuizID" value="${detail.takeQuizID}">
                                <input type="hidden" name="txtQuizID" value="${detail.quizID}">
                                <p style="font-size: 25px; font-family: 'Patua One', cursive; margin-left: 70px; margin-top: 20px">${10*(sessionScope.PAGE-1)+counter.count}.&nbsp; In ${detail.makeQuizDate} - You did quiz have ID : ${detail.quizID} - You get : ${detail.total} points</p>
                                <input type="submit" value="MORE DETAIL" style="font-family: 'Patua One', cursive; background-color: #FF9933; margin-left: 70px; margin-bottom: 30px; margin-top: -30px">
                            </c:forEach>
                        </c:if>
                        <c:if test="${not empty requestScope.EMPTY}">
                            <p style="font-size: 25px; font-family: 'Patua One', cursive; margin-left: 70px; margin-top: 20px; color: red">You do not have any quiz of this subject !</p>
                        </c:if>
                    </form>
                    <nav aria-label="Page navigation example" style="margin-top: 5px; margin-bottom: 20px;">
                        <ul class="pagination">
                            <!-- SHOW NUMBER OF PAGE, PAGING -->
                            <c:if test="${sessionScope.NUMBER_PAGE > 1}">
                                <li class="page-item" style="margin-left: auto">
                                    <a class="page-link" href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        <span class="sr-only"></span>
                                    </a>
                                </li>
                                <c:forEach var="num" begin="1" end="${sessionScope.NUMBER_PAGE}">
                                    <li class="page-item"><a class="page-link" href="HistoryController?txtNumber=${num}">${num}</a></li>
                                    </c:forEach>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only"></span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
                <div class="col-md-2"></div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
