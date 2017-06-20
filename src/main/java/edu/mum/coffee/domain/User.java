package edu.mum.coffee.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
public class User extends Person {
	
	@NotNull
	@NotEmpty
	private String password;
	
	@Transient
	private String passwordConfirm;

	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private Set<Authorities> authorities;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Set<Authorities> getAuthorities() {
		return authorities;
	}

	public String getAuthority() {
		return authorities.iterator().next().getAuthority();
	}
	public void setAuthorities(Set<Authorities> authorities) {
		this.authorities = authorities;
	}

	public String getPasswordConfirm() {
		return passwordConfirm;
	}

	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
	}

}
