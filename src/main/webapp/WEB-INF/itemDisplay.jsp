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
<title>Item Display</title>
</head>
<body>
	<h1>${item.name}</h1>
	<h4>${item.category}</h4>
	<c:if test = "${ item.file == null }">
		<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb-display"/>
	</c:if>
	<c:if test = "${ item.file != null }">
		<img src="data:image/jpg;base64,${item.file}" class="item-thumb-display"/>
	</c:if>
	<p>${item.description}</p>
	<p>$${item.price}</p>
	<c:if test="${item.restaurant.id == restaurantId}">
		<a href="/items/item/edit/${item.id}"><button>Modify</button></a>
		<a href="/items/item/delete/${item.id}"><button>Delete</button></a>
	</c:if>
</body>
</html>