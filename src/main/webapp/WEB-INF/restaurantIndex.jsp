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
	<div class="registration-form">
		<h1>Register as Restaurant</h1>
		<form:form action="/registerRestaurant" method="post" modelAttribute="newRestaurant" >
			<form:label class="form-label" path="restaurantName">Restaurant Name:</form:label>
			<form:errors path="restaurantName"/>
			<form:input class="form-control-sm" path="restaurantName"/><br><br>
			<form:label class="form-label" path="restaurantEmail">Restaurant Email:</form:label>
			<form:errors path="restaurantEmail"/>
			<form:input class="form-control-sm" type="email" path="restaurantEmail"/><br><br>
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
		<h1>Log in as Restaurant</h1>
		<form:form action="/loginRestaurant" method="post" modelAttribute="newLoginRestaurant">
			<form:label class="form-label" path="restaurantEmail">Restaurant Email:</form:label>
			<form:errors path="restaurantEmail"/>
			<form:input class="form-control-sm" type="email" path="restaurantEmail"/><br><br>
			<form:label class="form-label" path="password">Password:</form:label>
			<form:errors path="password"/>
			<form:input class="form-control-sm" type="password" path="password"/><br><br>
			<input type="submit" value="Submit"/>
		</form:form>
	</div>
	
	<h2>Not a restaurant? Log in as <a href="/">user</a></h2>
</body>
</html>