    <%--
      Created by IntelliJ IDEA.
      User: User
      Date: 15-08-2019
      Time: 13:28
      To change this template use File | Settings | File Templates.
    --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
        <title>Planets and moons</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<c:url value="/resources/css/Bootstrap4/bootstrap.min.css"/>" >
        <link rel="stylesheet" href="<c:url value="/resources/css/customCSS.css"/>" >
            <script src="<c:url value="/resources/javascript/jquery-3.4.1.js"/>" rel="script" type="text/javascript"></script>
            <script src="<c:url value="/resources/javascript/bootstrap.bundle.min.js"/>" rel="script" type="text/javascript"></script>
        </head>
        <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                                <a class="nav-link" href="#">Planets<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                                <a class="nav-link" href="${contextPath}/SolarSystemMVC_war/">Planet Information</a>
                        </li>
                        <li class="nav-item">
                                <a class="nav-link" href="${contextPath}/SolarSystemMVC_war/rocketbuild">Build A Rocket</a>
                        </li>
                </ul>
        </div>
        </nav>