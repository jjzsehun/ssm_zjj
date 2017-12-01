package edu.bistu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.bistu.crud.bean.Employee;
import edu.bistu.crud.bean.EmployeeExample;
import edu.bistu.crud.bean.EmployeeExample.Criteria;
import edu.bistu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	public List<Employee> findAll() {
		
		//查询带有部门信息的所有员工，条件为null
		List<Employee> emps = employeeMapper.selectWithDeptByExample(null);
		return emps;
		
	}
	public void addEmployee(Employee employee) {
		
		employeeMapper.insertSelective(employee);
		
	}
	public boolean checkName(String empName) {
		
		EmployeeExample employeeExample=new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		int count = (int) employeeMapper.countByExample(employeeExample);
		return count == 0;
		
		
		
	}
	public Employee findEmpById(Integer id) {
		Employee emp = employeeMapper.selectByPrimaryKey(id);
		return emp;
	}
	public void updateEmployee(Employee employee) {
		
		employeeMapper.updateByPrimaryKeySelective(employee);
		
	}
	public void deleteEmpById(Integer empId) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(empId);
	}
	public void deleteBatch(List<Integer> empIds) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(empIds);
		employeeMapper.deleteByExample(example);
		
	}

	
}
