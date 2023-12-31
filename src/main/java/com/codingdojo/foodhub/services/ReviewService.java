package com.codingdojo.foodhub.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.Review;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.repositories.ReviewRepository;

@Service
public class ReviewService {
	@Autowired
	private ReviewRepository rRepo;
	
	public ReviewService(ReviewRepository rRepo) {
		this.rRepo = rRepo;
	}
	
	public Review createReview(Review review, Restaurant restaurant, User user) {
		review.setRestaurant(restaurant);
		review.setUser(user);
		return rRepo.save(review);
	}
	
	public List<Review> findReviewsByRestaurant(Long id){
		return rRepo.findAllByRestaurantId(id);
	}
	
	public Integer findAverageRatingByRestaurant(Long id) {
		List <Review> reviews = rRepo.findAllByRestaurantId(id);
		Integer sum = 0;
		for (Review review : reviews) {
			Integer stars = review.getStars();
			sum += stars;
		}
		Integer count = reviews.size();
		Integer averageRating = Math.round((float) sum / count);
		return averageRating;
	}
	
	public List<Review> findReviewsByUser(Long id){
		return rRepo.findAllByUserId(id);
	}
	
	public Review findReviewById(Long id) {
		return rRepo.findReviewById(id);
	}
	
	
}
