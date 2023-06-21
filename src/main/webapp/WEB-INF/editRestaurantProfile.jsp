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
<title>Edit Restaurant</title>
</head>
<body>
	<h1>Edit Your Profile, <a href="/restaurantDashboard">${restaurant.name}</h1></a>
	<a href="/items/edit/${restaurant.id}">Make changes to menu</a>
</body>
</html>