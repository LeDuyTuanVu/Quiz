<%-- 
    Document   : home
    Created on : Jan 24, 2021, 3:20:36 PM
    Author     : Le Duy Tuan Vu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOME</title>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-dark navbar-expand-lg fixed-top bg-light" id="mainNav" style="margin-left: 7px; margin-right: 7px">
            <div class="container-fluid"><a class="navbar-brand" href="#home" style="font-family: 'Patua One', cursive; color: #FF9933; font-size: 28px;"> FPT UNIVERSITY </a><button data-toggle="collapse" data-target="#navbarResponsive" class="navbar-toggler navbar-toggler-right" type="button" data-toogle="collapse" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><i class="fas fa-bars"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="nav navbar-nav ml-auto text-uppercase" style="margin-left: auto; font-family: 'Patua One', cursive; font-size: 19px">
                        <div style="margin-right: 20px">
                            <form action="CreateQuizController">
                                <select style="border-radius: 4px; font-size: 15px; width: auto; font-family: 'Patua One', cursive; height: 35px; margin-top: 5px" name="comboxSubject">
                                    <c:if test="${not empty sessionScope.LIST_SUBJECT}">
                                        <option value="empty" style="font-family: 'Patua One', cursive"> &nbsp;Choose subject you want to do quiz </option>
                                        <c:forEach var="name" items="${sessionScope.LIST_SUBJECT}">
                                            <c:if test="${sessionScope.SUBJECT_NAME_CHOOSE eq name}">
                                                <option selected="selected" value="${name}" style="font-family: 'Patua One', cursive"> &nbsp;${name} </option>
                                            </c:if>
                                            <c:if test="${sessionScope.SUBJECT_NAME_CHOOSE ne name}">
                                                <option value="${name}" style="font-family: 'Patua One', cursive"> &nbsp;${name} </option>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty sessionScope.LIST_SUBJECT}">
                                        <option value="null" style="font-family: 'Patua One', cursive"> &nbsp;There is no subject in the system ! </option>
                                    </c:if>
                                </select> 
                                <input type="submit" value="TAKE QUIZ" style="font-size: 15px; height: 35px; background-color: #FF9933;">
                            </form>
                        </div>
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="HistoryPageController"> HISTORY </a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="SignOutController"> SIGN OUT </a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <c:if test="${not empty sessionScope.WELCOME}">
            <input type="hidden" id="welcome" value="${sessionScope.WELCOME}">
        </c:if>
        <div class="container-fluid">
            <form action="GetQuestionController" method="GET">
                <div class="row" style="margin-top: 85px">
                    <div class="col-md-2" style=" margin-top: 3px">
                        <c:if test="${not empty sessionScope.LIST_DO_QUIZ}">
                            <c:forEach var="detailQuiz" items="${sessionScope.LIST_DO_QUIZ}" varStatus="count">
                                <c:if test="${count.count % 4 == 0}">
                                    <c:if test="${count.count < 10}">
                                        <button id="submitQuiz" type="submit" name="btnAction" value="${count.count}" style="height: 40px; width: 40px; margin-left: 10px; font-family: 'Patua One', cursive; margin-bottom: 15px; border-radius: 20px">0${count.count}</button>
                                    </c:if>
                                    <c:if test="${count.count > 9}">
                                        <button id="submitQuiz" type="submit" name="btnAction" value="${count.count}" style="height: 40px; width: 40px; margin-left: 10px; font-family: 'Patua One', cursive; margin-bottom: 15px; border-radius: 20px">${count.count}</button>
                                    </c:if>
                                </c:if>
                                <c:if test="${count.count %4 != 0}">
                                    <c:if test="${count.count < 10}">
                                        <button id="submitQuiz" type="submit" name="btnAction" value="${count.count}" style="height: 40px; width: 40px; margin-left: 10px; font-family: 'Patua One', cursive; margin-bottom: 15px; border-radius: 20px">0${count.count}</button>
                                    </c:if>
                                    <c:if test="${count.count > 9}">
                                        <button id="submitQuiz" type="submit" name="btnAction" value="${count.count}" style="height: 40px; width: 40px; margin-left: 10px; font-family: 'Patua One', cursive; margin-bottom: 15px; border-radius: 20px">${count.count}</button>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>
                    <div class="col-md-10" style="font-family: 'Patua One', cursive">
                        <c:if test="${not empty requestScope.NUM_CORRECT && not empty requestScope.TOTAL}">
                            <p style="font-family: 'Patua One', cursive; font-size: 25px; color: #FF9933">You have ${requestScope.NUM_CORRECT} correct answers. You get ${requestScope.TOTAL} points.</p>
                        </c:if>
                        <c:if test="${not empty requestScope.MESS_CREATE_QUIZ}">
                            <p style="font-family: 'Patua One', cursive; font-size: 25px; color: red">${requestScope.MESS_CREATE_QUIZ}</p>
                        </c:if>
                        <!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- -->
                        <c:if test="${not empty sessionScope.SUBJECT_NAMEE}">
                            <p style="font-family: 'Patua One', cursive; font-size: 25px; color: red"><span style="color: black">YOU ARE DOING QUIZ OF SUBJECT :</span> ${sessionScope.SUBJECT_NAMEE}</p>
                        </c:if>
                        <!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- --><!-- -->
                        <c:if test="${not empty sessionScope.TAKE_QUIZ_DETAIL}">
                            <c:set var="temp" value=""></c:set>
                            <c:set var="tempQuestionID" value=""></c:set>
                            <c:if test="${not empty sessionScope.LIST_QUESTION}">
                                <c:forEach var="question" items="${sessionScope.LIST_QUESTION}">
                                    <c:if test="${question.questionID eq sessionScope.TAKE_QUIZ_DETAIL.questionID}">
                                        <p style="color: #FF9933; font-family: 'Patua One', cursive; font-size: 25px">${sessionScope.QUESTION_NUMBER}.&nbsp; ${question.questionContent}</p>
                                        <input type="hidden" name="txtQuestionDo" value="${question.questionID}">
                                        <c:set var="tempQuestionID" value="${question.questionID}"></c:set>
                                        <input type="hidden" name="txtQuestionNumber" value="${sessionScope.QUESTION_NUMBER}">
                                        <input type="hidden" name="txtNumberQuestion" value="${sessionScope.NUMBER_QUESTION}">
                                        <c:forEach var="answer" items="${sessionScope.LIST_ANSWER_QUIZ}" varStatus="counter">  
                                            <c:if test="${answer.questionID eq question.questionID}"> 
                                                <div style="display: flex">
                                                    <c:if test="${sessionScope.TAKE_QUIZ_DETAIL.ansFinal eq answer.answerID}">
                                                        <input id="checkBox${counter.count}" value="${answer.answerID}" checked="true" onclick="myFunction('checkBox' +${counter.count})" type="checkbox" name="txtChecBox" style="height: 22.5px; width: 22.5px">
                                                        <c:set var="temp" value="${answer.answerID}"></c:set>
                                                    </c:if>
                                                    <c:if test="${sessionScope.TAKE_QUIZ_DETAIL.ansFinal ne answer.answerID}">
                                                        <input id="checkBox${counter.count}" value="${answer.answerID}" onclick="myFunction('checkBox' +${counter.count})" type="checkbox" name="txtChecBox" style="height: 22.5px; width: 22.5px">
                                                    </c:if>  
                                                    <p style="font-family: 'Patua One', cursive; font-size: 15.5px">&nbsp; ${answer.answerContent} &nbsp;</p> 
                                                </div> 
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${sessionScope.QUESTION_NUMBER ne '1'}">
                                <button type="submit" style="margin-top: 5px; color: blue" name="btnAction" value="PREVIOUS">PREVIOUS</button>
                            </c:if>
                            <c:if test="${sessionScope.NUMBER_QUESTION ne sessionScope.QUESTION_NUMBER}">
                                <button type="submit" style="margin-top: 5px; color: blue" name="btnAction" value="NEXT">NEXT</button>
                            </c:if>
                            <c:if test="${not empty sessionScope.TAKE_QUIZ_DETAIL}">
                                <br>
                                <button id="buttonSubmit" name="btnAction" value="SUBMIT" type="submit" onclick="return confirm('Do you want to do submit ?')" style="background-color: #FF9933; margin-top: 30px;"><a style="font-family: 'Patua One', cursive; font-size: 20px">SUBMIT</a></button>
                            </c:if>
                            
                                <input id="m" type="hidden" value="${sessionScope.MINUTES_DO}">
                                <input id="s" type="hidden" value="${sessionScope.SECONDS_DO}">
                                <div style="margin-top: 15px">
                                    <button id="clock" style="font-family: 'Patua One', cursive; font-size: 20px; margin-top: 15px; width: 37.7%"></button>                                                          
                                </div>
                                <script>
                                    var m = 0, s = 0;
                                    m = parseInt(document.getElementById('m').value);
                                    s = parseInt(document.getElementById('s').value);
                                    var countDown = setInterval(run, 1000);
                                    function run() {
                                        if (s === -1) {
                                            m -= 1;
                                            s = 59;
                                        }
                                        var answerTemp = "";
                                        if (document.getElementById('checkBox1').checked == true) {
                                            answerTemp = document.getElementById('checkBox1').value;
                                        } else if (document.getElementById('checkBox2').checked == true) {
                                            answerTemp = document.getElementById('checkBox2').value;
                                        } else if (document.getElementById('checkBox3').checked == true) {
                                            answerTemp = document.getElementById('checkBox3').value;
                                        } else if (document.getElementById('checkBox4').checked == true) {
                                            answerTemp = document.getElementById('checkBox4').value;
                                        }
                                        if (m == 0 && s == 0) {
                                            window.location = "GetQuestionController?btnAction=SUBMIT&txtQuestionDo=${tempQuestionID}&txtChecBox=" + answerTemp;
                                            clearInterval(counDown);
                                        }
                                        document.getElementById('clock').innerHTML = m + " : " + s;
                                        s--;
                                    }
                                </script>


                            
                        </c:if>
                    </div>
                </div>
            </form>
        </div>
        <h1 style="font-size: 30px; color: red; margin-left: 17.5%; margin-top: 1.5%; font-family: 'Patua One', cursive">${requestScope.MESS_ERROR}</h1>

        <script>
            if (sessionStorage.getItem("WELCOME") == null) {
                alert(document.getElementById("welcome").value);
                sessionStorage.setItem("WELCOME", "true");
            }

            function myFunction(ID) {
                if (ID == 'checkBox1') {
                    document.getElementById('checkBox2').checked = false;
                    document.getElementById('checkBox3').checked = false;
                    document.getElementById('checkBox4').checked = false;
                } else if (ID == 'checkBox2') {
                    document.getElementById('checkBox1').checked = false;
                    document.getElementById('checkBox3').checked = false;
                    document.getElementById('checkBox4').checked = false;
                } else if (ID == 'checkBox3') {
                    document.getElementById('checkBox2').checked = false;
                    document.getElementById('checkBox1').checked = false;
                    document.getElementById('checkBox4').checked = false;
                } else if (ID == 'checkBox4') {
                    document.getElementById('checkBox2').checked = false;
                    document.getElementById('checkBox3').checked = false;
                    document.getElementById('checkBox1').checked = false;
                }
            }

            function toTimeString(seconds) {
                return (new Date(seconds * 1000)).toUTCString().match(/(\d\d:\d\d:\d\d)/)[0];
            }

            function startTimer() {
                var nextElem = $(this).parents('td').next();
                var duration = nextElem.text();
                var a = duration.split(':');
                var seconds = (+a[0]) * 60 * 60 + (+a[1]) * 60 + (+a[2]);
                setInterval(function () {
                    seconds--;
                    if (seconds >= 0) {
                        nextElem.html(toTimeString(seconds));
                    }
                    if (seconds <= 20) {
                        nextElem.css('color', 'red');
                    }
                    if (seconds === 0) {
                        document.getElementById('submitQuiz').click();
                        clearInterval(seconds);
                    }
                }, 1000);
            }
            $('#time').on('click', startTimer);

            jQuery(function () {
                jQuery('#time').click();
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
