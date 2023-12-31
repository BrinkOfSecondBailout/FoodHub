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
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/media.css">
<title>Restaurant Dashboard</title>
</head>
<body>
	<div class="container">
	<h1>Welcome to <u>FoodHub</u>!</h1>
 	<a href="/restaurants/${restaurant.id}"><h3>${restaurant.name}</h3></a>
	<div class="profile-div">
		<c:if test = "${ restaurant.profile == null }">
			<img class="avatar-thumb" src="/img/restaurant.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ restaurant.profile != null }">
			<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
		</c:if>
	</div>
	
	<div class="nav-buttons">
		<button class="button-small marked"><p>Home</p></button>
		<a href="/restaurants/edit"><button class="button-small"><p>Edit</p></button></a>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>
	
	
	<h2>Your Menu</h2>
	<c:if test="${items.size() == 0}">
		<p>No menu yet, start adding!</p>
	</c:if>
	<div class="my-items">
		<c:forEach var="item" items="${items}">
			<div class="one-item">
				<a href="/items/${item.id}"><h4><c:out value="${item.name}"/></h4>
				<c:if test = "${ item.file == null }">
					<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
				</c:if>
				<c:if test = "${ item.file != null }">
					<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>					
				</c:if></a>
			</div>
		</c:forEach>	
	</div>
	
	<div class="padding">
		<a href="/items/edit/${restaurant.id}"><button class="button-long"><p>Edit Your Menu</p></button></a>
	</div>
	
	<h2>All Other Restaurants</h2>
	<c:if test="${restaurants.size() == 0}">
		<p>None yet, tell your friends about Foodhub!</p> 
	</c:if>
	<div class="all-restaurants">
		<c:forEach var="restaurant" items="${restaurants}">
			<div class="one-item">
				<a href="/restaurants/${restaurant.id}"><h4><c:out value="${restaurant.name}"/></h4>
				<c:if test = "${ restaurant.profile == null }">
					<img class="avatar-thumb-sm" src="/img/restaurant.png" alt="No Profile Pic"/>
				</c:if>
				<c:if test = "${ restaurant.profile != null }">
					<img class="avatar-thumb-sm" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
				</c:if>
				</a>
			</div>
		</c:forEach>	
	</div>
	
	<h2>All Hungry Eaters</h2>
	<c:if test="${users.size() == 0}">
		<p>None yet, tell your friends about Foodhub!</p> 
	</c:if>
	<div class="all-users">
		<c:forEach var="user" items="${users}">
			<div class="one-item">
				<a href="/users/${user.id}"><h4><c:out value="${user.first_name} ${user.last_name}"/></h4>
				<c:if test = "${ user.profile == null }">
					<img class="avatar-thumb-sm" src="/img/avatar-icon.png" alt="No Profile Pic"/>
				</c:if>
				<c:if test = "${ user.profile != null }">
					<img class="avatar-thumb-sm" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
				</c:if>
				</a>
			</div>
		</c:forEach>	
	</div>
	</div>
</body>
</html>