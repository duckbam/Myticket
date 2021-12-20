package com.project.myticket.dto;

public class ListDTO {
	private int pageNumber; 
	private int start; 
	private int scroll; 
	private int totalPage; 
	private int totalRecord;
	
	public ListDTO() {
		setScroll();
	}
	private void setScroll() {
		this.scroll = 10;
	}
	public void setScroll(int n) {
		this.scroll = n;
	}
	
	public void setPageNumber(String pn) {
		if(pn == "" || pn == null)
			this.pageNumber = 1;
		else
			this.pageNumber = Integer.parseInt(pn);
		setStart();
	}
	
	private void setStart() {
		this.start = (this.pageNumber - 1) * this.scroll;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		setTotalPage();
	}
	
	private void setTotalPage() {
		if(totalRecord > 0) {
			if(totalRecord % scroll == 0) {
				this.totalPage = this.totalRecord / this.scroll;
			}else {
				this.totalPage = (this.totalRecord / this.scroll) + 1;
			}
		}
		else totalPage = 1;
		
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public int getStart() {
		return start;
	}
	public int getScroll() {
		return scroll;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	
}