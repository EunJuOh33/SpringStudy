package org.zerock.maper;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = { org.zerock.config.RootConfig.class })
@Log4j
public class ReplyMapperTests {
	
	private Long[] bnoArr = { 42L, 28L, 22L, 21L, 14L };	// 테스트 전, 해당 번호의 게시물이 존재하는 지 반드시 확인
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	
	
	/* insert 테스트 */
	// bnoArr 배열 안에 있는 게시글 번호에 각각 댓글을 두 개씩 단다. (forEach로 10번 반복) 
	@Test
	public void testCreate() {
		
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			
			// 게시물의 번호
			vo.setBno(bnoArr[i % 5]);		// 0->0, 1->1, 2->2, 3->3, 4->4 ...(bnoArr 인덱스 4까지 밖에 없어서)
			vo.setReply("댓글 테스트" + i);	// 댓글
			vo.setReplyer("replyer" + i);	// 댓쓰니
			
			mapper.insert(vo);
		});
	}
	
	
	/* 조회(read) 테스트 */
	@Test
	public void testRead() {
		
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);	// 5번 댓글 조회
		
		log.info(vo);
	}
	
	/* 삭제(delete) 테스트 */
	@Test
	public void testDelete() {
		Long targetRno = 1L;
		
		mapper.delete(targetRno);
		
		log.info(targetRno + " 번 댓글이 삭제되었습니다.");
	}
	
	/* 수정(update) 테스트 */
	@Test
	public void testUpdate() {
		Long targetRno = 10L;
		
		ReplyVO vo = mapper.read(targetRno);	// 10번 댓글을 조회하여 vo에 저장
		
		vo.setReply("Update Reply");	// "Update Reply"로 댓글 내용 수정
		
		int count = mapper.update(vo);	// sql에서 수정된 게시글 갯수가 반환된다.
		
		log.info("UPDATE COUNT: " + count);
	}
	
	
	@Test
	public void testMapper() {
		
		log.info(mapper);
	}

}
