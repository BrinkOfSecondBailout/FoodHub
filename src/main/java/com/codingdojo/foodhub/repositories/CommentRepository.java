package com.codingdojo.foodhub.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Comment;

public interface CommentRepository extends CrudRepository<Comment, Long>{
	@Query(value="SELECT * FROM comments WHERE review_id = ?1", nativeQuery = true)
	public List<Comment> findAllByReviewId(Long id);
}
