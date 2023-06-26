package com.codingdojo.foodhub.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.foodhub.models.Comment;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.Review;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.repositories.CommentRepository;

@Service
public class CommentService {
	@Autowired
	private CommentRepository cRepo;
	
	public CommentService(CommentRepository cRepo) {
		this.cRepo = cRepo;
	}
	
	public Comment createComment(Comment comment, Review review, User user, Restaurant restaurant) {
		comment.setReview(review);
		comment.setUser(user);
		comment.setRestaurant(restaurant);
		return cRepo.save(comment);
	}
	
	public List<Comment> findAllCommentsByReview(Long id) {
		return cRepo.findAllByReviewId(id);
	}
	
	public Comment findCommentById(Long id) {
		Optional <Comment> potentialCom = cRepo.findById(id);
		if(potentialCom.isEmpty()) {
			return null;
		} else {
			return potentialCom.get();
		}
	}
	
	
	
}
