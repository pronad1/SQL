drop table BOOKSHELF_AUDIT;
create table BOOKSHELF_AUDIT
(Title       VARCHAR2(100),
Publisher    VARCHAR2(20),
CategoryName VARCHAR2(20),
Old_Rating   VARCHAR2(2),
New_Rating   VARCHAR2(2),
Audit_Date   DATE);

drop table BOOKSHELF;
create table BOOKSHELF
(Title       VARCHAR2(100) primary key,
Publisher    VARCHAR2(20),
CategoryName VARCHAR2(20),
Rating       VARCHAR2(2)
);

describe BOOKSHELF;

Insert into BOOKSHELF values
('TO KILL A MOCKINGBIRD','HARPERCOLLINS','ADULTFIC','5');

select * from bookshelf;

select * from bookshelf_audit;

create or replace trigger BOOKSHELF_BEF_UPD_ROW
 before update on BOOKSHELF
 for each row
 when (new.Rating < old.Rating)
 begin
 insert into BOOKSHELF_AUDIT
 (Title, Publisher, CategoryName,
 Old_Rating, New_Rating, Audit_Date)
 values
 (:old.Title, :old.Publisher, :old.CategoryName,
 :old.Rating, :new.Rating, Sysdate);
 end;
 /

update BOOKSHELF set RATING =10;

SELECT * FROM BOOKSHELF_AUDIT;