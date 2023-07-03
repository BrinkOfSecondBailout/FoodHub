<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Heebo&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="https://use.fontawesome.com/10c872287a.js"></script>

<meta charset="ISO-8859-1">
<title>New Review</title>
</head>
<body>
	<div class="container">
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
	
	
	<h2>Write a Review</h2>
	<h3>for <a href="/restaurants/${restaurant.id}">${restaurant.name}</h3>
	<c:if test = "${ restaurant.profile == null }">
		<img class="avatar-thumb-med" src="/img/restaurant.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ restaurant.profile != null }">
		<img class="avatar-thumb-med" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
	</c:if></a>
	
	<div class="review-form">
		<form:form action="/reviews/add/${restaurant.id}" method="post" modelAttribute="review">
			<div>
				<form:errors path="review_text" class="error-message"/>			
			</div>
			<form:input type="textarea" path="review_text" class="review-text-area" />
		
			<h4>How many stars for <a href="/restaurants/${restaurant.id}">${restaurant.name}?</a></h4><br><br>
		
			<div class="ratings">
				<form:radiobutton path="stars" value="5" id="star5"/><form:label path="stars" for="star5"/>
				<form:radiobutton path="stars" value="4" id="star4"/><form:label path="stars" for="star4"/>
				<form:radiobutton path="stars" value="3" id="star3"/><form:label path="stars" for="star3"/>
				<form:radiobutton path="stars" value="2" id="star2"/><form:label path="stars" for="star2"/>
				<form:radiobutton path="stars" value="1" id="star1"/><form:label path="stars" for="star1"/>	
			</div>
			<div class="extra-padding">
				<form:errors path="stars" class="error-message"/>
			</div>
			<div>
				<button class="button-small"><p>Post!</p></button>
			</div>
		</form:form>
	</div>
	</div>
</body>
</html>