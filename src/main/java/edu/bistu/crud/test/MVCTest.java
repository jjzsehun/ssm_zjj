package edu.bistu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import edu.bistu.crud.bean.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
//ע��·�� ����д��ʽ����Ҫ����file:,���򱨴�Failed to load ApplicationContext and class path resource [src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml] cannot be opened because it does not exist
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {
	//����SpringMVC��IOC������@Autowiredֻ�����������еģ��������ͨ�� @WebAppConfiguration����
	@Autowired
	WebApplicationContext context;
	
	
	MockMvc mockMvc;
	//ÿ�δ�����ҪINIT�����Ե���@Before
	@Before
	public void initMockMvc()
	{
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception
	{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		PageInfo page=(PageInfo) result.getRequest().getAttribute("pageInfo");
		System.out.println(page.getPageNum());
		System.out.println(page.getPageSize());
		List<Employee> list=page.getList();
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
			
			
		}
	}
}
