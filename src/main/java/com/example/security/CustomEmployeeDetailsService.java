package com.example.security;

import java.util.ArrayList;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.vo.employee.Employee;
import com.example.vo.employee.EmployeeRole;

@Service
public class CustomEmployeeDetailsService implements UserDetailsService {

	@Autowired
	private EmployeeMapper employeeMapper;
	@Autowired
	private EmployeeRoleMapper employeeRoleMapper;
	
	@Override
	public UserDetails loadUserByUsername(String no) throws UsernameNotFoundException {
		
		// String 변수를 int로 바꿔서 getEmployeeByNo에 변수를 넣는다
		Employee employee = employeeMapper.getEmployeeByNo(Integer.parseInt(no));
		
		if(employee == null) {
			throw new UsernameNotFoundException("직원 정보가 존재하지 않습니다.");
		}
		
		if("S".equals(employee.getStatus())) {
			throw new UsernameNotFoundException("권한이 중지 처리된 사용자입니다.");
		}
		if("D".equals(employee.getStatus())) {
			throw new UsernameNotFoundException("권한이 해지 처리된 사용자입니다.");
		}
		
		List<EmployeeRole> employeeRoles = employeeRoleMapper.getEmpRolesByEmployeeNo(Integer.parseInt(no));
		Collection<? extends GrantedAuthority> authorities = this.getAuthorities(employeeRoles);
		
		return new CustomEmployeeDetails(
			Integer.toString(employee.getNo()),		// 사용자 아이디
			employee.getEncryptPassword(),			// 암호화된 사용자 비밀번호
			employee.getName(),						// 사용자 이름
			authorities);							// 사용자 권한 정보
	}

	private Collection<? extends GrantedAuthority> getAuthorities(List<EmployeeRole> employeeRoles) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for(EmployeeRole employeeRole : employeeRoles) {
			SimpleGrantedAuthority authority = new SimpleGrantedAuthority(employeeRole.getRoleName());
			authorities.add(authority);
		}
		return authorities;
	}
}
