package com.example.web.request;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeePasswordForm {

	@NotNull(message = "사원번호는 필수입력값입니다.")
	private Integer empNo;
	@NotBlank(message = "이메일은 필수입력값입니다.")
	private String email;
}
