package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface BoardService {
public void register(BoardVO board);
	
	public BoardVO get(Long bno);	// 명백하게 반환해야 할 데이터가 있는 메서드는 리턴 타입 지정
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);	
	// 전체 게시글 수 구하기 - 굳이 Criteria는 파라미터로 전달될 필요가 없기는 하지만, 목록과 전체 데이터 개수는 항상 같이 동작하는 경우가 많아서 지정.
}
