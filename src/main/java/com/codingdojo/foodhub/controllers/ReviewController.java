package com.codingdojo.foodhub.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;


import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.Review;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class ReviewController {
	@Autowired
	public ReviewService rServ;
	@Autowired
	public RestaurantService restServ;
	@Autowired
	public UserService uServ;
	
	@GetMapping("/reviews/new/{id}")
	public String newReview(@PathVariable("id") Long id, Model model, @ModelAttribute("review") Review review, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		Restaurant restaurant = restServ.findRestaurantById(id);
		model.addAttribute("restaurant", restaurant);
		return "newReview.jsp";
	}
}
