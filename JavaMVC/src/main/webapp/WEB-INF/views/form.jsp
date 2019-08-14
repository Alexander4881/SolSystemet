<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <style>
        .error{color:red}
    </style>
</head>
<body>
<form:form action="/userform" modelAttribute="per">
    Username(*): <form:input path="name"/> <br><br>
    <form:errors path="name" title="The name has to be min 2 and not longer than 20" cssClass="error"/><br><br>
    Age(*): <form:input path="age"/>
    <form:errors path="age" title="The age has to be min 2 and not longer than 20" cssClass="error"/><br><br>
    <input type="submit" value="submit">
</form:form>
</body>
</html>