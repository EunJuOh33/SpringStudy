console.log("Reply Module......");

var replyService = (function() {
	
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
			})
	}	// function add
	
	return {
		add : add
	};
	
})();
