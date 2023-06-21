<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Item</title>
</head>
<body>
	<h1>New Menu Item:</h1>
	<form:form action="/menu/newItem" method="post" modelAttribute="item" enctype="multipart/form-data">
		<form:label path="name">Item Name:</form:label>
		<form:errors path="name"/>
		<form:input path="name"/><br><br>
		<form:label path="price">Item Price:</form:label>
		<form:errors path="price"/>
		<form:input type="number" path="price"/><br><br>
		<form:label path="description">Item Description:</form:label>
		<form:errors path="description"/>
		<form:input path="description"/><br><br>
		<form:label path="category">Item Category:</form:label>
		<form:errors path="category"/>
		<form:select path="category">
			<form:option value="">-- Select Category --</form:option>
			<form:option value="Breakfast">Breakfast</form:option>
			<form:option value="Lunch">Lunch</form:option>
			<form:option value="Dinner">Dinner</form:option>
			<form:option value="Dessert">Dessert</form:option>
			<form:option value="Drinks">Drinks</form:option>
			<form:option value="Others">Others</form:option>
		</form:select><br><br>
		<form:label path="file">Upload a picture:</form:label>
		<form:errors path="file"/>
		<form:input type="file" path="file" accept="image/png, image/jpeg, image/jpg"/><br><br>
		<input type="submit" value="Submit"/>
	</form:form>
</body>
</html>