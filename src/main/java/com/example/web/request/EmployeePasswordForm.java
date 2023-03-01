package com.example.web.request;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmployeePasswordForm {

	private Integer empNo;
	@NotBlank(message = "이메일은 필수입력값입니다.")
	private String email;
}
