package com.example.bean;

public class Page {
	// �ڼ�ҳ
	private int index;
	// ���м�¼��
	private int count;
	// �ܹ�ҳ��
	private int total;
	//ÿҳ��ʾ������
	private int size;
	//ʱ��
	private int time;
	//״̬
	private int state;
	//ԤԼ
	private int appointment;
	//��������
	private String searchContent;
	//����Id
	private int condictionId;
	//����Id
	private int departmentId;
	
	private String name;
	
	private int capacity;
	 
	private String number;
	//�����豸����������
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
