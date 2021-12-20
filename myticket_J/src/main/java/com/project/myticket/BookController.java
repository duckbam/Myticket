package com.project.myticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.myticket.dto.ViewDTO;
import com.project.myticket.service.BookService;

@Controller
public class BookController {
	@Autowired BookService BS;
	
	@RequestMapping(value = "/bookingProc")
	public String bookingProc(@RequestParam(value = "saleCode", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=home";
		}
		BS.bookingProc(wn, model);
		return "forward:index?formpath=booking";
		
	}
	
	@RequestMapping(value = "/bookProc")
	public String bookProc(@RequestParam(value = "saleCode", required = false) String wn, ViewDTO view, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=home";
		}
		BS.bookProc(wn, view, model);
		return "forward:index?formpath=book";
		
	}
	
	@RequestMapping(value = "/bookInsertProc")
	public String bookInsertProc(@RequestParam(value = "bookData", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=back";
		}
		BS.bookInsertProc(wn, model);
		return "forward:index?formpath=home";
	}
	
	@RequestMapping(value = "/bookCancelProc")
	public String bookCancelProc(@RequestParam(value = "bNum", required = false) String wn, Model model) {
		if(wn == null || wn == "") {
			return "forward:index?formpath=back";
		}
		BS.bookCancelProc(wn, model);
		return "forward:index?formpath=bookCancel";
	}

}
