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
<meta charset="ISO-8859-1">
<title>Item Display</title>
</head>
<body>
	<div class="container">
	<h1>Welcome to <u>FoodHub</u>!</h1>
	<c:if test="${user != null}">
	
		<a href="/users/${user.id}"><h3>${user.first_name} ${user.last_name}</h3></a>
	
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
				<img src="/img/bag.png" class="bag-icon border-marked" alt="Shopping Bag"/>
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
			<a href="/dashboard"><button class="button-small"><p>Home</p></button></a>
			<a href="/users/edit"><button class="button-small"><p>Edit</p></button></a>
			<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
		</div>
	
	</c:if>
		
	<c:if test="${restaurant != null }">
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
			<a href="/restaurantDashboard"><button class="button-small"><p>Home</p></button></a>
			<a href="/restaurants/edit"><button class="button-small"><p>Edit</p></button></a>
			<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
		</div>
	</c:if>

	<h2>${item.name}</h2>
	<h3>From <a href="/restaurants/${item.restaurant.id}">${item.restaurant.name }</a></h3>
	<h3>$${item.price}</h3>
	<u><h4>${item.category}</h4></u>
	
	<div class="padding">
		<c:if test = "${ item.file == null }">
			<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb-display"/>
		</c:if>
		<c:if test = "${ item.file != null }">
			<img src="data:image/jpg;base64,${item.file}" class="item-thumb-display"/>
		</c:if>
	</div>
	
	<p>${item.description}</p>
	
	<div class="padding">
		<c:if test="${item.restaurant.id == restaurantId}">
			<a href="/items/item/edit/${item.id}"><button class="button-small"><p>Modify</p></button></a>
			<a href="/items/changepicture/${item.id}"><button class="button-small"><p>Picture</p></button></a>
			<a href="/items/item/delete/${item.id}"><button class="button-danger"><p>Delete</p></button></a>
		</c:if>	
	</div>
	
	<a href="javascript:history.back()"><h4>Go Back</h4></a>
	</div>
</body>
</html>