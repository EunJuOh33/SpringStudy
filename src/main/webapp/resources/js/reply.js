console.log("Reply Module......");

var replyService = (function() {
	
	/* 댓글 등록 */
	function add(reply, callback, error) {
		console.log("add reply...............");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
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
			"/replies/pages/" + bno + "/" + page + ".json",		// 첫 번째 매개변수는 JSON 파일
			function(data) {									// 두 번째 매개변수는 콜백함수. JSON 파일을 이용하여 로드된 데이터 처리
				if(callback) {
					callback(data);
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
	
	
	return {
		add : add,
		getList : getList,
		remove : remove
	};
})();
