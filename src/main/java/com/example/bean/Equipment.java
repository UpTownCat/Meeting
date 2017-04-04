package com.example.bean;

public class Equipment {
	private int id;
	private int count;
	private int need;
	private String name;

	public int getNeed() {
		return need;
	}

	public void setNeed(int need) {
		this.need = need;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "Equipment [id=" + id + ", name=" + name + ", count=" + count
				+ "]";
	}

	public Equipment(int count, String name) {
		super();
		this.count = count;
		this.name = name;
	}

	public Equipment() {
		super();
	}

}
