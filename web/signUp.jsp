<%-- 
    Document   : signUp
    Created on : Jan 24, 2021, 4:07:44 PM
    Author     : Le Duy Tuan Vu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SIGN UP</title>
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
                        <li class="nav-item" role="presentation"><a class="nav-link js-scroll-trigger" href="SignInPageController"> SIGN IN </a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6" style="margin-top: 160px">
                    <div class="panel panel-default" >
                        <div class="panel-heading"><h3 class="panel-title" style="font-family: 'Patua One', cursive; color: #333333; font-size: 28px; text-align: center ">ENTER YOUR INFORMATION</h3></div>
                        <div class="panel-body" style="margin-top: 30px">
                            <form action="SignUpController" method="POST">
                                <fieldset style="">
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Enter email" value="${sessionScope.EMAIL_SIGN_UP}" name="txtEmail" type="text" style="margin-bottom: 17px; height: 42px; font-family: 'Patua One', cursive">
                                    </div>
                                    <c:if test="${not empty requestScope.MESS_EMAIL_SIGN_UP}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -11px; margin-bottom: 6px">${requestScope.MESS_EMAIL_SIGN_UP}</p>
                                    </c:if>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Enter full name" value="${sessionScope.NAME_SIGN_UP}" name="txtFullName" type="text" style="margin-bottom: 28px; height: 42px; font-family: 'Patua One', cursive">
                                    </div>
                                    <c:if test="${not empty requestScope.MESS_NAME_SIGN_UP}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -22px; margin-bottom: 19px">${requestScope.MESS_NAME_SIGN_UP}</p>
                                    </c:if>
                                    <div class="form-group" style="margin-top: -12px">
                                        <input class="form-control" placeholder="Enter password" value="${sessionScope.PASS_SIGN_UP}" name="txtPassword" type="password" value="" style="margin-bottom: 37px; height: 42px; font-family: 'Patua One', cursive">
                                    </div> 
                                    <c:if test="${not empty requestScope.MESS_PASS_SIGN_UP}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -31px; margin-bottom: 27px">${requestScope.MESS_PASS_SIGN_UP}</p>
                                    </c:if>
                                    <div class="form-group" style="margin-top: -20px">
                                        <input class="form-control" placeholder="Re-enter password" value="${sessionScope.REPASS_SIGN_UP}" name="txtRePassword" type="password" value="" style="margin-bottom: 37px; height: 42px; font-family: 'Patua One', cursive">
                                    </div> 
                                    <c:if test="${not empty requestScope.MESS_REPASS_SIGN_UP}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -31px; margin-bottom: 35px">${requestScope.MESS_REPASS_SIGN_UP}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.MESS_SIGN_UP}">
                                        <p style="font-family: 'Patua One', cursive; color: red; margin-top: -31px; margin-bottom: 19px">${requestScope.MESS_SIGN_UP}</p>
                                    </c:if>
                                    <div style="margin-top: -10px">
                                        <input class="btn btn-lg btn btn-block" type="submit" value="SIGN UP" style="font-family: 'Patua One', cursive; color: #333333; background-color: orange">
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div> 	
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
