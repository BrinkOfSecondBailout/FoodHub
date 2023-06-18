package com.codingdojo.foodhub.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.codingdojo.foodhub.models.LoginRestaurant;
import com.codingdojo.foodhub.models.LoginUser;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.User;


@Controller
public class MainController {
	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}
	
	@GetMapping("/restaurant")
	public String indexRestaurant(Model model) {
		model.addAttribute("newRestaurant", new Restaurant());
		model.addAttribute("newLoginRestaurant", new LoginRestaurant());
		return "restaurantIndex.jsp";
	}
}
