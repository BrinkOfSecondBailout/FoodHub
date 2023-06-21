package com.codingdojo.foodhub.controllers;

import java.math.BigDecimal;
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
	
	@GetMapping("/items/add")
	public String addItem(@ModelAttribute("item") Item item, HttpSession session) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logoutRestaurant";
		} else {
			return "newItem.jsp";			
		}
	}
	
	@PostMapping("/items/new")
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
//			if (result.hasErrors()) {
//				return "newItem.jsp";
//			}
			Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
			iServ.saveItemToDB(file, name, price, description, category, restaurant);
			return "redirect:/restaurants/edit";			
		}
	}
	
	@GetMapping("/items/edit/{id}")
	public String editMenu(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logoutRestaurant";
		}
		if(id != session.getAttribute("restaurantId")) {
			return "redirect:/logoutRestaurant";
		} else {
			List <Item> items = iServ.findAllItemsByRestaurantId(id);
			Restaurant restaurant = rServ.findRestaurantById(id);
			model.addAttribute("items", items);
			model.addAttribute("restaurant", restaurant);
			return "editMenu.jsp";
		}
	}
	
	@GetMapping("/items/{id}")
	public String displayItem(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logoutRestaurant";
		} else {
			Item item = iServ.findItemById(id);
			model.addAttribute("item", item);
			return "itemDisplay.jsp";
		}
	}
}
