package com.codingdojo.foodhub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.foodhub.models.Bag;
import com.codingdojo.foodhub.models.CartItem;
import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.Order;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.BagService;
import com.codingdojo.foodhub.services.CartItemService;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.OrderService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class BagController {
	@Autowired
	public BagService bServ;
	@Autowired
	public UserService uServ;
	@Autowired
	public RestaurantService rServ;
	@Autowired
	public ReviewService revServ;
	@Autowired
	public ItemService iServ;
	@Autowired
	public OrderService oServ;
	@Autowired
	public CartItemService cServ;
	
	@GetMapping("/bags/show/{id}")
	public String showBag(@PathVariable("id") Long id,
			HttpSession session,
			Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		User user = uServ.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("user", user);
		return "bagDisplay.jsp";
	}
	
	@GetMapping("/bags/orders/new/{id}")
	public String newOrder(@PathVariable("id") Long restId,
			HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		User user = uServ.findUserById((Long) session.getAttribute("userId"));
		Restaurant restaurant = rServ.findRestaurantById(restId);
		Integer average = revServ.findAverageRatingByRestaurant(restId);
		List <Item> items = iServ.findAllItemsByRestaurantId(restId);
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("user", user);
		model.addAttribute("average", average);
		model.addAttribute("items", items);
		return "newOrder.jsp";
	}
	
	@PostMapping("/bags/create/{id}")
	public String createOrder(@PathVariable("id") Long restId,
			HttpSession session,
			@RequestParam("itemId") Long itemId,
			@RequestParam("quantity") int quantity) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		User user = uServ.findUserById((Long) session.getAttribute("userId"));
		Bag bag = user.getBag();
		Restaurant restaurant = rServ.findRestaurantById(restId);
		Item item = iServ.findItemById(itemId);
		// if there are already orders in the bag
		if (bag.getOrders() != null) {
			for( Order order: bag.getOrders()) {
				// check if one of those orders are with the restaurant
				if(order.getRestaurant() == restaurant) {
					for (CartItem cartItem : order.getCartItems()) {
						// if that cartItem already exists
						if(cartItem.getItem() == item) {
							// simply add the existing quantity to the new quantity
							cartItem.setQuantity(cartItem.getQuantity() + quantity);
							cServ.update(cartItem);
							return "redirect:/bags/orders/new/" + restId;
						} else {
							// if that cartItem doesn't exist yet
							cServ.createNew(order, item, quantity);
							return "redirect:/bags/orders/new/" + restId;
						}
					}	
				} else {
					// if none of those orders are with the restaurant
					Order thisOrder = oServ.createOrder(bag, restaurant);
					cServ.createNew(thisOrder, item, quantity);
					return "redirect:/bags/orders/new/" + restId;
				}
			}
		}
		// if there are no orders in the bag yet
		Order order = oServ.createOrder(bag, restaurant);
		cServ.createNew(order, item, quantity);
		return "redirect:/bags/orders/new/" + restId;
	}
}
