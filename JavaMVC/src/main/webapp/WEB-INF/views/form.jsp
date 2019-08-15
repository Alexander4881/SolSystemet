<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@include file="layout/header.jsp"%>

<form:form modelAttribute="user" action="user">
    <form:input path="name"/>
    <form:errors path="name"/>
    <br>
    <form:input path="age"/>
    <form:errors path="age"/>
    <br>
    <input type="submit" value="submit">
</form:form>

<%@include file="layout/fotter.jsp"%>