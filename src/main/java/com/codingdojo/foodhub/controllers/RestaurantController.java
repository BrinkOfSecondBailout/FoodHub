package com.codingdojo.foodhub.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.codingdojo.foodhub.models.LoginRestaurant;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.services.RestaurantService;

@Controller
public class RestaurantController {
	@Autowired
	public RestaurantService rServ;
	
	@GetMapping("/restaurant")
	public String indexRestaurant(Model model) {
		model.addAttribute("newRestaurant", new Restaurant());
		model.addAttribute("newLoginRestaurant", new LoginRestaurant());
		return "restaurantIndex.jsp";
	}
	
	@PostMapping("/registerRestaurant")
	public String registerRestaurant(@Valid @ModelAttribute("newRestaurant") Restaurant restaurant, BindingResult result, Model model, HttpSession session) {
		Restaurant newRestaurant = rServ.register(restaurant, result);
		if(result.hasErrors()) {
			model.addAttribute("newLoginRestaurant", new LoginRestaurant());
			return "restaurantIndex.jsp";
		} else {
			session.setAttribute("restaurantId", newRestaurant.getId());
			return "redirect:/restaurantDashboard";
		}
	}
	
	
	@PostMapping("/loginRestaurant")
	
	@GetMapping("/restaurantDashboard")
}
