package com.project.myticket.dto;

public class SearchDTO {
	private String pageNumber;
	private String category; //center에서 각 제품 sale코드를 가져오기 위한 변수, table명 생성에도 사용 
	private String mode; 
	private String find;  
	private String data;
	private String id;
	private String table; //테이블명 Manage에서만 사용 
	private String sGenre;//장르 선택 조건  Manage에서만 사용
	private String loginType;//관리자 타입인지 확인 Manage에서만 사용
	
	public String getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(String pageNumber) {
		this.pageNumber = pageNumber;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getFind() {
		return find;
	}
	public void setFind(String find) {
		this.find = find;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public String getsGenre() {
		return sGenre;
	}
	public void setsGenre(String sGenre) {
		this.sGenre = sGenre;
	}
	public String getLoginType() {
		return loginType;
	}
	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}
	
}
