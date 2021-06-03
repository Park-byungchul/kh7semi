-- 지점 추가 ( 찾아오는길 페이지 나오게 )

drop sequence area_seq;

create sequence area_seq
minvalue 1
start with 1
increment by 1
nocycle
nocache;

delete from area;

insert into area values(area_seq.nextval,'당산도서관','서울특별시 영등포구 선유동2로 57 이레빌딩 (구관) 19F, 20F','010-1111-1111');
insert into area values(area_seq.nextval,'종로도서관','서울특별시 중구 남대문로 120 대일빌딩 2F, 3F','010-2222-2222');
insert into area values(area_seq.nextval,'강남도서관','서울특별시 강남구 테헤란로 14길 6 남도빌딩 2F, 3F, 4F, 5F, 6F','010-3333-3333');
commit;