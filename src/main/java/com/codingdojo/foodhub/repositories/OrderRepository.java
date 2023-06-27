package com.codingdojo.foodhub.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Order;

public interface OrderRepository extends CrudRepository<Order, Long>{
	public List<Order> findAllOrdersByRestaurant(Long id);
}
