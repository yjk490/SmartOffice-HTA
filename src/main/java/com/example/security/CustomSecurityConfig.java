package com.example.security;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@EnableWebSecurity
public class CustomSecurityConfig extends WebSecurityConfigurerAdapter {
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			
		.authorizeHttpRequests()		// 모든 요청에 대해서 인가정책을 적용하도록 한다. AuthorizeHttpRequestsConfigurer 객체를 반환한다.
		.antMatchers("/", "/note").permitAll();
		
	}
	
	// 이미지, 스타일시트, 자바스크립트소스와 같은 정적 컨텐츠는 인증/인가 작업을 수행하지 않도록 설정한다.
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**", "/favicon.ico");
	}

}
