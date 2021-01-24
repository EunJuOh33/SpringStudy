<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@include file="../includes/header.jsp" %>	<!-- 이 부분에 header 파일을 넣는다는 의미 -->


<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Tables</h1>
    </div>	<!-- /.col-lg-12 -->
</div>	<!-- /.row -->

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
            </div>	<!-- /.panel-body -->
        </div>	<!-- /.panel -->
    </div>	<!-- /.col-lg-12 -->
</div>	<!-- /.row -->


<!-- 댓글 -->
<div class='row'>
	<div class="col-lg-12">
		<div class="panel panel-default">
		<!--<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
			</div>	-->
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> 
				Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			</div>
			
			<div class="paenl-body">
				<ul class="chat">
					<!-- start reply -->
					<!-- replyService.getList 가 제대로 작동하지 않으면 아래와 같이 출력-->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2018-01-01 13:13 </small>
							</div>
							<p>Good job! </p>
						</div>
					</li>
					<!-- end reply -->
				</ul>
			</div>	<!-- /.panel-body -->
			
		</div>	<!-- /.panel-default -->
	</div>	<!-- /.col-lg-12 -->
</div>	<!-- /.row -->


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Reply MODAL</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                	<label>Reply</label>
                	<input class="form-control" name='reply' value='New Reply!!!'>
                </div>
                <div class="form-group">
                	<label>Replyer</label>
                	<input class="form-control" name='replyer' value='replyer'>
                </div>
                <div class="form-group">
                	<label>Reply Date</label>
                	<input class="form-control" name='replyDate' value=''>
                </div>
            </div>
            <div class="modal-footer">
                <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>            
                <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>            
                <button id='modalCloseBtn' type="button" class="btn btn-dafault">Close</button>            
            </div>
        </div>	<!-- /.modal-content -->
    </div>	<!-- /.modal-dialog -->
</div>	<!-- /.modal -->


<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">

$(document).ready(function() {

	/* 1. 댓글 목록 */
	var bnoValue = '<c:out value="${board.bno}" />';	// 컨트롤러를 통해 get페이지로 넘어온 bno 확인!
	var replyUL = $(".chat");	// <ul>
	
	showList(1);
	
	function showList(page) {
		replyService.getList(
							{bno: bnoValue, page : page || 1},	// param(bno, page)
							function(list) {	// callback
								var str = "";
								
								if(list == null || list.length == 0) {
									replyUL.html("");
									
									return;
								}
								
								// <ul class="chat"> 밑을 채워준다.
								var len = list.length || 0;
								for (var i=0; i < len; i++) {
									str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
									str += "	<div><div class='header'><strong class='primary-front'>" + list[i].replyer + "</strong>";
									str += "							<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
									str += "		<p>" + list[i].reply + "</p></div></li>";
								}
			
								replyUL.html(str);
							});	// end function showList, replyService.getList
	}	// end showList
	
	
	/* 2. 새로운 댓글 등록 - 모달 */
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	// 'New Reply' 버튼
	$("#addReplyBtn").on("click", function(e) {
		modal.find("input").val("");				// modal 창 안의 input value들을 모두 ""로 만든다.(지운다)
		modalInputReplyDate.closest("div").hide();	// closest : 엘리멘트에 가장 까가운 조상 (날짜 칸을 삭제한다.)
		
		modal.find("button[id != 'modalCloseBtn']").hide();	// 모달 창에서 Close 버튼을 제외한 버튼을 모두 숨긴다.
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
	});
	
	// 모달창 안 '등록' 버튼
	modalRegisterBtn.on("click", function(e) {
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
		};
		
		replyService.add(
				reply, 
				function(result) {
					alert(result);	// 성공 : success
					
					modal.find("input").val("");	// 등록했던 내용으로 다시 등록할 수 없도록 입력 창을 비운다.
					modal.modal("hide");
					
					showList(1);	// 등록 후 댓글 목록 갱신
				});
	});
	
	
	/* 3. 특정 댓글 수정/삭제 */
	
	// 특정 댓글 클릭 이벤트 처리
	$(".chat").on("click", "li", function(e) {	// 클릭 이벤트는 <ul class="chat">에 걸었지만, this 는 각 댓글인 li태그 
		var rno = $(this).data("rno");
		
		// console.log(rno);
		
		replyService.get(
				rno, 
				function(reply) {
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime( reply.replyDate )).attr("readonly", "readonly");
					modal.data("rno", reply.rno);
					
					modal.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					$(".modal").modal("show");
				});
	});
	
	// 수정 버튼
	modalModBtn.on("click", function(e) {
		var reply = {
				rno : modal.data("rno"), 
				reply : modalInputReply.val()
		};
		
		replyService.update(reply, function(result) {
			
			alert(result);	// 성공 : success
			modal.modal("hide");
			showList(1);
		
		});
	});
	
	// 삭제 버튼
	modalRemoveBtn.on("click", function(e) {
		
		var rno = modal.data("rno");
		
		replyService.remove(rno, function(result) {
			
			alert(result);
			modal.modal("hide");
			showList(1);
		
		});
	});
	
});
</script>


<%@include file="../includes/footer.jsp" %>