package edu.bistu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import edu.bistu.crud.bean.Employee;
import edu.bistu.crud.bean.Msg;
import edu.bistu.crud.service.EmployeeService;

/**
 * 处理员工CRUD请求
 * @author zjj
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
/*	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids)
	{
		if(ids.contains("-"))
		{
			List<Integer> empIds = new ArrayList<>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				empIds.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(empIds);
			System.out.println("cheng");
		}
		else
		{
			Integer empId = Integer.parseInt(ids);
			employeeService.deleteEmpById(empId);
		}
		return Msg.success();
	}
	*/
	
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//批量删除
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else{
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}
		return Msg.success();
	}
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg update(Employee employee)
	{
		employeeService.updateEmployee(employee);
		return Msg.success();
	}
/*	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("empId") Integer empId) {
		employeeService.deleteEmpById(empId);
		return Msg.success().add("success", "good");
	}*/
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg findEmpById(@PathVariable("id")Integer id)
	{
		Employee emp = employeeService.findEmpById(id);
		return Msg.success().add("emp", emp);
	}
	
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	/*@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		
		Employee employee = employeeService.findEmpById(id);
		return Msg.success().add("emp", employee);
	}*/
	
	
	@RequestMapping(value="/validName",method=RequestMethod.POST)
	@ResponseBody
	public Msg validName(@RequestParam(required=false) String empName) {
		
		boolean isChecked = employeeService.checkName(empName);
		if(isChecked == true)
		{		
			return Msg.success().add("success", "该用户不存在，可用");
		}else {
			return Msg.failure().add("error", "该用户已存在");
		}
		
	}
	
	
	
	
	
	@RequestMapping(value="/emps",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmployeesByJson(@RequestParam(value="pn",defaultValue="1",required=false) Integer pn,
			@RequestParam(value="startRow",defaultValue="1",required=false)Integer startRow, @RequestParam(value="averPage",defaultValue="5",required=false)Integer averPage)
	{
		
		PageHelper.startPage(pn,averPage);
		List<Employee> emps = employeeService.findAll();
		PageInfo pi = new PageInfo(emps);
		return Msg.success().add("emps", pi);
	}
	
	
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody	
	public Msg insertEmployee(@Valid Employee employee, BindingResult br)
	{
		Map<String, Object> map = new HashMap<>();
		if(br.hasErrors())
		{
			List<FieldError> error = br.getFieldErrors();
			for (Iterator iterator = error.iterator(); iterator.hasNext();) {
				FieldError fieldError = (FieldError) iterator.next();
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
				System.out.println(fieldError.getField());
				System.out.println(fieldError.getDefaultMessage());
			}
			return Msg.failure().add("error", map);
		}else {
		employeeService.addEmployee(employee);
		return Msg.success();
		}
	}
	
	
	
	/*@RequestMapping("/emps")
	public String Employees(@RequestParam(value="pn",defaultValue="1")Integer pn, @RequestParam(value="1",defaultValue="3")Integer pgsize, Model model) 
	{
		//获取第pn页，5条内容，默认查询总数count
		PageHelper.startPage(pn,pgsize);
		//紧接着的这个查询就是一个分页查询
		List<Employee> employees = employeeService.findAll();
		//使用PageInfo对查询后的结果进行包装，只需要将pageInfo交给页面就行，PageInfo中已包含了分页的大部分信息，可以直接返回PageInfo给页面
		//PageInfo方法的第二个参数是连续显示几页
		PageInfo page = new PageInfo(employees,5);
		model.addAttribute("pageInfo", page);
		return "list";
		
	}*/
	

}
