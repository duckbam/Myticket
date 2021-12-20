package com.project.myticket;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.myticket.dto.ItemDTO;
import com.project.myticket.dto.SearchDTO;
import com.project.myticket.service.ManageService;


@Controller
public class ManageController {
	@Autowired ManageService service;
	@Autowired HttpSession session;
	
	@RequestMapping(value = "/manage")
	public String saleManage() {
		service.dateCheck("2011-11-11", "0", null);
		return "manage/saleManage";
	}
	
	@RequestMapping(value = "/saleView")
	public String saleView() {
		return "manage/saleView";
	}
	@RequestMapping(value = "/saleReg")
	public String saleReg(SearchDTO searchDto, Model model) {
		String id = (String)session.getAttribute("id");
		if(id == null) {
			return "member/normalLogin";
		}
		model.addAttribute("searchDto", searchDto);
		return "manage/saleReg";
	}
	
	@RequestMapping(value = "/saleModify")
	public String saleModify(String saleCode, String writer, SearchDTO searchDto, Model model) {
		String id = (String)session.getAttribute("id");
		String type = (String)session.getAttribute("type");
		if(id == null) {
			model.addAttribute("msg","로그인 후 이용해 주세요");
			return "member/normalLogin";
		}
		service.viewProc(saleCode, searchDto.getCategory(), model);
		model.addAttribute("searchDto", searchDto);
		if(type.equals("admin") == false && writer.equals(id) == false ){
			model.addAttribute("msg","수정 권한이 없습니다");
			return "manage/saleView";
		}
		return "manage/saleModify";
	}

	@RequestMapping(value = "/manageProc")
	public String manageProc(SearchDTO searchDto, Model model) {
		if(searchDto.getCategory() == null || searchDto.getCategory() == ""){
			searchDto.setCategory("movie");
		}
		if(searchDto.getsGenre() == null || searchDto.getsGenre() == "") {
			searchDto.setsGenre("00");
		}
		String id = (String) session.getAttribute("id");
		if(id == null || id =="") {
			return "forward:index?formpath=normalLogin";	
		}
		searchDto.setId(id);
		searchDto.setLoginType((String) session.getAttribute("type"));
		service.manageProc(searchDto, model);
		return "forward:index?formpath=manage";
	}
	
	@RequestMapping(value = "/saleRegProc")
	public String saleRegProc(ItemDTO merDto, String category, MultipartHttpServletRequest req, Model model) {
		if(service.regProc(merDto, req) == false) model.addAttribute("msg", "상품 등록에 실패하였습니다. 다시 시도해 주십시오");
		//return "forward:manageProc";
		return "redirect:manageProc?category="+category;
	}
	
	@RequestMapping(value = "/saleViewProc")
	public String saleViewProc(String saleCode, SearchDTO searchDto, Model model) {
		if(saleCode.isEmpty()) 	return "forward:manageProc";
		service.viewProc(saleCode, searchDto.getCategory(), model);
		model.addAttribute("searchDto", searchDto);
		return "forward:index?formpath=saleView";
	}
		
	@RequestMapping(value = "/saleViewDelProc")
	public String saleViewDelProc(String writer, String saleCode, SearchDTO searchDto,  Model model) {
		String id = (String)session.getAttribute("id");
		String type = (String)session.getAttribute("type");
		if(id == null) {
			model.addAttribute("msg","로그인 후 이용해 주세요");
			return "forward:index?formpath=normalLogin";
		}
		model.addAttribute("searchDto", searchDto);
		if(type.equals("admin") == false && id.equals(writer) == false) {
			model.addAttribute("msg","삭제 권한이 없습니다");
			return "forward:saleViewProc?saleCode="+saleCode;
		}
		service.delProc(saleCode, searchDto.getCategory());
		return "redirect:manageProc?category="+searchDto.getCategory();
	}
	
	@RequestMapping(value = "/saleModifyProc")
	public String saleModifyProc(ItemDTO merDto, String category, MultipartHttpServletRequest req, Model model) {
		if(service.modifyProc(merDto, req) == false) model.addAttribute("msg", "상품 수정에 실패하였습니다. 다시 시도해 주십시오");
		return "redirect:manageProc?category="+category;
	}
	
	@RequestMapping(value = "/display")
	public ResponseEntity<byte[]> getImage(String fileName, String regDate){
		regDate = regDate.replace("-", "");
		regDate = regDate.substring(0, 6);
		
		File file = new File(service.getFILE_LOCATION()+ "\\" + regDate + "\\" + fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}	
		return result;
	}
	
	@RequestMapping(value = "/saleList")
	public String saleList() {
		return "manage/saleList";
	}
	
	@RequestMapping(value = "/saleListProc")
	public String saleListProc(SearchDTO searchDto, Model model) {
		String id = (String) session.getAttribute("id");
		if(id == null || id =="") {
			return "forward:index?formpath=normalLogin";	
		}
		searchDto.setId(id);
		service.saleListProc(searchDto, model);
		return "forward:index?formpath=saleList";
	}

}
