<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Edit Your Menu</title>
</head>
<body>
	<h1>Edit Your Menu, <a href="/restaurantDashboard">${restaurant.name}</a></h1>
	<c:if test = "${ restaurant.profile == null }">
		<img class="avatar-thumb" src="/img/restaurant.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ restaurant.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
	</c:if>
	<c:forEach var="item" items="${items}">
		<div class="one-edit-item">
			<p><c:out value="${item.name}"/></p>
			<c:if test = "${ item.file == null }">
				<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
			</c:if>
			<c:if test = "${ item.file != null }">
				<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>			
			</c:if>
			<a href="/items/item/edit/${item.id}"><button>Modify</button></a>
			<a href="/items/item/delete/${item.id}"><button>Delete</button></a>		
		</div>
	</c:forEach>
	<a href="/items/add"><button>Add New Item</button></a>
</body>
</html>