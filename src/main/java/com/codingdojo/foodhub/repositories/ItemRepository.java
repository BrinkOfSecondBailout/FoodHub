package com.codingdojo.foodhub.repositories;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Item;

public interface ItemRepository extends CrudRepository<Item, Long>{
	
}
