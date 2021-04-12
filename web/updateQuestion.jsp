<%-- 
    Document   : updateQuestion
    Created on : Jan 28, 2021, 11:42:12 PM
    Author     : Le Duy Tuan Vu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UPDATE QUESTION</title>
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
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="AllQuestionController"> ALL QUESTION </a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="CreateQuesionPageController"> CREATE QUESTION </a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="SignOutController"> SIGN OUT </a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10" style="margin-top: 80px">
                    <p style="text-align: center; font-size: 30px; font-family: 'Patua One', cursive">Enter information you want to update</p>
                    <strong>Question content</strong>
                    <form action="UpdateQuestionController">
                        <c:if test="${not empty sessionScope.QUESTION_UPDATE}">
                            <input type="hidden" name="txtQuestionID" value="${sessionScope.QUESTION_UPDATE.questionID}">
                            <input type="text" name="txtQuestionContent" value="${sessionScope.QUESTION_UPDATE.questionContent}" style="color: #FF9933; width: 100%; height: 35px; margin-bottom: 15px; margin-top: 5px; font-family: 'Patua One', cursive"> 
                            <c:if test="${not empty requestScope.MESS_UPDATE_QUESTION}">
                                <p style="color: red; font-family: 'Patua One', cursive; margin-bottom: 8px;">${requestScope.MESS_UPDATE_QUESTION}</p>
                            </c:if>
                            <c:if test="${not empty sessionScope.LIST_ANSWER_UPDATE}">
                                <c:set var="tempAnswerID" value=""></c:set>
                                <c:forEach var="answer" items="${sessionScope.LIST_ANSWER_UPDATE}" varStatus="count">
                                    <c:set var="tempAnswerID" value="${answer.answerID}-${tempAnswerID}"></c:set>
                                    <strong>Answer${count.count}</strong>
                                    <div style="margin-bottom: 10px; display: flex">                                       
                                        <input type="text" name="txtAnswer${count.count}" value="${answer.answerContent}" style="height: 35px; width: 100%; ">
                                        <c:if test="${answer.answerCorrect eq true}">
                                            <input class="form-check-input" type="radio" checked="true" name="txtCheckBox" value="${answer.answerID}" style="height: 27px; width: 27px; margin-left: 7px">
                                        </c:if>
                                        <c:if test="${answer.answerCorrect eq false}">
                                            <input class="form-check-input" type="radio" name="txtCheckBox" value="${answer.answerID}" style="height: 27px; width: 27px; margin-left: 7px">
                                        </c:if>
                                    </div>
                                </c:forEach>
                                <input type="hidden" name="answerID" value="${tempAnswerID}">
                                <c:if test="${not empty requestScope.MESS_UPDATE_ANSWER}">
                                    <p style="color: red; font-family: 'Patua One', cursive; margin-top: 15px">${requestScope.MESS_UPDATE_ANSWER}</p>
                                </c:if>
                            </c:if>
                            <div style="margin-top: 17px">
                                <strong>Subject</strong>
                                <select style="border-radius: 4px; font-size: 15px; margin-left: 1.5px; width: auto; font-family: 'Patua One', cursive; height: 35px;" name="comboxSubject">
                                    <c:if test="${not empty sessionScope.LIST_SUBJECT}">
                                        <c:forEach var="name" items="${sessionScope.LIST_SUBJECT}">
                                            <c:if test="${sessionScope.QUESTION_UPDATE.subjectID eq name}">
                                                <option value="${name}" selected="selected" style="font-family: 'Patua One', cursive">${name}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.QUESTION_UPDATE.subjectID ne name}">
                                                <option value="${name}" style="font-family: 'Patua One', cursive">${name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty sessionScope.LIST_SUBJECT}">
                                        <option value="null" style="font-family: 'Patua One', cursive">There is no subject in the system !</option>
                                    </c:if>
                                </select>
                            </div>
                            <div style="margin-top: 17px">
                                <strong>Status</strong>
                                <select style="border-radius: 4px; font-size: 15px; margin-left: 1.5px; width: auto; font-family: 'Patua One', cursive; height: 35px;" name="comboxStatus">
                                    <c:if test="${sessionScope.QUESTION_UPDATE.status eq true}">
                                        <option value="true" selected="selected" style="font-family: 'Patua One', cursive"> Active </option>
                                        <option value="false" style="font-family: 'Patua One', cursive"> Inactive</option>
                                    </c:if>
                                    <c:if test="${sessionScope.QUESTION_UPDATE.status ne true}">
                                        <option value="true" style="font-family: 'Patua One', cursive"> Active</option>
                                        <option value="false" selected="selected" style="font-family: 'Patua One', cursive"> Inactive </option>
                                    </c:if>
                                </select>
                            </div>
                            <input class="btn btn-warning" type="submit" value="UPDATE QUESTION" style="font-family: 'Patua One', cursive; background-color: #FF9933; margin-top: 17px">
                            <c:if test="${not empty requestScope.MESS_UPDATE}">
                                <p style="color: red; font-family: 'Patua One', cursive; font-size: 20px; margin-top: 10px">${requestScope.MESS_UPDATE}</p>
                            </c:if>
                        </c:if>
                    </form>
                </div>
                <div class="col-md-1"></div>
            </div>
        </div> 	
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
