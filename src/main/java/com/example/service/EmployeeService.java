package com.example.service;

import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.emp.EmployeeDetailDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.vo.employee.Employee;
import com.example.vo.employee.EmployeeRole;
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
	
	// 이름으로 직원 정보 출력(쪽지 부분 모달에서 활용됨)
	public List<EmployeeDetailDto> getEmpDetailByName(String name) {
		return  employeeMapper.getEmployeeByName(name);
		
	}

	// 회원가입
	public Employee registerEmployee(EmployeeRegisterform employeeRegisterform) {
		Employee emp = employeeMapper.getEmployeeByEmail(employeeRegisterform.getEmail());
		if(emp != null) {
			throw new AlreadyRegisteredEmailException("["+employeeRegisterform.getEmail()+"] 사용할 수 없는 이메일입니다.");
		}
		
		Employee employee = new Employee();
		BeanUtils.copyProperties(employeeRegisterform, employee);
		
		employee.setEncryptPassword(passwordEncoder.encode(employeeRegisterform.getPassword()));
		employeeMapper.insertEmployee(employee);
		
		List<String> rolesNames = employeeRegisterform.getRoleName();
		for (String roleName : rolesNames) {
			EmployeeRole employeeRole = new EmployeeRole(employee.getNo(), roleName);
			employeeRoleMapper.insertEmpRole(employeeRole);
		}
		
		return employee;
	}
	
	// 관리자 페이지에서 회원 등록 후 insertEmp 정보 출력로직
	public EmployeeDetailDto getInsertEmployeeDetail(int no) {
		EmployeeDetailDto employeeDetailDto = employeeMapper.getInsertEmployeeByNo(no);
		List<EmployeeRole> employeeRoles = employeeRoleMapper.getEmpRolesByEmployeeNo(no);
		
		employeeDetailDto.setEmpRoles(employeeRoles);
		
		return employeeDetailDto;
	}

}
