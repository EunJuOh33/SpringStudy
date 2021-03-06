<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//ETE HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>Upload with Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name='uploadFile' multiple>
	</div>
	
	<button id='uploadBtn'>Upload</button>
	
	
	
	<script
		src="https://code.jquery.com/jquery-3.5.1.js"
  		integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  		crossorigin="anonymous"></script>
  		
  	<script>
	  	$(document).ready(function() {
	  		
	  		// Upload버튼 클릭
	  		$("#uploadBtn").on("click", function() {
	  			
	  			var formData = new FormData();
	  			var inputFile = $("input[name='uploadFile']");
	  			var files = inputFile[0].files;
	  			
	  			console.log(files);
	  			
	  			// file 데이터를 formData에 추가
	  			for(var i=0; i < files.length; i++) {
	  				formData.append("uploadFile", files[i]);
	  			}
	  		
	  			// ajax
		  		$.ajax({
		  			url: '/uploadAjaxAction',
		  			processData: false,
		  			contentType: false,
		  			data: formData,
		  			type: 'POST',
		  			success: function(result) {
		  						alert("Uploaded");
		  					}
	  			}); // end ajax
	  			
	  		});	// end uploadBtn 클릭
	  		
	  	});
  	</script>	
</body>
</html>