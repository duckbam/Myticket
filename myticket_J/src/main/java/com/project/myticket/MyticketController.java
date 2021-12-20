package com.project.myticket;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.myticket.dto.NormalMemberDTO;
import com.project.myticket.dto.SellerMemberDTO;
import com.project.myticket.service.BoardViewService;
import com.project.myticket.service.MemberService;

@Controller
public class MyticketController {
	@Autowired MemberService service;
	@Autowired BoardViewService BVS;
	private static final Logger logger = LoggerFactory.getLogger(MyticketController.class);
	
	@RequestMapping(value = "/")
	public String index(Model model) {
		model.addAttribute("formpath", "home");
		return "index";
	}
	
	@RequestMapping(value = "/index")
	public String index(Model model, @RequestParam String formpath) {
		model.addAttribute("formpath", formpath);
		logger.warn("formpath : " + formpath);
		return "index";
	}
	
	@RequestMapping(value = "/home")
	public void home() {}
	
	@RequestMapping(value = "/CompanyIntroduction")
	public String CompanyIntroduction() {
		return "banner/CompanyIntroduction";
	}
	
	@RequestMapping(value = "/EmploymentAnnouncement")
	public String EmploymentAnnouncement() {
		return "banner/EmploymentAnnouncement";
	}
	
	@RequestMapping(value = "/AffiliateAndAdvertisement")
	public String AffiliateAndAdvertisement() {
		return "banner/AffiliateAndAdvertisement";
	}
	
	@RequestMapping(value = "/CustomerSupport")
	public String CustomerSupport() {
		return "banner/CustomerSupport";
	}
	
	@RequestMapping(value = "/UncomfortableReport")
	public String UncomfortableReport() {
		return "banner/UncomfortableReport";
	}
	
	@RequestMapping(value = "/login")
	public String login() {
		return "member/login";
	}
	
	@RequestMapping(value = "/registerSelect")
	public String registerSelect() {
		return "member/registerSelect";
	}
	
	@RequestMapping(value = "/loginSelect")
	public String loginSelect() {
		return "member/loginSelect";
	}
	
	@RequestMapping(value = "/normalLogin")
	public String normalLogin() {
		return "member/normalLogin";
	}
	
	@RequestMapping(value = "/sellerLogin")
	public String sellerLogin() {
		return "member/sellerLogin";
	}
	
	@RequestMapping(value = "/normalRegister")
	public String normalRegister() {
		return "member/normalRegister";
	}
	
	@RequestMapping(value = "/sellerRegister")
	public String sellerRegister() {
		return "member/sellerRegister";
	}
	
	@RequestMapping(value = "/normalDelete")
	public String normalDelete() {
		return "forward:normalMypage?page=normalDelete";
	}
	
	@RequestMapping(value = "/normalModify")
	public String normalModify(String id, Model model, HttpSession session) {
		id = session.getAttribute("id").toString();
		model.addAttribute("normalInfo", service.normalMemberInfo(id));
		return "forward:normalMypage?page=normalModify";
	}
	
	@RequestMapping(value = "/sellerDelete")
	public String sellerDelete() {
		return "forward:sellerMypage?page=sellerDelete";
	}
	
	@RequestMapping(value = "/sellerModify")
	public String sellerModify(String id, Model model, HttpSession session) {
		id = session.getAttribute("id").toString();
		model.addAttribute("sellerInfo", service.sellerMemberInfo(id));
		return "forward:sellerMypage?page=sellerModify";
	}
	
	
	@RequestMapping(value = "/movie")
	public String movie(@RequestParam(value = "pageNumber", required = false) String page,
			@RequestParam(value = "clsCheck", required = false) String clsCheck, Model model, String category) {
		BVS.movieProc(model, category, page, clsCheck);
		return "category/movie";
	}
	
	@RequestMapping(value = "/theater")
	public String theater(@RequestParam(value = "pageNumber", required = false) String page,
			@RequestParam(value = "clsCheck", required = false) String clsCheck, Model model, String category) {
		BVS.theaterProc(model, category, page, clsCheck);
		return "category/theater";
	}
	
	@RequestMapping(value = "/concert")
	public String concert(@RequestParam(value = "pageNumber", required = false) String page,
			@RequestParam(value = "clsCheck", required = false) String clsCheck, Model model, String category) {
		BVS.concertProc(model, category, page, clsCheck);
		return "category/concert";
	}
	
	@RequestMapping(value = "/sports")
	public String sports(@RequestParam(value = "pageNumber", required = false) String page,
			@RequestParam(value = "clsCheck", required = false) String clsCheck, Model model, String category) {
		BVS.sportsProc(model, category, page, clsCheck);
		return "category/sports";
	}
	
	@RequestMapping(value = "/leisure")
	public String leisure(@RequestParam(value = "pageNumber", required = false) String page,
			@RequestParam(value = "clsCheck", required = false) String clsCheck, Model model, String category) {
		BVS.leisureProc(model, category, page, clsCheck);
		return "category/leisure";
	}
	
	@RequestMapping(value = "/normalMypages")
	public String normalMypages() {
		return "member/normalMypage";
	}
	
	@RequestMapping(value = "/normalMypage")
	public String normalMypage(String page, Model model) {
		model.addAttribute("page", page);
		return "forward:index?formpath=normalMypages";
	}
	
	@RequestMapping(value = "/sellerMypages")
	public String sellerMypages() {
		return "member/sellerMypage";
	}
	
	@RequestMapping(value = "/sellerMypage")
	public String sellerMypage(String page, Model model) {
		model.addAttribute("page", page);
		return "forward:index?formpath=sellerMypages";
	}
	
	@RequestMapping(value = "/adminPage")
	public String adminPage(String page, Model model) {
		model.addAttribute("page", page);
		return "member/adminPage";
	}
	
	@RequestMapping(value = "/memberManage")
	public String memberManage(Model model) {
		model.addAttribute("normalDB", service.normalList());
		model.addAttribute("sellerDB", service.sellerList());
		return "forward:index?formpath=adminPage?page=memberManage";
	}
	
	@RequestMapping(value = "/normalMemberInfo")
	public String normalMemberInfo(String info, Model model) {
		model.addAttribute("normalInfo", service.normalMemberInfo(info));
		return "forward:index?formpath=adminPage?page=normalMemberInfo";
	}
	
	@RequestMapping(value = "/sellerMemberInfo")
	public String sellerMemberInfo(String info, Model model) {
		model.addAttribute("sellerInfo", service.sellerMemberInfo(info));
		return "forward:index?formpath=adminPage?page=sellerMemberInfo";
	}
	
	@RequestMapping(value = "/adminNormalModify")
	public String adminNormalModify(String normalId, Model model) {
		model.addAttribute("normalInfo", service.normalMemberInfo(normalId));
		return "forward:index?formpath=adminPage?page=adminNormalModify";
	}
	
	@RequestMapping(value = "/adminSellerModify")
	public String adminSellerModify(String sellerId, Model model) {
		model.addAttribute("sellerInfo", service.sellerMemberInfo(sellerId));
		return "forward:index?formpath=adminPage?page=adminSellerModify";
	}
	
	@RequestMapping(value = "adminNormalModifyProc")
	public String adminNormalModifyProc(NormalMemberDTO DTO, String pwCheck, Model model, String normalId) {
		model.addAttribute("normalInfo", service.normalMemberInfo(normalId));
		String msg = service.normalModifyProc(DTO, pwCheck);
		model.addAttribute("msg", msg);
		return "forward:index?formpath=adminPage?page=adminNormalModify";
	}
	
	@RequestMapping(value = "adminSellerModifyProc")
	public String adminSellerModifyProc(SellerMemberDTO DTO, String pwCheck, Model model, String sellerId) {
		model.addAttribute("sellerInfo", service.sellerMemberInfo(sellerId));
		String msg = service.sellerModifyProc(DTO, pwCheck);
		model.addAttribute("msg", msg);
		return "forward:index?formpath=adminPage?page=adminSellerModify";
	}
	
	@RequestMapping(value = "/normalRegisterProc")
	public String normalRegisterProc(NormalMemberDTO DTO, String pwCheck, Model model) {
		boolean check = service.normalRegisterProc(DTO, pwCheck, model);
		if(check == false) {
			return "member/normalRegisterProc";
		} else {
		return "redirect:index?formpath=home";
		}
	}
	
	@RequestMapping(value = "/sellerRegisterProc")
	public String sellerRegisterProc(SellerMemberDTO DTO, String pwCheck, Model model) {
		boolean check = service.sellerRegisterProc(DTO, pwCheck, model);
		if(check == false) {
			return "member/sellerRegisterProc";
		} else {
		return "redirect:index?formpath=home";
		}
	}
	
	@RequestMapping(value = "/normalLoginProc")
	public String normalLoginProc(NormalMemberDTO DTO, Model model) {
		boolean check = service.normalLoginProc(DTO, model);
		if(check == false) {
			return "forward:index?formpath=normalLogin";
		} else {
		return "redirect:index?formpath=home";
		}
	}
	
	@RequestMapping(value = "/sellerLoginProc")
	public String sellerLoginProc(SellerMemberDTO DTO, Model model) {
		boolean check = service.sellerLoginProc(DTO, model);
		if(check == false) {
			return "forward:index?formpath=sellerLogin";
		} else {
		return "redirect:index?formpath=home";
		}
	}
	
	@RequestMapping(value = "/normalModifyProc")
	public String normalModifyProc(NormalMemberDTO DTO, String pwCheck, Model model) {
		model.addAttribute("normalInfo", service.normalMemberInfo(DTO.getId()));
		String msg = service.normalModifyProc(DTO, pwCheck);
		model.addAttribute("msg", msg);
		return "forward:normalMypage?page=normalModify";
	}

	@RequestMapping(value = "/normalDeleteProc")
	public String normalDeleteProc(Model model, String id, String pwCheck, String pw, HttpSession session) {
		id = session.getAttribute("id").toString();
		boolean check = service.normalDeleteProc(id, pw, pwCheck, model);
		if(check == false) {
			return "forward:normalMypage?page=normalDelete";
		}else {
		return "redirect:index?formpath=home";
		}
	}
	
	@RequestMapping(value = "/sellerModifyProc")
	public String sellerModifyProc(SellerMemberDTO DTO, String pwCheck, Model model) {
		model.addAttribute("sellerInfo", service.sellerMemberInfo(DTO.getId()));
		String msg = service.sellerModifyProc(DTO, pwCheck);
		model.addAttribute("msg", msg);
		return "forward:sellerMypage?page=sellerModify";
	}
	
	@RequestMapping(value = "/sellerDeleteProc")
	public String sellerDeleteProc(Model model, String id, String pwCheck, String pw, HttpSession session) {
		id = session.getAttribute("id").toString();
		boolean check = service.sellerDeleteProc(id, pw, pwCheck, model);
		if(check == false) {
			return "forward:sellerMypage?page=sellerDelete";
		}else {
		return "redirect:index?formpath=home";
		}
	}
	
	@RequestMapping(value = "adminSellerDeleteProc")
	public String adminSellerDeleteProc(String sellerId) {
		service.adminSellerDeleteProc(sellerId);
		return "forward:memberManage";
	}
	
	@RequestMapping(value = "adminNormalDeleteProc")
	public String adminNormalDeleteProc(String normalId) {
		service.adminNormalDeleteProc(normalId);
		return "forward:memberManage";
	}
	
	@RequestMapping (value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:index?formpath=home";
	}
	
	@RequestMapping(value = "/movieView")
	public String movieView() {
		return "view/movieView";
	}
	
	@RequestMapping(value = "/concertView")
	public String concertView() {
		return "view/concertView";
	}
	
	@RequestMapping(value = "/leisureView")
	public String leisureView() {
		return "view/leisureView";
	}
	
	@RequestMapping(value = "/sportsView")
	public String sportsView() {
		return "view/sportsView";
	}
	
	@RequestMapping(value = "/theaterView")
	public String view() {
		return "view/theaterView";
	}
	
	@RequestMapping(value = "/booking")
	public String booking() {
		return "booking/booking";
	}
	
	@RequestMapping(value = "/book")
	public String book() {
		return "booking/book";
	}
	
	@RequestMapping(value = "/bookList")
	public String bookList(@RequestParam(value = "pageNumber", required = false) String page,
			@RequestParam(value = "clsCheck", required = false) String clsCheck, Model model) {
		BVS.bookListProc(model, page, clsCheck);
		return "forward:normalMypage?page=bookList";
	}
	
	@RequestMapping(value = "/bookView")
	public String bookView() {
		return "booking/bookView";
	}
	
	@RequestMapping(value = "/bookCancel")
	public String bookCancel() {
		return "booking/bookCancel";
	}
	
	@RequestMapping(value = "/back")
	public String back() {
		return "back";
	}
	
	@RequestMapping(value = "/searchDataProc")
	public String searchDataProc(@RequestParam(value = "searchData", required = false) String sendData,
			@RequestParam(value = "stage", required = false) String stage,
			@RequestParam(value = "find", required = false) String find,
			@RequestParam(value = "pageNumber", required = false) String page,
			@RequestParam(value = "category", required = false) String category,
		    Model model) {
		System.out.println(category);
		if(stage.contains("t")) {
			BVS.searchDataProc(model, sendData, find, stage, page, category);
			return "forward:index?formpath=theater";
		}else if(stage.contains("l")) {
			BVS.searchDataProc(model, sendData, find, stage, page, category);
			return "forward:index?formpath=leisure";
		}else if(stage.contains("s")) {
			BVS.searchDataProc(model, sendData, find, stage, page, category);
			return "forward:index?formpath=sports";
		}else if(stage.contains("c")) {
			BVS.searchDataProc(model, sendData, find, stage, page, category);
			return "forward:index?formpath=concert";
		}else if(stage.contains("m")) {
			BVS.searchDataProc(model, sendData, find, stage, page, category);
			return "forward:index?formpath=movie";
		}else if(stage.contains("b")) {
			BVS.searchListProc(model, sendData, find, stage, page);
			return "forward:index?formpath=bookList";
		}
		
		return "forward:index?formpath=back";
	}
	
}
