package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service	// 주로 비즈니스 영역을 담당하는 객체임을 표시
@AllArgsConstructor	// 모든 파라미터를 이용하는 생성자를 만든다.
public class BoardServiceImpl implements BoardService {	/* BoardService 인터페이스를 구현하는 구현체 */
	
	// spring 4.3 이상에서 자동 처리
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("register......" + board);
		
		mapper.insertSelectKey(board);
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	/* 조회 */
	@Override
	public BoardVO get(Long bno) {	// 게시물 번호가 파라미터(매개변수)
		log.info("get......" + bno);
		return mapper.read(bno);
	}
	
	/* 수정 */
	public boolean modify(BoardVO board) {	// 리턴타입을 void로 설계할 수도 있지만, 엄격하게 처리하기 위해서 Boolean 타입으로 처리
		log.info("modify......" + board);
		return mapper.update(board) == 1;	
		// update메서드의 리턴타입은 int. 정상적으로 수정이 이루어지면 '1'이라는 값이 반환. 
		// "==" 연산자를 사용해서 '1'이 맞다면 true, 아니라면 false를 리턴하도록 처리한다. 
	}
	
	/* 삭제 */
	public boolean remove(Long bno) {
		log.info("remove......" + bno);
		return mapper.delete(bno) == 1;
	}

	/* 전체 게시글 수 구하기 */
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
}
