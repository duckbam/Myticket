package com.project.myticket.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.myticket.dao.IBoardViewDAO;
import com.project.myticket.dao.IBookDAO;
import com.project.myticket.dto.BookDTO;
import com.project.myticket.dto.ItemDTO;
import com.project.myticket.dto.ViewDTO;

@Service
public class BookService {
	@Autowired IBoardViewDAO IBDao;
	@Autowired IBookDAO IBookDao;
	@Autowired HttpSession session;
	
	public void bookingProc(String saleCode, Model model) {
		System.out.println(saleCode);
		if(saleCode.contains("m")) {
			model.addAttribute("booking", IBDao.viewMovieProc(saleCode));
			model.addAttribute("categoryTab", "영화");
		} else if(saleCode.contains("t")) {
			model.addAttribute("booking", IBDao.viewTheaterProc(saleCode));
			model.addAttribute("categoryTab", "연극");
		} else if(saleCode.contains("c")) {
			model.addAttribute("booking", IBDao.viewConcertProc(saleCode));
			model.addAttribute("categoryTab", "콘서트");
		} else if(saleCode.contains("s")) {
			model.addAttribute("booking", IBDao.viewSportsProc(saleCode));
			model.addAttribute("categoryTab", "스포츠");
		} else if(saleCode.contains("l")) {
			model.addAttribute("booking", IBDao.viewLeisureProc(saleCode));
			model.addAttribute("categoryTab", "레저");
		}
		
	}

	public void bookProc(String saleCode, ViewDTO view, Model model) {
		if(saleCode.contains("m")) {
			model.addAttribute("book", IBDao.viewMovieProc(saleCode));
			model.addAttribute("categoryTab", "영화");
		} else if(saleCode.contains("t")) {
			model.addAttribute("book", IBDao.viewTheaterProc(saleCode));
			model.addAttribute("categoryTab", "연극");
		} else if(saleCode.contains("c")) {
			model.addAttribute("book", IBDao.viewConcertProc(saleCode));
			model.addAttribute("categoryTab", "콘서트");
		} else if(saleCode.contains("s")) {
			model.addAttribute("book", IBDao.viewSportsProc(saleCode));
			model.addAttribute("categoryTab", "스포츠");
		} else if(saleCode.contains("l")) {
			model.addAttribute("book", IBDao.viewLeisureProc(saleCode));
			model.addAttribute("categoryTab", "레저");
		}
		session.setAttribute("bookView", view);
		
	}

	public void bookInsertProc(String bookData, Model model) {
		if(bookData.contains("m")) {
			ItemDTO iDto = IBDao.viewMovieProc(bookData);
			BookDTO bDto = new BookDTO();
			bDto.setSaleCode(iDto.getSaleCode());
			ViewDTO vDto = (ViewDTO)session.getAttribute("bookView");
			Date day = new Date();
			SimpleDateFormat forDay = new SimpleDateFormat("yyyy-MM-dd");
			bDto.setbToday(forDay.format(day));
			bDto.setbCancel(forDay.format(day));
			bDto.setbWatch(vDto.getBookDate());	
			bDto.setbTicket(vDto.getBookCount());
			bDto.setbName(iDto.getName());
			Random r = new Random();
			String num = String.format("%10d", r.nextInt(1000000000));
			bDto.setbNum(num);
			bDto.setbState("b");
			String id = (String)session.getAttribute("id");
			bDto.setId(id);
			IBookDao.bookInsertProc(bDto);
			int oldSeat = iDto.getSeat();
			int count = Integer.parseInt(vDto.getBookCount());
			int newSeat = (oldSeat - count);
			iDto.setSeat(newSeat);
			IBookDao.MSeatUpdate(iDto);
		} else if(bookData.contains("t")) {
			ItemDTO iDto = IBDao.viewTheaterProc(bookData);
			BookDTO bDto = new BookDTO();
			bDto.setSaleCode(iDto.getSaleCode());
			ViewDTO vDto = (ViewDTO)session.getAttribute("bookView");
			Date day = new Date();
			SimpleDateFormat forDay = new SimpleDateFormat("yyyy-MM-dd");
			bDto.setbToday(forDay.format(day));
			bDto.setbCancel(forDay.format(day));
			bDto.setbWatch(vDto.getBookDate());	
			bDto.setbTicket(vDto.getBookCount());
			bDto.setbName(iDto.getName());
			Random r = new Random();
			String num = String.format("%10d", r.nextInt(1000000000));
			bDto.setbNum(num);
			bDto.setbState("b");
			String id = (String)session.getAttribute("id");
			bDto.setId(id);
			IBookDao.bookInsertProc(bDto);
			int oldSeat = iDto.getSeat();
			int count = Integer.parseInt(vDto.getBookCount());
			int newSeat = (oldSeat - count);
			iDto.setSeat(newSeat);
			IBookDao.TSeatUpdate(iDto);
		} else if(bookData.contains("c")) {
			ItemDTO iDto = IBDao.viewConcertProc(bookData);
			BookDTO bDto = new BookDTO();
			bDto.setSaleCode(iDto.getSaleCode());
			ViewDTO vDto = (ViewDTO)session.getAttribute("bookView");
			Date day = new Date();
			SimpleDateFormat forDay = new SimpleDateFormat("yyyy-MM-dd");
			bDto.setbToday(forDay.format(day));
			bDto.setbCancel(forDay.format(day));
			bDto.setbWatch(vDto.getBookDate());	
			bDto.setbTicket(vDto.getBookCount());
			bDto.setbName(iDto.getName());
			Random r = new Random();
			String num = String.format("%10d", r.nextInt(1000000000));
			bDto.setbNum(num);
			bDto.setbState("b");
			String id = (String)session.getAttribute("id");
			bDto.setId(id);
			IBookDao.bookInsertProc(bDto);
			int oldSeat = iDto.getSeat();
			int count = Integer.parseInt(vDto.getBookCount());
			int newSeat = (oldSeat - count);
			iDto.setSeat(newSeat);
			IBookDao.CSeatUpdate(iDto);
		} else if(bookData.contains("s")) {
			ItemDTO iDto = IBDao.viewSportsProc(bookData);
			BookDTO bDto = new BookDTO();
			bDto.setSaleCode(iDto.getSaleCode());
			ViewDTO vDto = (ViewDTO)session.getAttribute("bookView");
			Date day = new Date();
			SimpleDateFormat forDay = new SimpleDateFormat("yyyy-MM-dd");
			bDto.setbToday(forDay.format(day));
			bDto.setbCancel(forDay.format(day));
			bDto.setbWatch(vDto.getBookDate());	
			bDto.setbTicket(vDto.getBookCount());
			bDto.setbName(iDto.getName());
			Random r = new Random();
			String num = String.format("%10d", r.nextInt(1000000000));
			bDto.setbNum(num);
			bDto.setbState("b");
			String id = (String)session.getAttribute("id");
			bDto.setId(id);
			IBookDao.bookInsertProc(bDto);
			int oldSeat = iDto.getSeat();
			int count = Integer.parseInt(vDto.getBookCount());
			int newSeat = (oldSeat - count);
			iDto.setSeat(newSeat);
			IBookDao.SSeatUpdate(iDto);
		} else if(bookData.contains("l")) {
			ItemDTO iDto = IBDao.viewLeisureProc(bookData);
			BookDTO bDto = new BookDTO();
			bDto.setSaleCode(iDto.getSaleCode());
			ViewDTO vDto = (ViewDTO)session.getAttribute("bookView");
			Date day = new Date();
			SimpleDateFormat forDay = new SimpleDateFormat("yyyy-MM-dd");
			bDto.setbToday(forDay.format(day));
			bDto.setbCancel(forDay.format(day));
			bDto.setbWatch(vDto.getBookDate());	
			bDto.setbTicket(vDto.getBookCount());
			bDto.setbName(iDto.getName());
			Random r = new Random();
			String num = String.format("%10d", r.nextInt(1000000000));
			bDto.setbNum(num);
			bDto.setbState("b");
			String id = (String)session.getAttribute("id");
			bDto.setId(id);
			IBookDao.bookInsertProc(bDto);
			int oldSeat = iDto.getSeat();
			int count = Integer.parseInt(vDto.getBookCount());
			int newSeat = (oldSeat - count);
			iDto.setSeat(newSeat);
			IBookDao.LSeatUpdate(iDto);
		}
		
	}

	public void bookCancelProc(String bNum, Model model) {
		BookDTO bDto = IBDao.bookCancelProc(bNum);
		bDto.setbState("c");
		IBookDao.bookUpdateProc(bDto);
		if(bDto.getSaleCode().contains("m")) {
			ItemDTO iDto = IBDao.viewMovieProc(bDto.getSaleCode());
			int booKSeat = Integer.parseInt(bDto.getbTicket());
			int selSeat = iDto.getSeat();
			int reSeat = (selSeat + booKSeat);
			iDto.setSeat(reSeat);
			IBookDao.MSeatUpdate(iDto);
		} else if(bDto.getSaleCode().contains("t")) {
			ItemDTO iDto = IBDao.viewTheaterProc(bDto.getSaleCode());
			int booKSeat = Integer.parseInt(bDto.getbTicket());
			int selSeat = iDto.getSeat();
			int reSeat = (selSeat + booKSeat);
			iDto.setSeat(reSeat);
			IBookDao.TSeatUpdate(iDto);
		} else if(bDto.getSaleCode().contains("c")) {
			ItemDTO iDto = IBDao.viewConcertProc(bDto.getSaleCode());
			int booKSeat = Integer.parseInt(bDto.getbTicket());
			int selSeat = iDto.getSeat();
			int reSeat = (selSeat + booKSeat);
			iDto.setSeat(reSeat);
			IBookDao.CSeatUpdate(iDto);
		} else if(bDto.getSaleCode().contains("s")) {
			ItemDTO iDto = IBDao.viewSportsProc(bDto.getSaleCode());
			int booKSeat = Integer.parseInt(bDto.getbTicket());
			int selSeat = iDto.getSeat();
			int reSeat = (selSeat + booKSeat);
			iDto.setSeat(reSeat);
			IBookDao.SSeatUpdate(iDto);
		} else if(bDto.getSaleCode().contains("l")) {
			ItemDTO iDto = IBDao.viewLeisureProc(bDto.getSaleCode());
			int booKSeat = Integer.parseInt(bDto.getbTicket());
			int selSeat = iDto.getSeat();
			int reSeat = (selSeat + booKSeat);
			iDto.setSeat(reSeat);
			IBookDao.LSeatUpdate(iDto);
		}
	}



}
