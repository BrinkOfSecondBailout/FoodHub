package com.codingdojo.foodhub.repositories;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Restaurant;

public interface RestaurantRepository extends CrudRepository<Restaurant, Long>{

}
