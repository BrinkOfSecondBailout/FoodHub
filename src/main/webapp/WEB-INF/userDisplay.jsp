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
<title>Eater Display</title>
</head>
<body>
	<c:if test="${me != null }">
		<h1>${me.first_name} ${me.last_name}</h1>
		<div class="profile-div">
			<c:if test = "${ me.profile == null }">
				<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
			</c:if>
			<c:if test = "${ me.profile != null }">
				<img class="avatar-thumb" src="data:image/jpg;base64,${me.profile}" alt="Profile-Pic"/>
			</c:if>
		</div>
	
		<div class="bag-div">
			<a href="/bags/show/${me.bag.id}">
				<img src="/img/bag.png" class="bag-icon" alt="Shopping Bag"/>
			</a>
		</div>
	
		<div class="bag-notification">
			<c:if test="${me.bag.orders.size() == 0 }">
				<p>0</p>
			</c:if>
			<c:if test="${me.bag.orders.size() != 0 }">
				<p>${me.bag.orders.size()}</p>
			</c:if>
		</div>
	
	
		<div class="nav-buttons">
			<a href="/dashboard"><button class="button-small"><p>Home</p></button></a>
			<a href="/users/edit"><button class="button-small"><p>Edit</p></button></a>
			<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
		</div>
	</c:if>
	
	<c:if test="${restaurant != null }">
		<h1>Welcome, <a href="/restaurants/${restaurant.id}">${restaurant.name}!</h1></a>

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
	
	<h2>${user.first_name} ${user.last_name}</h2>
	<div class="profile-div">
		<c:if test = "${ user.profile == null }">
			<img class="avatar-thumb-med" src="/img/avatar-icon.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ user.profile != null }">
			<img class="avatar-thumb-med" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
		</c:if>
	</div>
	
	<h3>All Reviews</h3>
	<c:if test="${user.reviews.size() == 0 }">
		<p>No reviews written by ${user.first_name} yet..</p>
	</c:if>
	<c:forEach var="review" items="${user.reviews}">
		<div class="one-review user-review">
			<a href="/restaurants/${review.restaurant.id}"><h4>${review.restaurant.name}</h4>
			<c:if test="${ review.restaurant.profile == null}">
				<img src="/img/restaurant.png" alt="No Profile" class="avatar-thumb-sm"/>
			</c:if>
			<c:if test="${ review.restaurant.profile != null}">
				<img src="data:image/jpg;base64,${review.restaurant.profile}" alt="Restaurant Pic" class="avatar-thumb-sm"/>
			</c:if></a>
			
			<div class="review-text">
				<p>"${review.review_text}"</p>			
			</div>
			
			<div class="review-stars">
				<c:if test="${review.stars == 1}">
					<img src="/img/1star.png" class="star-rating" alt="1 Star"/>
				</c:if>
				<c:if test="${review.stars == 2}">
					<img src="/img/2stars.png" class="star-rating" alt="2 Star"/>
				</c:if>
				<c:if test="${review.stars == 3}">
					<img src="/img/3stars.png" class="star-rating" alt="3 Star"/>
				</c:if>
				<c:if test="${review.stars == 4}">
					<img src="/img/4stars.png" class="star-rating" alt="4 Star"/>
				</c:if>
				<c:if test="${review.stars == 5}">
					<img src="/img/5stars.png" class="star-rating" alt="5 Star"/>
				</c:if>
			</div>
		</div>
	</c:forEach>
</body>
</html>