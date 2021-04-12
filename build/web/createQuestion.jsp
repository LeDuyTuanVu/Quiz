<%-- 
    Document   : createQuestion
    Created on : Jan 25, 2021, 10:20:22 PM
    Author     : Le Duy Tuan Vu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CREATE QUESTION</title>
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
            .container fieldset .checkBox{
                height: 45px;
                width: 45px;
                margin-top: -1.5px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-dark navbar-expand-lg fixed-top bg-light" id="mainNav" style="margin-left: 7px; margin-right: 7px">
            <div class="container-fluid"><a class="navbar-brand" href="#home" style="font-family: 'Patua One', cursive; color: #FF9933; font-size: 28px;"> FPT UNIVERSITY </a><button data-toggle="collapse" data-target="#navbarResponsive" class="navbar-toggler navbar-toggler-right" type="button" data-toogle="collapse" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><i class="fas fa-bars"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="nav navbar-nav ml-auto text-uppercase" style="margin-left: auto; font-family: 'Patua One', cursive; font-size: 19px">
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="AllQuestionController"> ALL QUESTION </a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="SignOutController"> SIGN OUT </a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6" style="margin-top: 100px">
                    <div class="panel panel-default" >
                        <div class="panel-heading"><h3 class="panel-title" style="font-family: 'Patua One', cursive; color: #333333; font-size: 28px; text-align: center ">ENTER INFORMATION OF QUESTION</h3></div>
                        <div class="panel-body" style="margin-top: 30px">
                            <fieldset style="">
                                <form action="CreateQuestionController">
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Enter question" value="${sessionScope.QUESTION}" name="txtQuestion" type="text" style="margin-bottom: 28px; height: 42px; font-family: 'Patua One', cursive">
                                    </div>
                                    <c:if test="${not empty requestScope.MESS_QUESTION}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -23px; margin-bottom: 18px; margin-left: 3px">${requestScope.MESS_QUESTION}</p>
                                    </c:if>

                                    <div class="form-group" style="margin-top: -12px; display: flex">
                                        <input class="form-control" placeholder="Enter answer 1" value="${sessionScope.ANSWER1}" name="txtAnswer1" type="text" value="" style="margin-bottom: 37px; height: 42px; font-family: 'Patua One', cursive">
                                        <c:if test="${sessionScope.CHECK_BOX eq '1'}">
                                            <input class="checkBox" id="checkBox1" type="checkbox" value="1" onclick="myFunction('checkBox1')" name="checkBox" checked="true">
                                        </c:if>
                                        <c:if test="${sessionScope.CHECK_BOX ne '1'}">
                                            <input class="checkBox" id="checkBox1" type="checkbox" value="1" onclick="myFunction('checkBox1')" name="checkBox">
                                        </c:if>

                                    </div> 
                                    <c:if test="${not empty requestScope.MESS_ANSWER1}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -33px; margin-bottom: 25px; margin-left: 3px">${requestScope.MESS_ANSWER1}</p>
                                    </c:if>

                                    <div class="form-group" style="margin-top: -20px; display: flex">
                                        <input class="form-control" placeholder="Enter answer 2" value="${sessionScope.ANSWER2}" name="txtAnswer2" type="text" value="" style="margin-bottom: 37px; height: 42px; font-family: 'Patua One', cursive">
                                        <c:if test="${sessionScope.CHECK_BOX eq '2'}">
                                            <input class="checkBox" id="checkBox2" type="checkbox" value="2" onclick="myFunction('checkBox2')" name="checkBox" checked="true">
                                        </c:if>
                                        <c:if test="${sessionScope.CHECK_BOX ne '2'}">
                                            <input class="checkBox" id="checkBox2" type="checkbox" value="2" onclick="myFunction('checkBox2')" name="checkBox">
                                        </c:if>
                                    </div> 
                                    <c:if test="${not empty requestScope.MESS_ANSWER2}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -33px; margin-bottom: 25px; margin-left: 3px">${requestScope.MESS_ANSWER2}</p>
                                    </c:if>

                                    <div class="form-group" style="margin-top: -20px; display: flex">
                                        <input class="form-control" placeholder="Enter answer 3" value="${sessionScope.ANWERS3}" name="txtAnswer3" type="text" value="" style="margin-bottom: 37px; height: 42px; font-family: 'Patua One', cursive">
                                        <c:if test="${sessionScope.CHECK_BOX eq '3'}">
                                            <input class="checkBox" id="checkBox3" type="checkbox" value="3" onclick="myFunction('checkBox3')" name="checkBox" checked="true">
                                        </c:if>
                                        <c:if test="${sessionScope.CHECK_BOX ne '3'}">
                                            <input class="checkBox" id="checkBox3" type="checkbox" value="3" onclick="myFunction('checkBox3')" name="checkBox">
                                        </c:if>
                                    </div> 
                                    <c:if test="${not empty requestScope.MESS_ANSWER3}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -33px; margin-bottom: 25px; margin-left: 3px">${requestScope.MESS_ANSWER3}</p>
                                    </c:if>

                                    <div class="form-group" style="margin-top: -20px; display: flex">
                                        <input class="form-control" placeholder="Enter answer 4" value="${sessionScope.ANSWER4}" name="txtAnswer4" type="text" value="" style="margin-bottom: 37px; height: 42px; font-family: 'Patua One', cursive">
                                        <c:if test="${sessionScope.CHECK_BOX eq '4'}">
                                            <input class="checkBox" id="checkBox4" type="checkbox" value="4" onclick="myFunction('checkBox4')" name="checkBox" checked="true">
                                        </c:if>
                                        <c:if test="${sessionScope.CHECK_BOX ne '4'}">
                                            <input class="checkBox" id="checkBox4" type="checkbox" value="4" onclick="myFunction('checkBox4')" name="checkBox">
                                        </c:if>
                                    </div>
                                    <c:if test="${not empty requestScope.MESS_ANSWER4}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -33px; margin-bottom: 27px; margin-left: 3px">${requestScope.MESS_ANSWER4}</p>
                                    </c:if>                                 
                                    <div style="margin-top: -20px">
                                        <select style="border-radius: 4px; font-size: 15px; margin-left: 1.5px; width: auto; font-family: 'Patua One', cursive; height: 40px;" name="comboxSubject">
                                            <c:if test="${not empty sessionScope.LIST_SUBJECT}">
                                                <option value="empty" style="font-family: 'Patua One', cursive">Choose subject of this question</option>
                                                <c:forEach var="name" items="${sessionScope.LIST_SUBJECT}">
                                                    <c:if test="${name eq sessionScope.SUBJECT}">
                                                        <option value="${name}" selected="selected" style="font-family: 'Patua One', cursive">${name}</option>
                                                    </c:if>
                                                    <c:if test="${name ne sessionScope.SUBJECT}">
                                                        <option value="${name}" style="font-family: 'Patua One', cursive">${name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty sessionScope.LIST_SUBJECT}">
                                                <option value="null" style="font-family: 'Patua One', cursive">There is no subject in the system !</option>
                                            </c:if>
                                        </select>
                                    </div>
                                    <c:if test="${not empty requestScope.MESS_SUBJECT}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: 5px; margin-bottom: -13px; margin-left: 3px">${requestScope.MESS_SUBJECT}</p>
                                    </c:if>
                                    <div style="margin-top: 20px;">
                                        <input class="btn btn-lg btn btn-block" type="submit" value="CREATE" style="font-family: 'Patua One', cursive; color: #333333; background-color: orange">
                                    </div>
                                    <c:if test="${not empty requestScope.MESS_CHECK_BOX}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: 7px; margin-left: 3px">${requestScope.MESS_CHECK_BOX}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.MESS_CREATE_QUESTION}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: 8px; margin-left: 3px; font-size: 25px">${requestScope.MESS_CREATE_QUESTION}</p>
                                    </c:if>
                                </form>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div> 
        <script>
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
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
