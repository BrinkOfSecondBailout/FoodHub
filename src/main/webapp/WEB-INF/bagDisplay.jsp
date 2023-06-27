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
<title>Grocery Bag</title>
</head>
<body>
	<c:if test="${user.bag.orders.size() == 0 }">
		<p>No goodies yet... start shopping!</p>
	</c:if>
	
	<c:if test="${user.bag.orders.size() != 0 }">
		<c:forEach var="order" items="${user.bag.orders}">
			<p>${order.restaurant.name}</p>
			<c:forEach var="cartItem" items="${order.cartItems}">
				<p>${cartItem.item.name}</p>
				<p>${cartItem.item.price}</p>
				<p>${cartItem.quantity}</p>
			</c:forEach>
		</c:forEach>
	</c:if>
</body>
</html>