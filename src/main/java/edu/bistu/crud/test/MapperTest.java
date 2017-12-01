package edu.bistu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.bistu.crud.bean.Employee;
import edu.bistu.crud.dao.DepartmentMapper;
import edu.bistu.crud.dao.EmployeeMapper;

/**
 * 娴嬭瘯dao灞傜殑宸ヤ綔
 * @author lfy
 *鎺ㄨ崘Spring鐨勯」鐩氨鍙互浣跨敤Spring鐨勫崟鍏冩祴璇曪紝鍙互鑷姩娉ㄥ叆鎴戜滑闇�瑕佺殑缁勪欢
 *1銆佸鍏pringTest妯″潡
 *2銆丂ContextConfiguration鎸囧畾Spring閰嶇疆鏂囦欢鐨勪綅缃�
 *3銆佺洿鎺utowired瑕佷娇鐢ㄧ殑缁勪欢鍗冲彲
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 娴嬭瘯DepartmentMapper
	 */
	@Test
	public void testCRUD(){
	/*	//1銆佸垱寤篠pringIOC瀹瑰櫒
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2銆佷粠瀹瑰櫒涓幏鍙杕apper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		System.out.println(departmentMapper);
		
		//1銆佹彃鍏ュ嚑涓儴闂�
//		departmentMapper.insertSelective(new Department(null, "寮�鍙戦儴"));
//		departmentMapper.insertSelective(new Department(null, "娴嬭瘯閮�"));
		
		//2銆佺敓鎴愬憳宸ユ暟鎹紝娴嬭瘯鍛樺伐鎻掑叆
		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
		
		//3銆佹壒閲忔彃鍏ュ涓憳宸ワ紱鎵归噺锛屼娇鐢ㄥ彲浠ユ墽琛屾壒閲忔搷浣滅殑sqlSession銆�
		
//		for(){
//			employeeMapper.insertSelective(new Employee(null, , "M", "Jerry@atguigu.com", 1));
//		}
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i<1000;i++){
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null,uid, "M", uid+"@atguigu.com", 1));
		}
		System.out.println("鎵归噺瀹屾垚");
		
	}

}
