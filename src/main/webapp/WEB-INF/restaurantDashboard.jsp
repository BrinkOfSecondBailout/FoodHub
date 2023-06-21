<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Restaurant Dashboard</title>
</head>
<body>
	<h1>Welcome, <a href="/restaurants/edit">${restaurant.name}!</h1></a>
	<h2>Your Menu</h2>
	<c:forEach var="item" items="${items}">
		<p><c:out value="${item.name}"/></p>
		<img src="*{'data:image/jpeg;base64, '+{item.file}}"/>
	</c:forEach>
	<h2>All Hungry Users</h2>
	<c:forEach var="user" items="${users}">
		<a href="/users/${user.id}"><p><c:out value="${user.first_name} ${user.last_name}"/></p></a>
	</c:forEach>
	<a href="/logoutRestaurant"><button>Logout</button></a>
</body>
</html>