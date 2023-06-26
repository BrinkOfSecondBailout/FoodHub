package com.codingdojo.foodhub.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty(message="First name cannot be empty")
	private String first_name;
	
	@NotEmpty(message="Last name cannot be empty")
	private String last_name;
	
	@Email
	@NotEmpty(message="Email cannot be empty")
	private String email;
	
	@Lob
	@Column(columnDefinition="MEDIUMTEXT")
	private String profile;
	
	@Size(min=5, message="Password must contain at least 5 characters")
	private String password;
	
	@Transient
	private String confirmPw;
	
	@OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "bag_id")
    private Bag bag;
	
	@OneToMany(mappedBy="user", fetch = FetchType.LAZY)
	private List <Review> reviews;
	
	@OneToMany(mappedBy="user", fetch = FetchType.LAZY)
	private List <Comment> comments;
	
	@OneToMany(mappedBy="user", fetch=FetchType.LAZY)
	private List <Like> likes;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date created_at;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updated_at;
    
    
    
    
    public User() {}

	
    
	
    


	public Bag getBag() {
		return bag;
	}







	public void setBag(Bag bag) {
		this.bag = bag;
	}







	public List<Comment> getComments() {
		return comments;
	}







	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}







	public List<Like> getLikes() {
		return likes;
	}







	public void setLikes(List<Like> likes) {
		this.likes = likes;
	}







	public List<Review> getReviews() {
		return reviews;
	}







	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}







	public String getProfile() {
		return profile;
	}







	public void setProfile(String profile) {
		this.profile = profile;
	}







	public Long getId() {
		return id;
	}







	public void setId(Long id) {
		this.id = id;
	}







	public String getFirst_name() {
		return first_name;
	}







	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}







	public String getLast_name() {
		return last_name;
	}







	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}







	public String getEmail() {
		return email;
	}







	public void setEmail(String email) {
		this.email = email;
	}







	public String getPassword() {
		return password;
	}







	public void setPassword(String password) {
		this.password = password;
	}







	public String getConfirmPw() {
		return confirmPw;
	}







	public void setConfirmPw(String confirmPw) {
		this.confirmPw = confirmPw;
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
