<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to FoodHub</title>
</head>
<body>
	<div class="login-form">
		<h1 class="display-4 text-center">Register</h1>
		<form:form action="/register" method="post" modelAttribute="newUser" >
			<form:label class="form-label" path="name">Name:</form:label>
			<form:errors path="name"/>
			<form:input class="form-control-sm" path="name"/><br><br>
			<form:label class="form-label" path="email">Email:</form:label>
			<form:errors path="email"/>
			<form:input class="form-control-sm" type="email" path="email"/><br><br>
			<form:label class="form-label" path="password">Password:</form:label>
			<form:errors path="password"/>
			<form:input class="form-control-sm" type="password" path="password"/><br><br>
			<form:label class="form-label" path="confirmPw">Confirm PW:</form:label>
			<form:errors path="confirmPw"/>
			<form:input class="form-control-sm" type="password" path="confirmPw"/><br><br>
			<input type="submit" value="Submit"/>
		</form:form>
	</div>
	
	<div class="login-form">
		<h1 class="display-4 text-center">Log in</h1>
		<form:form action="/login" method="post" modelAttribute="newLogin">
			<form:label class="form-label" path="email">Email:</form:label>
			<form:errors path="email"/>
			<form:input class="form-control-sm" type="email" path="email"/><br><br>
			<form:label class="form-label" path="password">Password:</form:label>
			<form:errors path="password"/>
			<form:input class="form-control-sm" type="password" path="password"/><br><br>
			<input type="submit" value="Submit"/>
		</form:form>
	</div>
</body>
</html>