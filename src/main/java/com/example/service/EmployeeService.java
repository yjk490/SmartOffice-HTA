package com.example.service;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.EmployeeDetailDto;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.vo.Employee;
import com.example.vo.EmployeeRole;

@Service
@Transactional
public class EmployeeService {
	
	@Autowired
	private EmployeeMapper employeeMapper;
	@Autowired
	private EmployeeRoleMapper employeeRoleMapper;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public EmployeeDetailDto getEmplDetail(int no) {
		Employee employee = employeeMapper.getEmployeeByNo(no);
		List<EmployeeRole> employeeRoles = employeeRoleMapper.getEmpRolesByEmployeeNo(no);
		
		
		EmployeeDetailDto employeeDetailDto = new EmployeeDetailDto();
		BeanUtils.copyProperties(employee, employeeDetailDto);
		employeeDetailDto.setEmpRoles(employeeRoles);
		
		return employeeDetailDto;
	}

}
