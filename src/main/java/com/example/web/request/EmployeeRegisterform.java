package com.example.web.request;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class EmployeeRegisterform {
	
	@Size(min = 1, message = "접속권한은 하나 이상 선택해주세요")
	private List<String> roleName;
	
	@NotBlank(message = "비밀번호는 필수입력값입니다.")
	@Pattern(regexp = "^(?=.*[a-z])(?=.*\\d)[a-zA-Z\\d]{8,}$", message = "비밀번호는 최소 8자 이상, 소문자 하나 이상 및 숫자 하나 이상이 포함되어야 합니다.")
	private String password;
	
	@NotBlank(message = "이름은 필수입력값입니다.")
	@Pattern(regexp = "^[가-힣]{2,}$", message = "이름은 한글 2글자 이상으로 입력하세요.")
	private String name;
	
	@NotBlank(message = "전화번호는 필수입력값입니다.")
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "유효한 전화번호 형식이 아닙니다.")
	private String tel;
	
	@NotBlank(message = "이메일은 필수입력값입니다.")
	@Email(message = "유효한 이메일 형식이 아닙니다.")
	private String email;
	
	@NotNull(message = "부서 선택은 필수입력값입니다.")
	private Integer departmentNo;
	
	@NotNull(message = "직급 선택은 필수입력값입니다.")
	private Integer positionNo;
	
	@NotNull(message = "입사일은 필수입력값입니다.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hireDate;

}
