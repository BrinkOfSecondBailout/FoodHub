<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<title>Restaurant Dashboard</title>
</head>
<body>
	<h1>Welcome, <a href="/restaurants/edit">${restaurant.name}!</h1></a>
	<h2>Your Menu</h2>
	<div class="my-items">
		<c:forEach var="item" items="${items}">
			<div class="one-item">
				<a href="/items/${item.id}"><p><c:out value="${item.name}"/></p>
				<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/></a>		
			</div>
		</c:forEach>	
	</div>
	<a href="/items/edit/${restaurant.id}"><button>Edit Your Menu</button></a>
	<h2>All Hungry Users</h2>
	<c:forEach var="user" items="${users}">
		<a href="/users/${user.id}"><p><c:out value="${user.first_name} ${user.last_name}"/></p></a>
	</c:forEach>
	<a href="/logoutRestaurant"><button>Logout</button></a>
</body>
</html>