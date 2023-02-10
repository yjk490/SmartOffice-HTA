package com.example.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomEmployeeDetails extends LoginEmployee implements UserDetails {
	
	private static final long serialVersionUID = 5248469338625599498L;
	
	private Collection<? extends GrantedAuthority> authorities;
	
	public CustomEmployeeDetails(String empNo, 
								String password, 
								String userName, 
								Collection<? extends GrantedAuthority> authorities) {
		super(Integer.parseInt(empNo), password, userName);
		this.authorities = authorities;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return getEncryptPassword();
	}

	@Override
	public String getUsername() {
		return Integer.toString(getNo());
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
	
	
}
