package com.project.myticket.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.myticket.dao.IBoardViewDAO;
import com.project.myticket.dto.BookDTO;
import com.project.myticket.dto.ItemDTO;
import com.project.myticket.dto.ListDTO;

@Service
public class BoardViewService {
	@Autowired IBoardViewDAO IBDao;
	@Autowired HttpSession session;

	public void movieProc(Model model, String category, String page, String clsCheck) {
		if(category == null || category == "") {
			ArrayList<ItemDTO> itemList = IBDao.movieProc();
			model.addAttribute("itemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		} else {
				ArrayList<ItemDTO> itemList = IBDao.movieSearchProc(category);
				model.addAttribute("itemList", itemList);
				if(clsCheck == "" || clsCheck == null) {
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
		}
	}

	public void theaterProc(Model model, String category, String page, String clsCheck) {
		if(category == null || category == "") {
			ArrayList<ItemDTO> itemList = IBDao.theaterProc();
			model.addAttribute("TItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		} else {
			ArrayList<ItemDTO> itemList = IBDao.theaterSearchProc(category);
			model.addAttribute("TItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		}
		
	}

	public void concertProc(Model model, String category, String page, String clsCheck) {
		if(category == null || category == "") {
			ArrayList<ItemDTO> itemList = IBDao.concertProc();
			model.addAttribute("CItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		} else {
			ArrayList<ItemDTO> itemList = IBDao.concertSearchProc(category);
			model.addAttribute("CItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		}
		
	}

	public void sportsProc(Model model, String category, String page, String clsCheck) {
		if(category == null || category == "") {
			ArrayList<ItemDTO> itemList = IBDao.sportsProc();
			model.addAttribute("SItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		} else {
			ArrayList<ItemDTO> itemList = IBDao.sportsSearchProc(category);
			model.addAttribute("SItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			};
		}
		
	}

	public void leisureProc(Model model, String category, String page, String clsCheck) {
		if(category == null || category == "") {
			ArrayList<ItemDTO> itemList = IBDao.leisureProc();
			model.addAttribute("LItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		} else {
			ArrayList<ItemDTO> itemList = IBDao.leisureSearchProc(category);
			model.addAttribute("LItemList", itemList);
			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(itemList.size());
				model.addAttribute("cls", cls);
				model.addAttribute("cate", category);
			}
		}
		
		
	}

	public void viewMoiveProc(String saleCode, Model model) {
		model.addAttribute("movieView", IBDao.viewMovieProc(saleCode));
		
	}

	public void viewConcertProc(String saleCode, Model model) {
		model.addAttribute("concertView", IBDao.viewConcertProc(saleCode));
		
	}

	public void viewLeisureProc(String saleCode, Model model) {
		model.addAttribute("leisureView", IBDao.viewLeisureProc(saleCode));
		
	}

	public void viewSportsProc(String saleCode, Model model) {
		model.addAttribute("sportsView", IBDao.viewSportsProc(saleCode));
		
	}

	public void viewTheaterProc(String saleCode, Model model) {
		model.addAttribute("theaterView", IBDao.viewTheaterProc(saleCode));
		
	}

	public void bookListProc(Model model, String page, String clsCheck) {
			String id = (String)session.getAttribute("id");
			ArrayList<BookDTO> bookList = IBDao.bookListProc(id);
			model.addAttribute("bookList", bookList);

			if(clsCheck == "" || clsCheck == null) {
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(bookList.size());
				model.addAttribute("cls", cls);
			}
	}

	public void bookViewProc(String bNum, Model model) {
		model.addAttribute("view", IBDao.bookViewProc(bNum));
		BookDTO bDto = IBDao.bookViewProc(bNum);
		if(bDto.getSaleCode().contains("m")) {
			model.addAttribute("viewImg", IBDao.viewMovieProc(bDto.getSaleCode()));
		} else if(bDto.getSaleCode().contains("t")) {
			model.addAttribute("viewImg", IBDao.viewTheaterProc(bDto.getSaleCode()));
		} else if(bDto.getSaleCode().contains("c")) {
			model.addAttribute("viewImg", IBDao.viewConcertProc(bDto.getSaleCode()));
		} else if(bDto.getSaleCode().contains("s")) {
			model.addAttribute("viewImg", IBDao.viewSportsProc(bDto.getSaleCode()));
		} else if(bDto.getSaleCode().contains("l")) {
			model.addAttribute("viewImg", IBDao.viewLeisureProc(bDto.getSaleCode()));
		}
	}

	public void searchDataProc(Model model, String sendData, String find, String stage, String page, String category) {
		if(stage.contains("t")) {
			if(find.contains("title")) {
				ArrayList<ItemDTO> itemList = IBDao.searchTitleTProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
				
			}else {
				ArrayList<ItemDTO> itemList = IBDao.searchSellTProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
				
			}
		}else if(stage.contains("c")) {
			if(find.contains("title")) {
				ArrayList<ItemDTO> itemList = IBDao.searchTitleCProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
			}else {
				ArrayList<ItemDTO> itemList = IBDao.searchSellCProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
				
			}
		
		}else if(stage.contains("m")) {
			if(find.contains("title")) {
				ArrayList<ItemDTO> itemList = IBDao.searchTitleMProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
			}else {
				ArrayList<ItemDTO> itemList = IBDao.searchSellMProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
				
			}
			
		}else if(stage.contains("l")) {
			if(find.contains("title")) {
				ArrayList<ItemDTO> itemList = IBDao.searchTitleLProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
			}else {
				ArrayList<ItemDTO> itemList = IBDao.searchSellLProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
				
			}
			
		}else if(stage.contains("s")) {
			if(find.contains("title")) {
				ArrayList<ItemDTO> itemList = IBDao.searchTitleSProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
			}else {
				ArrayList<ItemDTO> itemList = IBDao.searchSellSProc(sendData);
				ArrayList<ItemDTO> newList = new ArrayList<ItemDTO>();
				for(ItemDTO i : itemList) {
					if(i.getsGenre().contains(category)) {
						newList.add(i);
					}
				}
				if(category == "" || category == null) {
					model.addAttribute("seachReturn", itemList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(itemList.size());
					model.addAttribute("cls", cls);
				}else {
					model.addAttribute("seachReturn", newList);
					ListDTO cls = new ListDTO();
					cls.setPageNumber(page);
					cls.setTotalRecord(newList.size());
					model.addAttribute("cls", cls);
					model.addAttribute("cate", category);
				}
				
			}
			
		}
		
	}

	public void searchListProc(Model model, String sendData, String find, String stage, String page) {
		if(stage.contains("b")) {
			if(find.contains("title")) {
				String id = (String)session.getAttribute("id");
				ArrayList<BookDTO> itemList = IBDao.searchTitleBProc(sendData);
				ArrayList<BookDTO> BookList = new ArrayList<BookDTO>();
				for(BookDTO i : itemList) {
					if(i.getId().contains(id)) {
						BookList.add(i);
					}
				}
				model.addAttribute("seachReturn", BookList);
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(BookList.size());
				model.addAttribute("cls", cls);
			}else if(find.contains("sellNum")){
				String id = (String)session.getAttribute("id");
				ArrayList<BookDTO> itemList = IBDao.searchSellNumBProc(sendData);
				ArrayList<BookDTO> BookList = new ArrayList<BookDTO>();
				for(BookDTO i : itemList) {
					if(i.getId().contains(id)) {
						BookList.add(i);
					}
				}
				model.addAttribute("seachReturn", BookList);
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(BookList.size());
				model.addAttribute("cls", cls);
				
			}else if(find.contains("sellState")){
				String id = (String)session.getAttribute("id");
				if(sendData.contains("예") || sendData.contains("약") || sendData.contains("중")) {
					sendData = "b";
				}else if(sendData.contains("취") || sendData.contains("소") || sendData.contains("완") || sendData.contains("료")) {
					sendData = "c";
				}
				ArrayList<BookDTO> itemList = IBDao.searchSellStateBProc(sendData);
				ArrayList<BookDTO> BookList = new ArrayList<BookDTO>();
				for(BookDTO i : itemList) {
					if(i.getId().contains(id)) {
						BookList.add(i);
					}
				}
				model.addAttribute("seachReturn", BookList);
				ListDTO cls = new ListDTO();
				cls.setPageNumber(page);
				cls.setTotalRecord(BookList.size());
				model.addAttribute("cls", cls);
			}
			
		}
	}

}
