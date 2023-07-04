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
<title>Edit Profile</title>
</head>
<body>
	<div class="container">
	<h1>Edit Your Profile, <a href="/users/${user.id}">${user.first_name}</a></h1>
	
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
		<a href="/dashboard"><button class="button-small"><p>Home</p></button></a>
		<button class="button-small marked"><p>Edit</p></button>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>
	
	<div class="upload-form">
		<form:form action="/users/newprofile" modelAttribute="user" method="post" enctype="multipart/form-data">
			<input type="hidden" name="_method" value="put"/>
			<h3>Change your profile picture:</h3>
			<div class="upload">
				<form:errors path="profile"/>
				<form:input type="file" path="profile" accept="image/png, image/jpeg, image/jpg"/>
				<button class="button-small">Upload</button>
			</div>
		</form:form>
	</div>
	
	</div>
	
	
</body>
</html>