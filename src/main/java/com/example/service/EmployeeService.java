package com.example.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.emp.EmployeeDetailDto;
import com.example.dto.emp.EmployeeListDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.ApplicationException;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.utils.Pagination;
import com.example.vo.employee.Employee;
import com.example.vo.employee.EmployeeRole;
import com.example.web.request.EmployeePasswordForm;
import com.example.web.request.EmployeeRegisterform;

@Service
@Transactional
public class EmployeeService {
	
	@Value("${smartoffice-team2.default-profile-image}")
	private String defaultProfileImage;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	@Autowired
	private EmployeeRoleMapper employeeRoleMapper;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// 사원의 디테일 정보 가져오기
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
		
		if (employee.getPhoto() == null) {
			employee.setPhoto(defaultProfileImage);			
		}
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

	// 모든 사원정보 가져오기
	public Map<String, Object> getAllEmployees(Map<String, Object> param) {
		int totalRows = employeeMapper.getAllEmployeeTotalRows(param);
		int page = (Integer)param.get("page");
		int rows = (Integer)param.get("rows");
		Pagination pagination = new Pagination(page,totalRows, rows);
		
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		List<EmployeeListDto> employees = employeeMapper.getAllEmployees(param);
		
		Map<String, Object> result = new HashMap<>();
		result.put("employees", employees);
		result.put("pagination", pagination);
		
		return result;
	}

	// 사원 번호를 받아서 해당 사원 사용 중지 시키기
	public void stopEmployees(List<Integer> empNos) {
		for(int empNo : empNos) {
			Employee employee = employeeMapper.getEmployeeByNo(empNo);
			employee.setStatus("S");
			
			employeeMapper.updateEmployee(employee);
		}
		
	}

	// 사원 번호를 받아서 해당 사원 사용 해지 시키기
	public void deleteEmployees(List<Integer> empNos) {
		for(int empNo : empNos) {
			Employee employee = employeeMapper.getEmployeeByNo(empNo);
			employee.setStatus("D");
			
			employeeMapper.updateEmployee(employee);
		}
		
	}
	
	// 사원 번호를 받아서 해당 사원 사용 복구 시키기
	public void backEmployees(List<Integer> empNos) {
		for(int empNo : empNos) {
			Employee employee = employeeMapper.getEmployeeByNo(empNo);
			employee.setStatus("Y");
			
			employeeMapper.updateEmployee(employee);
		}
		
	}

	// 비밀번호 바꾸기
	public void changePassword(int empNo, String oldPassword, String password) {
		Employee employee = employeeMapper.getEmployeeByNo(empNo);
		
		if(employee == null) {
			throw new ApplicationException("직원 정보가 존재하지 않아서 비밀번호를 변경할 수 없습니다.");
		}
		if("S".equals(employee.getStatus())) {
			throw new ApplicationException("사용 중지 처리된 직원의 비밀번호를 변경할 수 없습니다.");
		}
		if("D".equals(employee.getStatus())) {
			throw new ApplicationException("사용 중지 처리된 직원의 비밀번호를 변경할 수 없습니다.");
		}
		if (!passwordEncoder.matches(oldPassword, employee.getEncryptPassword())) {
			throw new ApplicationException("비밀번호가 일치하지 않아서 비밀번호를 변경할 수 없습니다.");
		}
		
		employee.setEncryptPassword(passwordEncoder.encode(password));
		employeeMapper.updateEmployee(employee);
		
	}

	// 프로필 사진 업데이트
	public void updateProfile(int empNo, String filename) throws IOException {
		Employee employee = employeeMapper.getEmployeeByNo(empNo);
		employee.setPhoto(filename);
		employeeMapper.updateEmployee(employee);
	}

	// 임시비밀번호로 비밀번호 업데이트 시키기
	public String getUpdateTemporaryPassword(@Valid EmployeePasswordForm employeePasswordForm) {
		
		Employee employee = employeeMapper.getEmployeeByNo(employeePasswordForm.getEmpNo());
		String str = getTemporaryPassword();
		
		employee.setEncryptPassword(passwordEncoder.encode(str));
		employeeMapper.updateEmployee(employee);
		
		return str;
		
	}
	
	// 임시비밀번호 발급
	public String getTemporaryPassword() {
		char[] charSet = new char[] {'0','1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'!', '@', '^', '*', '_'};
		String str = "";
		int idx = 0;
		for (int i = 0; i < 10; i++) {
			idx = (int) (charSet.length * Math.random());
			str += charSet[idx];
		}
		return str;
		
	}


}
