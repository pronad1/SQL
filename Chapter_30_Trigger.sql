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

commit;
update BOOKSHELF set RATING =10;

SELECT * FROM BOOKSHELF_AUDIT;

Insert into BOOKSHELF values
 ('WONDERFUL LIFE','W.W.NORTON','ADULTNF','5');
Insert into BOOKSHELF values
 ('INNUMERACY','VINTAGE BOOKS','ADULTNF','4');
Insert into BOOKSHELF values
 ('KIERKEGAARD ANTHOLOGY','PRINCETON UNIV PR','ADULTREF','3');
Insert into BOOKSHELF values
 ('ANNE OF GREEN GABLES','GRAMMERCY','CHILDRENFIC','3');
Insert into BOOKSHELF values
 ('GOOD DOG, CARL','LITTLE SIMON','CHILDRENPIC','1');
Insert into BOOKSHELF values
 ('LETTERS AND PAPERS FROM PRISON','SCRIBNER','ADULTNF','4');
Insert into BOOKSHELF values
 ('THE DISCOVERERS','RANDOM HOUSE','ADULTNF','4');
Insert into BOOKSHELF values
 ('THE MISMEASURE OF MAN','W.W. NORTON','ADULTNF','5');
Insert into BOOKSHELF values
 ('EITHER/OR','PENGUIN','ADULTREF','3');
Insert into BOOKSHELF values
 ('POLAR EXPRESS','HOUGHTON MIFFLIN','CHILDRENPIC','1');
Insert into BOOKSHELF values
('RUNAWAY BUNNY','HARPERFESTIVAL','CHILDRENPIC','1');
Insert into BOOKSHELF values
('MY LEDGER','KOCH PRESS','ADULTNF','5');
Insert into BOOKSHELF values
('COMPLETE POEMS OF JOHN KEATS','VIKING','ADULTREF','2');
Insert into BOOKSHELF values
('UNDER THE EYE OF THE CLOCK','ARCADE PUB','CHILDRENNF','3');
Insert into BOOKSHELF values
('JOHN ADAMS','SIMON SCHUSTER','ADULTNF','4');
Insert into BOOKSHELF values
('TRUMAN','SIMON SCHUSTER','ADULTNF','4');
Insert into BOOKSHELF values
('JOURNALS OF LEWIS AND CLARK','MARINER','ADULTNF','4');
Insert into BOOKSHELF values
('GOSPEL','PICADOR','ADULTFIC','4');
Insert into BOOKSHELF values
('EMMA WHO SAVED MY LIFE','ST MARTIN''S PRESS','ADULTFIC','3');
Insert into BOOKSHELF values
('MIDNIGHT MAGIC','SCHOLASTIC','CHILDRENFIC','1');
Insert into BOOKSHELF values
('HARRY POTTER AND THE GOBLET OF FIRE','SCHOLASTIC','CHILDRENFIC','4');
Insert into BOOKSHELF values
('SHOELESS JOE','MARINER','ADULTFIC','3');

commit;

update BOOKSHELF set RATING =15;

select * from bookshelf;

-- create new trigger to audit all updates to the BOOKSHELF table
create or replace trigger BOOKSHELF_BEF_UPD_ROW
 before update on BOOKSHELF
 for each row
 when (new.Rating > old.Rating)
 begin
 insert into BOOKSHELF_AUDIT
 (Title, Publisher, CategoryName,
 Old_Rating, New_Rating, Audit_Date)
 values
 (:old.Title, :old.Publisher, :old.CategoryName,
 :old.Rating, :new.Rating, Sysdate);
 end;
 /


 SELECT * FROM BOOKSHELF_AUDIT;

 update BOOKSHELF set RATING =10 where title = 'TO KILL A MOCKINGBIRD';

drop trigger BOOKSHELF_BEF_UPD_ROW;

-- create trigger for insert and update
create or REPLACE trigger BOOKSHELF_BEF_UPD_INS_ROW 
before INSERT or update of rating on BOOKSHELF
for each row BEGIN
if INSERTING then 
insert into BOOKSHELF_AUDIT
(Title, Publisher,CategoryName,New_Rating,Audit_Date)
VALUES
(:new.Title, :new.Publisher, :new.CategoryName, :new.Rating, SYSDATE);
else 
insert into BOOKSHELF_AUDIT
(Title,Publisher,CategoryName,Old_Rating,New_Rating,Audit_Date)
VALUES
(:Old.Title, :old.Publisher,:old.CategoryName,:old.Rating,:new.Rating,SYSDATE);
end if;
end;
/



-- Statement level trigger

CREATE table job(
    position varchar2(15),
    salary numeric(10,2),
    lev NUMBER,
    location varchar(15)
);

CREATE table job_record(
    position varchar2(15),
    salary numeric(10,2),
    location varchar(15),
    old_lev NUMBER,
    new_lev NUMBER,
    record_date DATE
);

INSERT INTO job VALUES('Manager', 50000, 1, 'New York');
select * from job;

create or replace trigger job_bef_upd_row
before update on job
for each ROW
WHEN(new.lev>old.lev)
BEGIN
    insert into job_record
    (position, salary, location, old_lev, new_lev,record_date)
    VALUES
    (:old.position, :old.salary, :old.location, :old.lev, :new.lev, SYSDATE);
    END;
    /

select * from job_record;

update job set lev = 2 where position = 'Manager';

select * from job_record;

CREATE table job_log(
    action varchar2(30),
    update_date DATE
);

CREATE or replace trigger job_log_rec
BEFORE UPDATE on job
BEGIN
    insert into job_log
    (action, update_date)
    VALUES
    ('Update executed on Job', SYSDATE);
END;
/

INSERT into job values ('Soft.Engg.',50000, 1,'Canada');

select * from job_record;

select * from job_log;

UPDATE job set lev = 2 where position = 'Soft.Engg.';

commit;


-- EDGE Practices

create table edge(
    Title varchar2(100) primary key,
    Publisher varchar2(20),
    Categoryname varchar2(20),
    rating NUMERIC
);

insert into edge values
('TO KILL A MOCKINGBIRD','HARPERCOLLINS','ADULTFIC','5');

select * from edge;