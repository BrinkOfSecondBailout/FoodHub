<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Heebo&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Add New Item</title>
</head>
<body>
	<div class="container">
	<h1>New Menu Item:</h1>
	
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
	
	
	<form:form action="/items/new" method="post" modelAttribute="item" >
		<form:label path="name"><h4>Item Name:</h4></form:label>
		<form:errors path="name" class="error-message"/>
		<form:input path="name" class="form-field"/><br><br>
		<form:label path="price"><h4>Item Price:</h4></form:label>
		<form:errors path="price" class="error-message"/>
		<form:input type="number" path="price" value="0" class="form-field"/><br><br>
		<form:label path="description"><h4>Item Description:</h4></form:label>
		<form:errors path="description" class="error-message"/>
		<form:input path="description" class="form-field"/><br><br>
		<form:label path="category"><h4>Item Category:</h4></form:label>
		<form:errors path="category" class="error-message"/>
		<form:select path="category">
			<form:option value="">-- Select Category --</form:option>
			<form:option value="Breakfast">Breakfast</form:option>
			<form:option value="Lunch">Lunch</form:option>
			<form:option value="Dinner">Dinner</form:option>
			<form:option value="Dessert">Dessert</form:option>
			<form:option value="Drinks">Drinks</form:option>
			<form:option value="Others">Others</form:option>
		</form:select><br><br>
		
		<div class="padding">
			<button class="button-small"><p>Post!</p></button>		
		</div>
		
	</form:form>
	</div>
</body>
</html>