package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller	// 스프링의 빈으로 인식할 수 있도록 한다.
@Log4j
@RequestMapping("/board/*")	// hostname:port/board/ 로 시작하는 모든 처리를 BoardController가 하도록 지정한다.
@AllArgsConstructor	// 모든 인자를 가진 생성자 생성
public class BoardController {
	
	private BoardService service;
	
	
	/* 목록 페이지 */
	@GetMapping("/list")
	// @RequestMapping(value="/aaa", method=RequestMethod.GET)을 대신하는 코드. 메소드별로 다른 방식으로 처리하기 위함
	public void list(Criteria cri, Model model) {
		
		int total = service.getTotal(cri);	// 전체 게시글의 수
		log.info("total: " + total);
		
		model.addAttribute("list", service.getList(cri));		// service.getList() 리턴 객체를 "list" 라는 이름에 담아 view로 전달한다.
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	/* 등록 */
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register: " + board);
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());	// addFlashAttribute는 일회성으로만 데이터를 전달
		
		return "redirect:/board/list";
	}
	
	/* 조회, 수정 */
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {	// name="bno"인 값을 전달받는다, 소문자long 대문자Long 상관없다.
		// log.info("/get or /modify");
		model.addAttribute("board", service.get(bno));	// service.get(bno)의 리턴값을 "board"에 저장
	}
	
	/* 수정 */
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		// log.info("modify: " + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		// getListLink로 변경
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list" + cri.getListLink();	
		// '/board/list?pageNum=3&amount=20&type=TC%&keywrod=%EC%83%88%...' 와 같이 GET 방식에 적합한 URL 인코딩 결과로 만들어진다.
	}
	
	/* 삭제 */
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		// log.info("remove..." + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");	// result라는 값에 sucess라는 문자열을 담는다.
		}
		
		// getListLink로 변경
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list" + cri.getListLink();
	}
}
