<%-- 
    Document   : admin
    Created on : Feb 7, 2021, 2:19:00 AM
    Author     : Le Duy Tuan Vu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN</title>
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
        <div class="container-fluid" style="margin-top: 80px; font-family: 'Patua One', cursive">
            <div class="row">
                <div class="col-md-3">
                    <div style="max-width: 95%; margin-left: 7px">
                        <p style="font-size: 25px; ">SEARCH BY FILTER</p>
                        <div>
                            <strong>Search by subject</strong><br>
                            <select style="border-radius: 4px; font-size: 15px; width: auto; font-family: 'Patua One', cursive; height: 40px; margin-top: 5px; width: 82.6%" name="comboxSubject" onchange="location = this.value;">
                                <c:if test="${not empty sessionScope.LIST_SUBJECT}">
                                    <option value="SearchBySubjectController?comboxSubject=empty" style="font-family: 'Patua One', cursive"> &nbsp;Choose subject of question </option>
                                    <c:forEach var="name" items="${sessionScope.LIST_SUBJECT}">
                                        <c:if test="${sessionScope.SUBJECT_TXT eq name}">
                                            <option selected="selected" value="SearchBySubjectController?comboxSubject=${name}" style="font-family: 'Patua One', cursive"> &nbsp;${name} </option>
                                        </c:if>
                                        <c:if test="${sessionScope.SUBJECT_TXT ne name}">
                                            <option value="SearchBySubjectController?comboxSubject=${name}" style="font-family: 'Patua One', cursive"> &nbsp;${name} </option>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty sessionScope.LIST_SUBJECT}">
                                    <option value="SearchBySubjectController?comboxSubject=null" style="font-family: 'Patua One', cursive"> &nbsp;There is no subject in the system ! </option>
                                </c:if>
                            </select>                                
                            <c:if test="${not empty requestScope.MESS_SEARCH_BY_SUBJECT}">
                                <p style="color: red; font-family: 'Patua One', cursive; margin-top: 5px; margin-bottom: -5px">${requestScope.MESS_SEARCH_BY_SUBJECT}</p>
                            </c:if>
                        </div> 
                        <div style="margin-top: 20px">
                            <strong>Search by status</strong><br>
                            <select style="border-radius: 4px; font-size: 15px; width: auto; font-family: 'Patua One', cursive; height: 40px; margin-top: 5px; width: 82.6%" name="comboxStatus" onchange="location = this.value;">
                                <option value="SearchByStatusController?comboxStatus=status" style="font-family: 'Patua One', cursive"> &nbsp;Choose status of question </option>
                                <c:if test="${not empty sessionScope.STATUS_TXT}">
                                    <c:if test="${sessionScope.STATUS_TXT eq 'true'}">
                                        <option selected="selected" value="SearchByStatusController?comboxStatus=true" style="font-family: 'Patua One', cursive"> &nbsp;Active </option>
                                        <option value="SearchByStatusController?comboxStatus=false" style="font-family: 'Patua One', cursive"> &nbsp;Inactive </option>
                                    </c:if>
                                    <c:if test="${sessionScope.STATUS_TXT eq 'false'}">
                                        <option value="SearchByStatusController?comboxStatus=true" style="font-family: 'Patua One', cursive"> &nbsp;Active </option>
                                        <option selected="selected" value="SearchByStatusController?comboxStatus=false" style="font-family: 'Patua One', cursive"> &nbsp;Inactive </option>
                                    </c:if>
                                    <c:if test="${sessionScope.STATUS_TXT eq 'status'}">
                                        <option value="SearchByStatusController?comboxStatus=true" style="font-family: 'Patua One', cursive"> &nbsp;Active </option>
                                        <option value="SearchByStatusController?comboxStatus=false" style="font-family: 'Patua One', cursive"> &nbsp;Inactive </option>
                                    </c:if>
                                </c:if>
                                <c:if test="${empty sessionScope.STATUS_TXT}">
                                    <option value="SearchByStatusController?comboxStatus=true" style="font-family: 'Patua One', cursive"> &nbsp;Active </option>
                                    <option value="SearchByStatusController?comboxStatus=false" style="font-family: 'Patua One', cursive"> &nbsp;Inactive </option>
                                </c:if>
                            </select>
                            <c:if test="${not empty requestScope.MESS_SEARCH_BY_STATUS}">
                                <p style="color: red; font-family: 'Patua One', cursive; margin-top: 5px">${requestScope.MESS_SEARCH_BY_STATUS}</p>
                            </c:if>
                        </div>
                        <div style="margin-top: 20px">
                            <form action="SearchByNameController">
                                <strong>Search by name</strong><br>
                                <input type="text" name="txtSearchByName" value="${sessionScope.NAME_TXT}" placeholder=" Enter name of question " style="height: 40px; border-radius: 4px; margin-top: 5px; width: 60%">
                                <input type="submit" value="SEARCH" style="height: 40px; border-radius: 4px">
                                <c:if test="${not empty requestScope.MESS_SEARCH_BY_NAME}">
                                    <p style="color: red; font-family: 'Patua One', cursive; margin-bottom: -5px; margin-top: 6px">${requestScope.MESS_SEARCH_BY_NAME}</p>
                                </c:if>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-9" style="margin-top: 4px">
                    <c:if test="${not empty requestScope.DELETE}">
                        <p style="color: red; font-family: 'Patua One', cursive; font-size: 25px; margin-bottom: 10px">${requestScope.DELETE}</p>
                    </c:if>
                    <!-- GET ALL -->
                    <c:if test="${empty sessionScope.STATUS_TXT && empty sessionScope.NAME_TXT && empty sessionScope.SUBJECT_TXT}">
                        <c:if test="${not empty sessionScope.HASH}">
                            <c:forEach var="map" items="${sessionScope.HASH}" varStatus="counter">
                                <c:if test="${not empty sessionScope.LIST_QUESTION}">
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <p style="color: #FF9933">${20*(sessionScope.PAGE-1)+counter.count}.&nbsp; ${question.questionContent}</p>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:forEach var="hash" items="${map.value}" varStatus="count">  
                                    <c:if test="${count.count == 1}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>A.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>A.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 2}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>B.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>B.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 3}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>C.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>C.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 4}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>D.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>D.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                <div>
                                    <button type="button"><a href="UpdatePageController?txtQuestionID=${map.key}" style="text-decoration: none">UPDATE</a></button>
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <c:if test="${question.status eq true}">
                                                <button type="button"><a href="DeleteQuestionController?txtQuestionID=${question.questionID} " onclick="return confirm('Do you want to delete ?')" style="text-decoration: none">DELETE</a></button>
                                            </c:if>
                                            <c:if test="${question.status ne true}">
                                                <button type="button" disabled="disabled">DELETED</button>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                </br>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <!-- SEARCH BY STATUS -->
                    <c:if test="${not empty sessionScope.STATUS_TXT}">
                        <c:if test="${not empty sessionScope.NAME_SUBJECT}">
                            <p style="color: red; font-family: 'Patua One', cursive; font-size: 25px; margin-top: -4px">${sessionScope.NAME_SUBJECT}</p>
                        </c:if>
                        <c:if test="${not empty sessionScope.HASH}">
                            <c:forEach var="map" items="${sessionScope.HASH}" varStatus="counter">
                                <c:if test="${not empty sessionScope.LIST_QUESTION}">
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <p style="color: #FF9933">${counter.count}.&nbsp; ${question.questionContent}</p>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:forEach var="hash" items="${map.value}" varStatus="count">  
                                    <c:if test="${count.count == 1}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>A.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>A.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 2}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>B.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>B.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 3}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>C.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>C.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 4}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>D.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>D.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                <div>
                                    <button type="button"><a href="UpdatePageController?txtQuestionID=${map.key}" style="text-decoration: none">UPDATE</a></button>
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <c:if test="${question.status eq true}">
                                                <button type="button"><a href="DeleteQuestionController?txtQuestionID=${question.questionID} " onclick="return confirm('Do you want to delete ?')" style="text-decoration: none">DELETE</a></button>
                                            </c:if>
                                            <c:if test="${question.status ne true}">
                                                <button type="button" disabled="disabled">DELETED</button>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                </br>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <!-- SEARCH BY NAME -->
                    <c:if test="${not empty sessionScope.NAME_TXT}">
                        <c:if test="${not empty sessionScope.NAME_SUBJECT}">
                            <p style="color: red; font-family: 'Patua One', cursive; font-size: 25px; margin-top: -4px">${sessionScope.NAME_SUBJECT}</p>
                        </c:if>
                        <c:if test="${not empty sessionScope.HASH}">
                            <c:forEach var="map" items="${sessionScope.HASH}" varStatus="counter">
                                <c:if test="${not empty sessionScope.LIST_QUESTION}">
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <p style="color: #FF9933">${counter.count}.&nbsp; ${question.questionContent}</p>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:forEach var="hash" items="${map.value}" varStatus="count">  
                                    <c:if test="${count.count == 1}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>A.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>A.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 2}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>B.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>B.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 3}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>C.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>C.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 4}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>D.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>D.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                <div>
                                    <button type="button"><a href="UpdatePageController?txtQuestionID=${map.key}" style="text-decoration: none">UPDATE</a></button>
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <c:if test="${question.status eq true}">
                                                <button type="button"><a href="DeleteQuestionController?txtQuestionID=${question.questionID} " onclick="return confirm('Do you want to delete ?')" style="text-decoration: none">DELETE</a></button>
                                            </c:if>
                                            <c:if test="${question.status ne true}">
                                                <button type="button" disabled="disabled">DELETED</button>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                </br>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <!-- SEARCH BY SUBJECT -->
                    <c:if test="${not empty sessionScope.SUBJECT_TXT}">
                        <c:if test="${not empty sessionScope.HASH}">
                            <c:forEach var="map" items="${sessionScope.HASH}" varStatus="counter">
                                <c:if test="${not empty sessionScope.LIST_QUESTION}">
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <p style="color: #FF9933">${20*(sessionScope.PAGE-1)+counter.count}.&nbsp; ${question.questionContent}</p>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:forEach var="hash" items="${map.value}" varStatus="count">  
                                    <c:if test="${count.count == 1}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>A.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>A.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 2}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>B.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>B.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 3}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>C.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>C.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${count.count == 4}">
                                        <c:if test="${hash.answerCorrect eq true}">
                                            <p>D.&nbsp; ${hash.answerContent} &nbsp;<span style="color: limegreen">(Correct)</span></p>
                                        </c:if>
                                        <c:if test="${hash.answerCorrect ne true}">
                                            <p>D.&nbsp; ${hash.answerContent} </p>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                <div>
                                    <button type="button"><a href="UpdatePageController?txtQuestionID=${map.key}" style="text-decoration: none">UPDATE</a></button>
                                    <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                        <c:if test="${question.questionID eq map.key}">
                                            <c:if test="${question.status eq true}">
                                                <button type="button"><a href="DeleteQuestionController?txtQuestionID=${question.questionID} " onclick="return confirm('Do you want to delete ?')" style="text-decoration: none">DELETE</a></button>
                                            </c:if>
                                            <c:if test="${question.status ne true}">
                                                <button type="button" disabled="disabled">DELETED</button>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                </br>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <c:if test="${empty sessionScope.HASH}">
                        <p style="color: red; font-size: 20px; margin-top: -2px">Don't have any question !</p>
                    </c:if>
                </div>
            </div>     
        </div>
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
                        <li class="page-item"><a class="page-link" href="PagingController?txtNumber=${num}">${num}</a></li>
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

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
