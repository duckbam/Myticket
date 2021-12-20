package com.project.myticket.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.project.myticket.dto.NormalMemberDTO;
import com.project.myticket.dto.SellerMemberDTO;

public interface IMemberService {
	
	public boolean normalRegisterProc(NormalMemberDTO DTO, String pwCheck, Model model);
	
	public boolean sellerRegisterProc(SellerMemberDTO DTO, String pwCheck, Model model);
	
	public void sendAuth(String email);
	
	public String authConfirm(String inputAuthNum);
	
	public boolean sellerLoginProc(SellerMemberDTO DTO, Model model);
	
	public boolean normalLoginProc(NormalMemberDTO DTO, Model model);
	
	public ArrayList<NormalMemberDTO> normalList();
	
	public ArrayList<SellerMemberDTO> sellerList();
	
	public NormalMemberDTO normalMemberInfo(String info);
	
	public SellerMemberDTO sellerMemberInfo(String info);
	
	public String normalModifyProc(NormalMemberDTO DTO, String pwCheck);
	
	public boolean normalDeleteProc(String id, String pw, String pwCheck, Model model);
	
	public String sellerModifyProc(SellerMemberDTO DTO, String pwCheck);
	
	public boolean sellerDeleteProc(String id, String pw, String pwCheck, Model model);
	
	public void adminNormalDeleteProc(String normalId);
	
	public void adminSellerDeleteProc(String sellerId);
}