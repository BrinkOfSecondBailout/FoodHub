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
<meta charset="ISO-8859-1">
<title>Edit Item</title>
</head>
<body>
	<div class="container">
		<h1>Edit Your Item, <a href="/restaurants/${restaurant.id}">${restaurant.name}</a></h1>
	
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
	
	<form:form action="/items/item/update/${item.id}" method="post" modelAttribute="item" >
		<input type="hidden" name="_method" value="put"/>
		<input type="hidden" name="file" value="${item.file}"/>
		<form:label path="name"><h4>Item Name:</h4></form:label>
		<div>
		<form:errors path="name" class="error-message"/>		
		</div>
		<form:input path="name" class="form-field"/><br><br>
		<form:label path="price"><h4>Item Price:</h4></form:label>
		<div>
		<form:errors path="price" class="error-message"/>
		</div>
		<form:input type="number" path="price" value="${item.price}" class="form-field"/><br><br>
		<form:label path="description"><h4>Item Description:</h4></form:label>
		<div>
		<form:errors path="description" class="error-message"/>
		</div>
		<form:input path="description" class="form-field"/><br><br>
		<form:label path="category"><h4>Item Category:</h4></form:label>
		<div>
		<form:errors path="category" class="error-message"/>
		</div>
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
			<button class="button-small"><p>Update!</p></button>		
		</div>
		
	</form:form>
	</div>
	
	
	</div>
</body>
</html>