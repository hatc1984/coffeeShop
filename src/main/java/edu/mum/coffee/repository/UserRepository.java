package edu.mum.coffee.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.mum.coffee.domain.Authorities;
import edu.mum.coffee.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Serializable> {
	public User findByEmail(String email);
	public List<User> findByFirstNameLikeOrLastNameLikeAllIgnoreCase(String userName, String description);
	public List<User> findByAuthorities(Authorities authorities);
}
