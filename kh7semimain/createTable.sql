---테이블 제약조건 컬럼 등등 수정되었을때 create문으로만 table 만드는 코드 --
-- 외래키 조건에 맞게 순서대로 적혀있음 -> 전체 선택 후 컨트롤+엔터 --
-- 테이블 초기화가 필요한 경우 아래 코드 실행 -- 
-- SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;
-- 위 문구 실행 후 결과값 드래그로 전체 복사 후 실행 시 외래키조건 상관없이 테이블전체 강제삭제

SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

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
	area_location	varchar2(300)	NOT NULL,
	area_call	char(13)	not NULL check(regexp_like(area_call,'^010-\d{4}-\d{4}$'))
);

--장르
CREATE TABLE genre (
	genre_no	number(3)	primary key,
	genre_name	varchar2(60)	NOT NULL
);

--책 테이블
CREATE TABLE Book (
	book_isbn   varchar2(24) primary key,
	genre_no	references genre(genre_no) on delete set null,
	book_title	varchar2(300)	NOT NULL,
	book_author	varchar2(300)	NOT NULL,
    book_publisher varchar2(300) not null,
    book_date date,
    book_content varchar2(4000),
    book_img varchar2(4000) not null unique
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
	hopelist_date	date	default sysdate  not null,
	hopelist_library varchar2(100) not null
);

--리뷰 테이블
CREATE TABLE review (
	review_no	number(19)	primary key,
	client_no	references client(client_no) on delete set null,
	book_isbn	references book(book_isbn) on delete cascade,
	review_subject	varchar2(300)	not NULL,
	review_content	varchar2(4000)	NOT NULL,
	review_read	number(19)	default 0 not NULL check(review_read >= 0),
	review_like	number(19)	default 0 not NULL check(review_like >= 0),
	review_date	date	default sysdate  not null,
    review_reply number(19) default 0 not null check(review_reply >= 0)
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
	get_book_date	date	default sysdate not null
);

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
CREATE TABLE plan (
	plan_no 	number(19)	primary key,
	area_no	references area(area_no) on delete cascade,
	plan_start_date	date	default sysdate NOT NULL,
	plan_end_date	date	default sysdate NOT NULL,
	plan_content	varchar2(300)	not NULL,
    check(plan_end_date >= plan_start_date)
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

-- 좋아요 table
create table board_like (
client_no references client(client_no) on delete cascade,
board_no references board(board_no) on delete cascade,
like_time date default sysdate not null,
primary key(client_no, board_no)
);

-- 질문 답변 게시판 상태를 위한 테이블
create table board_answer (
    board_no references board(board_no) on delete cascade,
    board_status varchar2(12) default '접수중' not null check (board_status in ('접수중', '답변완료')),
    client_no references client(client_no) on delete set null,
    answer_content varchar2(4000) default '아직 답변이 등록되지 않았습니다.' not null,
    answer_date Date,
    primary key(board_no)
);

create table review_like (
    client_no references client(client_no) on delete cascade,
    review_no references review(review_no) on delete cascade,
    like_time date default sysdate not null,
    primary key(client_no, review_no)
);

insert into board_type values(1, '공지사항');
insert into board_type values(2, '질문답변');
insert into board_type values(3, '자유게시판');
insert into board_type values(4, '도서리뷰');
commit;

alter table review add review_reply number(19) default 0 not null check(review_reply >= 0);

-- 프로모션 테이블
create table promotion(
promotion_no number(19) primary key,
area_no references area(area_no) on delete set null
);

-- 프로모션 파일 테이블
create table promotion_file(
file_no number(19) primary key,
file_upload_name varchar2(256) not null,
file_save_name varchar2(256) not null,
file_content_type varchar2(30),
file_size number(19) not null,
file_origin references promotion(promotion_no) on delete cascade
);

DROP TABLE "CLIENT" CASCADE CONSTRAINTS;
DROP TABLE "AREA" CASCADE CONSTRAINTS;
DROP TABLE "GENRE" CASCADE CONSTRAINTS;
DROP TABLE "BOOK" CASCADE CONSTRAINTS;
DROP TABLE "ROLE" CASCADE CONSTRAINTS;
DROP TABLE "BOARD_TYPE" CASCADE CONSTRAINTS;
DROP TABLE "BOARD" CASCADE CONSTRAINTS;
DROP TABLE "HOPELIST" CASCADE CONSTRAINTS;
DROP TABLE "REVIEW" CASCADE CONSTRAINTS;
DROP TABLE "RECOMMEND" CASCADE CONSTRAINTS;
DROP TABLE "GET_BOOK" CASCADE CONSTRAINTS;
DROP TABLE "LEND_BOOK" CASCADE CONSTRAINTS;
DROP TABLE "PLAN" CASCADE CONSTRAINTS;
DROP TABLE "WISHLIST" CASCADE CONSTRAINTS;
DROP TABLE "RESERVATION" CASCADE CONSTRAINTS;
DROP TABLE "BOARD_LIKE" CASCADE CONSTRAINTS;
DROP TABLE "REVIEW_COMMENT" CASCADE CONSTRAINTS;
DROP TABLE "BOARD_COMMENT" CASCADE CONSTRAINTS;
DROP TABLE "BOARD_ANSWER" CASCADE CONSTRAINTS;