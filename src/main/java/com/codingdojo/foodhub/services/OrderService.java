package com.codingdojo.foodhub.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.foodhub.models.Bag;
import com.codingdojo.foodhub.models.Order;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.repositories.OrderRepository;

@Service
public class OrderService {
	@Autowired
	private OrderRepository oRepo;
	
	
	public OrderService(OrderRepository oRepo) {
		this.oRepo = oRepo;
	}
	
	public Order createOrder(Bag bag, Restaurant restaurant) {
		Order newOrder = new Order();
		newOrder.setBag(bag);
		newOrder.setRestaurant(restaurant);
		return oRepo.save(newOrder);
	}
	
	
	public List<Order> findAllByRestaurant(Long id) {
		return oRepo.findAllOrdersByRestaurant(id);
	}
}
