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
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Add a Picture</title>
</head>
<body>
	<h1>${item.name}</h1>
	<h3>$${item.price}</h3>
	<h4>${item.category}</h4>
	<p>${item.description}</p>
	<img class="no-image-display" src="/img/no-image.png" alt="No Picture Yet"/>
	<h2>Looks great! Want to add a picture?</h2>
	<h5>Tips: An awesome picture tends to make eaters salivate more</h5>
	
	<form:form action="/items/processpicture/${item.id}" modelAttribute="item" method="post" enctype="multipart/form-data">
		<input type="hidden" name="_method" value="put"/>
		<form:label path="file">Upload a picture:</form:label><br>
		<form:errors path="file"/>
		<form:input type="file" path="file" accept="image/png, image/jpeg, image/jpg"/><br><br>
		<input type="submit" value="Submit"/>
	</form:form>
	
	<a href="/items/edit/${item.restaurant.id}">Skip this step...</a>
</body>
</html>