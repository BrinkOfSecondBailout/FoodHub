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
<title>Eater Display</title>
</head>
<body>
	<h1>${user.first_name} ${user.last_name}</h1>
	<c:if test = "${ user.profile == null }">
		<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ user.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
	</c:if>
	
	<h2>All Reviews</h2>
	<c:forEach var="review" items="${user.reviews}">
		<div class="one-review">
			<a href="/restaurants/${review.restaurant.id}"><p>${review.restaurant.name}</p>
			<c:if test="${ review.restaurant.profile == null}">
				<img src="/img/restaurant.png" alt="No Profile" class="avatar-thumb-sm"/>
			</c:if>
			<c:if test="${ review.restaurant.profile != null}">
				<img src="data:image/jpg;base64,${review.restaurant.profile}" alt="Restaurant Pic" class="avatar-thumb-sm"/>
			</c:if></a>
			
			<div class="review-text">
				<p>${review.review_text}</p>			
			</div>
			
			<div class="review-stars">
				<c:if test="${review.stars == 1}">
					<img src="/img/onestar.png" class="star-rating" alt="1 Star"/>
				</c:if>
				<c:if test="${review.stars == 2}">
					<img src="/img/twostar.png" class="star-rating" alt="2 Star"/>
				</c:if>
				<c:if test="${review.stars == 3}">
					<img src="/img/threestar.png" class="star-rating" alt="3 Star"/>
				</c:if>
				<c:if test="${review.stars == 4}">
					<img src="/img/fourstar.png" class="star-rating" alt="4 Star"/>
				</c:if>
				<c:if test="${review.stars == 5}">
					<img src="/img/fivestar.png" class="star-rating" alt="5 Star"/>
				</c:if>
			</div>
		</div>
	</c:forEach>
</body>
</html>