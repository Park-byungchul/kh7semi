<%@page import="library.beans.board.BoardTypeDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.board.BoardDto"%>
<%@page import="library.beans.board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	BoardDao boardDao = new BoardDao(); 
	BoardDto boardDto = boardDao.get(boardNo);
	
	AreaDao areaDao = new AreaDao();
	List<AreaDto> areaList = areaDao.list();
	
	String root = request.getContextPath();
	
	BoardTypeDao boardTypeDao = new BoardTypeDao();
	String boardName = boardTypeDao.getBoardName(boardDto.getBoardTypeNo());
%>

<jsp:include page="/board/boardMenuSidebar.jsp"></jsp:include>

<style>
	th {
		width:15%;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function() {
		$("select[name=areaNo]").val("<%=boardDto.getAreaNo()%>");
	});
	
	$(function() {
		var boardOpen = "<%=boardDto.getBoardOpen()%>";
		
		console.log(boardOpen);
		
		if(boardOpen === "공개") {
			$('input[name="boardOpen"]').val(['공개']);
		}
		else {
			$('input[name="boardOpen"]').val(['비공개']);
		}
	});

	// 높이 자동 설정
	function resize(obj) {
  		obj.style.height = "1px";
  		obj.style.height = (12+obj.scrollHeight)+"px";
	}
</script>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title"><%=boardName%></span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > <%=boardName %></span>
		</div>
	</div>

	<form action="boardEdit.kh" method="post">
		<input type="hidden" name="boardNo" value="<%=boardDto.getBoardNo()%>">
		<input type="hidden" name="boardTypeNo" value="<%=boardDto.getBoardTypeNo()%>">
	
		<table class="table table-border table-hover board-table">
			<tbody>
				<%if(boardDto.getBoardTypeNo() == 1 || boardDto.getBoardTypeNo() == 2) { %>
					<tr>
						<th>도서관</th>
						<td>
							<select name="areaNo">
								<%for(int i = 0; i < areaList.size(); i++) { %>
									<option value="<%=areaList.get(i).getAreaNo()%>"><%=areaList.get(i).getAreaName()%></option>
								<%} %>
							</select>
						</td>
					</tr>
				<%} else { %>
					<input type="hidden" name="areaNo" value="0">
				<%} %>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" maxlength="300" name="boardTitle" value="<%=boardDto.getBoardTitle()%>" class="form-input">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea maxlength="4000" class="board-write-area" onkeydown="resize(this)" onkeyup="resize(this)" name="boardField" rows="15"><%=boardDto.getBoardField()%></textarea>
					</td>
				</tr>
				<%if(boardDto.getBoardTypeNo() == 2) { %>
					<tr>
						<th>공개 여부</th>
						<td>
							<div>
							    <input type="radio" name="boardOpen" value="공개">
							    <label for="공개">공개</label>
							    
							    <input type="radio" name="boardOpen" value="비공개">
							    <label for="비공개">비공개</label>
						  	</div>
						</td>
					</tr>
				<%} else { %>
					<input type="hidden" name="boardOpen" value="공개">
				<%} %>
			</tbody>
		</table>

		<div class="row text-right">
			<input type="submit" value="수정" class="board-btn">
			<%if(boardDto.getBoardTypeNo() == 2) { %>
				<a href="qnaDetail.jsp?boardNo=<%=boardNo%>" class="link-btn">취소</a>
			<%} else { %>
				<a href="boardDetail.jsp?boardNo=<%=boardNo%>" class="link-btn">취소</a>
			<%} %>
		</div>
	
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>