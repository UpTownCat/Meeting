package com.example.bean;

public class Page {
	// 第几页
	private int index;
	// 所有记录数
	private int count;
	// 总共页数
	private int total;
	//每页显示的条数
	private int size;
	//时间
	private int time;
	//状态
	private int state;
	//预约
	private int appointment;
	//搜索内容
	private String searchContent;
	//条件Id
	private int condictionId;
	//部门Id
	private int departmentId;
	
	private String name;
	
	private int capacity;
	 
	private String number;
	//用于设备容量的排序
	private int count2;
	

	public int getCount2() {
		return count2;
	}

	public void setCount2(int count2) {
		this.count2 = count2;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public int getCondictionId() {
		return condictionId;
	}

	public void setCondictionId(int condictionId) {
		this.condictionId = condictionId;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}


	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getAppointment() {
		return appointment;
	}

	public void setAppointment(int appointment) {
		this.appointment = appointment;
	}

	public String getSearchContent() {
		return searchContent;
	}

	public void setSearchContent(String searchContent) {
		this.searchContent = searchContent;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public Page() {
		super();
	}


	@Override
	public String toString() {
		return "?index=" + index + "&time=" + time + "&state=" + state
				+ "&appointment=" + appointment + "&searchContent="
				+ searchContent ;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int totalPage) {
		this.total = totalPage;
	}

}
