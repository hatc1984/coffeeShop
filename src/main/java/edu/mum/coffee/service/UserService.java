package edu.mum.coffee.service;

import java.util.HashSet;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.mum.coffee.domain.Address;
import edu.mum.coffee.domain.Authorities;
import edu.mum.coffee.domain.Person;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.repository.PersonRepository;
import edu.mum.coffee.repository.UserRepository;

@Service
@Transactional
public class UserService {
	
	private static final String DEFAULT_PHONE = "(123) 789-1234";
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private PersonRepository personRepository;
	
	public User save(User user) {
		user.setEnable(true);

		Set<Authorities> authorities = new HashSet<>();
		Authorities authority = new Authorities();
		authority.setAuthority("ROLE_USER");
		authority.setUser(user);
		authorities.add(authority);
		user.setAuthorities(authorities);
		
		Person person = createPersonByUser(user);
		personRepository.save(person);
		return userRepository.save(user);
	}
	
	public User findUser(String username) {
		return userRepository.findOne(username);
	}

	public String encodePassword(String password) {
		return new BCryptPasswordEncoder().encode(password);
	}

	private Person createPersonByUser(User user) {
		Person person = new Person();
		person.setEmail(user.getUserName());
		person.setEnable(true);
		person.setFirstName(user.getFirstName());
		person.setLastName(user.getLastName());
		person.setPhone(DEFAULT_PHONE);
		person.setAddress(new Address("FairField", "IA", "US", "52766"));
		return person;
	}
	
	public User authenticate(User user) {
		User users = userRepository.findOne(user.getUserName());
		if (users == null) {
			return null;
		}
		if (users.getPassword().equals(user.getPassword())) {
			return null;
		}
		return users;
	}
}
