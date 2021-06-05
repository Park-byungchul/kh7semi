<%@page import="library.beans.board.BoardTypeDao"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int boardTypeNo = Integer.parseInt(request.getParameter("boardTypeNo"));

	Integer clientNo = (Integer)session.getAttribute("clientNo");

	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
	
	AreaDao areaDao = new AreaDao();
	List<AreaDto> areaList = areaDao.list();
	
	String root = request.getContextPath();
	
	BoardTypeDao boardTypeDao = new BoardTypeDao();
	String boardName = boardTypeDao.getBoardName(boardTypeNo);
%>
    
<jsp:include page="/board/boardMenuSidebar.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	function chooseList() {
		var boardTypeNo = <%=boardTypeNo%>

		if(boardTypeNo === 1) {
			location.href = "noticeList.jsp";
		}
		else if(boardTypeNo === 2) {
			location.href = "qnaList.jsp";
		}
		else if(boardTypeNo === 3) {
			location.href = "freeBoardList.jsp";
		}
	}
	
	// 높이 자동 설정
	function resize(obj) {
  		obj.style.height = "1px";
  		obj.style.height = (12+obj.scrollHeight)+"px";
	}
</script>

<style>
	th {
		width:15%;
	}
</style>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title"><%=boardName%></span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > <%=boardName %></span>
		</div>
	</div>
	
	<form action="boardWrite.kh" method="post">
		<input type="hidden" name="boardTypeNo" value="<%=boardTypeNo%>">
		<table class="table table-border table-hover">
			<tbody>
				<%if(boardTypeNo == 1 || boardTypeNo == 2) {%>
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
				<%} %>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" maxlength="300" name="boardTitle" class="form-input" style="width:750px">
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<p><%=clientDto.getClientName()%></p>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea maxlength="4000" class="board-write-area" onkeydown="resize(this)" onkeyup="resize(this)" name="boardField" rows="15"></textarea>
					</td>
				</tr>
				<%if(boardTypeNo == 2) { %>
					<tr>
						<th>공개 여부</th>
						<td>
							<div>
							    <input type="radio" name="boardOpen" value="공개">
							    <label for="공개">공개</label>
							    
							    <input type="radio" name="boardOpen" value="비공개" checked>
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
			<button class="board-btn">등록</button>
			<a href="#" onclick="chooseList()" class="link-btn">목록</a>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>