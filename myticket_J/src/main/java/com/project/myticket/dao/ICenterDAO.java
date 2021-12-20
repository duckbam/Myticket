package com.project.myticket.dao;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.project.myticket.dto.CenterDTO;
import com.project.myticket.dto.ItemDTO;
import com.project.myticket.dto.SearchDTO;

@Repository
public interface ICenterDAO {

	void writeProc(CenterDTO centerDto);

	void reWriteProc(CenterDTO centerDto);

	ArrayList<CenterDTO> centerProcSearch(SearchDTO searchDto);

	ArrayList<CenterDTO> centerProc(SearchDTO searchDto);

	ArrayList<ItemDTO> readSaleCode(Map<String, Object> map);

	ArrayList<CenterDTO> centerProcSaleCode(Map<String, Object> map);

	CenterDTO viewProc(int no);

	void delProc(int no);

	void modifyProc(CenterDTO centerDto);

	void upReply(int no);

	void delReply(int no);

	String readSellerId(Map<String, Object> map);
	
	String readSaleName(Map<String, Object> map);
	
	CenterDTO readReply(Map<String, Object> map);
}
