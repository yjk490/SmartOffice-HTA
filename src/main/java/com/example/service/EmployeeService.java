package com.example.service;

import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.dto.EmployeeDetailDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.vo.Employee;
import com.example.vo.EmployeeRole;
import com.example.web.request.EmployeeRegisterform;

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

	// 회원가입
	public void registerEmployee(EmployeeRegisterform employeeRegisterform) {
		Employee emp = employeeMapper.getEmployeeByEmail(employeeRegisterform.getEmail());
		if(emp != null) {
			throw new AlreadyRegisteredEmailException("["+employeeRegisterform.getEmail()+"] 사용할 수 없는 이메일입니다.");
		}
		
		Employee employee = new Employee();
		BeanUtils.copyProperties(employeeRegisterform, employee);
		
		employee.setEncryptPassword(passwordEncoder.encode(employeeRegisterform.getPassword()));
		employeeMapper.insertEmployee(employee);
		
		System.out.println("번호? " + employee.getNo());
		
		List<String> rolesNames = employeeRegisterform.getRoleName();
		for (String roleName : rolesNames) {
			EmployeeRole employeeRole = new EmployeeRole(employee.getNo(), roleName);
			employeeRoleMapper.insertEmpRole(employeeRole);
		}
		
	}

}
