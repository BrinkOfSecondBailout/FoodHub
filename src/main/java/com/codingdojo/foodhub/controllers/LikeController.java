package com.codingdojo.foodhub.controllers;



import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.codingdojo.foodhub.models.Comment;
import com.codingdojo.foodhub.models.Like;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.CommentService;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.LikeService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class LikeController {
	@Autowired
	public LikeService lServ;
	@Autowired
	public CommentService cServ;
	@Autowired
	public RestaurantService rServ;
	@Autowired
	public UserService uServ;
	@Autowired
	public ReviewService reServ;
	@Autowired
	public ItemService iServ;
	
	@GetMapping("/likes/new/{revid}/{cid}/{rid}")
	public String createLike(@Valid @ModelAttribute("like") Like like,
			@ModelAttribute("comment") Comment comment,
			HttpSession session,
			BindingResult result,
			@PathVariable("revid") Long reviewId,
			@PathVariable("cid") Long commentId,
			@PathVariable("rid") Long restPageId,
			Model model) {
		if (session.getAttribute("userId") == null && session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			if(result.hasErrors()) {
				return "redirect:/";
			}
//			Restaurant restaurant = rServ.findRestaurantById(restPageId);
//			List <Item> items = iServ.findAllItemsByRestaurantId(restPageId);
//			List <Review> reviews = reServ.findReviewsByRestaurant(restPageId);
//			Integer average = reServ.findAverageRatingByRestaurant(restPageId);
			Comment comment2 = cServ.findCommentById(commentId);
			
			// if viewer is a user
			if (session.getAttribute("userId") != null) {
				Long userId = (Long) session.getAttribute("userId");
				User user = uServ.findUserById(userId);
				lServ.createLike(like, comment2, user, null);
//				model.addAttribute("userId", userId);
//				model.addAttribute("average", average);
//				model.addAttribute("restaurant", restaurant);
//				model.addAttribute("items", items);
//				model.addAttribute("reviews", reviews);
//				model.addAttribute("user", user);
				return "redirect:/restaurants/" + restPageId + "?comments=show&reviewId=" + reviewId + "#comment" + commentId;
			}
			// if viewer is a restaurant
			Long restaurantId = (Long) session.getAttribute("restaurantId");
			Restaurant restaurantViewer = rServ.findRestaurantById(restaurantId);
			lServ.createLike(like, comment2, null, restaurantViewer);
//			model.addAttribute("average", average);
//			model.addAttribute("restaurant", restaurant);
//			model.addAttribute("items", items);
//			model.addAttribute("reviews", reviews);
//			model.addAttribute("restaurantViewer", restaurantViewer);
			return "redirect:/restaurants/" + restPageId + "?comments=show&reviewId=" + reviewId + "#comment" + commentId;
		}
	}
	
	@GetMapping("/likes/delete/{revid}/{lid}/{cid}/{rid}")
	public String removeLike(@PathVariable("lid") Long likeId, 
			@PathVariable("revid") Long reviewId,
			@PathVariable("cid") Long commentId,
			@PathVariable("rid") Long restPageId,
			HttpSession session) {
		if (session.getAttribute("userId") == null && session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Like like = lServ.findLikeById(likeId);
			// if viewer is a user
			if(session.getAttribute("userId") != null) {
				User user = uServ.findUserById((Long) session.getAttribute("userId"));
				if(like.getUser() != user) {
					return "redirect:/logout";
				}
				lServ.delete(likeId);
				return "redirect:/restaurants/" + restPageId + "?comments=show&reviewId=" + reviewId + "#comment" + commentId;
				
			}
			// if viewer is a restaurant
			Restaurant restaurantViewer = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
			if(like.getRestaurant() != restaurantViewer) {
				return "redirect:/logout";
			}
			lServ.delete(likeId);
			return "redirect:/restaurants/" + restPageId + "?comments=show&reviewId=" + reviewId + "#comment" + commentId;
		}
	}
	
}
