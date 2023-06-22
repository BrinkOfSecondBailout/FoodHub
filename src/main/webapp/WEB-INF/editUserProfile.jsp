<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Edit Profile</title>
</head>
<body>
	<h1>Edit Your Profile, <a href="/dashboard">${user.first_name}</a></h1>
	<c:if test = "${ user.profile == null }">
		<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ user.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
	</c:if>
	<form:form action="/users/newprofile" modelAttribute="user" method="post" enctype="multipart/form-data">
		<input type="hidden" name="_method" value="put"/>
		
		<form:label path="profile">Change profile picture:</form:label><br>
		<form:errors path="profile"/>
		<form:input type="file" path="profile" accept="image/png, image/jpeg, image/jpg"/><br><br>
		<input type="submit" value="Submit"/>	
	</form:form>
</body>
</html>