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

import com.example.bean.Equipment;
import com.example.bean.Page;
import com.example.service.EquipmentService;

@Controller
@RequestMapping("/equipment")
public class EquipmentController {
	@Autowired
	private EquipmentService equipmentService;
	private final String LIST_URL = "redirect:/equipment/list";
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String addEquipment(Equipment equipment, @RequestParam("index") Integer index) {
		equipmentService.addEquipment(equipment);
		return LIST_URL + "?index=" + index;
	}
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String listEquipment(Page page, Map<String, Object> map) {
		if(page.getIndex() <= 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		List<Equipment> equipments = equipmentService.selectAllByPage(page);
		if(equipments.size() == 0 && page.getIndex() != 1) {
			page.setIndex(page.getIndex() - 1);
			equipments = equipmentService.selectAllByPage(page);
		}
		map.put("equipments", equipments);
		map.put("page", page);
		map.put("size", equipments.size());
		return "/equipment/equipment_list_admin";
	}
	
	@RequestMapping(value="/{id}/delete", method=RequestMethod.DELETE)
	public String deleteEquipment(@PathVariable Integer id) {
		equipmentService.deleteEquipment(id);
		return LIST_URL;
	}
	
	@RequestMapping(value="/{id}/update", method=RequestMethod.GET)
	public String prepareUpdate(Integer index,Map<String, Object>map) {
		map.put("index", index);
		return "/equipment/update";
	}
	
	@RequestMapping(value="/{id}/update", method=RequestMethod.PUT)
	public String updateEquipment(Integer index, @ModelAttribute("equipment") Equipment equipment) {
		equipmentService.updateEquipment(equipment);
		return LIST_URL + "?index=" + index;
	}
	
	@ModelAttribute
	public void bindEquipment(@RequestParam(value="id", required=false) Integer id, Map<String, Object> map) {
		if(id != null) {
			Equipment equipment = equipmentService.selectEquipmentById(id);
			map.put("equipment", equipment);
		}
	}
}
