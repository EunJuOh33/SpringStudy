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
				
				<script type="text/javascript" src="/resources/js/reply.js"></script>
				
				<script type="text/javascript">
					
					$(document).ready(function() {
					
						var bnoValue = '<c:out value="${board.bno}" />';	// 컨트롤러를 통해 get페이지로 넘어온 bno
						var replyUL = $(".chat");
						
						showList(1);
						
						function showList(page) {
							replyService.getList({bno.bnoValue, page : page || 1} function(list) {
								var str = "";
								
								if(list == null || list.length == 0) {
									replyUL.html("");
									
									return;
								}
								
								for (var i=0; len = list.length || 0; i < len; i++) {
									str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
									str += "	<div><div class='header'><strong class='primary-front'>" + list[i].replyer + "</strong>";
									str += "							<small class='pull-right text-muted'>" + list[i].replyDate + "</small></div>";
									str += "		<p>" + list[i].reply + "</p></div></li>";	
								}
								
								replyUL.html(str);
							
							});	// end function
						}	// end showList
						
					});
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
            </div>	<!-- /.panel-body -->
        </div>	<!-- /.panel -->
    </div>	<!-- /.col-lg-12 -->
</div>	<!-- /.row -->


<!-- 댓글 -->
<div class='row'>
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
			</div>
			
			<div class="paenl-body">
				<ul class="chat">
					<!-- start reply -->
					<li class="left clearfix" data-rno-'12'>
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



<%@include file="../includes/footer.jsp" %>