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
<title>Restaurant Display</title>
</head>
<body>
	<h1>${restaurant.name}</h1>
	<c:if test = "${ restaurant.profile == null }">
		<img class="avatar-thumb" src="/img/avatar-icon-2.jpg" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ restaurant.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
	</c:if>
	
	<div>
		<c:if test="${average == 1}">
			<img src="/img/onestar.png" class="main-star-rating" alt="1 Star Average"/>
		</c:if>
		<c:if test="${average == 2}">
			<img src="/img/twostar.png" class="main-star-rating" alt="2 Star Average"/>
		</c:if>
		<c:if test="${average == 3}">
			<img src="/img/threestar.png" class="main-star-rating" alt="3 Star Average"/>
		</c:if>
		<c:if test="${average == 4}">
			<img src="/img/fourstar.png" class="main-star-rating" alt="4 Star Average"/>
		</c:if>
		<c:if test="${average == 5}">
			<img src="/img/fivestar.png" class="main-star-rating" alt="5 Star Average"/>
		</c:if>
		
		<c:if test="${reviews.size() == 0}">
			<p>No reviews yet..</p>
		</c:if>
		<c:if test="${reviews.size() != 0}">
			<p><a href="#reviews">(${reviews.size()} reviews)</a></p>
		</c:if>
	</div>
	
	<div class="menu">
		<c:forEach var="item" items="${items}">
			<div>
				<a href="/items/${item.id}"><p><c:out value="${item.name}"/></p>
				<c:if test = "${ item.file == null }">
					<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
				</c:if>
				<c:if test = "${ item.file != null }">
					<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
				</c:if>
				</a>
			</div>
		</c:forEach>	
	</div>
	
	<c:if test="${userId != null}">
		<button>Start ordering!</button>
		<a href="/reviews/new/${restaurant.id}"><button>Add a review</button></a>
	</c:if>
	
	<section id="reviews">
		<h2>Reviews</h2>
		<c:forEach var="review" items="${reviews}">
			<div class="one-review">
				<div class="user_of_review">
					<a href="/users/${review.user.id}"><p>${review.user.first_name} ${review.user.last_name}</p>
					<c:if test="${review.user.profile == null}">
						<img class="avatar-thumb-sm" src="/img/avatar-icon.png" alt="No Profile Pic"/>
					</c:if>
					<c:if test="${review.user.profile != null}">
						<img class="avatar-thumb-sm" src="data:image/jpg;base64,${review.user.profile}" alt="Profile-Pic"/>
					</c:if>
					</a>
				</div>
				<div class="review">
					<div class="review-date">
						<u><fmt:formatDate pattern="MMMM dd, yyyy" value="${review.created_at}"/></u>					
					</div>
					
					<div class="review-stars">
						<c:if test="${review.stars == 1}">
							<img src="/img/onestar.png" class="star-rating" alt="1 Star"/>
						</c:if>
						<c:if test="${review.stars == 2}">
							<img src="/img/twostar.png" class="star-rating" alt="2 Star"/>
						</c:if>
						<c:if test="${review.stars == 3}">
							<img src="/img/threestar.png" class="star-rating" alt="3 Star"/>
						</c:if>
						<c:if test="${review.stars == 4}">
							<img src="/img/fourstar.png" class="star-rating" alt="4 Star"/>
						</c:if>
						<c:if test="${review.stars == 5}">
							<img src="/img/fivestar.png" class="star-rating" alt="5 Star"/>
						</c:if>
					</div>
					
					<div class="review-text">
						<p>${review.review_text}</p>				
					</div>
					
					<c:if test="${review.comments.size() != 0 }">
						<p><a href="#" onclick="toggleComments(${review.id}); return false;">${review.comments.size()} comment(s)</a></p>
						<div id="all-comments">
							<c:forEach var="comment" items="${review.comments}">
								<section id="comment${comment.id}">
								<div class="one-comment">
									<img src="/img/downright.png" alt="arrow" class="down-right-arrow"/>
									<c:if test="${comment.user == null}">
										<a href="/restaurants/${comment.restaurant.id}"><p>${comment.restaurant.name}</p>
										<c:if test="${comment.restaurant.profile == null }">
											<img class="avatar-thumb-xtra-sm" src="/img/avatar-icon-2.jpg" alt="No Profile Pic"/></a>
										</c:if>
										<c:if test="${comment.restaurant.profile != null }">
											<img class="avatar-thumb-xtra-sm" src="data:image/jpg;base64,${comment.restaurant.profile}" alt="Profile-Pic"/></a>									
										</c:if>
										<div class="comment-text">
											<p>${comment.comment_text}</p>										
										</div>
									</c:if>
									
									<c:if test="${comment.user != null}">
										<a href="/users/${comment.user.id}"><p>${comment.user.first_name}</p>
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
											<a href="/likes/new/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>
										</c:if>
										<c:if test="${comment.likes.size() != 0 }">
											<c:forEach var="like" items="${comment.likes}">
												<c:if test="${like.user == user}">
													<a href="/likes/delete/${like.id}"><img src="/img/heart.png" alt="liked" class="like-button"/></a>
												</c:if>
												<c:if test="${like.user != user}">
													<a href="/likes/new/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>											
												</c:if>
											</c:forEach>
										</c:if>
									</c:if>
									
									<c:if test="${restaurantViewer != null}">
										<c:if test="${comment.likes.size() == 0 }">
											<a href="/likes/new/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>
										</c:if>
										<c:if test="${comment.likes.size() != 0 }">
											<c:forEach var="like" items="${comment.likes}">
												<c:if test="${like.restaurant == restaurantViewer}">
													<a href="/likes/delete/${like.id}"><img src="/img/heart.png" alt="liked" class="like-button"/></a>
												</c:if>
												<c:if test="${like.restaurant != restaurantViewer}">
													<a href="/likes/new/${comment.id}/${restaurant.id}"><img src="/img/heart-outline.png" alt="like button" class="like-button"/></a>
												</c:if>
											</c:forEach>
										</c:if>							
									</c:if>
									
									<c:if test="${comment.likes.size() == 0 }">
										<p>${comment.likes.size()} likes</p>
									</c:if>
									<c:if test="${comment.likes.size() != 0 }">
										<a href="/likes/show/"><p>${comment.likes.size()} like(s)</p></a>
									</c:if>
								</div>
								</section>
							</c:forEach>
						</div>
					</c:if>
					
					<div class="comment-form">
						<form:form action="/comments/add/${restaurant.id}" method="post" modelAttribute="comment">
							<form:input type="textarea" path="comment_text" class="comment-text-area"/><br>
							<form:errors path="comment_text" class="form-error"/><br>
							<input type="hidden" name="review_id" value=${review.id} />
							<input type="submit" value="Reply"/>
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

   //If 'comments' is 'show', show the comments
   if (commentsParam === 'show') {
	   const commentsDiv = document.getElementById("all-comments");
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
	   var commentsDiv = document.getElementById("all-comments")
	   commentsDiv.style.display = (commentsDiv.style.display === "none") ? "block" : "none";
   }
</script>
</body>
</html>