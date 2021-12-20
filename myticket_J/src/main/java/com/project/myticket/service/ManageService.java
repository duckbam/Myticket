package com.project.myticket.service;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.myticket.dao.IManageDAO;
import com.project.myticket.dto.BookDTO;
import com.project.myticket.dto.ItemDTO;
import com.project.myticket.dto.ListDTO;
import com.project.myticket.dto.SearchDTO;

@Service
public class ManageService {
	@Autowired IManageDAO manageDao;
	@Autowired HttpSession session;
	
private String FILE_LOCATION = "C:\\Myticket\\img";
	
	public String getFILE_LOCATION() {
		return FILE_LOCATION;
	}
	
	public void manageProc(SearchDTO searchDto, Model model) {		
		ArrayList<ItemDTO> merchList  = null;
		String table ="myticket_"+searchDto.getCategory();
		searchDto.setTable(table);
		if(searchDto.getMode() != null && searchDto.getMode().equals("search") && searchDto.getData() != null){
			merchList = manageDao.manageProcSearch(searchDto);			
		}
		else{
			merchList = manageDao.manageProc(searchDto);
		}
		
		ListDTO cl = new ListDTO();
		cl.setPageNumber(searchDto.getPageNumber());
		cl.setTotalRecord(merchList.size());
		model.addAttribute("merchList", merchList);
		model.addAttribute("cl", cl);
		model.addAttribute("searchDto", searchDto);
	}
	
	public void insertProc(String category, ItemDTO merDto) {
		switch(category) {
		case "m" : manageDao.insertMovie(merDto); break;
		case "t" : manageDao.insertTheater(merDto); break;
		case "c" : manageDao.insertConcert(merDto); break;
		case "s" : manageDao.insertSports(merDto); break;
		case "l" : manageDao.insertLeisure(merDto); break;
		default : ;
		}
	}
			
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
	
	public boolean codeCheck(String category, String sGenre)
	{	
		int movie = 7;
		int theater = 1;
		int concert = 4;
		int sports = 5;
		int leisure = 3;
		
		boolean ret = false;
		
		if(category == "" || sGenre == "") return ret;
		int sGenreCheck = 0;
		try {
			sGenreCheck = Integer.parseInt(sGenre);
		} catch (Exception e) {
			// TODO: handle exception
			return ret;
		}	
		switch(category) {
		case "m" : if(sGenreCheck > 0 && sGenreCheck <= movie) ret = true; break;
		case "t" : if(sGenreCheck > 0 && sGenreCheck <= theater) ret = true; break;
		case "c" : if(sGenreCheck > 0 && sGenreCheck <= concert) ret = true; break;
		case "s" : if(sGenreCheck > 0 && sGenreCheck <= sports) ret = true; break;
		case "l" : if(sGenreCheck > 0 && sGenreCheck <= leisure) ret = true; break;
		default : ; 
		}
		return ret;
	}
	
	public boolean dateCheck(String start, String end, String current) {
		LocalDate startDate = null;
		LocalDate endDate = null;
		LocalDate currentDate = null;
		try {
			startDate = LocalDate.parse(start);
			endDate = LocalDate.parse(end);
			currentDate = LocalDate.parse(current);
		} catch (Exception e) {
			//e.printStackTrace();
			return false;
		}
	
		if(startDate.isAfter(endDate)) return false;
		if(currentDate.isAfter(endDate)) return false;
		//startDate.compareTo(endDate);
		//System.out.println(startDate+" "+endDate+" "+currentDate);
		return true;
	}
	public boolean regProc(ItemDTO dto, MultipartHttpServletRequest req) {
		
		String category = req.getParameter("categoryCode"); //카테고리 코드 : 'm', 't', 'c', 's', 'l'
		String sGenre = req.getParameter("sGenreCode");   //서브 장르 코드 : 01~xx까지

		if(codeCheck(category, sGenre) == false) return false;
		
		String id = (String)session.getAttribute("id");
		
		if(dataCheck(dto.getName(), 50) == false) return false;		
		if(dataCheck(dto.getPlace(), 50) == false) return false;
		if(dataCheck(dto.getZipcode(), 5) == false) return false;
		if(dataCheck(dto.getAddr1(), 100) == false) return false;
		if(dto.getAddr2() != "" && dataCheck(dto.getAddr2(), 100) == false) return false;
		if(dataCheck(dto.getStartDate(), 10) == false) return false;
		if(dataCheck(dto.getEndDate(), 10) == false) return false;
		if(dto.getContent() != "" && dataCheck(dto.getContent(), 1000) == false) return false;

		if(dto.getAge() < 0 || dto.getPrice() < 0  || dto.getSeat() < 0) return false;
		
		LocalDate localDate = LocalDate.now();
	    String date = localDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).toString();
	    if(dateCheck(dto.getStartDate(),dto.getEndDate(), date) == false) return false;
	    
	    ItemDTO merDto = dto;
	    merDto.setsGenre(sGenre);
	    merDto.setId(id);
	    merDto.setRegDate(date);
	 		
	    String saleCode;
	    String seqVal = String.format("%04d", manageDao.SeqNextVal());
	    date = localDate.format(DateTimeFormatter.ofPattern("yyyyMM")).toString();
		saleCode = category+sGenre+date+seqVal; //상품 코드 영화 : M   
		merDto.setSaleCode(saleCode);
		
		MultipartFile file = req.getFile("file");
		if(file.getSize() != 0) {
			
			if(file.getSize() > 50 *1024*1024) return false;
			
			String originName = file.getOriginalFilename();
			if(dataCheck(originName, 64) == false) return false;
			
			originName = originName.substring(originName.lastIndexOf(".") + 1);
			if(!originName.equals("jpg") &&  !originName.equals("jpga") && !originName.equals("png")) return false;
			
			// uuid 생성 
	        UUID uuid = UUID.randomUUID();
	
	        String fileName = uuid.toString()+"_"+file.getOriginalFilename();
			merDto.setImg(fileName);
			
			File folder = new File(FILE_LOCATION + "\\" + date);
			if(!folder.exists()) {	//해당 path(폴더)가 존재하지 않는가?
				folder.mkdir();		// 폴더 만든다.
			}
			
			File save = new File(FILE_LOCATION + "\\" + date+ "\\" + fileName);
			try {
				file.transferTo(save);
			} catch (Exception e) {
				e.printStackTrace();
			} 
	    
		}else {
			merDto.setImg("없음");
		}
		insertProc(category, merDto);
		return true;
	}
	
	public void viewProc(String saleCode, String category, Model model) {
		String table ="myticket_"+category;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("table", table);
		map.put("saleCode", saleCode);
		ItemDTO merDto = manageDao.viewProc(map);
		model.addAttribute("sale", merDto);
	}
		
	public boolean modifyProc(ItemDTO dto, MultipartHttpServletRequest req) {
		
		//수정할 항목
		if(dataCheck(dto.getName(), 50) == false) return false;		
		if(dataCheck(dto.getPlace(), 50) == false) return false;
		if(dataCheck(dto.getZipcode(), 5) == false) return false;
		if(dataCheck(dto.getAddr1(), 100) == false) return false;
		if(dto.getAddr2() != "" && dataCheck(dto.getAddr2(), 100) == false) return false;
		if(dataCheck(dto.getStartDate(), 10) == false) return false;
		if(dataCheck(dto.getEndDate(), 10) == false) return false;
		if(dto.getContent() != "" && dataCheck(dto.getContent(), 1000) == false) return false;
		
		if(dto.getAge() < 0 || dto.getPrice() < 0  || dto.getSeat() < 0) return false;
		
		String img = req.getParameter("img");//등록된 이미지 파일명
		if(img != "" && dataCheck(img, 100) == false) return false;
		
		//table 선택
		String category = req.getParameter("category"); 
		if(dataCheck(category, 7) == false) return false;
		String saleCode = req.getParameter("saleCode"); 
		if(dataCheck(category, 13) == false) return false;
		
		//이미지 파일 수정을 위해 파일 경로를 계산
		String regDate = dto.getRegDate();
		if(dataCheck(regDate, 10) == false) return false;
		
		regDate = regDate.replace("-", "");
		regDate = regDate.substring(0, 6);
		
		ItemDTO merDto = new ItemDTO();
	    merDto.setSaleCode(saleCode);
		merDto.setName(dto.getName());
	    merDto.setPlace(dto.getPlace());
	    merDto.setZipcode(dto.getZipcode());
	    merDto.setAddr1(dto.getAddr1());
	    merDto.setAddr2(dto.getAddr2());
	    merDto.setStartDate(dto.getStartDate());
	    merDto.setEndDate(dto.getEndDate());
	    merDto.setAge(dto.getAge());
	    merDto.setContent(dto.getContent());
		
		MultipartFile file = req.getFile("file");
		if(file.getSize() != 0) {
			
			if(file.getSize() > 50 *1024*1024) return false;
			
			String originName = file.getOriginalFilename();
			if(dataCheck(originName, 64) == false) return false;

			originName = originName.substring(originName.lastIndexOf(".") + 1);
			if(!originName.equals("jpg") &&  !originName.equals("jpga") && !originName.equals("png")) return false;

			//이전에 등록된 이미지 삭제
			if(img.equals("없음") == false) {
				File del = new File(FILE_LOCATION + "\\" + regDate+ "\\" + img);
				if(del.isFile()) {
					del.delete();
				}
			}
			
		 	// uuid 생성 
	        UUID uuid = UUID.randomUUID();	
	        String fileName = uuid.toString()+"_"+file.getOriginalFilename();
			merDto.setImg(fileName);
			
			File save = new File(FILE_LOCATION + "\\" + regDate+ "\\" + fileName);
			try {
				file.transferTo(save);
			} catch (Exception e) {
				e.printStackTrace();
			} 
	    
		}else {
			merDto.setImg(img);
		}

		switch(category) {
		case "movie" : manageDao.modifyMovie(merDto); break;
		case "theater" : manageDao.modifyTheater(merDto); break;
		case "concert" : manageDao.modifyConcert(merDto); break;
		case "sports" : manageDao.modifySports(merDto); break;
		case "leisure" : manageDao.modifyLeisure(merDto); break;
		default : return false;
		}
	
		return true;
	}
	
	public void delProc(String saleCode, String category) {
		String table ="myticket_"+category;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("table", table);
		map.put("saleCode", saleCode);
		ItemDTO merDto = manageDao.viewProc(map);
		System.out.println("fileName : " + merDto.getImg());
		if(merDto.getImg().equals("없음") == false) {
			String fileName = merDto.getImg();
			String regDate = merDto.getRegDate();
			regDate = regDate.replace("-", "");
			regDate = regDate.substring(0, 6);
			File delFile = new File(FILE_LOCATION + "\\" + regDate+ "\\" + fileName);
			//System.out.println("isFile : " + delFile.isFile());
			if(delFile.isFile()) delFile.delete();
		}
		manageDao.delProc(map);
	}
	
	public void saleListProc(SearchDTO searchDto, Model model) {
		ArrayList<String> saleCode = new ArrayList<String>();
		
		searchDto.setTable("myticket_movie");
		saleCode.addAll(manageDao.readSaleCode(searchDto));
		searchDto.setTable("myticket_theater");
		saleCode.addAll(manageDao.readSaleCode(searchDto));
		searchDto.setTable("myticket_concert");
		saleCode.addAll(manageDao.readSaleCode(searchDto));
		searchDto.setTable("myticket_sports");
		saleCode.addAll(manageDao.readSaleCode(searchDto));
		searchDto.setTable("myticket_leisure");
		saleCode.addAll(manageDao.readSaleCode(searchDto));
		
		ArrayList<BookDTO> saleList  = new ArrayList<BookDTO>();
		
		
		if(searchDto.getMode() != null && searchDto.getMode().equals("search") && searchDto.getData() != null){
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("find", searchDto.getFind());
			map.put("data", searchDto.getData());
			for(String s : saleCode) {
				map.put("saleCode", s);
				saleList.addAll(manageDao.readBookingSearch(map));
			}
		}
		else{	
			for(String s : saleCode) {
				saleList.addAll(manageDao.readBooking(s));
			}
		}
		
		ListDTO cl = new ListDTO();
		cl.setPageNumber(searchDto.getPageNumber());
		cl.setTotalRecord(saleList.size());
		model.addAttribute("saleList", saleList);
		model.addAttribute("cl", cl);
		model.addAttribute("searchDto", searchDto);
	}

}
