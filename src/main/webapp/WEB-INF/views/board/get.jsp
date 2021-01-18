<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@include file="../includes/header.jsp" %>	<!-- 이 부분에 header 파일을 넣는다는 의미 -->
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Tables</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Read</div>
            <!-- /.panel-heading -->
            <div class="panel-body">
            
            	<div class="form-group">
                    <label>BNO</label>
                    <input class="form-control" name="title" readonly="readonly" value='<c:out value="${board.bno}"/>'>
				</div>
               
               	<div class="form-group">
                    <label>Title</label>
                    <input class="form-control" name="title" readonly="readonly" value='<c:out value="${board.title}"/>'>
				</div>
				
				<div class="form-group">
                    <label>Content</label>
                    <textarea rows="5" cols="50" name="content" class="form-control"><c:out value="${board.content}"/></textarea>
				</div>
				
				<div class="form-group">
                    <label>Writer</label>
                    <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>'>
				</div>
				
				 <form id='actionForm' action="/board/list" method='get'>
                	<input type="hidden" name="bno" value="${board.bno}">
                	<input type="hidden" name="pageNum" value="${cri.pageNum }">
                	<input type="hidden" name="amout" value="${cri.amount}">
                	<input type="hidden" name="type" value="${cri.type}">	<!-- BoardController에서 Modal에 Criteria를 담아 보냈다. 여기는 pageMaker를 보내지 않음 -->
                	<input type="hidden" name='keyword' value='<c:out value="${cri.keyword }" />' />
                </form>
				
				<button type="button" class="btn btn-default listBtn"><a href="/board/list">List</a></button>
                <button type="button" class="btn btn-default modBtn"><a href="/board/modify?bno=<c:out value="${board.bno}"/>">Modify</a></button>
				
				<script type="text/javascript" src="/resources/js/reply.js"></script>
				
				<script type="text/javascript">
					console.log("==================");
					console.log("JS TEST");
					
					var bnoValue = '<c:out value="${board.bno}" />';	// 컨트롤러를 통해 get페이지로 넘어온 bno
					
					// for replyService add test
					replyService.add(
						{reply:"JS Test", replyer:"tester", bno:bnoValue},	// add의 파라미터인 reply를 객체 타입으로 만들어 전송
						function(result) {	// Ajax 전송 결과를 처리하는 함수
							alert("RESULT: " + result);	// 성공하면 success 출력
						}
					);
					
					// for replyService getList test
					replyService.getList(
							{bno:bnoValue, page:1}, 
							function(list) {
								for(var i=0; len = list.length||0; i < len; i++) {
									console.log(list[i]);
								}
							}
					);
					
					// for replyService remove test
					replyService.remove(
							23, 
							function(count) {	// 23번 댓글 삭제
								console.log(count);
					
								if (count === "success") {
									alert("REMOVE");
								}
							},
							function(err) {
								alert('ERROR...');
							}
					);
				</script>
				
				<script>	
					// 위의 버튼 눌렀을 때 실행
					var actionForm = $("#actionForm");
				
					// 'list' 버튼
					$(".listBtn").click(function(e) {
						e.preventDefault();
						actionForm.find("input[name='bno']").remove();	// 게시글을 클릭했다가 다시 리스트로 이동할 때, URL에 bno 값이 붙지 않도록 하기 위함
						actionForm.submit();
					});
					
					// 'modify' 버튼
					$(".modBtn").click(function(e) {
						e.preventDefault();
						actionForm.attr("action", "/board/modify");
						actionForm.submit();
					});
				</script>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<%@include file="../includes/footer.jsp" %>