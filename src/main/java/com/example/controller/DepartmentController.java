package com.example.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.bean.Department;
import com.example.bean.Manager;
import com.example.bean.Page;
import com.example.service.DepartmentService;
import com.example.service.ManagerService;

@Controller
@RequestMapping("/department")
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private ManagerService managerService;
	private final static String LIST_URL = "redirect:/department/list";
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String addDepartment(Department department, @RequestParam("index")Integer index) {
		departmentService.addDepartment(department);
		return LIST_URL + "?index=" + index;
	}
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String listDepartment(Page page, Map<String, Object> map) {
		if(page.getIndex() <= 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		List<Department> departments = departmentService.selectAllByPage(page);
		map.put("departments", departments);
		map.put("page", page);
		map.put("size", departments.size());
		return "/department/department_list_admin";
	}
	
	@RequestMapping(value="/{id}/delete", method=RequestMethod.DELETE)
	public String deleteDepartment(@PathVariable Integer id) {
		departmentService.deleteDepartment(id);
		return LIST_URL;
	}
	
	@RequestMapping(value="/{id}/update", method=RequestMethod.GET)
	public String prepareUpdate(@PathVariable Integer id, Map<String, Object> map) {
		Department department = departmentService.selectDepartmentById(id);
		List<Manager> managers = managerService.selectAll();
		map.put("department", department);
		map.put("managers", managers);
		return "/department/update";
	}
	
	@RequestMapping(value="/{id}/update", method=RequestMethod.PUT)
	public String updateDepartment(Integer index, @ModelAttribute Department department) {
		departmentService.updateDepartment(department);
		return LIST_URL + "?index=" + index; 
	}
//	@ModelAttribute
//	public void bindDepartment(@RequestParam(value="id", required=false)Integer id, Map<String, Object> map) {
//		if(id != null) {
//			Department department = departmentService.selectDepartmentById(id);
//			map.put("department", department);
//		}
//	}
}
