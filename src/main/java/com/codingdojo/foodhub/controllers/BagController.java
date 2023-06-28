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
		List<Order> orders = bag.getOrders();
		boolean restaurantExists = false;
		// if there are already orders in the bag
		if (orders != null) {
			for( Order order: orders) {
				// check if one of those orders are with the restaurant
				if(order.getRestaurant() == restaurant) {
					restaurantExists = true;
					boolean itemExists = false;
					for (CartItem cartItem : order.getCartItems()) {
						if(cartItem.getItem() == item) {
							// if that cartItem already exists
							// simply add the existing quantity to the new quantity
							cartItem.setQuantity(cartItem.getQuantity() + quantity);
							cServ.update(cartItem);
							itemExists = true;
							break;
						}
					}	
					// if that cartItem doesn't exist yet
					if(!itemExists) {
						cServ.createNew(order, item, quantity);					
					}
					break;
				}
			}
		}
		if(!restaurantExists) {
			// if none of those orders are with the restaurant
			Order thisOrder = oServ.createOrder(bag, restaurant);
			cServ.createNew(thisOrder, item, quantity);					
		}
		return "redirect:/bags/orders/new/" + restId;
	}
	
	@GetMapping("/bags/increase/{bid}/{id}")
	public String increaseQuantity(@PathVariable("id") Long id, 
			@PathVariable("bid") Long bagId, 
			HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		CartItem cartItem = cServ.findById(id);
		cartItem.setQuantity(cartItem.getQuantity() + 1);
		cServ.update(cartItem);
		return "redirect:/bags/show/" + bagId;
	}
	
	@GetMapping("/bags/decrease/{bid}/{id}")
	public String decreaseQuantity(@PathVariable("id") Long id, 
			@PathVariable("bid") Long bagId, 
			HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		CartItem cartItem = cServ.findById(id);
		if(cartItem.getQuantity() == 1) {
			Long orderId = cartItem.getOrder().getId();
			return "redirect:/bags/remove/" + orderId + "/" + id;
		}
		cartItem.setQuantity(cartItem.getQuantity() - 1);
		cServ.update(cartItem);
		return "redirect:/bags/show/" + bagId;
	}
	
	
	@GetMapping("/bags/remove/{oid}/{cid}")
	public String removeItemFromOrder(@PathVariable("oid") Long orderId,
			@PathVariable("cid") Long cartItemId,
			HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		Order order = oServ.findById(orderId);
		List <CartItem> cartItems = order.getCartItems();
		for (CartItem cartItem:cartItems) {
			if(cartItem.getId() == cartItemId) {
				cServ.delete(cartItem);
				break;
			}
		}
		User user = uServ.findUserById((Long) session.getAttribute("userId"));
		Long bagId = user.getBag().getId();
		return "redirect:/bags/show/" + bagId;
	}
	
	@GetMapping("/bags/order/remove/{oid}")
	public String removeOrderFromBag(@PathVariable("oid") Long orderId, 
			HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		Order order = oServ.findById(orderId);
		Long bagId = order.getBag().getId();
		oServ.deleteOrder(order);
		return "redirect:/bags/show/" + bagId;
	}
	
}
