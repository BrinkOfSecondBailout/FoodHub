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
<title>Grocery Bag</title>
</head>
<body>
	<div class="container">
	<h1>Welcome to <u>FoodHub</u>!</h1>
	<a href="/users/${user.id}"><h3>${user.first_name} ${user.last_name}</h3></a>
	<div class="profile-div">
		<c:if test = "${ user.profile == null }">
			<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ user.profile != null }">
			<img class="avatar-thumb" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
		</c:if>
	</div>
	
	<div class="bag-div">
		<a href="/bags/show/${user.bag.id}">
			<img src="/img/bag.png" class="bag-icon border-marked" alt="Shopping Bag"/>
		</a>
	</div>
	
	<div class="bag-notification">
		<c:if test="${user.bag.orders.size() == null}">
			<p>0</p>
		</c:if>
		<c:if test="${user.bag.orders.size() != null}">
			<p>${user.bag.orders.size()}</p>
		</c:if>
	</div>
	
	
	<div class="nav-buttons">
		<a href="/dashboard"><button class="button-small"><p>Home</p></button></a>
		<a href="/users/edit"><button class="button-small"><p>Edit</p></button></a>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>
	
	
	<c:if test="${user.bag.orders.size() == 0 }">
		<p>No goodies yet... start shopping!</p>
	</c:if>
	
	<c:if test="${user.bag.orders.size() != 0 }">
		<c:forEach var="order" items="${user.bag.orders}">
			<div class="one-order">
				<c:set var="orderTotal" value="0" />
				<div class="order-restaurant">
					<div>
						<a href="/restaurants/${order.restaurant.id}"><c:if test="${order.restaurant.profile == null}">
						<img class="avatar-thumb-med" src="/img/restaurant.png" alt="No Profile Pic"/>
						</c:if>
						<c:if test="${order.restaurant.profile != null}">
							<img class="avatar-thumb-med" src="data:image/jpg;base64,${order.restaurant.profile}" alt="Profile-Pic"/>
						</c:if>
					</div>
					<div class="restaurant-name-bag">
						<h2>${order.restaurant.name}</h2></a>
					</div>
				</div>
				<c:forEach var="cartItem" items="${order.cartItems}">
					<div class="one-order-item">
						<div class="order-info">
							<a href="/items/${cartItem.item.id}"><h4>${cartItem.item.name}</h4>
							<c:if test="${cartItem.item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb-sm"/>
							</c:if>
							<c:if test="${cartItem.item.file != null }">
								<img src="data:image/jpg;base64,${cartItem.item.file}" class="item-thumb-sm"/>
							</c:if></a>
						</div>
						<div class="order-price">
							<u><p>$${cartItem.item.price}</p></u>					
						</div>
						
						<div class="order-quantity">
							<a href="/bags/decrease/${user.bag.id}/${cartItem.id}"><img src="/img/minus2.png" class="quantity-button"/></a>
							<p>${cartItem.quantity}</p>
							<a href="/bags/increase/${user.bag.id}/${cartItem.id}"><img src="/img/plus.png" class="quantity-button"/></a>
						</div>
						
						<a href="/bags/remove/${order.id}/${cartItem.id}"><button class="button-danger">Remove</button></a>
						<c:set var="subtotal" value="${cartItem.item.price * cartItem.quantity}" />
						<c:set var="orderTotal" value="${orderTotal + subtotal}" />
					</div>
				</c:forEach>
				<div class="order-total">
					<h3>Total for ${order.restaurant.name}:</h3>
					<u><h3><fmt:formatNumber value="${orderTotal}" pattern="$#,##0.00" /></h3></u>
				</div>
				
				<div class="remove-order">
					<a href="/bags/order/remove/${order.id}"><button class="button-danger">Remove All</button></a>
				</div>
			</div>
		</c:forEach>
	</c:if>
	</div>
</body>
</html>