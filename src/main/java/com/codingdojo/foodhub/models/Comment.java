package com.codingdojo.foodhub.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="comments")
public class Comment {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty(message="Please type a comment!")
	@Size(min = 10, max = 200, message = "Comment must be between 10 and 200 characters!")
	private String comment_text;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="review_id")
	private Review review;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User user;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date created_at;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updated_at;
    
    
    
    public Comment() {}
    
    



	public Long getId() {
		return id;
	}





	public void setId(Long id) {
		this.id = id;
	}





	public String getComment_text() {
		return comment_text;
	}





	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}





	public Review getReview() {
		return review;
	}





	public void setReview(Review review) {
		this.review = review;
	}





	public User getUser() {
		return user;
	}





	public void setUser(User user) {
		this.user = user;
	}





	public Date getCreated_at() {
		return created_at;
	}





	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}





	public Date getUpdated_at() {
		return updated_at;
	}





	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}





	@PrePersist
    protected void onCreate(){
        this.created_at = new Date();
    }
	
}
