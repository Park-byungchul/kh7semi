<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	request.setCharacterEncoding("UTF-8");
 	String keyword = request.getParameter("keyword");
 	String type = request.getParameter("type");
 
	String root = request.getContextPath();
 %>
 
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<title>도서 검색</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
function setParentText(){
    opener.document.getElementById("bookAuthor").value = document.getElementById("searched-bookAuthor").value;
    opener.document.getElementById("bookTitle").value = document.getElementById("searched-bookTitle").value;
//     opener.document.getElementById("bookIsbn").value = document.getElementById("searched-bookIsbn").value;
    window.close();
}




	
</script>
<style>

</style>
<body>
	<div class="container-600">
	<input type="text" value=<%=keyword %>>
	<input type="text" value=<%=type%>>
	<hr>
	</div>
<!-- 	booklist 구현 후 for Dto:list 로 불러올 예정 -->
	<input type="text" Id="searched-bookAuthor" value="저자부분">
	<input type="text" Id="searched-bookTitle" value="제목부분">
	<input type="text" Id="searched-bookIsbn" value="책번호부분">
	<button onclick="setParentText();">선택하기</button>
	

</body>
</html>