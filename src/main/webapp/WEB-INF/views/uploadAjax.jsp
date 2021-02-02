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
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  		
  	<script>
	  	$(document).ready(function() {
	  		
	  		$("#uploadBtn").on("click", function() {
	  			
	  			var formData = new FormData();
	  			var inputFile = $("input[name='uploadFile']");
	  			var files = inputFile[0].files;
	  			
	  			console.log(files);
	  			
	  		});
	  	});
  	</script>	
</body>
</html>