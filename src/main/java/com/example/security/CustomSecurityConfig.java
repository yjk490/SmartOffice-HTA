package com.example.security;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
public class CustomSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private CustomEmployeeDetailsService customEmployeeDetailsService;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
		.authorizeHttpRequests()		// 모든 요청에 대해서 인가정책을 적용하도록 한다. AuthorizeHttpRequestsConfigurer 객체를 반환한다.

		.antMatchers("/", "/login", "/logout").permitAll()
		.antMatchers("/note/**").hasRole("EMPLOYEE")
		.antMatchers("/post/**").hasAnyRole("EMPLOYEE", "ADMIN")
		.antMatchers("/todo/**").hasAnyRole("EMPLOYEE", "ADMIN")
		.antMatchers("/admin/**").hasRole("ADMIN")
		
	.and()
		// 로그인 설정
		.formLogin()
		.loginPage("/login")
		.loginProcessingUrl("/login")
		.usernameParameter("no")
		.passwordParameter("password")
		.defaultSuccessUrl("/")				// 로그인이 성공하면 홈화면으로 돌아가는 url 설정
		.failureUrl("/login?error=fail")	// 로그인 실패시 돌아가도록 하는 url인데 아직 구현 전..
	
	.and()
		
		// 로그아웃
		.logout()
		.logoutUrl("/logout")
		.logoutSuccessUrl("/");
	}
	
	// 이미지, 스타일시트, 자바스크립트소스와 같은 정적 컨텐츠는 인증/인가 작업을 수행하지 않도록 설정한다.
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**", "/favicon.ico");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customEmployeeDetailsService).passwordEncoder(passwordEncoder);
	}

}
