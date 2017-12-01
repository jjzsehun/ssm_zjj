package edu.bistu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.bistu.crud.bean.Department;

import edu.bistu.crud.bean.Employee;
import edu.bistu.crud.dao.DepartmentMapper;
import edu.bistu.crud.dao.EmployeeMapper;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class DBTest {
	@Autowired
	private DepartmentMapper departmentMapper;
	@Autowired
	private EmployeeMapper employeeMapper;
	@Autowired
	private SqlSession sqlsession;
	@Test
	public void testCRUD()
	{
		System.out.println(departmentMapper);
		departmentMapper.insertSelective(new Department(1,"zjj"));
		departmentMapper.insertSelective(new Department(2,"zk"));
		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
		/*employeeMapper.insertSelective(new Employee(10,"zjj","M","ajd",1));*/
		/*EmployeeMapper mapper = sqlsession.getMapper(EmployeeMapper.class);
		for(int i=0; i<100;i++)
		{
			String uid=(String) UUID.randomUUID().toString().substring(0, 5);
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@bistu.edu",1));
		}*/
	}

}
