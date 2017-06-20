package edu.mum.coffee.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.mum.coffee.domain.Authorities;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.repository.UserRepository;

@Service
@Transactional
public class UserService {
	
	private static final int PAGE_SIZE = 7;
	
	@Autowired
	private UserRepository userRepository;
	
	public User save(User user) throws Exception {
		
		User userToCheck = userRepository.findByEmail(user.getEmail());
		if (userToCheck != null) {
			throw new Exception("This Email is Existing in System");
		}
		
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
	
	public void deleteById(long userId) {
		User user = getUser(userId);
		delete(user);
	}
	
	public User getUser(long userId) {
		return  userRepository.findOne(userId);
	}
	
	public void delete(User user) {
		userRepository.delete(user);
	}
	
	public User findUser(String username) {
		return userRepository.findOne(username);
	}
	
	public List<User> findByTextSearch(String criteria) {
		if (!criteria.contains("%")) {
			criteria = "%"+criteria+"%";
		}
		return userRepository.findByFirstNameLikeOrLastNameLikeAllIgnoreCase(criteria, criteria);
	}
	
	public List<User> findByUserRole(Authorities authorities) {
		 return userRepository.findByAuthorities(authorities);
	}
	
	public Page<User> findUserPagination(Integer pageNumber) {
        PageRequest request =
            new PageRequest(pageNumber - 1, PAGE_SIZE, Sort.Direction.DESC, "firstName");
        return userRepository.findAll(request);
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
