console.log("reply.js 정상작동......");

var replyService = (function() {
	
	/* 댓글 등록 */
	function add(reply, callback, error) {
		console.log("add reply...............");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),						// 자바스크립트의 값을 JSON 문자열로 변환
			contentType : "application/json; charset=utf-8",	// 데이터 전송 타입
			success : function(result, status, xhr) {	// Ajax 호출이 성공하고,
							if (callback) {				// callback 값으로 적절한 함수가 존재한다면
								callback(result);		// 해당 함수 호출
							}
						},
			error : function(xhr, status, er) {
						if (error) {
							error(er);
						}
					} 
		});
	}
	
	/* 특정 게시물의 댓글 목록 가져오기 */
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON(
			"/replies/pages/" + bno + "/" + page + ".json",		// 첫 번째 매개변수는 JSON 파일 (data -> 주소 치면 나오니 확인하기)
			function(data) {									// 두 번째 매개변수는 콜백함수. JSON 파일을 이용하여 로드된 데이터 처리
				if(callback) {
					// callback(data);	// 댓글 목록만 가져오는 경우
					callback(data.replyCnt, data.list);	// 댓글 숫자와 목록을 가져오는 경우
				}	
			}).fail(function(xhr, status, err) {
				if(error) {
					error();
				}
			}
		);
	}
	
	/* 댓글 삭제 */
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			success : function(deleteResult, status, xhr) {
						if(callback) {	// undefined인지 함수가 들어왔는지 먼저 검사한다. 함수가 들어왔다면,
							callback(deleteResult);	// count에 deleteResult를 할당하여 처리한다. 
						}
					},
			error : function(xhr, status, er) {
						if(error) {
							error(er);
						}
					}
		});
	}
	
	/* 댓글 수정 */
	function update(reply, callback, error) {
		
		console.log("RNO: " + reply.rno);
		
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
						if(callback) {
							callback(result);
						}
					},
			error : function(xhr, status, er) {
						if(error) {
							error(er);
						}
					}
		});
	}
	
	/* 댓글 번호로 단순 댓글 조회 */
	function get(rno, callback, error) {
		$.get(
			"/replies/" + rno + ".json", 
			function(result) {
			
				if(callback) {
					callback(result);
				}
			
			}).fail(function(xhr, status, err) {
					error();
		});
	}
	
	/* 댓글 시간 처리 */
	function displayTime(timeValue) {	// timeValue = replyDate = 자바 Date 객체
		var today = new Date();	// 현재 날짜 및 시간
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		// console.log(timeValue);	// 1610721679000 자바 Date는 객체
		// console.log(dateObj);	// Fri Jan 15 2021 23:41:19 GMT+0900 (대한민국 표준시)
		
		if(gap < (1000 * 60 * 60 * 24)) {	// 해당 일 내의 댓글이라면
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh , ":", (mi > 9 ? '' : '0') + mi , ":", (ss > 9 ? '' : '0') + ss ].join('');
		
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;	// getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	
	
	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};
	
})();
