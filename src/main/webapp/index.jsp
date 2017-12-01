<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>


<body>

	<div class="container">

		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary btn-lg"
					id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除
				</button>
			</div>
		</div>
		<div class="row clearfix">
			<div class="col-md-12 column">
				<table class="table table-hover" id="empsTable">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"/></th>
							<th>id</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>住址</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>

				<div class="row">

					<div class="col-md-3" id="navAver"></div>
					<div class="col-md-4" id="navInfos"></div>
					<div class="col-md-3" id="navInfo"></div>
				</div>
				<!-- 添加信息模态框 -->				
				 <div class="modal fade" id="addUserModal" tabindex="-1"
					role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h1>新增用户</h1>
							</div>
							<div class="modal-body">
								<form class="form-horizontal" id="add_emp">

									<div class="form-group">
										<label class="col-sm-2 control-label">姓名</label>
										<div class="col-sm-10">
											<input type="text" name="empName" class="form-control"
												id="name" placeholder="zjj">
											<span id="helpBlock2" class="help-block"></span>
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-2 control-label">email</label>
										<div class="col-sm-10">
											<input type="text" name="email" class="form-control"
												id="email" placeholder="123@qq.com">
											<span id="helpBlock3" class="help-block"></span>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">性别</label> <label
											class="radio-inline"> <input type="radio"
											name="gender" id="gender" value="M">男
										</label> <label class="radio-inline"> <input type="radio"
											name="gender" id="gender" value="F"> 女
										</label>
									</div>


									<div class="form-group">
										<label class="col-sm-2 control-label">所在部门</label>
										<div class="col-sm-2 control-label">
											<select class="form-control" name="dId" id="deptInfo">

											</select>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
						</div>
					</div>
				</div>
				
				<!-- 修改信息模态框 -->
				<div class="modal fade" id="modifyUserModal" tabindex="-1"
					role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h1>修改用户信息</h1>
							</div>
							<div class="modal-body">
								<form class="form-horizontal" id="add_emp">

									<div class="form-group">
										<label class="col-sm-2 control-label">姓名</label>
										<div class="col-sm-10">
										<!-- 	<input type="text" name="empName" class="form-control"
												id="name_modify" placeholder="zjj">
											<span id="helpBlock2" class="help-block"></span> -->
											 <p class="form-control-static" id="name_modify"></p>
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-2 control-label">email</label>
										<div class="col-sm-10">
											<input type="text" name="email" class="form-control"
												id="email_modify" placeholder="123@qq.com">
											<span id="helpBlock3" class="help-block"></span>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">性别</label> <label
											class="radio-inline"> <input type="radio"
											name="gender" id="gender_modify" value="M">男
										</label> <label class="radio-inline"> <input type="radio"
											name="gender" id="gender_modify" value="F"> 女
										</label>
									</div>


									<div class="form-group">
										<label class="col-sm-2 control-label">所在部门</label>
										<div class="col-sm-2 control-label">
											<select class="form-control" name="dId" id="deptInfo_modify">

											</select>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="emp_modify_btn">保存</button>
						</div>
					</div>
				</div>
				
				
				
				<script type="text/javascript">
				var totalItems=0;
				var currentPage = 0;
				$(function(){
					to_page(1);
				});
				function to_page(n)
				{
					$.ajax({
						url:"${APP_PATH}/emps",
						data:"pn="+n,
						type:"GET",
						success:function(result)
						{
							build_emps_table(result); 
							build_navNumSelect(result);
							build_emps_navInfo(result);
							build_emps_nav(result);
							 
						}
					});
				}
				function build_emps_table(result)
				{
					$("#empsTable tbody").empty();
					var emps = result.extend.emps.list;
					totalItems =result.extend.emps.total;
					$.each(emps,function(index,item){
						var checkBoxId=$("<td><input type='checkbox' class='check_item'/></td>");
						var empIdTd=$("<td></td>").append(item.empId); 
						var empNameTd=$("<td></td>").append(item.empName);
						var empGenderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
						var empEmailTd=$("<td></td>").append(item.email);
						var empDeptName=$("<td></td>").append(item.department.deptName);
						var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
										.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
						//为编辑按钮添加一个用户ID对应
						editBtn.attr("edit_id",item.empId);
						
						var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
						.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("删除");
						deleteBtn.attr("delete_id",item.empId);
						
						var btnTd = $("<td></td>").append(editBtn).append("  ").append(deleteBtn);
						$("<tr></tr>").append(checkBoxId)
							.append(empIdTd)
							.append(empNameTd)
							.append(empGenderTd)
							.append(empEmailTd)
							.append(empDeptName)
							.append(btnTd)
							.appendTo("#empsTable tbody");						
					});					
				}
				
			
				//控制全选全不选
				//元素原生属性使用prop获取值/赋值
				//元素自定义属性使用attr获取值/赋值
				//子选框的属性是跟着全全选框的状态变化的，所以直接以全选框的状态给全部子选框赋值
				$("#check_all").click(function(){
					$(".check_item").prop("checked",$(this).prop("checked"));
				});
				
				//全框框根据子选框是否全部选中改变状态
				//由于子选框也是后来生成所以得用.on
				//多选框选中了几个可使用$(".check_item:checked").length查看
				$(document).on("click",".check_item",function(){
					var flag = $(".check_item:checked").length == $(".check_item").length;
					$("#check_all").prop("checked",flag);
				});
				
				$("#emp_delete_all_btn").click(function(){
					var empNames = "";
					var empIds = "";
					//不可以写$.each($("#.check_item:checked"),function(){
					$.each($(".check_item:checked"),function(){
						empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
						empIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
						//不可以写parents("<tr>")
						//empIds += $(this).parents("<tr>").find("td:eq(1)").text()+"-";
					});
					//除掉最后分割字符
					empNames = empNames.substring(0,empNames.length-1);
					empIds = empIds.substring(0,empNames.length-1);
					/* if(confirm("确定要删除"+empNames+"吗？"))
					{
						$.ajax({
							url:"${APP_PATH}/emp/"+empIds,
							type:"DELETE",
							success:function(result){
								alert("删除成功");
								to_page(currentPage);
							}
						});
					} */
					if(confirm("确认删除【"+empNames+"】吗？")){
						//发送ajax请求删除
						$.ajax({
							url:"${APP_PATH}/emp/"+empIds,
							type:"DELETE",
							success:function(result){
								alert(result.msg);
								//回到当前页面
								to_page(currentPage);
							}
						});
					}
				});
				
				
				//弹出修改信息模态框
				//选择Class元素需要加上.；id元素需要加上#
				$(document).on("click",".edit_btn",function(){
					//如何获取到编辑按钮对应的id
					var id = $(this).attr("edit_id");
					getEmp(id);
					getDept("#deptInfo_modify");
					
					//在弹出模态框之前将id绑定到更新按钮上，方便以后发送ajax请求时的id获取，相当于将编辑按钮绑定的id传递到更新按钮上
					$("#emp_modify_btn").attr("edit_id",id);
					$("#modifyUserModal").modal({
						backdrop:"static"
					});
				});
				
				//删除单条信息
			
					$(document).on(
							"click",
							".delete_btn",
							function() {
								//姓名信息在当前删除按钮的父类——表格的第二个项中，获取text
								var empName = $(this).parents("tr").find(
										"td:eq(1)").text();
								var empId = $(this).attr("delete_id");

								if (confirm("确认删除【" + empName + "】吗？")) {
									//确认，发送ajax请求删除即可
									$.ajax({
										url : "${APP_PATH}/emp/" + empId,
										type : "DELETE",
										success : function(result) {
											alert("zjj");
											//回到本页
											to_page(currentPage);
										}
									});
								}
							});

					//保存更新的信息
					$("#emp_modify_btn")
							.click(
									function() {

										//首先验证
										/* var empEmail = $("#email_modify").val();
										var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
										if(!regEmail.test(empEmail))
										{
											show_validate_msg("#email_modify","error","该邮箱不可用");
											return false;
										}else{
											show_validate_msg("#email_modify","success","该邮箱可用");
										} */

										var email = $("#email_modify").val();
										var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
										if (!regEmail.test(email)) {
											show_validate_msg(
													"#email_update_input",
													"error", "邮箱格式不正确");
											return false;
										} else {
											show_validate_msg(
													"#email_update_input",
													"success", "");
										}
										//后台发送ajax请求
										var id = $(this).attr("edit_id");
										$.ajax({
											url : "${APP_PATH}/emp/" + id,
											type : "PUT",
											data : $("#modifyUserModal form")
													.serialize(),
											success : function(result) {

												$("#modifyUserModal").modal(
														"hide");
												to_page(currentPage);

											}
										});
									});

					//回显信息
					function getEmp(id) {
						$.ajax({
							url : "${APP_PATH}/emp/" + id,
							type : "GET",
							success : function(result) {
								var emp = result.extend.emp;
								//对于文本标签使用text填入值，对于input标签使用val填入值
								$("#name_modify").text(emp.empName);
								$("#email_modify").val(emp.email);
								$("#modifyUserModal input[name=gender]").val(
										[ emp.gender ]);
								$("#modifyUserModal select").val([ emp.dId ]);

							}

						});
					}

					/* function getEmp(id){
						$.ajax({
							url:"${APP_PATH}/emp/"+id,
							type:"GET",
							success:function(result){
						/* 		//console.log(result);
								var empData = result.extend.emp;
								$("#empName_update_static").text(empData.empName);
								$("#email_update_input").val(empData.email);
								$("#empUpdateModal input[name=gender]").val([empData.gender]);
								$("#empUpdateModal select").val([empData.dId]);
						}
						});
					} */

					function build_navNumSelect(result) {
						$("#navAver").empty();
						var div = $("<div></div>").addClass("dropdown");
						var btn = $("<button></button>").addClass(
								"btn dropdown-toggle").append(
								$("<span></span>").addClass("caret")).attr({
							"id" : "dropdownMenu1",
							"data-toggle" : "dropdown"
						}).append("主題");
						var ul = $("<ul></ul>").addClass("dropdown-menu").attr(
								{
									"role" : "menu",
									"aria-labelledby" : "dropdownMenu1"
								});
						var li1 = $("<li></li>").append($("<a></a>").attr({
							"role" : "menuitem",
							"tabindex" : "-1",
							"href" : "#"
						})).attr("role", "presentation").append("10");
						var li2 = $("<li></li>").append($("<a></a>").attr({
							"role" : "menuitem",
							"tabindex" : "-1",
							"href" : "#"
						})).attr("role", "presentation").append("20");
						li1.click(function() {
							averPage(1, 10);
						});
						li2.click(function() {
							averPage(1, 20);
						});
						ul.append(li1).append(li2);

						var div2 = $("<div></div>").append(div).append(btn)
								.append(ul);
						$("#navAver").append(div2);

					}

					function averPage(startRow, averPage) {
						$.ajax({
							url : "${APP_PATH}/emps",
							data : "startRow=" + startRow + "&" + "averPage="
									+ averPage,
							type : "GET",
							success : function(result) {
								build_emps_table(result);
								build_emps_navInfo(result);
								build_emps_nav(result);
							}
						});
					}

					function build_emps_navInfo(result) {
						$("#navInfos").empty();
						var pageNum = $("<div></div>").addClass("col-md-4")
								.append(
										"这是第" + result.extend.emps.pageNum
												+ "页");
						var total = $("<div></div>")
								.addClass("col-md-4")
								.append("共有" + result.extend.emps.total + "条记录");
						var pages = $("<div></div>").addClass("col-md-4")
								.append("共有" + result.extend.emps.pages + "页");
						/* var averPage = $("<div></div>").a */
						$("#navInfos").append(pageNum).append(total).append(
								pages);
						currentPage = result.extend.emps.pageNum;
					}
					function build_emps_nav(result) {
						$("#navInfo").empty();
						var ul = $("<ul></ul>").addClass("pagination");
						var firstPageLi = $("<li></li>").append(
								$("<a></a>").append("首页").attr("href", "#"));
						var prePageLi = $("<li></li>").append(
								$("<a></a>").append("&laquo;"));
						if (result.extend.emps.hasPreviousPage == false) {
							firstPageLi.addClass = "disabled";
							prePageLi.addClass = "disabled;"
						} else {
							firstPageLi.click(function() {
								to_page(1);
							});
							prePageLi.click(function() {
								to_page(result.extend.emps.pageNum - 1);
							});
						}

						var lastPageLi = $("<li></li>").append(
								$("<a></a>").append("末页").attr("href", "#"));
						var nextPageLi = $("<li></li>").append(
								$("<a></a>").append("&raquo;"));
						if (result.extend.emps.hasNextPage == false) {
							lastPageLi.addClass = "disabled";
							nextPageLi.addClass = "disabled;"
						} else {
							lastPageLi.click(function() {
								to_page(result.extend.emps.pages);
							});
							nextPageLi.click(function() {
								to_page(result.extend.emps.pageNum + 1);
							});
						}
						ul.append(firstPageLi).append(prePageLi);
						$.each(result.extend.emps.navigatepageNums, function(
								index, item) {
							var numLi = $("<li></li>").append(
									$("<a></a>").append(item));
							if (result.extend.emps.pageNum == item) {
								numLi.addClass("active");
							}
							numLi.click(function() {
								to_page(item);
							});
							ul.append(numLi);
						});
						ul.append(nextPageLi).append(lastPageLi);
						var nav = $("<nav></nav>").append(ul);
						nav.appendTo("#navInfo");
					}
					/* 
					function reset_form(ele)
					{
						$(ele)[0].reset(); 
						$(ele).find("*").removeClass("has-error has-success");
						$(ele).find(".help-block").text("");
					} */

					//清空表单样式及内容
					function resetion_form(ele) {
						$(ele)[0].reset();
						//清空表单样式
						$(ele).find("*").removeClass("has-error has-success");
						$(ele).find(".help-block").text("");
					}

					function getDept(ele) {
						$(ele).empty();
						$.ajax({
							url : "${APP_PATH}/depts",
							type : "GET",
							success : function(result) {
								$.each(result.extend.depts, function() {
									var optionEle = $("<option></option>")
											.append(this.deptName).attr(
													"value", this.deptId);
									optionEle.appendTo(ele);
								});
							}
						});
					}

					//弹出模态框，弹出前去掉之前的校验信息与格式
					$("#emp_add_modal_btn").click(function() {
						resetion_form("#addUserModal form");

						getDept("#deptInfo");
						$("#addUserModal").modal({
							backdrop : "static"
						});
					});

					function show_validate_msg(ele, status, msg) {
						//为了清空之前的样式，适用于修改合法后依然显示error状态的情况
						$(ele).parent().removeClass("has-success has-error");
						$(ele).next("span").text("");

						if (status == "success") {
							$(ele).parent().addClass("has-success");
							$(ele).next("span").text(msg);
						} else {
							$(ele).parent().addClass("has-error");
							$(ele).next("span").text(msg);
						}

					}

					function valid_name(empName) {
						$("#name").empty();
						$.ajax({
							url : "${APP_PATH}/validName",
							data : "empName=" + empName,
							type : "POST",
							success : function(result) {
								if (result.code == 100) {
									show_validate_msg("#name", "success",
											result.extend.success);
									/* return true; */
								} else {
									show_validate_msg("#name", "error",
											"该用户已存在");
									/* return false; */
								}

							}
						});
					}

					$("#name").change(function() {
						var empName = this.value;
						valid_name(empName);

						/* 	//别忘了获取参数变量
							var empName = this.value;
							$.ajax({
								uri:"${APP_PATH}/validName",
								data:"empName="+empName,
								type:"GET",
								success:function(result){
									/* if(result.code==100)
									{
										show_validate_msg("#name","success",result.extend.success);
										$("#emp_save_btn").attr("ajax-va","success");
									}else if(result.code==200)
									{
										show_validate_msg("#name","error","该用户已存在");
										$("#emp_save_btn").attr("ajax-va","error");
									} 
									if(result.code==100){
										show_validate_msg("#empName_add_input","success","用户名可用");
										$("#emp_save_btn").attr("ajax-va","success");
									}else{
										show_validate_msg("#empName_add_input","error","用户名不可用");
										$("#emp_save_btn").attr("ajax-va","error");
									}
								
								}
							}); */
					});

					function check_form() {
						var empName = $("#name").val();
						var empEmail = $("#email").val();

						/* var regName = /(^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{3-6})/; */
						var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
						/* var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/; */

						if (!regName.test(empName)) {
							show_validate_msg("#name", "error", "该用户名不可用");
							return false;
						} else {
							show_validate_msg("#name", "success", "该用户名可用");
						}
						var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
						if (!regEmail.test(empEmail)) {
							show_validate_msg("#email", "error", "该邮箱不可用");
							return false;
						} else {
							show_validate_msg("#email", "success", "该邮箱可用");
						}

						if (!valid_name()) {
							return false;
						}

						return true;

					}

					$("#emp_save_btn")
							.click(
									function() {

										//1、进行校验
										/* check_form(); */

										/* if(!check_form())
										{
											return false;
										}else{ */
										$
												.ajax({
													url : "${APP_PATH}/emp",
													type : "POST",
													data : $(
															"#addUserModal form")
															.serialize(),
													success : function(result) {

														if (result.code == 200) {
															if (undefined != result.extend.error.email) {
																show_validate_msg(
																		"#email",
																		"error",
																		result.extend.error.email);
															}
															if (undefined != result.extend.error.empName) {
																show_validate_msg(
																		"#name",
																		"error",
																		result.extend.error.empName);
															}

														} else {
															//隐藏模态框
															$("#addUserModal")
																	.modal(
																			'hide');
															//到最后一页
															to_page(1000);
														}
													}

												});

										/* } */

									});
				</script>
		</div>
		</div>

	</div>
	
</body>
</html>

