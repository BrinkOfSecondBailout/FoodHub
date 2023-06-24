package com.codingdojo.foodhub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.foodhub.models.Comment;
import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.Review;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.CommentService;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class CommentController {
	@Autowired
	public CommentService cServ;
	@Autowired
	public ReviewService rServ;
	@Autowired
	public RestaurantService restServ;
	@Autowired
	public ItemService iServ;
	@Autowired
	public UserService uServ;
	
	@PostMapping("/comments/add/{id}")
	public String newComment(@Valid @ModelAttribute("comment") Comment comment, 
			BindingResult result, 
			HttpSession session,
			@RequestParam("review_id") Long reviewId,
			@PathVariable("id") Long id,
			Model model) {
		if (session.getAttribute("userId") == null && session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Restaurant restaurant = restServ.findRestaurantById(id);
			List <Item> items = iServ.findAllItemsByRestaurantId(id);
			List <Review> reviews = rServ.findReviewsByRestaurant(id);
			Integer average = rServ.findAverageRatingByRestaurant(id);
			if(result.hasErrors()) {
				// if viewer is a user
				if (session.getAttribute("userId") != null) {
					Long userId = (Long) session.getAttribute("userId");
					model.addAttribute("average", average);
					model.addAttribute("restaurant", restaurant);
					model.addAttribute("items", items);
					model.addAttribute("userId", userId);
					model.addAttribute("reviews", reviews);
					return "restaurantDisplay.jsp";
				}
				// if viewer is a restaurant
				model.addAttribute("average", average);
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("items", items);
				model.addAttribute("reviews", reviews);
				return "restaurantDisplay.jsp";
			} else {

				// if viewer is a user
				if (session.getAttribute("userId") != null) {
					Long userId = (Long) session.getAttribute("userId");
					Review review = rServ.findReviewById(reviewId);
					User user = uServ.findUserById(userId);
					cServ.createComment(comment, review, user, null);
					model.addAttribute("average", average);
					model.addAttribute("restaurant", restaurant);
					model.addAttribute("items", items);
					model.addAttribute("userId", userId);
					model.addAttribute("reviews", reviews);
					return "redirect:/restaurants/" + id + "?refresh=true";
				}
				// if viewer is a restaurant
				Review review = rServ.findReviewById(reviewId);
				cServ.createComment(comment, review, null, restaurant);
				model.addAttribute("average", average);
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("items", items);
				model.addAttribute("reviews", reviews);
				return "redirect:/restaurants/" + id + "?refresh=true";
			}
		}
	}
	
}
