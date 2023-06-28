package com.codingdojo.foodhub.repositories;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.CartItem;

public interface CartItemRepository extends CrudRepository<CartItem, Long> {
	public Optional<CartItem> findById(Long id);
}
