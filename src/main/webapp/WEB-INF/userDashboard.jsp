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
<title>User Dashboard</title>
</head>
<body>
	<h1>Welcome, <a href="/users/edit">${user.first_name}!</h1></a>
	
	<div>
	<a href="/logout"><button>Logout</button></a>
	</div>
	
	<c:if test = "${ user.profile == null }">
		<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ user.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
	</c:if>
	<h2>All Delicious Restaurants</h2>
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
				</c:if></a>
			</div>
		</c:forEach>
	</div>
	<a href="/logout"><button>Logout</button></a>
</body>
</html>