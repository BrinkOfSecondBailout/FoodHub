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
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Restaurant Display</title>
</head>
<body>

	<c:if test="${user != null}">
		<h1>Welcome, <a href="/users/${user.id}">${user.first_name}!</h1></a>
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
			<img src="/img/bag.png" class="bag-icon" alt="Shopping Bag"/></a>
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
	</c:if>
		
		
	<c:if test="${restaurantViewer != null}">
		<a href="/restaurantDashboard"><button class="button-medium">Dashboard</button></a>
	</c:if>

	<h1>${restaurant.name}</h1>
	
	<div class="logo-and-stars">
		<c:if test = "${ restaurant.profile == null }">
			<img class="avatar-thumb" src="/img/restaurant.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ restaurant.profile != null }">
			<img class="avatar-thumb-med" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
		</c:if>
	
		<div class="average-rating">
			<c:if test="${average == 1}">
				<img src="/img/1star.png" class="main-star-rating" alt="1 Star Average"/>
			</c:if>
			<c:if test="${average == 2}">
				<img src="/img/2stars.png" class="main-star-rating" alt="2 Star Average"/>
			</c:if>
			<c:if test="${average == 3}">
				<img src="/img/3stars.png" class="main-star-rating" alt="3 Star Average"/>
			</c:if>
			<c:if test="${average == 4}">
				<img src="/img/4stars.png" class="main-star-rating" alt="4 Star Average"/>
			</c:if>
			<c:if test="${average == 5}">
				<img src="/img/5stars.png" class="main-star-rating" alt="5 Star Average"/>
			</c:if>
		
			<c:if test="${reviews.size() == 0}">
				<p>No reviews yet..</p>
			</c:if>
			<c:if test="${reviews.size() != 0}">
				<p><a href="#reviews">${reviews.size()} review(s)</a></p>
			</c:if>
		</div>	
	</div>
	
	
	<h2>Full Menu</h2>
	
	<div class="menu">
	
		<c:if test="${breakfast.size() != 0}">
			<h3>Breakfast</h3>
			<div class="one-category">
				<c:forEach var="item" items="${breakfast}">
					<div class="one-menu-item">
						<div class="item-name-and-pic">
							<a href="/items/${item.id}"><h4>${item.name}</h4>
							<c:if test = "${ item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
							</c:if>
							<c:if test = "${ item.file != null }">
								<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
							</c:if></a>
						</div>
					
						<div class="description-and-price">
							<p>${item.description }</p>
							<p>$${item.price}</p>					
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>

		
		<c:if test="${lunch.size() != 0}">
			<h3>Lunch</h3>
			<div class="one-category">
				<c:forEach var="item" items="${lunch}">
					<div class="one-menu-item">
						<div class="item-name-and-pic">
							<a href="/items/${item.id}"><h4>${item.name}</h4>
							<c:if test = "${ item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
							</c:if>
							<c:if test = "${ item.file != null }">
								<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
							</c:if></a>
						</div>
					
						<div class="description-and-price">
							<p>${item.description }</p>
							<p>$${item.price}</p>					
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>

		
		
		<c:if test="${dinner.size() != 0}">
			<h3>Dinner</h3>
			<div class="one-category">
				<c:forEach var="item" items="${dinner}">
					<div class="one-menu-item">
						<div class="item-name-and-pic">
							<a href="/items/${item.id}"><h4>${item.name}</h4>
							<c:if test = "${ item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
							</c:if>
							<c:if test = "${ item.file != null }">
								<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
							</c:if></a>
						</div>
					
						<div class="description-and-price">
							<p>${item.description }</p>
							<p>$${item.price}</p>					
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>

		
		<c:if test="${dessert.size() != 0}">
			<h3>Dessert</h3>
			<div class="one-category">
				<c:forEach var="item" items="${dessert}">
					<div class="one-menu-item">
						<div class="item-name-and-pic">
							<a href="/items/${item.id}"><h4>${item.name}</h4>
							<c:if test = "${ item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
							</c:if>
							<c:if test = "${ item.file != null }">
								<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
							</c:if></a>
						</div>
					
						<div class="description-and-price">
							<p>${item.description }</p>
							<p>$${item.price}</p>					
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>

		
		<c:if test="${drinks.size() != 0}">
			<h3>Drinks</h3>
			<div class="one-category">
			<c:forEach var="item" items="${drinks}">
				<div class="one-menu-item">
						<div class="item-name-and-pic">
							<a href="/items/${item.id}"><h4>${item.name}</h4>
							<c:if test = "${ item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
							</c:if>
							<c:if test = "${ item.file != null }">
								<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
							</c:if></a>
						</div>
					
						<div class="description-and-price">
							<p>${item.description }</p>
							<p>$${item.price}</p>					
						</div>
				</div>
			</c:forEach>
		</div>
		</c:if>
		
		<c:if test="${others.size() != 0}">
			<h3>Others</h3>
			<div class="one-category">
				<c:forEach var="item" items="${others}">
					<div class="one-menu-item">
						<div class="item-name-and-pic">
							<a href="/items/${item.id}"><h4>${item.name}</h4>
							<c:if test = "${ item.file == null }">
								<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
							</c:if>
							<c:if test = "${ item.file != null }">
								<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
							</c:if></a>
						</div>
					
						<div class="description-and-price">
							<p>${item.description }</p>
							<p>$${item.price}</p>					
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>

		
		
	</div>
	
	<div class="order-and-review-buttons">
		<c:if test="${userId != null}">
			<a href="/bags/orders/new/${restaurant.id}"><button class="button-medium"><p>Start ordering!</p></button></a>
			<a href="/reviews/new/${restaurant.id}"><button class="button-medium"><p>Add a review</p></button></a>
		</c:if>
	</div>
	
	<section id="reviews">
		<h2>Reviews</h2>
		<c:if test="${reviews.size() == 0 }">
			<p>No reviews yet..</p>
		</c:if>
		<c:forEach var="review" items="${reviews}">
			<div class="one-review">
				<div class="user_of_review">
					<a href="/users/${review.user.id}"><h4>${review.user.first_name} ${review.user.last_name}</h4>
					<c:if test="${review.user.profile == null}">
						<img class="avatar-thumb-sm" src="/img/avatar-icon.png" alt="No Profile Pic"/>
					</c:if>
					<c:if test="${review.user.profile != null}">
						<img class="avatar-thumb-sm" src="data:image/jpg;base64,${review.user.profile}" alt="Profile-Pic"/>
					</c:if>
					</a>
				</div>
				<div class="review">
					
					<div class="review-stars">
						<c:if test="${review.stars == 1}">
							<img src="/img/1star.png" class="star-rating" alt="1 Star"/>
						</c:if>
						<c:if test="${review.stars == 2}">
							<img src="/img/2stars.png" class="star-rating" alt="2 Star"/>
						</c:if>
						<c:if test="${review.stars == 3}">
							<img src="/img/3stars.png" class="star-rating" alt="3 Star"/>
						</c:if>
						<c:if test="${review.stars == 4}">
							<img src="/img/4stars.png" class="star-rating" alt="4 Star"/>
						</c:if>
						<c:if test="${review.stars == 5}">
							<img src="/img/5stars.png" class="star-rating" alt="5 Star"/>
						</c:if>
					</div>
					
					<div class="review-text">
						<p>${review.review_text}</p>				
					</div>
					
					<div class="review-date">
						<u><fmt:formatDate pattern="MMMM dd, yyyy" value="${review.created_at}"/></u>					
					</div>
					
					<c:if test="${review.comments.size() != 0 }">
						<p class="small-font"><a href="#" onclick="toggleComments(${review.id}); return false;">${review.comments.size()} comment(s)</a></p>
						<div id="all-comments${review.id}" style="display:none;">
							<c:forEach var="comment" items="${review.comments}">
								<section id="comment${comment.id}">
									<div class="one-comment">
										<img src="/img/downright.png" alt="arrow" class="down-right-arrow"/>
										<c:if test="${comment.user == null}">
											<a href="/restaurants/${comment.restaurant.id}"><h4>${comment.restaurant.name}</h4>
											<c:if test="${comment.restaurant.profile == null }">
												<img class="avatar-thumb-xtra-sm" src="/img/restaurant.png" alt="No Profile Pic"/>
											</c:if>
											<c:if test="${comment.restaurant.profile != null }">
												<img class="avatar-thumb-xtra-sm" src="data:image/jpg;base64,${comment.restaurant.profile}" alt="Profile-Pic"/>						
											</c:if></a>
											<div class="comment-text">
												<p>${comment.comment_text}</p>										
											</div>
										</c:if>
									
										<c:if test="${comment.user != null}">
											<a href="/users/${comment.user.id}"><h4>${comment.user.first_name}</h4>
											<c:if test="${comment.user.profile == null }">
												<img class="avatar-thumb-xtra-sm" src="/img/avatar-icon.png" alt="No Profile Pic"/>
											</c:if>
											<c:if test="${comment.user.profile != null }">
												<img class="avatar-thumb-xtra-sm" src="data:image/jpg;base64,${comment.user.profile}" alt="Profile-Pic"/>
											</c:if></a>
											<div class="comment-text">
												<p>${comment.comment_text}</p>
											</div>
										</c:if>
									</div>
								
									<div class="like-area">
										<c:if test="${user != null}">
											<c:if test="${comment.likes.size() == 0 }">
												<a href="/likes/new/${review.id}/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>
											</c:if>
											<c:if test="${comment.likes.size() != 0 }">
												<c:set var="userLiked" value="false" />
												<c:forEach var="like" items="${comment.likes}">
													<c:if test="${like.user == user}">
														<c:set var="userLiked" value="true" />
														<a href="/likes/delete/${review.id}/${like.id}/${comment.id}/${restaurant.id}"><img src="/img/heart.png" alt="liked" class="like-button"/></a>
													</c:if>
												</c:forEach>													
												<c:if test="${userLiked eq false}">
													<a href="/likes/new/${review.id}/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>											
												</c:if>
											</c:if>
										</c:if>
									
										<c:if test="${restaurantViewer != null}">
											<c:if test="${comment.likes.size() == 0 }">
												<a href="/likes/new/${review.id}/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>
											</c:if>
											<c:if test="${comment.likes.size() != 0 }">
												<c:set var="restaurantLiked" value="false" />
												<c:forEach var="like" items="${comment.likes}">
													<c:if test="${like.restaurant == restaurantViewer}">
														<c:set var="restaurantLiked" value="true" />
														<a href="/likes/delete/${review.id}/${like.id}/${comment.id}/${restaurant.id}"><img src="/img/heart.png" alt="liked" class="like-button"/></a>
													</c:if>
												</c:forEach>
												<c:if test="${restaurantLiked eq false}">
													<a href="/likes/new/${review.id}/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>
												</c:if>
											</c:if>							
										</c:if>
									
										<c:if test="${comment.likes.size() == 0 }">
											<p>${comment.likes.size()} likes</p>
										</c:if>
										<c:if test="${comment.likes.size() != 0 }">
											<p>${comment.likes.size()} like(s)</p>
										</c:if>
									</div>
								</section>
							</c:forEach>
						</div>
					</c:if>
					
					<div class="comment-form">
						<form:form action="/comments/add/${restaurant.id}/${review.id}" method="post" modelAttribute="comment">
							<form:input type="textarea" path="comment_text" class="comment-text-area"/><br>
							<form:errors path="comment_text" class="form-error"/><br>
							<button class="button-medium"><p>Reply</p></button>
						</form:form>
					</div>
				</div>
			</div>
		</c:forEach>
	</section>
	
<script>


   // Check if the 'refresh' query parameter is present
   const urlParams = new URLSearchParams(window.location.search);
   const refreshParam = urlParams.get('refresh');
   
   const commentsParam = urlParams.get('comments')
   
   const reviewParam = urlParams.get('reviewId');

   //If 'comments' is 'show', show the comments
   if (commentsParam === 'show') {
	   const commentsDiv = document.getElementById("all-comments" + reviewParam);
	   commentsDiv.style.display = "block";
   }
   
   // If 'refresh' is true, force page reload
   if (refreshParam === 'true') {
	  urlParams.delete('refresh');
	  const newUrl = window.location.pathname + '?' + urlParams.toString();
      window.history.replaceState({}, '', newUrl);
      location.reload();
   }
   
   
   function toggleComments(reviewId) {
	   var commentsDiv = document.getElementById("all-comments" + reviewId);
	   commentsDiv.style.display = (commentsDiv.style.display === "none") ? "block" : "none";
   }
   
   
   
   
</script>
</body>
</html>