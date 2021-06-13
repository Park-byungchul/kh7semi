-- ���� �߰� ( ã�ƿ��±� ������ ������ )

drop sequence area_seq;

create sequence area_seq
minvalue 1
start with 1
increment by 1
nocycle
nocache;

delete from area;

insert into area values(0,'���ε�����','���ε�����','010-1111-1111');
insert into area values(area_seq.nextval,'��굵����','����Ư���� �������� ������2�� 57 �̷����� (����) 19F, 20F','010-1111-1111');
insert into area values(area_seq.nextval,'���ε�����','����Ư���� �߱� ���빮�� 120 ���Ϻ��� 2F, 3F','010-2222-2222');
insert into area values(area_seq.nextval,'����������','����Ư���� ������ ������� 14�� 6 �������� 2F, 3F, 4F, 5F, 6F','010-3333-3333');
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
select * from recommendBook where (book_title || book_author) like '%��𼱰�%';


create view review_list as
select R.review_no, R.client_no as reviewer, R.book_isbn, R.review_subject,
        R.review_content, R.review_read, R.review_like, R.review_date, R.review_reply,
        C.client_no, C.client_name
from review R
left outer join client C on R.client_no = C.client_no;

insert into book values('1111111111111', 140, '�׽�Ʈ', '123', '�׽�Ʈ', sysdate, '����', '����');
insert into book values('1111111111112', 150, '�׽�Ʈ1', '123', '�׽�Ʈ', sysdate, '����', '��1��');
insert into book values('1111111111113', 160, '�׽�Ʈ2', '123', '�׽�Ʈ', sysdate, '����', '��32��');
insert into book values('1111111111114', 140, '�׽�Ʈ3', '123', '�׽�Ʈ', sysdate, '����', '��4��');
insert into book values('1111111111115', 160, '1�׽�Ʈ', '123', '�׽�Ʈ', sysdate, '����', '��6��');
insert into book values('1111111111116', 170, '2�׽�Ʈ', '123', '�׽�Ʈ', sysdate, '����', '��7��');
insert into book values('1111111111117', 110, '3�׽�Ʈ', '123', '�׽�Ʈ', sysdate, '����', '��1342��');
insert into book values('1111111111118', 170, '�׽�Ʈ', '123', '�׽�Ʈ', sysdate, '����', '��122��');
insert into book values('1111111111119', 160, '123', '�׽�Ʈ', '�׽�Ʈ', sysdate, '����', '61234����');
insert into book values('1111111111120', 130, '123', '�׽�Ʈ', '�׽�Ʈ', sysdate, '����', '��162��');
insert into book values('1111111113111', 140, '123', '�׽�Ʈ', '�׽�Ʈ', sysdate, '����', '��332��');
insert into book values('1111114111111', 150, '123�׽�Ʈ', '�׽�Ʈ123', '�׽�Ʈ', sysdate, '����', '��12525��');
commit;

select * from get_book;

select * from board_list;

select * from board_list where board_type_no = 1 order by board_no desc;

select * from (select rownum rn, TMP.* from (select * from board_list where board_type_no = 1 order by board_no desc)TMP) where rn between 1 and 10;


select area_no,count(*) from get_book group by area_no;