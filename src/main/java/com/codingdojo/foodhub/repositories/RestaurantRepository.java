package com.codingdojo.foodhub.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Restaurant;

public interface RestaurantRepository extends CrudRepository<Restaurant, Long>{
	public Optional <Restaurant> findByEmail(String email);
	public Optional <Restaurant> findById(Long id);
	public Restaurant findRestaurantById(Long id);
	public List <Restaurant> findAll();
	
	public void deleteById(Long id);
}
