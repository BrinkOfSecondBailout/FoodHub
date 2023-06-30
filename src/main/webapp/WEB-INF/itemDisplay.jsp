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
<title>Item Display</title>
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

	<h1>${item.name}</h1>
	<h4>${item.category}</h4>
	<c:if test = "${ item.file == null }">
		<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb-display"/>
	</c:if>
	<c:if test = "${ item.file != null }">
		<img src="data:image/jpg;base64,${item.file}" class="item-thumb-display"/>
	</c:if>
	<p>${item.description}</p>
	<p>$${item.price}</p>
	<c:if test="${item.restaurant.id == restaurantId}">
		<a href="/items/item/edit/${item.id}"><button>Modify</button></a>
		<a href="/items/item/delete/${item.id}"><button>Delete</button></a>
	</c:if>
</body>
</html>