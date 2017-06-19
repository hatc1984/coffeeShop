package edu.mum.coffee.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.mum.coffee.domain.Authorities;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.repository.UserRepository;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;

	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepository.findByEmail(username);
		if (user == null) {
			throw new UsernameNotFoundException("User not found");
		}

		List<GrantedAuthority> authorities = buildUserAuthority(user.getAuthorities());

		return buildUserForAuthentication(user, authorities);
	}

	private org.springframework.security.core.userdetails.User buildUserForAuthentication(
			edu.mum.coffee.domain.User user, List<GrantedAuthority> authorities) {
		return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(),
				user.isEnable(), true, true, true, authorities);
	}

	private List<GrantedAuthority> buildUserAuthority(Set<Authorities> userRoles) {

		Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();

		// Build user's authorities
		for (Authorities userRole : userRoles) {
			setAuths.add(new SimpleGrantedAuthority(userRole.getAuthority()));
		}

		List<GrantedAuthority> Result = new ArrayList<GrantedAuthority>(setAuths);

		return Result;
	}

}