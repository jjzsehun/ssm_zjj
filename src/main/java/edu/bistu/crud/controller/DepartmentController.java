package edu.bistu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.bistu.crud.bean.Department;
import edu.bistu.crud.bean.Msg;
import edu.bistu.crud.service.DepartmentService;
@Controller
public class DepartmentController {
	
	/*@Autowired
	private DepartmentService departmentService;
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getAllDept()
	{
		
		List<Department> depts = departmentService.getAllDept();
		return Msg.success().add("depts", depts);
	}*/
	
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有的部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		//查出的所有部门信息
		List<Department> list = departmentService.getAllDept();
		return Msg.success().add("depts", list);
	}

	
}
