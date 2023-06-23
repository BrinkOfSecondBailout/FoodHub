package com.codingdojo.foodhub.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Review;

public interface ReviewRepository extends CrudRepository<Review, Long> {
	@Query(value="SELECT * FROM reviews WHERE restaurant_id = ?1", nativeQuery = true)
	public List <Review> findAllByRestaurantId(Long id);
	
	@Query(value="SELECT * FROM reviews WHERE user_id = ?1", nativeQuery = true)
	public List <Review> findAllByUserId(Long id);
}