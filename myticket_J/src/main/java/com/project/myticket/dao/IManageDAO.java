package com.project.myticket.dao;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.project.myticket.dto.BookDTO;
import com.project.myticket.dto.ItemDTO;
import com.project.myticket.dto.SearchDTO;

@Repository
public interface IManageDAO {

	ArrayList<ItemDTO> manageProcSearch(SearchDTO searchDto);

	ArrayList<ItemDTO> manageProc(SearchDTO searchDto);

	void insertMovie(ItemDTO merDto);

	void insertTheater(ItemDTO merDto);

	void insertConcert(ItemDTO merDto);

	void insertSports(ItemDTO merDto);

	void insertLeisure(ItemDTO merDto);

	int SeqNextVal();

	ItemDTO viewProc(Map<String, Object> map);

	void modifyMovie(ItemDTO merDto);

	void modifyTheater(ItemDTO merDto);

	void modifyConcert(ItemDTO merDto);

	void modifySports(ItemDTO merDto);

	void modifyLeisure(ItemDTO merDto);

	void delProc(Map<String, Object> map);
	
	ArrayList<String> readSaleCode(SearchDTO searchDto);
	
	ArrayList<BookDTO> readBooking(String saleCode);
	
	ArrayList<BookDTO> readBookingSearch(Map<String, Object> map);
}
