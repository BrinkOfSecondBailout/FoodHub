package com.codingdojo.foodhub.services;

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
}
