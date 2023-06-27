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
		<c:set var="orderTotal" value="0" />
			<h3>${order.restaurant.name}</h3>
			<c:forEach var="cartItem" items="${order.cartItems}">
				<p>${cartItem.item.name}</p>
				<p>${cartItem.item.price}</p>
				<p>${cartItem.quantity}</p>
				<c:set var="subtotal" value="${cartItem.item.price * cartItem.quantity}" />
				<c:set var="orderTotal" value="${orderTotal + subtotal}" />
			</c:forEach>
			<p>Total for ${order.restaurant.name}:</p>
			<p><fmt:formatNumber value="${orderTotal}" pattern="$#,##0.00" /></p>
		</c:forEach>
	</c:if>
</body>
</html>