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
<link rel="stylesheet" type="text/css" href="/css/media.css">
<meta charset="ISO-8859-1">
<title>Edit Restaurant</title>
</head>
<body>
	<div class="container">
	<h1>Edit Your Profile, <a href="/restaurants/${restaurant.id}">${restaurant.name}</a></h1>
	
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
		<button class="button-small marked"><p>Edit</p></button>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>
	
	<div class="upload-form">
		<form:form action="/restaurants/newprofile" modelAttribute="restaurant" method="post" enctype="multipart/form-data">
			<input type="hidden" name="_method" value="put"/>
			<h3>Change profile picture:</h3>
			<div class="upload">
				<form:errors path="profile"/>
				<form:input type="file" path="profile" accept="image/png, image/jpeg, image/jpg"/>
				<button class="button-small"><p>Upload</p></button>
			</div>
		</form:form>
	</div>
	
	<div class="padding">
		<a href="/items/edit/${restaurant.id}"><button class="button-medium"><p>Edit Your Menu</p></button></a>
	</div>
	</div>
</body>
</html>