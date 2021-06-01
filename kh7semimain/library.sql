--회원 테이블
CREATE TABLE Client (
	client_no	number(19)	Primary key,
	client_id	varchar(20)	not NULL unique check(regexp_like(client_id,'^[a-zA-Z0-9]{8,20}$')) ,
	client_pw	varchar2(20)	not NULL check(regexp_like(client_pw,'^[a-zA-Z0-9!@#$]{8,20}$')),
	client_name	varchar2(21)	not NULL check(regexp_like(client_name,'^[가-힣]{2,7}$')),
	client_email	varchar2(50)	not NULL,
	client_made	date	default sysdate  not null,
	client_possible	date	default sysdate  not null,
	client_type	char(15) default '일반사용자' not null check(client_type in ('일반사용자', '일반관리자', '권한관리자', '전체관리자')),
	client_phone char(13) not null check(regexp_like(client_phone,'^010-\d{4}-\d{4}$'))
);

--지점 테이블
CREATE TABLE area (
	area_no	number(10)	primary key,
	area_name	varchar2(30)	NOT NULL,
	area_location	varchar2(300)	NOT NULL,ecl
	area_call	char(13)	not NULL check(regexp_like(area_call,'^010-\d{4}-\d{4}$'))
);

--장르
CREATE TABLE genre (
	genre_no	number(3)	primary key,
	genre_name	varchar2(60)	NOT NULL
);

-- 책 테이블
CREATE TABLE Book (
	book_isbn	number(13)	primary key,
	genre_no	references genre(genre_no) on delete set null,
	book_title	varchar2(300)	NOT NULL,
	book_author	varchar2(300)	NOT NULL
);

--관리자 권한 테이블
CREATE TABLE role (
	client_no	references client(client_no) on delete cascade,
	area_no	references area(area_no) on delete cascade,
	role_date	date	default sysdate  not null,
	primary key(client_no, area_no)
);

-- 게시판 종류 테이블
CREATE TABLE board_type (
	board_type_no	number(19)	primary key,
	board_type_name	varchar2(300)	NOT NULL UNIQUE
);

--게시글 테이블
CREATE TABLE board (
	board_no	number(19)	primary key,
	client_no	references client(client_no) on delete set null,
	board_type_no	references board_type(board_type_no) on delete set null,
	area_no	references area(area_no) on delete set null,
	board_title	varchar2(300)	NOT NULL,
	board_field	varchar2(4000)	NOT NULL,
	board_read	number(19)	default 0 NOT NULL check(board_read >= 0),
	board_like	number(19)	default 0 NOT NULL check(board_like >= 0),
	board_date	date	default sysdate not null,
    board_sep_no number(19) not null,
    board_reply number(19) default 0 not null check(board_reply >= 0),
    board_open varchar(9) default '공개' not null check(board_open in ('공개', '비공개'))
);

--희망도서 신청 테이블
CREATE TABLE hopelist (
	hopelist_no	number(19)	primary key,
	client_no	references client(client_no) on delete cascade,
	book_isbn	references book(book_isbn) on delete cascade,
	hopelist_reason	varchar2(4000)	NOT NULL,
	hopelist_date	date	default sysdate  not null
);
alter table hopelist add hopelist_library varchar2(100) not null; 

--리뷰 테이블
CREATE TABLE review (
	review_no	number(19)	primary key,
	client_no	references client(client_no) on delete set null,
	book_isbn	references book(book_isbn) on delete cascade,
	review_subject	varchar2(300)	not NULL,
	review_content	varchar2(4000)	NOT NULL,
	review_read	number(19)	default 0 not NULL check(review_read >= 0),
	review_like	number(19)	default 0 not NULL check(review_like >= 0),
	review_date	date	default sysdate  not null
);

--사용자추천도서
CREATE TABLE recommend (
	recommend_no	number(19)	NOT NULL,
	client_no	references client(client_no) on delete cascade,
	book_isbn	references book(book_isbn) on delete cascade
);

--도서관에 입고된 책(실물)
CREATE TABLE get_book (
	get_book_no	number(19)	primary key,
	book_isbn	references book(book_isbn) on delete cascade,
	area_no	references area(area_no) on delete cascade,
	get_book_date	date	default sysdate not null,
	get_book_status	varchar2(12)	default '대여가능' not null check (get_book_status in ('대여가능', '예약중', '대출중', '파손'))
);
alter table get_book add get_book_title varchar2(300) not null;
alter table get_book add get_book_author varchar2(300) not null;

-- 대출 테이블
CREATE TABLE lend_book (
	lend_book_no	number(19)	primary key,
	client_no	references client(client_no) on delete set null,
	get_book_no	references get_book(get_book_no) on delete set null,
	book_isbn	references book(book_isbn) on delete set null,
	area_no	references area(area_no) on delete set null,
	lend_book_date		date	default sysdate not NULL,
	lend_book_limit		date	not NULL,
	return_book_date		date	default NULL
);

--일정
CREATE TABLE Plan (
	plan_no 	number(19)	primary key,
	area_no	references area(area_no) on delete cascade,
	plan_start_date	date	NOT NULL,
	plan_end_date	date	NOT NULL,
	plan_content	varchar2(300)	not NULL
);

--관심목록
CREATE TABLE wishlist (
	wishlist_no	number(19)	primary key,
	client_no	references client(client_no) on delete set null,
	book_isbn	references book(book_isbn) on delete cascade
);

--도서예약
CREATE TABLE Reservation (
	reservation_no	number(19)	primary key,
	client_no	references client(client_no)  on delete cascade,
	get_book_no	references get_book(get_book_no)  on delete cascade,
	Reservation_date  date		default sysdate NOT NULL
);

----view 생성권한, 추천도서 count
grant create view to kh7semi2;
create or replace view recommendCount as select book_isbn, count(recommend_no) as recommendCount from recommend group by book_isbn; 

-- 관리자 권한
create or replace view roleArea as
select C.client_no, C.client_name, A.area_no, A.area_name, R.role_date
from role R, client C, area A
where R.area_no = A.area_no and R.client_no = C.client_no;

-------- 여기서부터 다 drop and create 해주세요 -------- 

drop table reviewComment;
drop table boardComment;

-- 책리뷰 댓글
CREATE TABLE review_comment (
	comment_no	number(19)	primary key,
	client_no	references client(client_no) on delete set null,
	review_no	references review(review_no) on delete cascade,
	comment_field	varchar2(900)	NOT NULL,
	comment_date	date	default sysdate NOT NULL,
	comment_like	number(19)	default 0 NOT NULL check(comment_like >= 0)
);

--게시판 댓글
CREATE TABLE board_comment (
	comment_no	number(19)	primary key,
	client_no	references client(client_no)  on delete set null,
	board_no	references board(board_no) on delete cascade,
    board_type_no   references board_type(board_type_no) on delete cascade,
	comment_content	varchar2(900)	NOT NULL,
	comment_date	date	default sysdate NOT NULL,
	comment_like	number(19)	default 0 NOT NULL check(comment_like >= 0)
);

-- 게시판은 고정이므로 developer에서 insert
insert into board_type values(1, '공지사항');
insert into board_type values(2, '질문답변');
insert into board_type values(3, '자유게시판');
insert into board_type values(4, '책리뷰');
commit;

-- board table에 게시판 별 번호 부여하는 번호 추가 (board table에 추가도 해놨음)
alter table board add (board_sep_no number(19) not null);

-- 좋아요 table
create table board_like (
client_no references client(client_no) on delete cascade,
board_no references board(board_no) on delete cascade,
like_time date default sysdate not null,
primary key(client_no, board_no)
);

-- comment에 게시판 번호 추가
alter table board_comment add board_type_no references board_type(board_type_no) on delete cascade;

----- 210601 SQL 업데이트 -----
-- board_list 드랍하고 다시 create 해주세요

alter table board add board_reply number(19) default 0 not null check(board_reply >= 0);

-- 도서 목록 출력을 위한 view
drop view board_list;

create view board_list as
select B.board_no, B.area_no as board_area, B.board_type_no, B.board_title, 
        B.board_date, B.board_read, B.board_like, B.client_no as board_writer,
        B.board_sep_no, B.board_reply, B.board_open,
        C.client_no, C.client_name, 
        A.area_no, A.area_name,
        BT.board_type_no as type_no, BT.board_type_name
from board B
left outer join client C on B.client_no = C.client_no
left outer join area A on B.area_no = A.area_no
left outer join board_type BT on B.board_type_no = bt.board_type_no;

-- 질문 답변 게시판 상태를 위한 테이블
drop table board_answer;

create table board_answer (
board_no references board(board_no) on delete cascade,
board_status varchar2(12) default '접수중' not null check (board_status in ('접수중', '답변완료')),
answer_content varchar2(4000) default '아직 답변이 등록되지 않았습니다.' not null,
answer_date Date default sysdate not null,
primary key(board_no)
);

drop view board_qna;

create view board_qna as
select B.board_no, B.client_no, B.area_no as board_area_no,
        B.board_title, B.board_field, B.board_read, B.board_date, B.board_open,
        BA.board_no as answer_no, BA.board_status, BA.answer_content,
        A.area_no, A.area_name
from board B
left outer join board_answer BA on B.board_no = BA.board_no
left outer join area A on A.area_no = B.area_no
where B.board_type_no = 2;

select * from board_list;

alter table board add board_open varchar(9) default '공개' not null check(board_open in ('공개', '비공개'));