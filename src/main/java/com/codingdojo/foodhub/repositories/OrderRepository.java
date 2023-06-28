package com.codingdojo.foodhub.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Order;

public interface OrderRepository extends CrudRepository<Order, Long>{
	public Optional<Order> findById(Long id);
	public List<Order> findAllOrdersByRestaurant(Long id);
}
