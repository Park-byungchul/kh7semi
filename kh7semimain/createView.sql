----view 생성권한
grant create view to kh7semi2;

--추천도서 view
create or replace view recommendCount as select book_isbn, count(recommend_no) as recommendCount from recommend group by book_isbn;



-- 관리자 권한 view
create or replace view roleArea as
select C.client_no, C.client_name, A.area_no, A.area_name, R.role_date
from role R, client C, area A
where R.area_no = A.area_no and R.client_no = C.client_no;

-- 도서 목록 출력을 위한 view

drop view board_list;

create view board_list as

select B.board_no, B.area_no as board_area, B.board_type_no, B.board_title, 
        B.board_date, B.board_read, B.board_like, B.client_no as board_writer,
        b.board_sep_no, b.board_reply, b.board_open,
        C.client_no, C.client_name,
        A.area_no, A.area_name,
        BT.board_type_no as type_no, BT.board_type_name
from board B
left outer join client C on B.client_no = C.client_no
left outer join area A on B.area_no = A.area_no
left outer join board_type BT on B.board_type_no = bt.board_type_no;


--get_book / lend_book view
create or replace view get_book_view as
    select g.get_book_no, g.get_book_date,
    a.area_name, 
    b.book_isbn, b.book_author, b.book_title, b.book_publisher, 
    b.book_date, b.book_content, b.book_img
        from get_book g
            inner join book b on g.book_isbn = b.book_isbn
            inner join area a on g.area_no = a.area_no;
    
create or replace view lend_book_view as
    select l.*, b.book_title from lend_book l 
        inner join book b on l.book_isbn = b.book_isbn
            where return_book_date is null;

create or replace view get_book_search_view as
    select g.*, 
        l.lend_book_date, 
        r.reservation_date
            from get_book_view g
                left outer join lend_book_view l on g.get_book_no = l.get_book_no 
                left outer join reservation r on g.get_book_no = r.get_book_no;
                
                
--게시판 질문-답변 조인한 view

create view board_qna as
select B.board_no, B.client_no, B.area_no as board_area_no,
        B.board_title, B.board_field, B.board_read, B.board_date, B.board_open,
        BA.board_no as answer_no, BA.board_status, BA.answer_content,
        A.area_no, A.area_name
from board B
left outer join board_answer BA on B.board_no = BA.board_no
left outer join area A on A.area_no = B.area_no
where B.board_type_no = 2;
                
--리뷰 목록 출력을 위한 view
create view review_list as
select R.review_no, R.client_no as reviewer, R.book_isbn, R.review_subject,
        R.review_content, R.review_read, R.review_like, R.review_date, R.review_reply,
        C.client_no, C.client_name
from review R
left outer join client C on R.client_no = C.client_no;

-- 추천도서 목록 출력 view
create or replace view recommendBook as
select RC.recommendCount, B.*
from recommendCount RC 
left outer join book B on RC.book_isbn = B.book_isbn;

-- 신착도서 출력 view
create or replace view newBook as
select a.area_name,
gb.book_isbn,
gb.get_book_date,
b.book_author,
b.book_date,
b.book_img,
b.book_publisher,
b.book_title,
g.genre_name
from get_book GB 
left outer join book B on GB.book_isbn = B.book_isbn
left outer join area A on gb.area_no = a.area_no
left outer join genre G on g.genre_no = b.genre_no;