package com.project.myticket.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.project.myticket.dto.NormalMemberDTO;
import com.project.myticket.dto.SellerMemberDTO;

@Repository
public interface IMemberDAO {
	public void normalRegisterProc(NormalMemberDTO DTO);
	
	public void sellerRegisterProc(SellerMemberDTO DTO);
	
	int isNormalExistId(String id);
	
	int isSellerExistId(String id);
	
	NormalMemberDTO normalLoginProc(String id);
	
	SellerMemberDTO sellerLoginProc(String id);
	
	ArrayList<NormalMemberDTO> normalList();
	
	ArrayList<SellerMemberDTO> sellerList();
	
	public void normalModifyProc(NormalMemberDTO DTO);
	
	public void normalDeleteProc(String id);
	
	public void sellerModifyProc(SellerMemberDTO DTO);
	
	public void sellerDeleteProc(String id);
}



