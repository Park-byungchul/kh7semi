<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.BoardDto"%>
<%@page import="library.beans.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	BoardDao boardDao = new BoardDao(); 
	BoardDto boardDto = boardDao.get(boardNo);
	
	AreaDao areaDao = new AreaDao();
	List<AreaDto> areaList = areaDao.list();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function() {
		$("select[name=areaNo]").val("<%=boardDto.getAreaNo()%>");
	});
	
	$(function() {
		$("#delete").click(function() {
			var choice = window.confirm("정말 삭제하시겠습니까?");
			
			if (choice) {
				return true;
			} 
			else {
				return false;
			}
		});
	});
</script>

<div class="container-900">
	<div class="row">
		<h2>게시글 수정</h2>
	</div>

	<form action="boardEdit.kh" method="post">
		<input type="hidden" name="boardNo" value="<%=boardDto.getBoardNo()%>">
		<input type="hidden" name="boardTypeNo" value="<%=boardDto.getBoardTypeNo()%>">
	
		<%if(boardDto.getBoardTypeNo() == 1 || boardDto.getBoardTypeNo() == 2) { %>
			<div class="row text-left">
				<label>도서관</label>
				<select name="areaNo">
					<option value="0">전체</option>
					<%for(int i = 0; i < areaList.size(); i++) { %>
						<option value="<%=areaList.get(i).getAreaNo()%>"><%=areaList.get(i).getAreaName()%></option>
					<%} %>
				</select>
			</div>
		<%} else { %>
			<input type="hidden" name="areaNo" value="0">
		<%} %>
		
		<div class="row text-left">
			<label>제목</label>
			<input type="text" name="boardTitle" value="<%=boardDto.getBoardTitle()%>" class="form-input">
		</div>
		
		<div class="row text-left">
			<label>내용</label>
			<textarea name="boardField" class="form-input" rows="15"><%=boardDto.getBoardField()%></textarea>
		</div>
	
		<div class="row">
			<input type="submit" value="수정" class="link-btn">
			<a id="delete" href="boardDelete.kh?boardTypeNo=<%=boardDto.getBoardTypeNo()%>&boardNo=<%=boardNo%>" class="link-btn">삭제</a>
			<%if(boardDto.getBoardTypeNo() == 2) { %>
				<a href="qnaDetail.jsp?boardNo=<%=boardNo%>" class="link-btn">취소</a>
			<%} else { %>
				<a href="boardDetail.jsp?boardNo=<%=boardNo%>" class="link-btn">취소</a>
			<%} %>
		</div>
	
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>