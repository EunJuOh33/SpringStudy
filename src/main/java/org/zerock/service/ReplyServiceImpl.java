package org.zerock.service;


import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyMapper mapper;
	
// @AllArgsConstructor의 효과	
//	public ReplyServiceImpl(ReplyMapper mapper) {
		// 클래스에 존재하는 모든 필드에 대한 생성자를 자동으로 생성
//	}
	
	
	// 등록
	@Override
	public int register(ReplyVO vo) {
		log.info("register......" + vo);
		
		return mapper.insert(vo);
	}

	// 조회
	@Override
	public ReplyVO get(Long rno) {
		log.info("get......");
		return mapper.read(rno);
	}

	// 삭제
	@Override
	public int remove(Long rno) {
		log.info("remove......" + rno);
		return mapper.delete(rno);
	}

	// 수정
	@Override
	public int modify(ReplyVO vo) {
		log.info("modify......" + vo);
		return mapper.update(vo);
	}

	// 특정 한 개시물의 댓글 가져오기
//	@Override
//	public List<ReplyVO> getList(Criteria cri, Long bno) {
//		log.info("get Reply List of a Board " + bno);
//		
//		return mapper.getListWithPaging(cri, bno);
//	}

	// 특정 게시글을 전체 댓글 수
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}
	
}
