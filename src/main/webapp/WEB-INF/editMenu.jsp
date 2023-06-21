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
<title>Edit Your Menu</title>
</head>
<body>
	<h1>Edit Your Menu, <a href="/restaurantDashboard">${restaurant.name}</a></h1>
	<c:forEach var="item" items="${items}">
		<div class="one-edit-item">
			<p><c:out value="${item.name}"/></p>
			<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
			<a href=""><button>Modify</button></a>
			<a href=""><button>Delete</button></a>		
		</div>
	</c:forEach>
	<a href="/items/add"><button>Add New Item</button></a>
</body>
</html>