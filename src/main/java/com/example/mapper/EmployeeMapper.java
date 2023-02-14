package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.employee.Employee;

@Mapper
public interface EmployeeMapper {
	
	// 관리자가 직원 등록 할때
	void insertEmployee(Employee employee);
	// 직원이 개인정보 업데이트 시
	void updateEmployee(Employee employee);
	// 직원번호로 직원 정보 얻을 때
	Employee getEmployeeByNo(int empNo);
	// 관리자가 직원관리 할때
	List<Employee> getAllEmployees();
	// 관리자가 이메일 정보로 사용자를 찾을 때
	Employee getEmployeeByEmail(String email);

}
