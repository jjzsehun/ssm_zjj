package edu.bistu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.bistu.crud.bean.Department;
import edu.bistu.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	public List<Department> getAllDept() {
		List<Department> depts = departmentMapper.selectByExample(null);
		return depts;
	}

	
}
