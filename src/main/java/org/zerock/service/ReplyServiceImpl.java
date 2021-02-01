package org.zerock.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	
	// 등록
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		log.info("register......" + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	// 조회
	@Override
	public ReplyVO get(Long rno) {
		log.info("get......");
		return mapper.read(rno);
	}

	// 삭제
	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove......" + rno);
		
		ReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	// 수정
	@Override
	public int modify(ReplyVO vo) {
		log.info("modify......" + vo);
		return mapper.update(vo);
	}

	// 특정 한 게시물의 댓글 가져오기
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
