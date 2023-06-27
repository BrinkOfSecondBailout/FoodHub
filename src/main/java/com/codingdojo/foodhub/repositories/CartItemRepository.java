package com.codingdojo.foodhub.repositories;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.CartItem;

public interface CartItemRepository extends CrudRepository<CartItem, Long> {
	
}
