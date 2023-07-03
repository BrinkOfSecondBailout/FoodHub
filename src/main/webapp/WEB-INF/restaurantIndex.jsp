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
<meta charset="ISO-8859-1">
<title>Welcome to FoodHub</title>
</head>
<body>
	<div class="container">
	<h1>Welcome to <u>FoodHub</u>!</h1>
	<div class="registration-form">
		<h2>Register as Restaurant</h2>
		<form:form action="/registerRestaurant" method="post" modelAttribute="newRestaurant" >
			<form:label path="name"><p>Restaurant Name:</p></form:label>
			<div>
			<form:errors path="name" class="error-message"/>
			</div>
			<form:input path="name" class="form-field"/><br><br>
			<form:label  path="email"><p>Restaurant Email:</p></form:label>
			<div>
			<form:errors path="email" class="error-message"/>
			</div>
			<form:input  type="email" path="email" class="form-field"/><br><br>
			<form:label  path="password"><p>Password:</p></form:label>
			<div>
			<form:errors path="password" class="error-message"/>
			</div>
			<form:input  type="password" path="password" class="form-field"/><br><br>
			<form:label path="confirmPw"><p>Confirm PW:</p></form:label>
			<div>
			<form:errors path="confirmPw" class="error-message"/>
			</div>
			<form:input  type="password" path="confirmPw" class="form-field"/><br><br>
			<button class="button-small">Submit</button>
		</form:form>
	</div>
	
	<div class="login-form">
		<h2>Log in as Restaurant</h2>
		<form:form action="/loginRestaurant" method="post" modelAttribute="newLoginRestaurant">
			<form:label path="email"><p>Restaurant Email:</p></form:label>
			<div>
			<form:errors path="email" class="error-message"/>
			</div>
			<form:input type="email" path="email" class="form-field"/><br><br>
			<form:label  path="password"><p>Password:</p></form:label>
			<div>
			<form:errors path="password" class="error-message"/>
			</div>
			<form:input type="password" path="password" class="form-field"/><br><br>
			<button class="button-small">Submit</button>
		</form:form>
	</div>
	
	<h3>Not a restaurant? Log in as <a href="/">user</a></h3>
	</div>
</body>
</html>