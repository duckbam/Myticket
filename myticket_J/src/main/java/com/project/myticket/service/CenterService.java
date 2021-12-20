package com.project.myticket.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.myticket.dao.ICenterDAO;
import com.project.myticket.dto.CenterDTO;
import com.project.myticket.dto.ItemDTO;
import com.project.myticket.dto.ListDTO;
import com.project.myticket.dto.SearchDTO;

@Service
public class CenterService {
	@Autowired ICenterDAO centerDao;
	@Autowired HttpSession session;
	
	public boolean dataCheck(String str, int lenMax)
	{
		if(str == null || str == "") {
			return false; // error : empty
		}
		if(str.length() > lenMax)
		{ 	
			return false; // error : length over
		}
		return true;
	}

	
	public boolean writeProc(CenterDTO dto) {
		String id = (String)session.getAttribute("id");	
		
		if(dataCheck(dto.getTitle(), 100) == false) return false;
		if(dataCheck(dto.getContent(), 1000) == false) return false;
		
		CenterDTO centerDto = dto;
		centerDto.setId(id);
		centerDto.setAnswer("n");
		centerDto.setGroupOrd(0);
		
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		centerDto.setWriteDate(sdf.format(date));
		
		centerDao.writeProc(centerDto);
		return true;
	}
	
	public boolean reWriteProc(CenterDTO dto) {
	
		String id = (String)session.getAttribute("id");
	
		String title = dto.getTitle();
		if(dataCheck(dto.getTitle(), 100) == false) return false;
		String content = dto.getContent();
		if(dataCheck(dto.getContent(), 1000) == false) return false;
		
		String category = dto.getCategory();
		String saleCode = dto.getSaleCode();
		int no = dto.getNo();
		
		CenterDTO centerDto = new CenterDTO();
		centerDto.setCategory(category);
		centerDto.setSaleCode(saleCode);
		centerDto.setId(id);
		centerDto.setTitle(title);
		centerDto.setContent(content);		
		centerDto.setAnswer("Y");
		centerDto.setOriginNo(no);
		System.out.println("setOriginNo = " + no);
		centerDto.setGroupOrd(1);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		centerDto.setWriteDate(sdf.format(date));
		
		centerDao.reWriteProc(centerDto);
		
		return true;
	}
	
	public void centerProc(SearchDTO searchDto, Model model) {
		
		ArrayList<CenterDTO> centerList  = null;
		if(searchDto.getMode() != null && searchDto.getMode().equals("search") && searchDto.getData() != null){
			centerList = centerDao.centerProcSearch(searchDto);			
		}
		else{
			centerList = centerDao.centerProc(searchDto);
		}
		
		if(searchDto.getCategory().equals("My")) {
			
			Map<String, Object> map = new HashMap<String,Object>();
			ArrayList<CenterDTO> reply = new ArrayList<CenterDTO>(); 
		
			int tmp = 0;
			int[] tmpNo = new int[centerList.size()];
			
			map.put("groupOrd", 1);
			for(int i= 0; i < centerList.size(); i++) {
				if(centerList.get(i).getAnswer().equals("y")) {
					map.put("originNo", centerList.get(i).getNo());
					reply.add(centerDao.readReply(map));
					tmpNo[tmp] = i;
					tmp++;
					
				}
			}
			for(int i=0; i < tmp; i++) {
				centerList.add(tmpNo[i]+1+i, reply.get(i));
			}
			
		}
		
		ListDTO cl = new ListDTO();
		cl.setPageNumber(searchDto.getPageNumber());
		cl.setTotalRecord(centerList.size());
		model.addAttribute("centerList", centerList);
		model.addAttribute("cl", cl);	
		model.addAttribute("searchDto", searchDto);
	}

	public void sellerProc(SearchDTO searchDto, String answer, Model model) {
		
		ArrayList<CenterDTO> centerList  = new ArrayList<CenterDTO>();
		
		String table ="myticket_"+searchDto.getCategory();
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("table", table);
		map.put("id", searchDto.getId());
		
		if(answer == null || answer =="") {
			answer = "y";
			//y일 경우 모든 게시물 조회
		}
		System.out.println("answer= "+answer);
		ArrayList<ItemDTO> merDto = centerDao.readSaleCode(map);
		for(ItemDTO mdto : merDto) {
			map.put("saleCode", mdto.getSaleCode());
			map.put("answer", answer);
			//System.out.println("saleCode = "+ mdto.getSaleCode() + "answer = " + answer);
			for(CenterDTO cdto: centerDao.centerProcSaleCode(map)) {
				centerList.add(cdto);
			}
		}
		ListDTO cl = new ListDTO();
		cl.setPageNumber(searchDto.getPageNumber());
		cl.setTotalRecord(centerList.size());
		model.addAttribute("centerList", centerList);
		model.addAttribute("cl", cl);
		model.addAttribute("searchDto", searchDto);
	}
	
	public void viewProc(String writeNo, Model model) {
		int no = Integer.parseInt(writeNo);
		CenterDTO center = centerDao.viewProc(no);
		if(!center.getSaleCode().equals("선택하지 않음")) {
			model.addAttribute("saleName", 	readSeleName(center.getCategory(), center.getSaleCode()));
		}
		model.addAttribute("center", center);
		model.addAttribute("centerCategory", center.getCategory());
		model.addAttribute("centerAnswer", center.getAnswer());
	}

	
	public void delProc(String writeNo) {
		int no = Integer.parseInt(writeNo);
		centerDao.delProc(no);
	}

	
	public boolean modifyProc(CenterDTO centerDto) {
		if(dataCheck(centerDto.getTitle(), 100) == false) return false;
		if(dataCheck(centerDto.getContent(), 1000) == false) return false;
		
		centerDao.modifyProc(centerDto);
		
		return true;
	}

	
	public void upReply(String writeNo) {
		int no = Integer.parseInt(writeNo);
		centerDao.upReply(no);
	}
	
	public void delReply(String writeNo) {
		int no = Integer.parseInt(writeNo);
		centerDao.delReply(no);
	}


	public void readSaleCode(String category, Model model) {
		String table ="myticket_"+category;
		System.out.println("table명 : " + table);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("table", table);
		map.put("id", null);
		ArrayList<ItemDTO> merDto = centerDao.readSaleCode(map);
		model.addAttribute("saleCode", merDto);
	}
	
	public String readSellerId(String category, String saleCode) {
		String table ="myticket_"+category;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("table", table);
		map.put("saleCode", saleCode);
		
		String seller = centerDao.readSellerId(map);
		return seller;
	}
	
	public String readSeleName(String category, String saleCode) {
		String table ="myticket_"+category;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("table", table);
		map.put("saleCode", saleCode);
		
		String name = centerDao.readSaleName(map);
		return name;
	}

}
