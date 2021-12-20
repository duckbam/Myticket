package com.project.myticket.service;


import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.myticket.dao.IMemberDAO;
import com.project.myticket.dto.NormalMemberDTO;
import com.project.myticket.dto.SellerMemberDTO;

@Service
public class MemberService implements IMemberService {
	@Autowired IMemberDAO dao;
	@Autowired HttpSession session;
	@Autowired MailService mailService;
	final static Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Override
	public boolean normalRegisterProc(NormalMemberDTO DTO, String pwCheck, Model model) {
		Boolean check = (Boolean)session.getAttribute("authState");
		if(check == null) {
			model.addAttribute("alter", "이메일 인증 후 가입 할 수 있습니다.");
			return false;
		}
		
		if(DTO.getPw().equals(pwCheck) == false) {
			model.addAttribute("alter", "비밀번호 확인이 일치하지 않습니다.");
			return false;
		}
		
			
		if(dao.isNormalExistId(DTO.getId()) > 0) {
			model.addAttribute("alter", "중복된 계정으로 가입할 수 없습니다.");
			return false;
		}

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(DTO.getPw());
		DTO.setPw(securePw);

		dao.normalRegisterProc(DTO);
		session.removeAttribute("authState");
		session.removeAttribute("authNum");
		model.addAttribute("alter", "가입 완료");
		return true;
	}
	
	@Override
	public boolean sellerRegisterProc(SellerMemberDTO DTO, String pwCheck, Model model) {
		Boolean check = (Boolean)session.getAttribute("authState");
		if(check == null) {
			model.addAttribute("alter", "이메일 인증 후 가입 할 수 있습니다.");
			return false;
		}
		
		if(DTO.getPw().equals(pwCheck) == false) {
			model.addAttribute("alter", "비밀번호 확인이 일치하지 않습니다.");
			return false;
		}
		
		if(dao.isSellerExistId(DTO.getId()) > 0) {
			model.addAttribute("alter", "중복된 계정으로 가입할 수 없습니다.");
			return false;
		}

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(DTO.getPw());
		DTO.setPw(securePw);

		dao.sellerRegisterProc(DTO);
		session.removeAttribute("authState");
		session.removeAttribute("authNum");
		model.addAttribute("alter", "가입 완료");
		return true;
	}
	
	@Override
	public boolean sellerLoginProc(SellerMemberDTO DTO, Model model) {
		SellerMemberDTO DTO2 = dao.sellerLoginProc(DTO.getId());
		if(DTO2 == null) {
			model.addAttribute("alter", "아이디 혹은 비밀번호가 잘못되었습니다.");
			return false;
		}
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(DTO.getPw(), DTO2.getPw()) == false) {
			model.addAttribute("alter", "아이디 혹은 비밀번호가 잘못되었습니다.");
			return false;
		}
		session.setAttribute("type", "seller");
		session.setAttribute("id", DTO.getId());
		return true;
	}

	@Override
	public boolean normalLoginProc(NormalMemberDTO DTO, Model model) {
		if(DTO.getId().equals("admin") && DTO.getPw().equals("admin")) {
			System.out.println("관리자세션 생성");
				session.setAttribute("type", "admin");
				session.setAttribute("id", DTO.getId());
				return true;
		}
		
		NormalMemberDTO DTO2 = dao.normalLoginProc(DTO.getId());
		if(DTO2 == null) {
			model.addAttribute("alter", "아이디 혹은 비밀번호가 잘못되었습니다.");
			return false;
		}
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(DTO.getPw(), DTO2.getPw()) == false) {
			model.addAttribute("alter", "아이디 혹은 비밀번호가 잘못되었습니다.");
			return false;
		}
		System.out.println(DTO.getId().equals("admin"));
		session.setAttribute("type", "normal");
		session.setAttribute("id", DTO.getId());
		return true;
	}

	@Override
	public void sendAuth(String email) {
		String authNum = (String)session.getAttribute("authNum");
		if(authNum == null) {
			Random r = new Random();
			String randNum = String.format("%06d", r.nextInt(1000000));
			session.setAttribute("authNum", randNum);
			session.setMaxInactiveInterval(180);
			mailService.sendMail(email, "[인증번호]", randNum);
			logger.warn(randNum);

		}else
			logger.warn("인증번호는 이미 생성되어 있습니다.");
	}

	@Override
	public String authConfirm(String inputAuthNum) {
		String sessionAuthNum = (String)session.getAttribute("authNum");
		if(sessionAuthNum == null) 
			return "인증 번호를 생성하세요.";
		if(inputAuthNum == "")
			return "인증 번호를 입력하세요.";
		if(inputAuthNum.equals(sessionAuthNum)) {
			session.setAttribute("authState", true);
			return "인증 완료";
		}
		return "인증 실패";
	}

	@Override
	public ArrayList<NormalMemberDTO> normalList() {
		ArrayList<NormalMemberDTO> normalDB = dao.normalList();
		return normalDB;
	}

	@Override
	public ArrayList<SellerMemberDTO> sellerList() {
		ArrayList<SellerMemberDTO> sellerDB = dao.sellerList();
		return sellerDB;
	}

	@Override
	public NormalMemberDTO normalMemberInfo(String info) {
		NormalMemberDTO normalInfo = dao.normalLoginProc(info);
		return normalInfo;
	}

	@Override
	public SellerMemberDTO sellerMemberInfo(String info) {
		SellerMemberDTO sellerInfo = dao.sellerLoginProc(info);
		return sellerInfo;
	}
	
	@Override
	public String normalModifyProc(NormalMemberDTO DTO, String pwCheck) {
		if(DTO.getPw() == "" || pwCheck == "" || DTO.getName() == "" || DTO.getPhone() == "" || DTO.getBirth() == "") {
			return "필수 정보를 전부 입력해주세요.";
		}
		if(DTO.getPw().equals(pwCheck) == false) {
			return "패스워드 확인이 일치하지 않습니다.";
		}
		NormalMemberDTO DTO2 = new NormalMemberDTO(); 
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(DTO.getPw());
		DTO2.setPw(securePw);
		DTO2.setId(DTO.getId());
		DTO2.setName(DTO.getName());
		DTO2.setEmail(DTO.getEmail());
		DTO2.setPhone(DTO.getPhone());
		DTO2.setBirth(DTO.getBirth());
		DTO2.setGender(DTO.getGender());
		dao.normalModifyProc(DTO2);
		return "정보가 변경되었습니다.";
	}

	@Override
	public boolean normalDeleteProc(String id, String pw, String pwCheck, Model model) {
		if(pw.equals(pwCheck) == false) {
			model.addAttribute("msg", "패스워드 확인이 일치하지 않습니다.");
			return false;
		}
		NormalMemberDTO DTO = dao.normalLoginProc(id);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(pw, DTO.getPw()) == false) {
			model.addAttribute("msg", "패스워드가 일치하지 않습니다. ");
			return false;
		}
		
		dao.normalDeleteProc(id);
		session.invalidate();
		return true;
	}

	@Override
	public String sellerModifyProc(SellerMemberDTO DTO, String pwCheck) {
		if(DTO.getPw() == "" || pwCheck == "" || DTO.getCompany() == "" || DTO.getPhone() == "" || DTO.getTin() == "" || DTO.getAddr2() == "") {
			return "필수 정보를 전부 입력해주세요.";
		}
		if(DTO.getPw().equals(pwCheck) == false) {
			return "패스워드 확인이 일치하지 않습니다.";
		}
		SellerMemberDTO DTO2 = new SellerMemberDTO(); 
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(DTO.getPw());
		DTO2.setPw(securePw);
		DTO2.setId(DTO.getId());
		DTO2.setPhone(DTO.getPhone());
		DTO2.setEmail(DTO.getEmail());
		DTO2.setCompany(DTO.getCompany());
		DTO2.setTin(DTO.getTin());
		DTO2.setZipcode(DTO.getZipcode());
		DTO2.setAddr1(DTO.getAddr1());
		DTO2.setAddr2(DTO.getAddr2());
		dao.sellerModifyProc(DTO2);
		return "정보가 변경되었습니다.";
	}

	@Override
	public boolean sellerDeleteProc(String id, String pw, String pwCheck, Model model) {
		if(pw.equals(pwCheck) == false) {
			model.addAttribute("msg", "패스워드 확인이 일치하지 않습니다.");
			return false;
		}
		SellerMemberDTO DTO = dao.sellerLoginProc(id);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(pw, DTO.getPw()) == false) {
			model.addAttribute("msg", "패스워드가 일치하지 않습니다. ");
			return false;
		}
		
		dao.sellerDeleteProc(id);
		session.invalidate();
		return true;
	}
	
	@Override
	public void adminNormalDeleteProc(String normalId) {
		dao.normalDeleteProc(normalId);
	}

	@Override
	public void adminSellerDeleteProc(String sellerId) {
		dao.sellerDeleteProc(sellerId);	
	}
	
}
