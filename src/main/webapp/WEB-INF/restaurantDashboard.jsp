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
	<h1>Welcome, <a href="/restaurants/${restaurant.id}">${restaurant.name}!</h1></a>
	<h2>All Hungry Users</h2>
	<c:forEach var="user" items="${users}">
		<a href="/users/${user.id}"><p><c:out value="${user.first_name} ${user.last_name}"/></p></a>
	</c:forEach>
</body>
</html>