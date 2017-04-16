package com.example.bean;


public class Notice {
	private int id;
	private int isShow;
	private String content;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	

	public int getIsShow() {
		return isShow;
	}

	public void setIsShow(int isShow) {
		this.isShow = isShow;
	}

	public Notice(int isShow, String content) {
		super();
		this.isShow = isShow;
		this.content = content;
	}

	public Notice() {
		super();
	}

}
