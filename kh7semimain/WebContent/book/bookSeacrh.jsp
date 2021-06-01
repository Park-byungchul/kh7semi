<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	//계산
	//= type과 keyword가 둘 다 있으면 검색 , 아니면 목록
	//목록 : type == null || keyword == null
	//검색 : type != null && keyword != null
	
	BookDao bookDao = new BookDao();
	//List<ProductDto> productList = 목록 또는 검색결과;
	List<BookDto> bookList;
	/* if(type == null || keyword == null){//목록
		productList = productDao.list();
	}
	else  */
	if(type == null){
		bookList = bookDao.search(keyword);
	}
	else{
		bookList = bookDao.search(type, keyword);
	}
%>
<jsp:include page="/template/header.jsp"></jsp:include>


<jsp:include page="/template/footer.jsp"></jsp:include>