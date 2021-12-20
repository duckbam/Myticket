package com.project.myticket;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.myticket.dto.CenterDTO;
import com.project.myticket.dto.SearchDTO;
import com.project.myticket.service.CenterService;


@Controller
public class CenterController {
	@Autowired CenterService service;
	@Autowired HttpSession session;
	
	@RequestMapping(value = "/center")
	public String customerCenter() {
		return "board/customerCenter";
	}
	
	@RequestMapping(value = "/centerView")
	public String centerView() {
		return "board/centerView";
	}
	@RequestMapping(value = "/centerWrite")
	public String centerWrite(String reUri, SearchDTO searchDto, Model model) {
		String id = (String)session.getAttribute("id");
		if(id == null) {
			return "member/normalLogin";
		}
		service.readSaleCode(searchDto.getCategory(), model);
		model.addAttribute("searchDto", searchDto);
		model.addAttribute("reUri",reUri);
		return "board/centerWrite";
	}
	
	@RequestMapping(value = "/centerProc")
	public String centerProc(SearchDTO searchDto, Model model) {
		//저장할때 대소문자 구분 없이 소문자로 저장되나 select로 검색할때는 대소문자 구분되어
		//카테고리를 소문자로 사용
		if(searchDto.getCategory() == ""  || searchDto.getCategory() == null){
			searchDto.setCategory("movie");
		}
		
		if(searchDto.getCategory().equals("My")) {
			if(session.getAttribute("id") == null) {
				return "forward:index?formpath=normalLogin";
			}
			searchDto.setId((String) session.getAttribute("id"));
		}
		service.centerProc(searchDto, model);
		return "forward:index?formpath=center";
	}
	
	@RequestMapping(value = "/centerWriteProc")
	public String writeProc(CenterDTO centerDto, String category, String reUri, Model model) {
		if(service.writeProc(centerDto) == false) model.addAttribute("msg", "게시물 작성에 실패하였습니다. 다시 시도해 주십시오");
		return "redirect:"+reUri+"?category="+category;
	}
	
	@RequestMapping(value = "/centerViewProc")
	public String viewProc(String writeNo, String reUri, SearchDTO searchDto, Model model) {
		if(writeNo.isEmpty()) 	return "forward:centerProc";
		service.viewProc(writeNo, model);
		model.addAttribute("searchDto", searchDto);
		model.addAttribute("reUri",reUri);
		return "forward:index?formpath=centerView";
	}
	
	@RequestMapping(value = "/CenterDelProc")
	public String CenterDelProc( String writeNo, String category, Model model) {
		String id = (String)session.getAttribute("id");
		if(id == null) {
			model.addAttribute("msg","로그인 후 이용해 주세요");
			return "forward:index?formpath=normalLogin";
		}
		if(writeNo.isEmpty() == false) {
			String[] no = writeNo.split(",");
			for(String n: no) {
				service.delProc(n);
			}
		}
		return "redirect:centerProc?category="+category;
	}
	
	@RequestMapping(value = "/CenterViewDelProc")
	public String CenterViewDelProc(String writer, String no, String originNo, String reUri, SearchDTO searchDto,  Model model) {
		String id = (String)session.getAttribute("id");
		String type = (String)session.getAttribute("type");
		if(id == null) {
			model.addAttribute("msg","로그인 후 이용해 주세요");
			return "forward:index?formpath=normalLogin";
		}
		model.addAttribute("searchDto", searchDto);
		if(type.equals("admin") == false && id.equals(writer) == false) {
			model.addAttribute("msg","삭제 권한이 없습니다");
			return "forward:centerViewProc?writeNo="+no;
		}
		service.delProc(no);
		if(originNo.equals(no) == false) service.delReply(originNo);
		return "redirect:"+reUri+"?category="+searchDto.getCategory();
	}
	@RequestMapping(value = "/centerModify")
	public String modify(String no, String writer, String reUri, SearchDTO searchDto, Model model) {
		String id = (String)session.getAttribute("id");
		String type = (String)session.getAttribute("type");
		if(id == null) {
			model.addAttribute("msg","로그인 후 이용해 주세요");
			return "member/normalLogin";
		}
		service.viewProc(no, model);
		model.addAttribute("searchDto", searchDto);
		model.addAttribute("reUri",reUri);
		if(type.equals("admin") == false && writer.equals(id) == false ){
			model.addAttribute("msg","수정 권한이 없습니다");
			return "board/centerView";
		}
		service.readSaleCode((String) model.getAttribute("centerCategory"), model);
		return "board/centerModify";
	}
	
	@RequestMapping(value = "/CenterModifyProc")
	public String CenterModifyProc(CenterDTO centerDto, String category, String reUri, Model model) {
		if(service.modifyProc(centerDto) == false) model.addAttribute("msg", "게시물 수정에 실패하였습니다. 다시 시도해 주십시오");

		return "redirect:"+reUri+"?category="+category;
	}
	
	@RequestMapping(value = "/seller")
	public String sellerCenter() {
		return "board/sellerCenter";
	}
	
	@RequestMapping(value = "/sellerProc")
	public String sellerProc(SearchDTO searchDto, String answer,Model model) {
		//저장할때 대소문자 구분 없이 소문자로 저장되나 select로 검색할때는 대소문자 구분되어
		//카테고리를 소문자로 사용
		if(searchDto.getCategory() == ""  || searchDto.getCategory() == null){
			searchDto.setCategory("movie");
		}
		
		if(session.getAttribute("id") == null) {
			model.addAttribute("msg","로그인 후 이용해 주세요");
			return "forward:index?formpath=normalLogin";
		}
		searchDto.setId((String) session.getAttribute("id"));
		
		service.sellerProc(searchDto, answer, model);
		return "forward:index?formpath=seller";
	}
	@RequestMapping(value = "/centerReWrite")
	public String centerReWrite(String no, String saleCode, String reUri, SearchDTO searchDto, Model model) {
		String id = (String)session.getAttribute("id");
		String type = (String)session.getAttribute("type");
		boolean ret = true;
		if(id == null) {
			model.addAttribute("msg","로그인 후 이용해 주세요");
			return "member/normalLogin";
		}
		if(saleCode.equals("선택하지 않음")) {	
			if(type.equals("admin") == false) {
				ret = false;
				model.addAttribute("msg","관리자만 사용하실 수 있습니다");
			}
		}
		else {
		   String seller = service.readSellerId(searchDto.getCategory(), saleCode);
		   if(id.equals(seller) == false && type.equals("admin") == false) {
			   ret = false;
			   model.addAttribute("msg","해당 판매자만 사용하실 수 있습니다");
		   }
		}
		service.viewProc(no, model);
		model.addAttribute("searchDto", searchDto);
		model.addAttribute("reUri",reUri);
		String answer = (String) model.getAttribute("centerAnswer");
		if(answer.equals("n") == false) {
			model.addAttribute("msg","이미 답변한 상품입니다");
			ret = false;
		}
		if(ret == false) {
			return "board/centerView";
		}
		return "board/centerReWrite";
	}
	
	@RequestMapping(value = "/centerReWriteProc")
	public String reWriteProc(CenterDTO centerDto, String originNo, String reUri, String category, Model model) {
		centerDto.setNo(Integer.parseInt(originNo));
		if(service.reWriteProc(centerDto) == false) model.addAttribute("msg", "답변 작성에 실패하였습니다. 다시 시도해 주십시오");
		else service.upReply(originNo);
		return "redirect:"+reUri+"?category="+category;
	}

}
