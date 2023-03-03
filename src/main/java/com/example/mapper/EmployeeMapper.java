package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.example.dto.emp.EmployeeDetailDto;
import com.example.dto.emp.EmployeeListDto;
import com.example.vo.employee.Employee;

@Mapper
public interface EmployeeMapper {
	
	// 관리자가 직원 등록 할때
	void insertEmployee(Employee employee);
	// 직원이 개인정보 업데이트 시
	void updateEmployee(Employee employee);
	// 직원번호로 직원 정보 얻을 때
	Employee getEmployeeByNo(int empNo);
	// 관리자가 이메일 정보로 사용자를 찾을 때
	Employee getEmployeeByEmail(String email);
	// 관리자가 사용자를 등록하고 그 사용자 정보를 출력 받을 때 사용하기 위함
	EmployeeDetailDto getInsertEmployeeByNo(int empno);
	// 쪽지보내기에서 이름 모달창에 검색하고 이름으로 직원들 정보를 받을 때
	List<EmployeeDetailDto> getEmployeeByName(String name);
	
	// 관리자가 직원관리 할때 전체직원 리스트
	List<EmployeeListDto> getAllEmployees(Map<String, Object> param);
	// 전체 사원의 수
	int getAllEmployeeTotalRows(Map<String, Object> param);

	//전체 사원 번호와 이름만 가져옴.
		List<Employee> getAllEmployeesNameNo();
}
