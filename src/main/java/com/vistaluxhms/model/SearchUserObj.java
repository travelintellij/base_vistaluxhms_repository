package com.vistaluxhms.model;

public class SearchUserObj {
	private String joiningFromDate;
	private String joiningToDate;
	private int userId;
	private String username;
	private String name;

	
	public String getJoiningFromDate() {
		return joiningFromDate;
	}
	public void setJoiningFromDate(String joiningFromDate) {
		this.joiningFromDate = joiningFromDate;
	}
	public String getJoiningToDate() {
		return joiningToDate;
	}
	public void setJoiningToDate(String joiningToDate) {
		this.joiningToDate = joiningToDate;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String userName) {
		this.username = userName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	

}
