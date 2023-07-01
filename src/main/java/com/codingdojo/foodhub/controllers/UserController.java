package com.codingdojo.foodhub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import com.codingdojo.foodhub.models.LoginUser;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.BagService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.UserService;


@Controller
public class UserController {
	@Autowired
	public UserService uServ;
	@Autowired
	public RestaurantService rServ;
	@Autowired
	public BagService bServ;
	
	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}
	
	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User user, BindingResult result, Model model, HttpSession session) {
		User newUser = uServ.register(user, result);
		if(result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		} else {
			bServ.createBag(newUser);
			session.setAttribute("userId", newUser.getId());
			return "redirect:/dashboard";			
		}
	}
	
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
		User user = uServ.login(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		} else {
			session.setAttribute("userId", user.getId());
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("/dashboard")
	public String userDash(HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			Long userId = (Long) session.getAttribute("userId");
			User user = uServ.findUserById(userId);
			List <User> users = uServ.findAllUsersNotById(userId);
			List <Restaurant> restaurants = rServ.findAllRestaurants();
			model.addAttribute("user", user);
			model.addAttribute("users", users);
			model.addAttribute("restaurants", restaurants);
			return "userDashboard.jsp";
		}
	}
	
	@GetMapping("/users/edit")
	public String editProfile(HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			User user = uServ.findUserById((Long) session.getAttribute("userId"));
			model.addAttribute("user", user);
			return "editUserProfile.jsp";
		}
	}


	
	@PutMapping("/users/newprofile")
	public String newProfilePicture(@Valid @ModelAttribute("user") User user,
			BindingResult result, HttpSession session,
			@RequestParam("profile") MultipartFile file) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			Long id = (Long) session.getAttribute("userId");
			if(file.isEmpty()) {
				result.rejectValue("profile", "error.profile", "Please upload an image");
			} else {
				uServ.addProfilePicture(id, file);
			}
			if(result.hasErrors()) {
				return "redirect:/users/edit";
			}
			return "redirect:/users/edit";	
		}
	}
	
	
	@GetMapping("/users/{id}")
	public String userDisplay(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("userId") == null && session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			if(session.getAttribute("userId") != null) {
				User user = uServ.findUserById(id);
				User me = uServ.findUserById((Long) session.getAttribute("userId"));
				model.addAttribute("user", user);
				model.addAttribute("me", me);
				return "userDisplay.jsp";				
			}
			Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
			User user = uServ.findUserById(id);
			model.addAttribute("user", user);
			model.addAttribute("restaurant", restaurant);
			return "userDisplay.jsp";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
