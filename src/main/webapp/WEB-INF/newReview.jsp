<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>New Review</title>
</head>
<body>
	<h1>Write a Review</h1>
	<h2>for <a href="/restaurants/${restaurant.id}">${restaurant.name}</a></h2>
	<c:if test = "${ restaurant.profile == null }">
		<img class="avatar-thumb" src="/img/avatar-icon-2.jpg" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ restaurant.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
	</c:if>
	
	<form:form action="/reviews/add/${restaurant.id}" method="post" modelAttribute="review">
		<form:label path="review_text">How was your experience?</form:label><br>
		<form:errors path="review_text"/>
		<form:input type="textarea" path="review_text" class="review-text-area"/><br><br>
		
		<form:label path="stars">How many stars would you give ${restaurant.name}?</form:label><br>
		
		<form:radiobutton path="stars" value="1"/>
		<form:radiobutton path="stars" value="2"/>
		<form:radiobutton path="stars" value="3"/>
		<form:radiobutton path="stars" value="4"/>
		<form:radiobutton path="stars" value="5"/><br>
		
		<input type="submit" value="Submit"/>
	</form:form>
</body>
</html>