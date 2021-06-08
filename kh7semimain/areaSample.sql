-- 지점 추가 ( 찾아오는길 페이지 나오게 )

drop sequence area_seq;

create sequence area_seq
minvalue 1
start with 1
increment by 1
nocycle
nocache;

delete from area;

insert into area values(0,'메인도서관','메인도서관','010-1111-1111');
insert into area values(area_seq.nextval,'당산도서관','서울특별시 영등포구 선유동2로 57 이레빌딩 (구관) 19F, 20F','010-1111-1111');
insert into area values(area_seq.nextval,'종로도서관','서울특별시 중구 남대문로 120 대일빌딩 2F, 3F','010-2222-2222');
insert into area values(area_seq.nextval,'강남도서관','서울특별시 강남구 테헤란로 14길 6 남도빌딩 2F, 3F, 4F, 5F, 6F','010-3333-3333');
commit;

select count(*) from get_book where area_no = 3;

select * from get_book_search_view where lend_book_date is null and reservation_date is null;
select * from recommend;

select * from recommend order by recommend_no desc;

select * from recommendCount;

create or replace view recommendBook as
select RC.recommendCount, B.*
from recommendCount RC 
left outer join book B on RC.book_isbn = B.book_isbn;

select * from recommendBook;
select * from recommendBook where (book_title || book_author) like '%어디선가%';


create view review_list as
select R.review_no, R.client_no as reviewer, R.book_isbn, R.review_subject,
        R.review_content, R.review_read, R.review_like, R.review_date, R.review_reply,
        C.client_no, C.client_name
from review R
left outer join client C on R.client_no = C.client_no;

insert into book values('1111111111111', 140, '테스트', '123', '테스트', sysdate, '설명', 'ㅇㅇ');
insert into book values('1111111111112', 150, '테스트1', '123', '테스트', sysdate, '설명', 'ㅇ1ㅇ');
insert into book values('1111111111113', 160, '테스트2', '123', '테스트', sysdate, '설명', 'ㅇ32ㅇ');
insert into book values('1111111111114', 140, '테스트3', '123', '테스트', sysdate, '설명', 'ㅇ4ㅇ');
insert into book values('1111111111115', 160, '1테스트', '123', '테스트', sysdate, '설명', 'ㅇ6ㅇ');
insert into book values('1111111111116', 170, '2테스트', '123', '테스트', sysdate, '설명', 'ㅇ7ㅇ');
insert into book values('1111111111117', 110, '3테스트', '123', '테스트', sysdate, '설명', 'ㅇ1342ㅇ');
insert into book values('1111111111118', 170, '테스트', '123', '테스트', sysdate, '설명', 'ㅇ122ㅇ');
insert into book values('1111111111119', 160, '123', '테스트', '테스트', sysdate, '설명', '61234ㅇㅇ');
insert into book values('1111111111120', 130, '123', '테스트', '테스트', sysdate, '설명', 'ㅇ162ㅇ');
insert into book values('1111111113111', 140, '123', '테스트', '테스트', sysdate, '설명', 'ㅇ332ㅇ');
insert into book values('1111114111111', 150, '123테스트', '테스트123', '테스트', sysdate, '설명', 'ㅇ12525ㅇ');
commit;

select * from get_book;

select * from board_list;

select * from board_list where board_type_no = 1 order by board_no desc;

select * from (select rownum rn, TMP.* from (select * from board_list where board_type_no = 1 order by board_no desc)TMP) where rn between 1 and 10;


select area_no,count(*) from get_book group by area_no;