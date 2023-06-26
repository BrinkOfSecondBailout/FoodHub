<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Eater Display</title>
</head>
<body>
	<h1>${user.first_name} ${user.last_name}</h1>
	<c:if test = "${ user.profile == null }">
		<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ user.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
	</c:if></a>
	
	<h2>All Reviews</h2>
	<c:forEach var="review" items="${user.reviews}">
		<p>${review.restaurant.name}</p>
		<c:if test="${ review.restaurant.profile == null}">
			<img src="/img/restaurant.png" alt="No Profile" class="avatar-thumb-sm"/>
		</c:if>
	</c:forEach>
</body>
</html>