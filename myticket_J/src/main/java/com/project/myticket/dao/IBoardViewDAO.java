package com.project.myticket.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.myticket.dto.BookDTO;
import com.project.myticket.dto.ItemDTO;

@Repository
public interface IBoardViewDAO {

	ArrayList<ItemDTO> movieProc();

	ArrayList<ItemDTO> theaterProc();

	ArrayList<ItemDTO> concertProc();

	ArrayList<ItemDTO> sportsProc();

	ArrayList<ItemDTO> leisureProc();

	ItemDTO viewMovieProc(String saleCode);

	ItemDTO viewConcertProc(String saleCode);

	ItemDTO viewLeisureProc(String saleCode);

	ItemDTO viewSportsProc(String saleCode);

	ItemDTO viewTheaterProc(String saleCode);

	ArrayList<BookDTO> bookListProc(String id);

	BookDTO bookViewProc(String bNum);

	BookDTO bookCancelProc(String bNum);

	ArrayList<ItemDTO> movieSearchProc(String category);

	ArrayList<ItemDTO> theaterSearchProc(String category);

	ArrayList<ItemDTO> concertSearchProc(String category);

	ArrayList<ItemDTO> sportsSearchProc(String category);

	ArrayList<ItemDTO> leisureSearchProc(String category);

	ArrayList<ItemDTO> searchTitleTProc(String sendData);

	ArrayList<ItemDTO> searchSellTProc(String sendData);

	ArrayList<ItemDTO> searchTitleCProc(String sendData);

	ArrayList<ItemDTO> searchSellCProc(String sendData);

	ArrayList<ItemDTO> searchTitleMProc(String sendData);

	ArrayList<ItemDTO> searchSellMProc(String sendData);

	ArrayList<ItemDTO> searchTitleLProc(String sendData);

	ArrayList<ItemDTO> searchSellLProc(String sendData);

	ArrayList<ItemDTO> searchTitleSProc(String sendData);

	ArrayList<ItemDTO> searchSellSProc(String sendData);

	ArrayList<BookDTO> searchTitleBProc(String sendData);

	ArrayList<BookDTO> searchSellNumBProc(String sendData);

	ArrayList<BookDTO> searchSellStateBProc(String sendData);
}
