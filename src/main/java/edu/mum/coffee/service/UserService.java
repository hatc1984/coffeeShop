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

import edu.mum.coffee.domain.Address;
import edu.mum.coffee.domain.Authorities;
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
	
	public User adminSaveUser(User user) throws Exception {
		if (!user.getPassword().equals(user.getPasswordConfirm())) {
			throw new Exception("Password and confirm Password not match");
		}
		
		User userToCheck = userRepository.findByEmail(user.getEmail());
		if (userToCheck != null) {
			throw new Exception("This Email is Existing in System");
		}
		user.setEnable(true);
		user.setPassword(encodePassword(user.getPassword()));

		Set<Authorities> authorities = new HashSet<>();
		Authorities authority = new Authorities();
		authority.setAuthority(user.getAuthority());
		authority.setUser(user);
		authorities.add(authority);
		user.setAuthorities(authorities);
		
		return userRepository.save(user);
	}
	
	public User update(User user) throws Exception {
		
		user.setEnable(true);
		
		User userToCheck = userRepository.findByEmail(user.getEmail());
		Address address = userToCheck.getAddress();
		address.setCity(user.getAddress().getCity());
		address.setCountry(user.getAddress().getCountry());
		address.setState(user.getAddress().getState());
		address.setZipcode(user.getAddress().getZipcode());
		user.setAddress(address);
		user.setAuthorities(userToCheck.getAuthorities());
		user.updateAuthorities();
		user.setPassword(userToCheck.getPassword());
		user.setPasswordConfirm(userToCheck.getPassword());
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
	
	public List<User> findByTextSearch(String criteria) {
		if (!criteria.contains("%")) {
			criteria = "%"+criteria+"%";
		}
		return userRepository.findByFirstNameLikeOrLastNameLikeAllIgnoreCase(criteria, criteria);
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

	public User findUserByEmail(String username) {
		return userRepository.findByEmail(username);
	}
}
