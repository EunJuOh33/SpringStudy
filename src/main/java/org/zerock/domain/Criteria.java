package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	/* 페이징 기능을 위한 변수 */
	private int pageNum;	// 현재 페이지 번호
	private int amount;		// 한 페이징 당 몇 개씩 보여줄 것인가
	
	/* 검색기능을 위한 변수 */
	private String type;	// 검색조건 - title, writer, content 'TC', 'C', 'TCW'
	private String keyword;	// 검색 키워드
	
	/* 생성자 */
	public Criteria() {
		this(1, 10);	// 기본값을 1페이지, 10개로 지정
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {	// 검색 기능
		return type == null ? new String[] {}: type.split("");
		// String.split : 괄호 안에 있는 문자를 기준으로 잘라 String 배열에 넣는다.
	}
	
	/* 여러 개의 파라미터들을 연결해서 URL 형태로 만들어주는 기능 */
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}
