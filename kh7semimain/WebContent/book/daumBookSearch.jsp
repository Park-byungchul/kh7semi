<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
 	String keyword = request.getParameter("keyword");
 	String type = request.getParameter("type");
 
	String root = request.getContextPath();
	
	BookDao bookDao = new BookDao();

	boolean isSearch = type != null && keyword != null && !keyword.trim().equals("");
	
 %>
 <html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<title>도서 검색</title>
</head>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
 
    <script>

 
$(document).ready(function () {
        	var pageNum = 1;
 			$(".next-btn").hide();
 			$(".bookSearchType").val("<%=type%>").attr("selected", "selected");
 			
 			// 팝업창 열릴 시 api가져오기
 			$.ajax({
 				
                     method: "GET",
                     url: "https://dapi.kakao.com/v3/search/book",
                     data: { query: $(".bookSearchKeyword").val(), 
                    	 		page: pageNum, 
                    	 		target: $(".bookSearchType option:selected").val()
      						  },
                     headers: {Authorization: "KakaoAK 0c7c4690db5e43829555bc3a5cc334a4"} 
  
            })
            .done(function (msg) {
                     console.log(msg);
                     $(".next-btn").show();
                 	 $("div").show();
                     for (var i=0; i<msg.documents.length; i++){
                    	 $("div").append("<h2>"+msg.documents[i].title+"</h2>");
                         $("div").append("<strong>isbn :</strong><span>"+msg.documents[i].isbn+"</span><br>");
                         $("div").append("<strong>저자 :</strong><span> "+msg.documents[i].authors+"</span><br>");
                         $("div").append("<strong>출판사 :</strong><span> "+msg.documents[i].publisher+"</span><br>");
                         $("div").append("<strong>요약 :</strong><span> "+msg.documents[i].contents+"...</span><br>");
                         $("div").append("<strong>발행일 :</strong><span> "+msg.documents[i].datetime+"</span><br>");
                         $("div").append("<img src='" + msg.documents[i].thumbnail + "'/><input type='hidden' value='"+msg.documents[i].thumbnail+"'><br>");
                         $("div").append("<button class='choice'>선택하기</button><hr>"); 	
                         
                         $(".choice").click(function(){
                             var index = $(".choice").index(this);
                             console.log(index);
                              
                      		var choice = $(this);
                      		
                      		var point = choice.parent().children();
                      		
                      		var title = point.eq(index*20+index).text();	
                      		var isbn = point.eq(index*20+index+2).text();
                      		var author = point.eq(index*20+index+5).text();
                      		var publisher = point.eq(index*20+index+8).text();
                      		var content = point.eq(index*20+index+11).text();
                      		var date = point.eq(index*20+index+14).text();
                      		var img = point.eq(index*20+index+17).val();
                  
                      		
                      	    opener.document.getElementById("bookTitle").value = title;
                      	    opener.document.getElementById("bookIsbn").value = isbn;
                      	    opener.document.getElementById("bookAuthor").value = author;
                      	    opener.document.getElementById("bookPublisher").value = publisher;
                      	    opener.document.getElementById("bookDate").value = date;
                      	    opener.document.getElementById("bookContent").value = content;
                      	    opener.document.getElementById("bookImg").value = img;
                      	  	opener.document.getElementById("thumnail").src = img;
                      	window.close();
                      	});
                 	}
            });
 			
 			
 			
 			//팝업창에서 검색 시 불러오기
        	$(".bookSearch-btn").click(function () {
                 $("div").html("");
  
                 $.ajax({
                     method: "GET",
                     url: "https://dapi.kakao.com/v3/search/book",
                     data: { 
                    	 query: $(".bookSearchKeyword").val(), 
                    	 page: pageNum,
                    	 target: $(".bookSearchType option:selected").val()	 
                     },
                     headers: {Authorization: "KakaoAK 0c7c4690db5e43829555bc3a5cc334a4"} 
  
                 })
                .done(function (msg) {
                    console.log(msg);
                    $(".next-btn").show();
                    for (var i=0; i<msg.documents.length; i++){
                    	$("div").append("<h2>"+msg.documents[i].title+"</h2>");
                        $("div").append("<strong>isbn :</strong><span>"+msg.documents[i].isbn+"</span><br>");
                        $("div").append("<strong>저자 :</strong><span> "+msg.documents[i].authors+"</span><br>");
                        $("div").append("<strong>출판사 :</strong><span> "+msg.documents[i].publisher+"</span><br>");
                        $("div").append("<strong>요약 :</strong><span> "+msg.documents[i].contents+"...</span><br>");
                        $("div").append("<strong>발행일 :</strong><span> "+msg.documents[i].datetime+"</span><br>");
                        $("div").append("<img src='" + msg.documents[i].thumbnail + "'/><input type='hidden' value='"+msg.documents[i].thumbnail+"'><br>");
                        $("div").append("<button class='choice'>선택하기</button><hr>");
                        
                        $(".choice").click(function(){
                            var index = $(".choice").index(this);
                            console.log(index);
                             
                     		var choice = $(this);
                     		
                     		var point = choice.parent().children();
                     		
                     		var title = point.eq(index*20+index).text();	
                     		var isbn = point.eq(index*20+index+2).text();
                     		var author = point.eq(index*20+index+5).text();
                     		var publisher = point.eq(index*20+index+8).text();
                     		var content = point.eq(index*20+index+11).text();
                     		var date = point.eq(index*20+index+14).text();
                     		var img = point.eq(index*20+index+17).val();
                 
                     		
                     	    opener.document.getElementById("bookTitle").value = title;
                     	    opener.document.getElementById("bookIsbn").value = isbn;
                     	    opener.document.getElementById("bookAuthor").value = author;
                     	    opener.document.getElementById("bookPublisher").value = publisher;
                     	    opener.document.getElementById("bookDate").value = date;
                     	    opener.document.getElementById("bookContent").value = content;
                     	    opener.document.getElementById("bookImg").value = img;
                     	    opener.document.getElementById("thumnail").src = img;
                   		 	window.close();
                     	});
                    }               
                });
            })
            
            //10개 더 보기 클릭시 10개 더 불러오기
            $(".next-btn").click(function(){
            	pageNum++;
            	
            	$.ajax({
                    method: "GET",
                    url: "https://dapi.kakao.com/v3/search/book",
                    data: { 
                    	query: $(".bookSearchKeyword").val(), 
                    	page:pageNum,
                    	target: $(".bookSearchType option:selected").val()	
                    },
                    headers: {Authorization: "KakaoAK 0c7c4690db5e43829555bc3a5cc334a4"} 
 
                })
                .done(function (msg) {
                    console.log(msg);
                    for (var i=0; i<msg.documents.length; i++){
                    	$("div").append("<h2>"+msg.documents[i].title+"</h2>");
                        $("div").append("<strong>isbn :</strong><span>"+msg.documents[i].isbn+"</span><br>");
                        $("div").append("<strong>저자 :</strong><span> "+msg.documents[i].authors+"</span><br>");
                        $("div").append("<strong>출판사 :</strong><span> "+msg.documents[i].publisher+"</span><br>");
                        $("div").append("<strong>요약 :</strong><span> "+msg.documents[i].contents+"...</span><br>");
                        $("div").append("<strong>발행일 :</strong><span> "+msg.documents[i].datetime+"</span><br>");
                        $("div").append("<img src='" + msg.documents[i].thumbnail + "'/><input type='hidden' value='"+msg.documents[i].thumbnail+"'><br>");
                        $("div").append("<button class='choice'>선택하기</button><hr>");
                        
                        $(".choice").click(function(){
                            var index = $(".choice").index(this);
                            console.log(index);
                             
                     		var choice = $(this);
                     		
                     		var point = choice.parent().children();
                     		
                     		var title = point.eq(index*20+index).text();	
                     		var isbn = point.eq(index*20+index+2).text();
                     		var author = point.eq(index*20+index+5).text();
                     		var publisher = point.eq(index*20+index+8).text();
                     		var content = point.eq(index*20+index+11).text();
                     		var date = point.eq(index*20+index+14).text();
                     		var img = point.eq(index*20+index+17).val();
                 
                     		
                     	    opener.document.getElementById("bookTitle").value = title;
                     	    opener.document.getElementById("bookIsbn").value = isbn;
                     	    opener.document.getElementById("bookAuthor").value = author;
                     	    opener.document.getElementById("bookPublisher").value = publisher;
                     	    opener.document.getElementById("bookDate").value = date;
                     	    opener.document.getElementById("bookContent").value = content;
                     	    opener.document.getElementById("bookImg").value = img;
                     	    opener.document.getElementById("thumnail").src = img;
                       		window.close();
                     	});
                    }          
                });
            });
     
});

</script>
<style>

</style>
<body>

			<select name="type" class="bookSearchType">
				<option value="all">전체</option>
				<option value="title">제목</option>
				<option value="authors">저자</option>
				<option value="publisher">출판사</option>
				<option value="isbn">isbn</option>
			</select>
			<input type="text" name="keyword"  class="bookSearchKeyword" value="<%=keyword%>">
			<input type="submit" value="검색" class="bookSearch-btn">
<hr>	


<div></div>

<button class="next-btn">10권 더 보기</button>
</body>
</html>


 