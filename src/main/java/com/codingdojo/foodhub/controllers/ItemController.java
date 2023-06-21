package com.codingdojo.foodhub.controllers;

import java.math.BigDecimal;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.RestaurantService;

@Controller
public class ItemController {
	@Autowired
	public ItemService iServ;
	@Autowired
	public RestaurantService rServ;
	
	@GetMapping("/menu/add")
	public String addItem(@ModelAttribute("item") Item item, HttpSession session) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logoutRestaurant";
		} else {
			return "newItem.jsp";			
		}
	}
	
	@PostMapping("/menu/newItem")
	public String addNewItem(@Valid @ModelAttribute("item") Item item, BindingResult result, 
			HttpSession session, 
			@RequestParam("file") MultipartFile file,
			@RequestParam("name") String name, 
			@RequestParam("price") BigDecimal price, 
			@RequestParam("description") String description, 
			@RequestParam("category") String category) 
	{
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logoutRestaurant";
		} else {
			if (result.hasErrors()) {
				System.out.println("A");
				return "newItem.jsp";
			}
			Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId")); 
			iServ.saveItemToDB(file, name, price, description, category, restaurant);
			return "redirect:/restaurants/edit";			
		}
	}
}
