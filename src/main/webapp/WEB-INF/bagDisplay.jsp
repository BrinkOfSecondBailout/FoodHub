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
			<div class="one-order">
				<c:set var="orderTotal" value="0" />
				<div class="order-restaurant">
					<a href="/restaurants/${order.restaurant.id}"><h2>${order.restaurant.name}</h2>
					<c:if test="${order.restaurant.profile == null}">
						<img class="avatar-thumb-med" src="/img/restaurant.png" alt="No Profile Pic"/>
					</c:if>
					<c:if test="${order.restaurant.profile != null}">
						<img class="avatar-thumb-med" src="data:image/jpg;base64,${order.restaurant.profile}" alt="Profile-Pic"/>
					</c:if></a>
				</div>
				<c:forEach var="cartItem" items="${order.cartItems}">
					<div class="one-order-item">
						<div>
							<a href="/items/${cartItem.item.id}"><p>${cartItem.item.name}</p>
							<c:if test="${cartItem.item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb-sm"/>
							</c:if>
							<c:if test="${cartItem.item.file != null }">
								<img src="data:image/jpg;base64,${cartItem.item.file}" class="item-thumb-sm"/>
							</c:if></a>
						</div>
						<p>$${cartItem.item.price}</p>
						
						<div class="order-quantity">
							<a href="/bags/decrease/${user.bag.id}/${cartItem.id}"><img src="/img/minus2.png" class="quantity-button"/></a>
							<p>${cartItem.quantity}</p>
							<a href="/bags/increase/${user.bag.id}/${cartItem.id}"><img src="/img/plus.png" class="quantity-button"/></a>
						</div>
						
						<a href="/bags/remove/${order.id}/${cartItem.id}"><button>Remove</button></a>
						<c:set var="subtotal" value="${cartItem.item.price * cartItem.quantity}" />
						<c:set var="orderTotal" value="${orderTotal + subtotal}" />
					</div>
				</c:forEach>
				<div class="order-total">
					<h3>Total for ${order.restaurant.name}:</h3>
					<p><fmt:formatNumber value="${orderTotal}" pattern="$#,##0.00" /></p>			
				</div>
			</div>
		</c:forEach>
	</c:if>
</body>
</html>