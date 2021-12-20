package com.project.myticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.myticket.service.BoardViewService;

@Controller
public class BoardViewController {
	@Autowired BoardViewService BVS;
	
	@RequestMapping(value = "/viewMovieProc")
	public String viewMovieProc(@RequestParam(value = "saleCode", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=moive";
		}
		BVS.viewMoiveProc(wn, model);
		return "forward:index?formpath=movieView";
	}
	
	@RequestMapping(value = "/viewConcertProc")
	public String viewConcertProc(@RequestParam(value = "saleCode", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=concert";
		}
		BVS.viewConcertProc(wn, model);
		return "forward:index?formpath=concertView";
	}
	
	@RequestMapping(value = "/viewLeisureProc")
	public String viewLeisureProc(@RequestParam(value = "saleCode", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=leisure";
		}
		BVS.viewLeisureProc(wn, model);
		return "forward:index?formpath=leisureView";
	}
	
	@RequestMapping(value = "/viewSportsProc")
	public String viewSportsProc(@RequestParam(value = "saleCode", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=sports";
		}
		BVS.viewSportsProc(wn, model);
		return "forward:index?formpath=sportsView";
	}
	
	@RequestMapping(value = "/viewTheaterProc")
	public String viewTheaterProc(@RequestParam(value = "saleCode", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=theater";
		}
		BVS.viewTheaterProc(wn, model);
		return "forward:index?formpath=theaterView";
	}
	
	@RequestMapping(value = "/bookViewProc")
	public String bookViewProc(@RequestParam(value = "bNum", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=home";
		}
		BVS.bookViewProc(wn, model);
		return "forward:index?formpath=bookView";
	}
	
}
