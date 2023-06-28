package com.codingdojo.foodhub.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.foodhub.models.CartItem;
import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.Order;
import com.codingdojo.foodhub.repositories.CartItemRepository;

@Service
public class CartItemService {
	@Autowired
	private CartItemRepository cRepo;
	
	public CartItemService(CartItemRepository cRepo) {
		this.cRepo = cRepo;
	}
	
	public CartItem createNew(Order order, Item item, int quantity) {
		CartItem cartItem = new CartItem();
		cartItem.setOrder(order);
		cartItem.setItem(item);
		cartItem.setQuantity(quantity);
		return cRepo.save(cartItem);
	}
	
	public CartItem update(CartItem c) {
		return cRepo.save(c);
	}
	
	public CartItem findById(Long id) {
		Optional <CartItem> potentialC = cRepo.findById(id);
		if(potentialC.isEmpty()) {
			return null;
		} else {
			return potentialC.get();
		}
		
	}
	
	public void delete(CartItem c) {
		Order order = c.getOrder();
	    Item item = c.getItem();
	    order.getCartItems().remove(c);
	    c.setOrder(null);
	    item.getCartItems().remove(c);
	    c.setItem(null);
	    cRepo.delete(c);
	}
}
