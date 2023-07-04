<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Heebo&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/media.css">
<meta charset="ISO-8859-1">
<title>Welcome to FoodHub</title>
</head>
<body>
	<div class="container">
	<h1>Welcome to <u>FoodHub</u>!</h1>
	<div class="registration-form">
		<h2>Register as User</h2>
		<form:form action="/register" method="post" modelAttribute="newUser" >
			<form:label path="first_name"><p>First Name:</p></form:label>
			<div>
			<form:errors path="first_name" class="error-message"/>
			</div>
			<form:input path="first_name" class="form-field"/><br><br>
			<form:label  path="last_name"><p>Last Name:</p></form:label>
			<div>
			<form:errors path="last_name" class="error-message"/>
			</div>
			<form:input  path="last_name" class="form-field"/><br><br>
			<form:label  path="email"><p>Email:</p></form:label>
			<div>
			<form:errors path="email" class="error-message"/>
			</div>
			<form:input  type="email" path="email" class="form-field"/><br><br>
			<form:label path="password"><p>Password:</p></form:label>
			<div>
			<form:errors path="password" class="error-message"/>
			</div>
			<form:input type="password" path="password" class="form-field"/><br><br>
			<form:label  path="confirmPw"><p>Confirm PW:</p></form:label>
			<div>
			<form:errors path="confirmPw" class="error-message"/>
			</div>
			<form:input type="password" path="confirmPw" class="form-field"/><br><br>
			<button class="button-small">Submit</button>
		</form:form>
	</div>
	
	<div class="login-form">
		<h2>Log in as User</h2>
		<form:form action="/login" method="post" modelAttribute="newLogin">
			<form:label path="email"><p>Email:</p></form:label>
			<div>
			<form:errors path="email" class="error-message"/>
			</div>
			<form:input  type="email" path="email" class="form-field"/><br><br>
			<form:label  path="password"><p>Password:</p></form:label>
			<div>
			<form:errors path="password" class="error-message"/>
			</div>
			<form:input type="password" path="password" class="form-field"/><br><br>
			<button class="button-small">Submit</button>
		</form:form>
	</div>
	
	<h3>Not a user? Log in as <a href="/restaurant">restaurant</a></h3>
	</div>
</body>
</html>