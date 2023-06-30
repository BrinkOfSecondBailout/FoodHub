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
<title>User Dashboard</title>
</head>
<body>
	<h1>Welcome, <a href="/users/${user.id}">${user.first_name}!</h1></a>
	
	<div class="profile-div">
		<c:if test = "${ user.profile == null }">
			<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ user.profile != null }">
			<img class="avatar-thumb" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
		</c:if>
	</div>
	
	<div class="bag-div">
		<a href="/bags/show/${user.bag.id}">
			<img src="/img/bag.png" class="bag-icon" alt="Shopping Bag"/>
		</a>
	</div>
	
	<div class="bag-notification">
		<c:if test="${user.bag.orders.size() == 0}">
			<p>0</p>
		</c:if>
		<c:if test="${user.bag.orders.size() != 0}">
			<p>${user.bag.orders.size()}</p>
		</c:if>
	</div>
	
	
	<div class="nav-buttons">
		<button class="button-small marked"><p>Home</p></button>
		<a href="/users/edit"><button class="button-small"><p>Edit</p></button></a>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>
	
	
	<h3>All Delicious Restaurants</h3>
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
	<h3>All Hungry Eaters</h3>
	<div class="all-users">
		<c:forEach var="user" items="${users}">
			<div class="one-item">
				<a href="/users/${user.id}"><h4><c:out value="${user.first_name} ${user.last_name}"/></h4>
				<c:if test = "${ user.profile == null }">
					<img class="avatar-thumb-sm" src="/img/avatar-icon.png" alt="No Profile Pic"/>
				</c:if>
				<c:if test = "${ user.profile != null }">
					<img class="avatar-thumb-sm" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
				</c:if></a>
			</div>
		</c:forEach>
	</div>
</body>
</html>