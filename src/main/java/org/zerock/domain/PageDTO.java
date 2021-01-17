package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage, endPage;
	private boolean prev, next;
	
	private int total;		// 전체 데이터 수
	private Criteria cri;	// amount(한 페이지 당 보여주는 데이터 수), pageNum(현재 페이지 번호)
	
	/* 생성자 */
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)( Math.ceil(cri.getPageNum()/10.0) ) * 10;	
		// Math.ceil : 0.8 -> 1 * 10 = 10 (현재 페이지가 8페이지라면 endPage = 10)
		
		this.startPage = endPage - 9;
		// endPage(10) - 9 = 1 (현재 페이지가 8페이지라면 startPage = 1)
		
		int realEnd = (int) (Math.ceil( (total * 1.0)/cri.getAmount() ));
		// Math.ceil(80/10) = Math.ceil(8) = 8 (데이터 개수가 80개일 때, endPage = 10, realEnd = 8)
		
		this.endPage = realEnd <= endPage? realEnd : endPage;
		
		this.prev = this.startPage > 1;
		// 1 > 1 -> false (거짓이므로 prev는 없다.)
		
		this.next = this.endPage < realEnd;
		// 10 < 8 (참이 아니므로 next도 없다.)
	}
}
