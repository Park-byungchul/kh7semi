insert into board values(board_seq.nextval, 8, 1, null, '전체 공지', '전체', 0, 0, sysdate, notice_seq.nextval, 0, '공개');
insert into board values(board_seq.nextval, 8, 1, 1, '당산도서관 공지', '전체', 0, 0, sysdate, notice_seq.nextval, 0, '공개');
insert into board values(board_seq.nextval, 8, 1, 2, '종로도서관 공지', '전체', 0, 0, sysdate, notice_seq.nextval, 0, '공개');
insert into board values(board_seq.nextval, 8, 1, 3, '강남도서관 공지', '전체', 0, 0, sysdate, notice_seq.nextval, 0, '공개');

select * from board;
delete board;