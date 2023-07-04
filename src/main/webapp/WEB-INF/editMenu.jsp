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
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Heebo&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/media.css">
<meta charset="ISO-8859-1">
<title>Edit Your Menu</title>
</head>
<body>
	<div class="container">
	<h1>Edit Your Menu, <a href="/restaurantDashboard">${restaurant.name}</a></h1>
	
	<div class="profile-div">
		<c:if test = "${ restaurant.profile == null }">
			<img class="avatar-thumb" src="/img/restaurant.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ restaurant.profile != null }">
			<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
		</c:if>
	</div>
	
	<div class="nav-buttons">
		<a href="/restaurantDashboard"><button class="button-small"><p>Home</p></button></a>
		<a href="/restaurants/edit"><button class="button-small marked"><p>Edit</p></button></a>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>
	
	<div class="all-items-edit">
		<c:forEach var="item" items="${items}">
			<div class="one-edit-item">
				<div>
					<a href="/items/${item.id}"><h4><c:out value="${item.name}"/></h4>			
				</div>
				<div class="item-picture">
					<c:if test = "${ item.file == null }">
						<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
					</c:if>
					<c:if test = "${ item.file != null }">
						<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>			
					</c:if></a>
				</div>
				<div class="padding">
					<a href="/items/item/edit/${item.id}"><button class="button-small"><p>Modify</p></button></a>
					<a href="/items/changepicture/${item.id}"><button class="button-small"><p>Picture</p></button></a>
					<a href="/items/item/delete/${item.id}"><button class="button-danger"><p>Delete</p></button></a>		
				</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="padding">
		<a href="/items/add"><button class="button-medium warning"><p>Add New Item</p></button></a>
	</div>
	</div>
</body>
</html>