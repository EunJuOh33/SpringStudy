<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@include file="../includes/header.jsp" %>	<!-- 이 부분에 header 파일을 넣는다는 의미 -->
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Tables</h1>
    </div>
</div>	<!-- /.row -->


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                DataTables Advanced Tables
                <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>BNO</th>
                            <th>Title</th>
                            <th>Writer</th>
                            <th>RegDate</th>
                            <th>UpdateDate</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list}" var="board">
                        <tr class="odd gradeX">
                            <td>${board.bno }</td>
                            <td>
                            	<a class='move' href='<c:out value="${board.bno}"/>'>
                            		<c:out value="${board.title }"/>
                            		<b>[ <c:out value="${board.replyCnt }"/> ]</b>
                            	</a>
                            </td>
                            <td>${board.title }</td>
                            <td>${board.writer }</td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- 검색 -->
           		<form id="searchForm" action="/board/list" method='get'>
           			<select name='type'>
           				<option value=""
           					<c:out value="${pageMaker.cri.type == null ? 'selected':'' }" />>--</option>
       					<option value="T"
       						<c:out value="${pageMaker.cri.type eq 'T' ? 'selected':'' }" />>제목</option>
       					<option value="C"
       						<c:out value="${pageMaker.cri.type eq 'C' ? 'selected':'' }" />>내용</option>
       					<option value="W"
       						<c:out value="${pageMaker.cri.type eq 'W' ? 'selected':'' }" />>작성자</option>
       					<option value="TC"
       						<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected':'' }" />>제목+내용</option>
       					<option value="TW"
       						<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected':'' }" />>제목+작성자</option>
       					<option value="TCW"
       						<c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected':'' }" />>제목+내용+작성자</option>
           			</select>
           			<input type="text" name='keyword' 
           					value='<c:out value="${pageMaker.cri.keyword }" />' />
           			<input type="hidden" name='pageNum' 
           					value='<c:out value="${pageMaker.cri.pageNum}"/>' />
           			<input type="hidden" name='amount' 
           					value='<c:out value="${pageMaker.cri.amount}"/>' />
           			<button class="btn btn-default">Search</button>
           		</form>
                
                <!-- 페이징 -->
                <!-- <h3>${pageMaker}</h3> 잘 나오는지 확인 먼저! -->
                <div class='pull-right'>
                	<ul class="pagination">
                		<c:if test="${pageMaker.prev}">
               			<li class="pagenate_button previous">
               				<a href="${pageMaker.startPage -1}">Previous</a>
               			</li>
                		</c:if>
                		
                		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">	
               			<!-- for(int num = startPage; num < endPage; num++) { System.out.print(num); } 과 같다. -->
               			<!-- pageNum = 현재 페이지 번호 -->
               			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""} ">
               				<a href="${num}">${num}</a>
               			</li>
                		</c:forEach>
                		
                		<c:if test="${pageMaker.next}">
               			<li class="pagenate_button next">
               				<a href="${pageMaker.endPage +1 }">Next</a>
               			</li>
                		</c:if>
                	</ul>	
                </div>
                
                <form id='actionForm' action="/board/list" method='get'>
                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                	<input type="hidden" name="amout" value="${pageMaker.cri.amount}">
                	<input type="hidden" name="type" value="${pageMaker.cri.type}">
                	<input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword }" />' />
                </form>
                
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- 모달 -->
<div id="myModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);
		
		history.replaceState({}, null, null);	// 주소창에서 보관하고 있는 데이터를 전부 지운다.
		
		/* 모달 체크 */
		function checkModal(result) {
			if(result === '' || history.state) {
				return;
			}
			
			if(result === 'success') {	// 글을 삭제하면 result에 success라는 값이 담겨 넘어온다.
				$(".modal-body").html("정상적으로 처리되었습니다.");
			
			} else if(parseInt(result) > 0) {
				$(".modal-body").html(
						"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			} 
			$("#myModal").modal("show");
		}
		
		/* 버튼 - 클릭시 /board/register 페이지로 이동 */
		$("#regBtn").click(function() {
			self.location = "/board/register";
		})
		
		
		/* 페이징 */
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e) {	// paginate_button과 a태그를 클릭하면 실행
			e.preventDefault();
			
			// var targetPage = $(this).attr("href"); 
			// console.log(targetPage);
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));	// input의 value값을 a태그의 href 값으로 바꾼다.
			actionForm.submit();
		});
		
		
		/* 게시글 조회 페이지에 amont, pageNum 파라미터 전달하기 (게시물 제목 클릭시) */
		$(".move").on("click", function(e) {
			e.preventDefault();
			
			var targetBno = $(this).attr("href");
			
			// console.log(targetBno);
			
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/get").submit();
		});
		
		
		/* 검색 버튼 클릭시 이벤트 처리 */
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e) {	// searchForm의 버튼 클릭시
			
			if(!searchForm.find("option:selected").val()) {	// 아무것도 선택하지 않았다면
				alert("검색종류를 선택하세요");
				return false;
			}
		
			if(!searchForm.find("input[name='keyword'").val()) {	// 아무것도 입력하지 않았다면
				alert("키워드를 입력하세요.");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");	// find : serchForm 하위에서 찾는다. 몇 페이지에서 검색하든 1페이지로 돌아오도록
			e.preventDefault();	// form태그의 전송을 막는다.
			// console.log(".......click")	// preventDefault 확인
			
			searchForm.submit();
		});
	});
</script>

<%@include file="../includes/footer.jsp" %>