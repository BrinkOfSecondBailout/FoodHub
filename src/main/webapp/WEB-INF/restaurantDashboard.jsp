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
	
	<div>
	<a href="/logout"><button>Logout</button></a>
	</div>
	
	<c:if test = "${ restaurant.profile == null }">
		<img class="avatar-thumb" src="/img/restaurant.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ restaurant.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
	</c:if>
	<h2>Your Menu</h2>
	<div class="my-items">
		<c:forEach var="item" items="${items}">
			<div class="one-item">
				<a href="/items/${item.id}"><p><c:out value="${item.name}"/></p>
				<c:if test = "${ item.file == null }">
					<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
				</c:if>
				<c:if test = "${ item.file != null }">
					<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>					
				</c:if></a>
			</div>
		</c:forEach>	
	</div>
	<a href="/items/edit/${restaurant.id}"><button>Edit Your Menu</button></a>
	
	<h2>All Other Restaurants</h2>
	<div class="all-restaurants">
		<c:forEach var="restaurant" items="${restaurants}">
			<div class="one-item">
				<a href="/restaurants/${restaurant.id}"><p><c:out value="${restaurant.name}"/></p>
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
	<div class="all-users">
		<c:forEach var="user" items="${users}">
			<div class="one-item">
				<a href="/users/${user.id}"><p><c:out value="${user.first_name} ${user.last_name}"/></p>
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
</body>
</html>