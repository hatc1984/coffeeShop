package edu.mum.coffee.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.mum.coffee.domain.Person;
import edu.mum.coffee.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Serializable> {
	public User findByEmail(String email);

}
