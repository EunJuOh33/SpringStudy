package org.zerock.maper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}
//	
//	@Test
//	public void testInsert() {
//		BoardVO board = new BoardVO();
//		board.setTitle("db 연결 테스트");
//		board.setContent("db 연결 테스트");
//		board.setWriter("newbie");
//		
//		mapper.insert(board);
//		
//		log.info(board);
//	}
//	
//	@Test
//	public void testInsertSelectKey() {
//		BoardVO board = new BoardVO();
//		board.setTitle("새로 작성하는 글 select key");
//		board.setContent("새로 작성하는 내용 select key");
//		board.setWriter("newbie");
//		
//		mapper.insertSelectKey(board);
//		
//		log.info(board);
//	}
//	
//	@Test
//	public void testRead() {
//		// 존재하는 게시물 번호로 테스트
//		BoardVO board = mapper.read(5L);
//		
//		log.info(board);
//	}
//	
//	@Test
//	public void testDelete() {
//		// 정상적으로 데이터가 삭제되면 '1'이 출력, 해당 번호의 게시물이 없다면 '0' 출력
//		log.info("DELETE COUNT: " + mapper.delete(3L));
//	}
//	
//	@Test
//	public void testUpdate() {
//		BoardVO board = new BoardVO();
//		// 실행 전 존재하는 번호인지 확인할 것
//		board.setBno(5L);
//		board.setTitle("수정된 제목");
//		board.setContent("수정된 내용");
//		board.setWriter("user00");
//		
//		int count = mapper.update(board);
//		
//		log.info("UPDATE COUNT: " + count);
//	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();	// this(1, 10)
		cri.setPageNum(2);	// 11 ~ 20페이지
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board.getBno()));
	}
	
//	@Test
//	public void testPageDTO() {
//		Criteria cri = new Criteria();
//		
//		PageDTO pageDTO = new PageDTO(cri, 250);
//		
//		log.info(pageDTO);
//	}
	
//	@Test
//	public void testSearch() {
//		Criteria cri = new Criteria();
//		cri.setKeyword("새로");
//		cri.setType("TC");	// 대소문자 주의!
//		
//		List<BoardVO> list = mapper.getListWithPaging(cri);
//		
//		list.forEach(board -> log.info(board));
//	}

}
