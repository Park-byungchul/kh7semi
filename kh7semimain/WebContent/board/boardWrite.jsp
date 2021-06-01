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
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

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
		else if(boardTypeNo === 4) {
			location.href = "reviewList.jsp";
		}
	}
</script>
    
<h1>글쓰기</h1>

<div class="container-800">
	<form action="boardWrite.kh" method="post">
		<input type="hidden" name="boardTypeNo" value="<%=boardTypeNo%>">
		<table>
			<tbody>
				<%if(boardTypeNo == 1 || boardTypeNo == 2) {%>
					<tr>
						<th class="text-left" style="background-color:lightgray;">도서관</th>
						<td>
							<select name="areaNo">
								<option value="0">전체</option>
								<%for(int i = 0; i < areaList.size(); i++) { %>
									<option value="<%=areaList.get(i).getAreaNo()%>"><%=areaList.get(i).getAreaName()%></option>
								<%} %>
							</select>
						</td>
					</tr>
				<%} %>
			
				<tr>
					<th class="text-left" style="background-color:lightgray;">제목</th>
					<td>
						<input type="text" name="boardTitle" class="form-input" style="width:750px">
					</td>
				</tr>
					
				<tr>
					<th class="text-left" style="background-color:lightgray;">작성자</th>
					<td>
						<p><%=clientDto.getClientName()%></p>
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">내용</th>
					<td>
						<textarea name="boardField" rows="15" class="text-right form-input"></textarea>
					</td>
				</tr>
				
				<%if(boardTypeNo == 2) { %>
					<tr>
						<th class="text-left" style="background-color:lightgray;">공개 여부</th>
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

		<div class="row">
			<button class="link-btn">등록</button>
			<a href="#" onclick="chooseList()" class="link-btn">목록</a>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>