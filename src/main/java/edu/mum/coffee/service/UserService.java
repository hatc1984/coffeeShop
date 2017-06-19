package edu.mum.coffee.service;

import java.util.HashSet;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.mum.coffee.domain.Authorities;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.repository.UserRepository;

@Service
@Transactional
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	public User save(User user) {
		user.setEnable(true);
		user.setPassword(encodePassword(user.getPassword()));

		Set<Authorities> authorities = new HashSet<>();
		Authorities authority = new Authorities();
		authority.setAuthority("ROLE_USER");
		authority.setUser(user);
		authorities.add(authority);
		user.setAuthorities(authorities);
		
		return userRepository.save(user);
	}
	
	public User findUser(String username) {
		return userRepository.findOne(username);
	}

	public String encodePassword(String password) {
		return new BCryptPasswordEncoder().encode(password);
	}

	public User authenticate(User user) {
		User userFindOne = userRepository.findOne(user.getEmail());
		if (userFindOne == null) {
			return null;
		}
		if (userFindOne.getPassword().equals(user.getPassword())) {
			return null;
		}
		return userFindOne;
	}
}
