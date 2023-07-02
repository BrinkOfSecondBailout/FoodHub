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
<title>Add a Picture</title>
</head>
<body>
	<div class="container">
	<h1>Add a Picture</h1>
	
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
		<a href="/restaurants/edit"><button class="button-small marked"><p>Edit</p></button></a>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>

	<h1>${item.name}</h1>
	<h3>$${item.price}</h3>
	<h4>${item.category}</h4>
	<p>${item.description}</p>
	<img class="no-image-display" src="/img/no-image.png" alt="No Picture Yet"/>
	
	<div class="padding">
		<h2>Looks great! Want to add a picture?</h2>
		<h4>Tips: An awesome picture tends to make eaters salivate more</h4>	
	</div>
	
	<form:form action="/items/processpicture/${item.id}" modelAttribute="item" method="post" enctype="multipart/form-data">
		<input type="hidden" name="_method" value="put"/>
		<form:label path="file"><h4>Upload a picture:</h4></form:label><br>
		<form:errors path="file"/>
		<form:input type="file" path="file" accept="image/png, image/jpeg, image/jpg"/><br><br>
		<button class="button-small">Upload</button>
	</form:form>
	
	<div class="padding">
		<a href="/items/edit/${item.restaurant.id}"><button class="button-small">Skip</button></a>	
	</div>
	</div>
</body>
</html>