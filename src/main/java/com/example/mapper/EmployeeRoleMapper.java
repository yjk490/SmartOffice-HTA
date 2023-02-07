package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.EmployeeRole;

@Mapper
public interface EmployeeRoleMapper {
	
	void insertEmpRole(EmployeeRole employeeRole);
	void deleteEmpRole(EmployeeRole employeeRole);
	List<EmployeeRole> getEmpRolesByEmployeeNo(int empNo);

}
