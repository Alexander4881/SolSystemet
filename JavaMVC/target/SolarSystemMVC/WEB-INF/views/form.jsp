<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<body>
<form:form modelAttribute="user" action="user">
    <form:input path="name"/>
    <form:errors path="name"/>
    <br>
    <form:input path="age"/>
    <form:errors path="age"/>
    <br>
    <input type="submit" value="submit">
</form:form>
</body>
</html>